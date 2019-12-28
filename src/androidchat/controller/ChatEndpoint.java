package androidchat.controller;

import java.io.IOException;
import java.util.Collections;
import java.util.HashSet;
import java.util.Set;

import javax.servlet.http.HttpSession;
import javax.websocket.EndpointConfig;
import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.RemoteEndpoint.Basic;
import javax.websocket.Session;
import javax.websocket.server.ServerEndpoint;

import com.google.common.collect.EvictingQueue;
import com.google.gson.JsonObject;

import androidchat.dto.ChatDTO;
import androidchat.utils.SessionGetter;
import androidchat.utils.TranslationUtils;

@ServerEndpoint(value="/websocket", configurator=SessionGetter.class)
public class ChatEndpoint {
	
	TranslationUtils tUtils = new TranslationUtils();
	
	
	private String xssProtect(String text) {
		text = text.replaceAll("&", "&amp;");
		text = text.replaceAll("<", "&lt;");
		text = text.replaceAll(">", "&gt;");
		return text;
	}
	
	private static Set<Session> clients = Collections.synchronizedSet(new HashSet<>());
	private HttpSession hSession = null;
	private static EvictingQueue<ChatDTO> msgs = EvictingQueue.create(30);
		
	@OnOpen
	public void handleOpen(Session session, EndpointConfig config) throws IOException {
		System.out.println("client is now connected.");
		clients.add(session);
		this.hSession = (HttpSession)config.getUserProperties().get("session");
	}
	
	@OnMessage
	public void handleMessage(String clientMsg, Session session) throws Exception{
		System.out.println(clientMsg);
		clientMsg = xssProtect(clientMsg);
		clientMsg = clientMsg.replaceAll("\"", "");
        String [] msg = clientMsg.split(":");
        msg = msg[1].split(",");
        String originMsg = msg[0];
		String translatedMsg = tUtils.papagoNMT(originMsg);
		String nickname = (String) this.hSession.getAttribute("nickname");
		ChatDTO dto = new ChatDTO(nickname, originMsg, translatedMsg);
		msgs.add(dto);
		System.out.println(msgs);
		JsonObject obj = new JsonObject();
			
		synchronized(clients) {
			for(Session client : clients) {
				if(client.equals(session)) {
					System.out.println("보낸 메세지 ");
					obj.addProperty("nickname", "me");
					obj.addProperty("origingMsg", originMsg);
					obj.addProperty("translatedMsg", translatedMsg);	
					System.out.println(obj.toString());
					client.getBasicRemote().sendText(obj.toString());
					
//					client.getBasicRemote().sendText(xssProtect("{\"nickname\":\"me\", \"originMsg\" : \"" + originMsg 
//							+ "\", \"translatedMsg\" : \"" + translatedMsg + "\"}"));
				}else {
					System.out.println("받는 메세지 ");
					obj.addProperty("nickname", nickname);
					obj.addProperty("origingMsg", originMsg);
					obj.addProperty("translatedMsg", translatedMsg);
					System.out.println(obj.toString());
					client.getBasicRemote().sendText(obj.toString());
//					client.getBasicRemote().sendText(xssProtect("{\"nickname\":\"" + nickname + "\", \"originMsg\" : \"" + originMsg 
//							+ "\", \"translatedMsg\" : \"" + translatedMsg + "\"}"));
				}
			}
		}
	}
	
	@OnClose
	public void handleClose(Session session) {
		clients.remove(session);
		System.out.println("client is not disconncted.");
	}
	
	@OnError
	public void handleError(Throwable t) {
		t.printStackTrace();
	}
}

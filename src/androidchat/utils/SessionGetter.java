package androidchat.utils;

import javax.servlet.http.HttpSession;
import javax.websocket.HandshakeResponse;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;

public class SessionGetter extends ServerEndpointConfig.Configurator{
	@Override
	public void modifyHandshake(ServerEndpointConfig sec,
			HandshakeRequest request,
			HandshakeResponse response) {
		
		HttpSession httpSession = (HttpSession)request.getHttpSession();
		sec.getUserProperties().put("session", httpSession);
	}	
}

package androidchat.utils;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

public class TranslationUtils {
	public String papagoNMT(String msg){
		String clientId = "vcM5QBaOsmQVa7etFfpv";//애플리케이션 클라이언트 아이디값";
        String clientSecret = "9x7fWy3Exv";//애플리케이션 클라이언트 시크릿값";
        
        try {
            String text = URLEncoder.encode(msg, "UTF-8");
            String apiURL = "https://openapi.naver.com/v1/papago/n2mt";
            
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setRequestMethod("POST");
            con.setRequestProperty("X-Naver-Client-Id", clientId);
            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            // post request
            String postParams = "source=ko&target=en&text=" + text;
            con.setDoOutput(true);// request에 담을 내용을 준비
            
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            wr.writeBytes(postParams);
            wr.flush();
            wr.close(); //request 보내기s
            
            //응답 수신
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if(responseCode==200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else {  // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            
            //수신 응답에 따라 메세지 읽음
            String inputLine;
            StringBuffer response = new StringBuffer();
            //StringBuffer는  + 형식으로 문자열을 연결
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            String result= response.toString();
            JsonParser parser = new JsonParser();
            JsonElement jsonResult = parser.parse(result);
            JsonObject root = jsonResult.getAsJsonObject();
            JsonObject message = root.getAsJsonObject("message"); // 키 값이 jsonObject형이라 getasjsonobject로 값을 꺼내고
            JsonObject rs =  message.getAsJsonObject("result");
            String translatedText = rs.get("translatedText").getAsString(); // 키 값이 String형이라 getasString으로 값을 꺼내고
            return translatedText;
        } catch (Exception e) {
            System.out.println(e);
            return "Translation failed.";
        }
	}
}

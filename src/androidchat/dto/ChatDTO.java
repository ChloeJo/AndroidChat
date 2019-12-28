package androidchat.dto;

public class ChatDTO {
	private String nickname;
	private String originMsg;
	private String translatedMsg;
	
	public ChatDTO() {};
	public ChatDTO(String nickname, String originMsg, String translatedMsg) {
		super();
		this.nickname = nickname;
		this.originMsg = originMsg;
		this.translatedMsg = translatedMsg;
	}
	
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public String getOriginMsg() {
		return originMsg;
	}
	public void setOriginMsg(String originMsg) {
		this.originMsg = originMsg;
	}
	public String getTranslatedMsg() {
		return translatedMsg;
	}
	public void setTranslatedMsg(String translatedMsg) {
		this.translatedMsg = translatedMsg;
	}
}

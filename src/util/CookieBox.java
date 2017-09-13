package util;

import java.net.URLEncoder;
import java.net.URLDecoder;
import java.util.Map;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Cookie;

public class CookieBox {
	private Map<String, Cookie> cookieMap = new java.util.HashMap<String, Cookie>();
	
	//������
	public CookieBox(HttpServletRequest request) {
		Cookie[] cookies = request.getCookies();
		if(cookies!=null && cookies.length>0) {
			for(int i=0; i<cookies.length; i++) {
				cookieMap.put(cookies[i].getName(), cookies[i]);
			}
		}
	} // end constructor
	
	// create �����ε� 3��
	// �̸�/��
	// �̸�/��/���/�Ⱓ
	// �̸�/��/������/���/�Ⱓ
	public static Cookie createCookie(String name, String value) throws IOException{
		return new Cookie(name, URLEncoder.encode(value,"utf-8"));		
	}
	public static Cookie createCookie(String name, String value, String path, int maxAge) throws IOException{
		Cookie cookie = new Cookie(name, URLEncoder.encode(value,"utf-8"));
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
	public static Cookie createCookie(String name, String value, String domain, String path, int maxAge) throws IOException{
		Cookie cookie = new Cookie(name, URLEncoder.encode(value,"utf-8"));
		cookie.setDomain(domain);
		cookie.setPath(path);
		cookie.setMaxAge(maxAge);
		return cookie;
	}
		
	// getCookie
	public Cookie getCookie(String name) {
		return cookieMap.get(name);
	}
	
	// getValue
	public String getValue(String name) throws IOException{
		Cookie cookie = cookieMap.get(name);
		if(cookie == null) return null;
		return URLDecoder.decode(cookie.getValue(), "utf-8");
	}
	
	// exists
	public boolean exists(String name) {
		return cookieMap.get(name) != null;
	}
	
}

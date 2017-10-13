package kh.mvcboard.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mvcboard.action.CommandAction;
import kh.mvcboard.action.NullAction;

public class ControllerMvcBoard extends HttpServlet{
	private Map commandMap = new HashMap();
	
	// 명령어와 처리클래스가 매핑되어 있는 properties 파일을 읽어서 Map 객체인 commandMap 에 저장
	// 명령어와 처리클래스가 매핑되어 있는 properties 파일은 /WEB-INF/CommandActionList.properties
	public void init(ServletConfig config) throws ServletException{
		String initConfig = config.getInitParameter("configActionList"); // web.xml 에서 "configActionList" 라는 init-param 을 찾아서 가져옴
		Properties prop = new Properties();		// 명령어와 처리클래스의 매핑정보를 저장할 Properties 객체생성
		FileInputStream fis = null;
		
		try {
			String configFilePath = config.getServletContext().getRealPath(initConfig);
			fis = new FileInputStream(configFilePath);
			prop.load(fis);
		}catch(IOException e) {
			e.printStackTrace();
			throw new ServletException(e);
		}finally {	
			if(fis != null)	try {fis.close();}	catch(IOException e) {}	
		}
		
		// 여기까진 설정파일 읽어서 Properties 객체에 올린거고, 이제 이걸 HashMap 에 <command, 명령별'객체'> 로 준비해 준다
		
		Iterator keyIter = prop.keySet().iterator();
		while(keyIter.hasNext()) {
			String command = (String) keyIter.next();
			String className = prop.getProperty(command);
			try {
				Class commandClass = Class.forName(className);
				Object commandInstance = commandClass.newInstance();
				commandMap.put(command, commandInstance);
			}catch(ClassNotFoundException e) {
				throw new ServletException(e);
			}catch(InstantiationException e) {
				throw new ServletException(e);
			}catch(IllegalAccessException e) {
				throw new ServletException(e);
			}
		}		
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request, response);
	}
	
	private void requestPro(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String view = null;
		CommandAction action = null;
		
		// 사용자가 입력학 command 추출
		String command = request.getRequestURI();
		if(command.indexOf(request.getContextPath()) == 0) {
			command = command.substring(request.getContextPath().length());
		}
		
		// 사용자 입력 command 를 commandMap 에서 찾아서 해당 commandInstance 추출 --> action 에 넣어준다.
		action = (CommandAction) commandMap.get(command);
		// 예외처리
		if(action == null) action = new NullAction();
		
		// action 에서 처리되어 리턴받은 jsp 주소를 view 에 넣어준다
		try {
			view = action.requestPro(request, response);
		} catch (Throwable e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new ServletException(e);
		}
		
		// 해당 view 로 이동시킨다.
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
		
	}
}









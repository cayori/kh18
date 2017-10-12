package kh.mvc.controller;

import java.io.FileInputStream;
import java.io.IOException;
import java.net.URL;
import java.util.Iterator;
import java.util.Map;
import java.util.Properties;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kh.mvc.command.CommandHandler;
import kh.mvc.command.NullHandler;

public class ControllerUsingFile extends HttpServlet{
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	// <커맨드,핸들러인스턴스> 매핑 정보 저장 
	private Map commandHandlerMap = new java.util.HashMap();
	
	public void init(ServletConfig config) throws ServletException{
		String configFile = config.getInitParameter("configFile");
		Properties prop = new Properties();
		FileInputStream fis = null;
		
		try {
			String configFilePath = config.getServletContext().getRealPath(configFile);
			fis = new FileInputStream(configFilePath);
			prop.load(fis);
		}catch(IOException e) {
			throw new ServletException(e);
		}finally {
			if(fis != null)	try {fis.close();} 	catch(IOException e) {}
		}
		
		Iterator keyIter = prop.keySet().iterator();
		while(keyIter.hasNext()) {
			String command = (String) keyIter.next();
			String handlerClassName = prop.getProperty(command);
			try {
				Class handlerClass = Class.forName(handlerClassName);
				Object handlerInstance = handlerClass.newInstance();
				commandHandlerMap.put(command, handlerInstance);
			}catch(ClassNotFoundException e) {
				throw new ServletException(e);				
			}catch(InstantiationException e) {
				throw new ServletException(e);
			}catch(IllegalAccessException e) {
				throw new ServletException(e);
			}
		}
	}
	
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		process(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		process(request, response);
	}
	
	private void process(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
		String command = request.getParameter("cmd");
		CommandHandler handler = (CommandHandler) commandHandlerMap.get(command);
		if(handler == null)		handler = new NullHandler();
		String viewPage = null;
		try {
			viewPage = handler.process(request, response);
		}catch(Throwable e) {
			throw new ServletException(e);
		}
		RequestDispatcher dispatcher = request.getRequestDispatcher(viewPage);
		dispatcher.forward(request, response);
	}
}

















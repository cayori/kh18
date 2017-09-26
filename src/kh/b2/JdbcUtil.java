package kh.b2;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import javax.servlet.http.HttpServletRequest;

public class JdbcUtil {
	public static void close(ResultSet rs) {
		if(rs != null)		try {rs.close();}		catch(SQLException se) {}
	}
	public static void close(Statement stmt) {
		if(stmt != null)	try {stmt.close();}		catch(SQLException se) {}
	}
	public static void close(Connection conn) {
		if(conn != null)	try {conn.close();}		catch(SQLException se) {}
	}
	public static void close(ResultSet rs, Statement stmt) {
		if(rs != null)		try {rs.close();}		catch(SQLException se) {}
		if(stmt != null)	try {stmt.close();}		catch(SQLException se) {}
	}
	public static void close(Statement stmt, Connection conn) {
		if(stmt != null)	try {stmt.close();}		catch(SQLException se) {}
		if(conn != null)	try {conn.close();}		catch(SQLException se) {}
	}
	public static void close(ResultSet rs, Statement stmt, Connection conn) {
		if(rs != null)		try {rs.close();}		catch(SQLException se) {}
		if(stmt != null)	try {stmt.close();}		catch(SQLException se) {}
		if(conn != null)	try {conn.close();}		catch(SQLException se) {}
	}
	public static void rollback(Connection conn) {
		if(conn != null)	try {conn.rollback();}	catch(SQLException se) {}
	}
	public static String getClientIpAddr(HttpServletRequest request) {
	    String ip = request.getHeader("X-Forwarded-For");
	 
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("WL-Proxy-Client-IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("HTTP_CLIENT_IP");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getHeader("HTTP_X_FORWARDED_FOR");
	    }
	    if(ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
	        ip = request.getRemoteAddr();
	    }	 
	    return ip;
	}
}

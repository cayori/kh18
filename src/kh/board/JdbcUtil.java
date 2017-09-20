package kh.board;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;

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
}

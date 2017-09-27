package kh.b2.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import kh.b2.JdbcUtil;
import kh.b2.ConnectionProvider;
import kh.b2.exception.IdGenerationFailedException;

public class IdGenerator {
	private IdGenerator() {}
	private static IdGenerator instance = new IdGenerator();
	public static IdGenerator getInstance() {	return instance;	}
	
	public int generateNextId(String sequenceName) throws IdGenerationFailedException{
		Connection conn = null;
		PreparedStatement pstmtSelect = null;
		ResultSet rs = null;
		PreparedStatement pstmtUpdate = null;
		int resultId = 0;
		
		try {
			conn = ConnectionProvider.getConnection();
			conn.setAutoCommit(false);
			pstmtSelect = conn.prepareStatement("SELECT next_value FROM id_sequence_jp WHERE sequence_name = ? FOR UPDATE");
			pstmtSelect.setString(1, sequenceName);
			rs = pstmtSelect.executeQuery();
			
			if(rs.next())	resultId = rs.getInt(1);
			resultId++;
			
			pstmtUpdate = conn.prepareStatement("UPDATE id_sequence_jp SET next_value=? WHERE sequence_name=?");
			pstmtUpdate.setInt(1, resultId);
			pstmtUpdate.setString(2, sequenceName);
			pstmtUpdate.executeQuery();
			
			conn.commit();
			
		}catch(SQLException e) {
			JdbcUtil.rollback(conn);
			throw new IdGenerationFailedException(e);
			
		}finally {
			JdbcUtil.close(rs);
			JdbcUtil.close(pstmtSelect);
			JdbcUtil.close(pstmtUpdate);
			JdbcUtil.close(conn);
		}		
		return resultId;		
	}
}

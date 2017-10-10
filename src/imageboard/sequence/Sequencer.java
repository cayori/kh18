package imageboard.sequence;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Sequencer {
	public synchronized static int nextId(Connection conn, String tableName) throws SQLException{
		PreparedStatement pstmtSelect = null;
		PreparedStatement pstmtUpdate = null;
		ResultSet rsSelect = null;
		int id = -1;
		
		try {
			pstmtSelect = conn.prepareStatement("SELECT message_id FROM id_sequences WHERE table_name=?");
			pstmtSelect.setString(1, tableName);
			
			rsSelect = pstmtSelect.executeQuery();
			
			if(rsSelect.next()) {
				id = rsSelect.getInt(1);
				id++;
				
				pstmtUpdate = conn.prepareStatement("UPDATE id_sequences SET message_id=? WHERE table_name=?");
				pstmtUpdate.setInt(1, id);
				pstmtUpdate.setString(2, tableName);
				pstmtUpdate.executeUpdate();
			}else {
				pstmtUpdate = conn.prepareStatement("INSERT INTP id_sequences VALUES(?,?)");
				pstmtUpdate.setString(1, tableName);
				pstmtUpdate.setInt(2, 1);
				pstmtUpdate.executeUpdate();
				id = 1;
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			if(rsSelect != null)	try {	rsSelect.close();	}		catch(SQLException e) {}
			if(pstmtSelect != null)	try {	pstmtSelect.close();	}	catch(SQLException e) {}
			if(pstmtUpdate != null)	try {	pstmtUpdate.close();	}	catch(SQLException e) {}
		}
		
		return id;
	}
}

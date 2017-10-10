package kh.pds.dao;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.ResultSet;
import java.sql.PreparedStatement;
import java.sql.Statement;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import kh.pds.model.PdsItem;
import kh.pds.JdbcUtil;

public class PdsItemDao {
	private PdsItemDao() {}
	private static PdsItemDao instance = new PdsItemDao();
	public static PdsItemDao getInstance() {	return instance;	}
	
	public int selectCount(Connection conn) throws SQLException{
		Statement stmt = null;
		ResultSet rs = null;
		int count = 0;
		
		try {
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT COUNT(*) FROM pds_item_jp");
			if(rs.next())	count = rs.getInt(1);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, stmt);
		}
		return count;
	}
	
	public List<PdsItem> select(Connection conn, int firstRow, int endRow) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<PdsItem> selectResult = new ArrayList<PdsItem>();
		
		try {
			pstmt = conn.prepareStatement("SELECT * FROM "
					+ "(SELECT rownum rnum, pds_item_id, filename, realpath, filesize, downloadcount, description FROM "
					+ "(SELECT * FROM pds_item_jp m ORDER BY m.pds_item_id DESC) "
					+ "WHERE rownum <=?) "
					+ "WHERE rnum >=?");
			pstmt.setInt(1, endRow);
			pstmt.setInt(2, firstRow);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				PdsItem pdsItem = null;
				do {
					pdsItem = makeItemFromResultSet(rs);
					selectResult.add(pdsItem);
				}while(rs.next());				
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}
		return selectResult;
	}
	
	private PdsItem makeItemFromResultSet(ResultSet rs) throws SQLException{
		PdsItem pdsItem = new PdsItem();
		pdsItem.setId(rs.getInt("pds_item_id"));
		pdsItem.setFileName(rs.getString("filename"));
		pdsItem.setRealPath(rs.getString("realpath"));
		pdsItem.setFileSize(rs.getLong("filesize"));
		pdsItem.setDownloadCount(rs.getInt("downloadcount"));
		pdsItem.setDescription(rs.getString("description"));
		
		return pdsItem;
	}
	
	public PdsItem selectById(Connection conn, int itemId) throws SQLException{
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		PdsItem pdsItem = null;
		
		try {
			pstmt = conn.prepareStatement("SELECT * FROM pds_itm_jp WHERE pds_item_id=?");
			pstmt.setInt(1, itemId);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				pdsItem = makeItemFromResultSet(rs);
			}
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
		}
		return pdsItem;
	}

	public int insert(Connection conn, PdsItem pdsItem) throws SQLException{
		PreparedStatement pstmt = null;
		Statement stmt = null;
		ResultSet rs = null;
		int result = -1;
		
		try {
			pstmt = conn.prepareStatement("INSERT INTO pds_item_jp "
					+ "(pds_item_id, filename, realpath, filesize, downloadcount, description) "
					+ "VALUES (pds_item_jp_seq.NEXTVAL,?,?,?,0,?");
			pstmt.setString(1, pdsItem.getFileName());
			pstmt.setString(2, pdsItem.getRealPath());
			pstmt.setLong(3, pdsItem.getFileSize());
			pstmt.setString(4, pdsItem.getDescription());
			result = pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			JdbcUtil.close(rs, pstmt);
			JdbcUtil.close(stmt);
		}
		
		return result;
	}
	
	
	
	
	
	
	
	
}





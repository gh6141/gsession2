package jp.groupsession.v2.gyoji.yotei;

  import java.sql.Connection;
  import java.sql.PreparedStatement;
  import java.sql.ResultSet;
  import java.sql.SQLException;
  import java.util.ArrayList;
  import jp.co.sjts.util.dao.AbstractDao;
  import jp.co.sjts.util.jdbc.JDBCUtil;

  import jp.co.sjts.util.jdbc.SqlBuffer;
  import org.apache.commons.logging.Log;
  import org.apache.commons.logging.LogFactory;

  public class YoteiDao extends AbstractDao {


  //      private static Log log__     = LogFactory.getLog(YoteiDao.class);

        public YoteiDao() {
        }

        public YoteiDao(Connection con) {
            super(con);
        }


        public int delete(int scdSid) throws SQLException {

        PreparedStatement pstmt = null;
        int count = 0;
        Connection con = null;
        con = getCon();

        try {

            SqlBuffer sql = new SqlBuffer();
            sql.addSql(" delete");
            sql.addSql(" from");
            sql.addSql("   SCH_DATA");
            sql.addSql(" where ");
            sql.addSql("   SCD_SID=?");

            pstmt = con.prepareStatement(sql.toSqlString());
            sql.addIntValue(scdSid);

       //     log__.info(sql.toLogString());
            sql.setParameter(pstmt);

            count = pstmt.executeUpdate();

        } catch (SQLException e) {


            throw e;

        } finally {
            JDBCUtil.closeStatement(pstmt);
        }
        return count;

    }






  }
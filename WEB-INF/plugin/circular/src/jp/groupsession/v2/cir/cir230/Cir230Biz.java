package jp.groupsession.v2.cir.cir230;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import jp.co.sjts.util.StringUtil;
import jp.co.sjts.util.date.UDate;
import jp.co.sjts.util.jdbc.JDBCUtil;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.dao.CirAccountDao;
import jp.groupsession.v2.cir.dao.CirInfLabelDao;
import jp.groupsession.v2.cir.dao.CirLabelDao;
import jp.groupsession.v2.cir.dao.CirViewLabelDao;
import jp.groupsession.v2.cir.model.CirLabelModel;
import jp.groupsession.v2.cir.model.LabelDataModel;

/**
 * <br>[機  能] ラベル管理画面のビジネスロジッククラス
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir230Biz {

    /** Logging インスタンス */
    private static Log log__ = LogFactory.getLog(Cir230Biz.class);

    /** コネクション */
    private Connection con__ = null;
    /**
     * コンストラクタ
     * @param con コネクション
     */
    public Cir230Biz(Connection con) {
        con__ = con;
    }

    /**
     * <br>[機  能] 初期表示を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param userSid ユーザSID
     * @throws SQLException SQL実行時例外
     */
    public void setInitData(Cir230ParamModel paramMdl,
                             int userSid
                             ) throws SQLException {

        //アカウント名取得
        int accountSid = paramMdl.getCirAccountSid();
        CirAccountDao acDao = new CirAccountDao(con__);
        String accountName =  acDao.getCirAccountName(accountSid);
        paramMdl.setCir230accountName(accountName);

        //ラベル情報取得
        CirLabelDao cirDao = new CirLabelDao(con__);
        List<LabelDataModel> labelList = cirDao.selectLabelList(accountSid);
        paramMdl.setCir230LabelList(labelList);

    }

    /**
     * <br>[機  能] 順序変更処理
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param sortKbn 処理区分 0:順序をあげる 1:順序を下げる
     * @param userSid ユーザSID
     * @throws SQLException SQL実行時例外
     * @return true:変更成功
     */
    public boolean updateSort(Cir230ParamModel paramMdl, int sortKbn, int userSid)
        throws SQLException {

        UDate now = new UDate();
        //ラジオ選択値取得
        String sortClaSid = paramMdl.getCir230SortRadio();
        if (StringUtil.isNullZeroString(sortClaSid)) {
            return false;
        }
        CirLabelDao dao = new CirLabelDao(con__);
        //画面表示順
        int claSid = Integer.parseInt(sortClaSid);
        int cacSid = paramMdl.getCirAccountSid();
        CirLabelModel mdl = dao.select(claSid, cacSid);
        if (mdl == null) {
            return false;
        }
        int selectSort = mdl.getClaOrder();
        int maxNumber = dao.maxSortNumber(paramMdl.getCirAccountSid());

        if ((selectSort == 1 && sortKbn == GSConstCircular.SORT_UP)
        || (selectSort == maxNumber && sortKbn == GSConstCircular.SORT_DOWN)) {
            return false;
        }
        int newSort = selectSort;
        if (sortKbn == GSConstCircular.SORT_UP) {
            newSort--;
        } else if (sortKbn == GSConstCircular.SORT_DOWN) {
            newSort++;
        }
        mdl = dao.selectClaSidFromOrder(newSort, cacSid);
        if (mdl == null) {
            return false;
        }
        int editClaSid = mdl.getClaSid();
        //順序の入れ替えを行う
        dao.updateSort(newSort, userSid, now, claSid);
        dao.updateSort(selectSort, userSid, now, editClaSid);

        return true;
    }


    /**
     * <br>[機  能] ラベルの削除を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param userSid ユーザSID
     * @throws SQLException SQL実行時例外
     */
    public void deleteLabel(Cir230ParamModel paramMdl, int userSid) throws SQLException {

        boolean commitFlg = false;
        int claSid = paramMdl.getCir230EditLabelId();
        int cacSid = paramMdl.getCirAccountSid();
        UDate now = new UDate();
        try {

            // ソート番号を取得
            CirLabelDao dao = new CirLabelDao(con__);
            CirLabelModel mdl = dao.select(claSid, cacSid);
            if (mdl == null) {
                return;
            }
            int sort = mdl.getClaOrder();
            // ソート更新
            dao.updateSortAll(cacSid, userSid,  now, sort);
            //ラベルを削除する
            dao.delete(claSid);

            //回覧板送信ラベル削除
            CirInfLabelDao infDao = new CirInfLabelDao(con__);
            infDao.delete(claSid, paramMdl.getCirAccountSid());
            //回覧板受信ラベル削除
            CirViewLabelDao viewDao = new CirViewLabelDao(con__);
            viewDao.delete(claSid, paramMdl.getCirAccountSid());

            //コミット実行
            con__.commit();
            commitFlg = true;
        } catch (SQLException e) {
            log__.error("SQLException", e);
            throw e;
        } finally {
            if (!commitFlg) {
                JDBCUtil.rollback(con__);
            }
        }
    }

}

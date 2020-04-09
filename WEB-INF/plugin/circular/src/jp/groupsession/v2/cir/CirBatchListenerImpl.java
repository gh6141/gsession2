package jp.groupsession.v2.cir;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import jp.co.sjts.util.date.UDate;
import jp.co.sjts.util.jdbc.JDBCUtil;
import jp.groupsession.v2.batch.DayJob;
import jp.groupsession.v2.batch.IBatchListener;
import jp.groupsession.v2.batch.IBatchModel;
import jp.groupsession.v2.cir.biz.CirCommonBiz;
import jp.groupsession.v2.cir.dao.CirAdelDao;
import jp.groupsession.v2.cir.dao.CirInfDao;
import jp.groupsession.v2.cir.dao.CirInfLabelDao;
import jp.groupsession.v2.cir.dao.CirLogCountSumDao;
import jp.groupsession.v2.cir.dao.CirViewDao;
import jp.groupsession.v2.cir.dao.CirViewLabelDao;
import jp.groupsession.v2.cir.dao.CircularDao;
import jp.groupsession.v2.cir.model.CirAdelModel;
import jp.groupsession.v2.cir.model.CirInitModel;
import jp.groupsession.v2.cir.model.CirLogCountSumModel;
import jp.groupsession.v2.cmn.biz.StatisticsBiz;
import jp.groupsession.v2.man.GSConstMain;
import jp.groupsession.v2.man.dao.base.CirLogCountAdelDao;
import jp.groupsession.v2.man.model.base.CirLogCountAdelModel;
import jp.groupsession.v2.usr.GSConstUser;

/**
 * <br>[機  能] バッチ処理起動時に実行される処理を実装
 * <br>[解  説] 回覧板についての処理を行う
 * <br>[備  考]
 *
 * @author JTS
 */
public class CirBatchListenerImpl implements IBatchListener {

    /** ロギングクラス */
    private static Log log__ = LogFactory.getLog(CirBatchListenerImpl.class);

    /**
     * <p>日次バッチ起動時に実行される
     * @param con DBコネクション
     * @param param バッチ処理時に使用する情報
     * @throws Exception バッチ処理実行時例外
     */
    public void doDayBatch(Connection con, IBatchModel param) throws Exception {

        log__.debug("回覧板バッチ処理開始");
        String pluginName = "回覧板";
        DayJob.outPutStartLog(con, param.getDomain(),
                pluginName, "");
        long startTime = System.currentTimeMillis();
        Throwable logException = null;
        con.setAutoCommit(false);
        boolean commitFlg = false;

        try {

            /**********************************************************
            *
            * 自動削除設定に従いデータを削除する
            *
            **********************************************************/

            CirCommonBiz cmnBiz = new CirCommonBiz(con);
            CirInitModel cacMdl = new CirInitModel();
            cacMdl = cmnBiz.getCirInitConf(0, con);

            CirInfDao infDao = new CirInfDao(con);
            CirViewDao viewDao = new CirViewDao(con);
            CirCommonBiz cirBiz = new CirCommonBiz();

            //回覧板自動削除
            CirAdelDao delDao = new CirAdelDao(con);
            CirAdelModel adelMdl = delDao.select(0);



            //「管理者が設定する」で設定済み
            if (adelMdl != null
                    && cacMdl.getCinAutoDelKbn() == GSConstCircular.CIR_DEL_KBN_ADM_SETTING) {

                if (adelMdl.getCadJdelKbn() == GSConstCircular.CIR_AUTO_DEL_LIMIT) {
                    //受信
                    cirBiz.deleteView(con, adelMdl, 1);
                }

                if (adelMdl.getCadSdelKbn() == GSConstCircular.CIR_AUTO_DEL_LIMIT) {

                    //回覧先の状態区分を更新する(削除)
                    List<Integer> allDelList = infDao.getDeleteCir(adelMdl, 1);
                    if (allDelList != null && !allDelList.isEmpty()) {
                        UDate now = new UDate();
                        CirViewLabelDao labelViewDao = new CirViewLabelDao(con);
                        for (Integer delCifSid : allDelList) {
                            viewDao.deleteAllView(delCifSid, 0, now);
                            labelViewDao.deleteCircularLabel(delCifSid);
                        }
                    }

                    //送信
                    cirBiz.deleteInf(con, adelMdl, 1);
                }

                if (adelMdl.getCadDdelKbn() == GSConstCircular.CIR_AUTO_DEL_LIMIT) {
                    //ゴミ箱
                    cirBiz.deleteView(con, adelMdl, 2);
                    cirBiz.deleteInf(con, adelMdl, 2);
                }

            //「各ユーザが設定する」で設定済み
            } else if (cacMdl.getCinAutoDelKbn()
                                        == GSConstCircular.CIR_DEL_KBN_USER_SETTING) {

                //ラベル
                CirInfLabelDao labelInfDao = new CirInfLabelDao(con);
                CirViewLabelDao labelViewDao = new CirViewLabelDao(con);
                //[自動削除する]に設定されている個人設定データを区分毎に取得
                ArrayList<CirAdelModel> jdelList = delDao.selectAutoDelUserData(1);
                ArrayList<CirAdelModel> sdelList = delDao.selectAutoDelUserData(2);
                ArrayList<CirAdelModel> ddelList = delDao.selectAutoDelUserData(3);

                //受信データ削除
                if (!jdelList.isEmpty()) {
                    //ラベル物理削除
                    labelViewDao.deleteLabel(jdelList, 1);
                    viewDao.delete(jdelList, 1);
                }

                //送信データ削除
                if (!sdelList.isEmpty()) {
                    //ラベル物理削除
                    labelInfDao.deleteLabel(sdelList, 1);
                    //回覧先の状態区分を更新する(削除)
                    viewDao.deleteSendView(sdelList);
                    infDao.delete(sdelList, 1);
                }

                //ゴミデータ削除
                if (!ddelList.isEmpty()) {
                    //ラベル物理削除
                    labelInfDao.deleteLabel(ddelList, 2);
                    labelViewDao.deleteLabel(ddelList, 2);
                    //回覧板論理削除
                    infDao.delete(ddelList, 2);
                    viewDao.delete(ddelList, 2);
                }
            }


            //削除対象の回覧板SIDを取得
            CircularDao cDao = new CircularDao(con);
            String[] delLst = cDao.getDelList();

            //回覧板情報を物理削除、バイナリ情報を論理削除
            cDao.deleteCir(delLst, GSConstUser.SID_ADMIN);

            //未登録の統計情報_集計結果を登録
            CirLogCountSumDao logSumDao = new CirLogCountSumDao(con);
            List<CirLogCountSumModel> logSumList = logSumDao.getNonRegisteredList(new UDate());
            if (logSumList != null && !logSumList.isEmpty()) {
                for (CirLogCountSumModel logSumMdl : logSumList) {
                    if (logSumDao.update(logSumMdl) == 0) {
                        logSumDao.insert(logSumMdl);
                    }
                }
            }

            //回覧板 統計情報集計データ削除
            log__.debug("回覧板 統計情報集計データ削除処理開始");
            CirLogCountAdelModel cirLogCntAdelMdl = null;
            CirLogCountAdelDao cirLogCntAdelDao = new CirLogCountAdelDao(con);
            List<CirLogCountAdelModel> adelList = cirLogCntAdelDao.select();
            if (adelList != null && !adelList.isEmpty()) {
                cirLogCntAdelMdl = adelList.get(0);
            }
            if (cirLogCntAdelMdl != null
                    && cirLogCntAdelMdl.getCldDelKbn() == GSConstMain.LAD_DELKBN_AUTO) {
                int cirLogAdelYear = cirLogCntAdelMdl.getCldDelYear();
                int cirLogAdelMonth = cirLogCntAdelMdl.getCldDelMonth();

                //削除する境界の日付を設定する
                UDate cirLogDelUd = new UDate();
                log__.debug("現在日 = " + cirLogDelUd.getDateString());
                log__.debug("削除条件 経過年 = " + cirLogAdelYear);
                log__.debug("削除条件 経過月 = " + cirLogAdelMonth);
                cirLogDelUd.addYear(cirLogAdelYear * -1);
                cirLogDelUd.addMonth(cirLogAdelMonth * -1);
                cirLogDelUd.setMaxHhMmSs();
                log__.debug("削除境界線(この日以前のデータを削除) = " + cirLogDelUd.getTimeStamp());

                StatisticsBiz statsBiz = new StatisticsBiz();
                //集計データを削除
                int cirLogDelCount = statsBiz.deleteLogCount(
                        con, "CIR_LOG_COUNT", "CLC_DATE", cirLogAdelYear, cirLogAdelMonth);
                log__.debug("回覧板 統計情報集計データ" + cirLogDelCount + "件を削除");
            }

            con.commit();
            commitFlg = true;

            log__.debug("回覧板バッチ処理終了");

        } catch (Exception e) {
            log__.error("回覧板バッチ処理失敗", e);
            JDBCUtil.rollback(con);
            logException = e;
            throw e;
        } finally {
            if (commitFlg) {
                DayJob.outPutFinishLog(con, param.getDomain(), pluginName, startTime);
            } else {
                JDBCUtil.rollback(con);
                DayJob.outPutFailedLog(con, param.getDomain(), pluginName, logException);
            }
        }
    }

    /**
     * <p>1時間間隔で実行されるJob
     * @param con DBコネクション
     * @param param バッチ処理時に使用する情報
     * @throws Exception バッチ処理実行時例外
     */
    public void doOneHourBatch(Connection con, IBatchModel param) throws Exception {
    }

    /**
     * <p>5分間隔で実行されるJob
     * @param con DBコネクション
     * @param param バッチ処理時に使用する情報
     * @throws Exception バッチ処理実行時例外
     */
    public void do5mBatch(Connection con, IBatchModel param) throws Exception {
    }
}

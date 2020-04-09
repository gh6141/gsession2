package jp.groupsession.v2.cir.cir040kn;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.apache.commons.collections.ListUtils;
import org.apache.commons.lang.ObjectUtils;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.util.LabelValueBean;

import jp.co.sjts.util.NullDefault;
import jp.co.sjts.util.StringUtil;
import jp.co.sjts.util.StringUtilHtml;
import jp.co.sjts.util.ValidateUtil;
import jp.co.sjts.util.date.UDate;
import jp.co.sjts.util.io.IOTools;
import jp.co.sjts.util.io.IOToolsException;
import jp.co.sjts.util.jdbc.JDBCUtil;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.biz.CirCommonBiz;
import jp.groupsession.v2.cir.biz.CirFileEditCheckBiz;
import jp.groupsession.v2.cir.biz.CirNotifyBiz;
import jp.groupsession.v2.cir.dao.CirAccountDao;
import jp.groupsession.v2.cir.dao.CirBinDao;
import jp.groupsession.v2.cir.dao.CirInfDao;
import jp.groupsession.v2.cir.dao.CirViewDao;
import jp.groupsession.v2.cir.dao.CircularDao;
import jp.groupsession.v2.cir.model.CirAccountModel;
import jp.groupsession.v2.cir.model.CirBinModel;
import jp.groupsession.v2.cir.model.CirInfModel;
import jp.groupsession.v2.cmn.GSConst;
import jp.groupsession.v2.cmn.biz.CommonBiz;
import jp.groupsession.v2.cmn.dao.MlCountMtController;
import jp.groupsession.v2.cmn.exception.TempFileException;
import jp.groupsession.v2.cmn.model.RequestModel;
import jp.groupsession.v2.cmn.model.base.CmnBinfModel;
import jp.groupsession.v2.struts.msg.GsMessage;

/**
 * <br>[機  能] 回覧板 新規作成確認画面のビジネスロジッククラス
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir040knBiz {

    /** Logging インスタンス */
    private static Log log__ = LogFactory.getLog(Cir040knBiz.class);
    /** DBコネクション */
    public Connection con__ = null;
    /** リクエストモデル*/
    private RequestModel reqMdl__ = null;



    /**
     * コンストラクタ
     * @param con コネクション
     * @param reqMdl リクエストモデル
     */
    public Cir040knBiz(Connection con, RequestModel reqMdl) {
        con__ = con;
        reqMdl__ = reqMdl;
    }

    /**
     * <br>[機  能] テンポラリディレクトリのファイル削除を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param tempDir テンポラリディレクトリパス
     * @throws IOToolsException ファイルアクセス時例外
     */
    public void doDeleteFile(String tempDir) throws IOToolsException {

        //テンポラリディレクトリのファイルを削除する
        IOTools.deleteDir(tempDir);
        log__.debug("テンポラリディレクトリのファイル削除");
    }

    /**
     * <br>[機  能] 初期表示情報を画面にセットする
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param con コネクション
     * @param tempDir テンポラリディレクトリパス
     * @throws SQLException SQL実行例外
     * @throws IOToolsException ファイルアクセス時例外
     */
    public void setInitData(
        Cir040knParamModel paramMdl,
        Connection con,
        String tempDir) throws SQLException, IOToolsException {

        CirAccountDao cacDao = new CirAccountDao(con);
        CirAccountModel cacMdl = null;

        cacMdl = cacDao.select(paramMdl.getCir040AccountSid());

        if (cacMdl != null) {
            //アカウント名
            paramMdl.setCirViewAccountName(cacMdl.getCacName());
            //アカウントテーマ
            paramMdl.setCir010AccountTheme(cacMdl.getCacTheme());

            paramMdl.setCirViewAccountUko(cacMdl.getUsrUkoFlg());
        }

        /** 回覧先をセット ******************************************************/
        if (paramMdl.getCir040userSid() != null
                && paramMdl.getCir040userSid().length > 0) {
            CirCommonBiz cirBiz = new CirCommonBiz();
            paramMdl.setCir040MemberList(cirBiz.getAccountList(con, paramMdl.getCir040userSid()));
        }


        //表示用内容
        String tmpBody =
            StringUtilHtml.transToHTmlPlusAmparsant(
                    NullDefault.getString(paramMdl.getCir040value(), ""));
        tmpBody = StringUtil.transToLink(tmpBody, StringUtil.OTHER_WIN, true);


        //「編集」の場合、回覧板送信先削除判定を行う
        paramMdl.setCir040knWarnAttesakiDel(Cir040knForm.DSP_WARN_ATTSAKI_DEL_NO);
        if (paramMdl.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_EDIT) {
            //回覧板SID
            int cifSid = NullDefault.getInt(paramMdl.getCirEditInfSid(), -1);

            //回覧先
            CirViewDao cirViewDao = new CirViewDao(con);
            List<String> loadAccSidList = new ArrayList<String>();
            List<Integer> intSidList = cirViewDao.getCirViewUser(cifSid);
            for (Integer intSid : intSidList) {
                loadAccSidList.add(String.valueOf(intSid));
            }

            List<String> viewAccSidList = new ArrayList<>();
            for (CirAccountModel accMdl : paramMdl.getCir040MemberList()) {
                viewAccSidList.add(String.valueOf(accMdl.getCacSid()));
            }
            for (String accSid : loadAccSidList) {
                if (!viewAccSidList.contains(accSid)) {
                    paramMdl.setCir040knWarnAttesakiDel(Cir040knForm.DSP_WARN_ATTSAKI_DEL_YES);
                    break;
                }

            }

        }


        paramMdl.setCir040knBody(tmpBody);
    }
    /**
     * <br>[機  能] 回覧板の登録を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param cntCon MlCountMtController
     * @param userSid ログインユーザSID
     * @param tempDir テンポラリディレクトリパス
     * @param appRootPath アプリケーションのルートパス
     * @return int 回覧板SID
     * @throws Exception 実行時例外
     */
    public int doInsert(
            Cir040knParamModel paramMdl,
            MlCountMtController cntCon,
            int userSid,
            String tempDir,
            String appRootPath)
    throws Exception {

        int cirSid = 0;

        boolean commit = false;
        try {
            con__.setAutoCommit(false);

            //システム日付
            UDate now = new UDate();

            /** 添付ファイルを登録 **********************************************/
            //テンポラリディレクトリパスにある添付ファイルを全て登録
            CommonBiz biz = new CommonBiz();
            List < String > binList =
                biz.insertBinInfo(con__, tempDir, appRootPath, cntCon, userSid, now);


            /** 回覧板情報を登録 **********************************************/
            //回覧板SID採番
            cirSid = (int) cntCon.getSaibanNumber(GSConstCircular.SBNSID_CIRCULAR,
                                                       GSConstCircular.SBNSID_SUB_CIRCULAR,
                                                       userSid);

            log__.debug("shoukbn ===> " + paramMdl.getCir040show());

            /** メモ欄修正期限を設定 *******************************************/
            UDate memoLimit = new UDate();
            int year = paramMdl.getCir040memoPeriodYear();
            int month = paramMdl.getCir040memoPeriodMonth();
            int day = paramMdl.getCir040memoPeriodDay();

            if (year == -1 && month == -1 && day == -1) {
                memoLimit = null;
            } else {
                memoLimit.setDate(year, month, day);
            }

            CirInfModel ciMdl = new CirInfModel();
            ciMdl.setCifSid(cirSid);
            ciMdl.setCifTitle(NullDefault.getString(paramMdl.getCir040title(), ""));
            ciMdl.setGrpSid(NullDefault.getInt(paramMdl.getCir040groupSid(), -1));
            ciMdl.setCifValue(NullDefault.getString(paramMdl.getCir040value(), ""));
            ciMdl.setCifAuid(paramMdl.getCir040AccountSid());
            ciMdl.setCifAdate(now);
            ciMdl.setCifEuid(paramMdl.getCir040AccountSid());
            ciMdl.setCifEdate(now);
            ciMdl.setCifJkbn(GSConstCircular.DSPKBN_DSP_OK);
            ciMdl.setCifEkbn(GSConstCircular.CIR_NO_EDIT);
            ciMdl.setCifShow(paramMdl.getCir040show());
            ciMdl.setCifMemoFlg(paramMdl.getCir040memoKbn());
            ciMdl.setCifMemoDate(memoLimit);
            ciMdl.setCifEditDate(now);

            //回覧板情報を登録する
            CircularDao cDao = new CircularDao(con__);
            cDao.insertCir(
               ciMdl, binList, paramMdl.getCir040userSid());

            con__.commit();

            if (paramMdl.getCir040userSid() != null
                    && paramMdl.getCir040userSid().length > 0) {
                CirCommonBiz cirBiz = new CirCommonBiz();
                paramMdl.setCir040MemberList(
                        cirBiz.getAccountList(con__, paramMdl.getCir040userSid()));
            }
            /** 新回覧先*/
            List<Integer> newAccSidList = new ArrayList<>();
            for (CirAccountModel accMdl : paramMdl.getCir040MemberList()) {
                newAccSidList.add(accMdl.getCacSid());
            }

            CirNotifyBiz notifyBiz = new CirNotifyBiz(con__, reqMdl__);
            //追加送信者へ受信ショートメール通知
            notifyBiz.doNotifiesJusin(cntCon, newAccSidList, ciMdl, appRootPath);


            commit = true;
        } catch (SQLException e) {
            log__.warn("回覧板登録に失敗", e);
            JDBCUtil.rollback(con__);
            throw e;
        } catch (TempFileException e) {
            log__.warn("回覧板添付ファイル登録に失敗", e);
            JDBCUtil.rollback(con__);
            throw e;
        } finally {
            if (!commit) {
                con__.rollback();
            }
        }

        //テンポラリディレクトリのファイルを削除する
        IOTools.deleteDir(tempDir);
        log__.debug("テンポラリディレクトリのファイル削除");

        return cirSid;
    }

    /**
     * <br>[機  能] 回覧板の登録を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param userSid ログインユーザSID
     * @param tempDir テンポラリディレクトリパス
     * @param cntCon MlCountMtController
     * @param appRootPath アプリケーションのルートパス
     * @return int 回覧板SID
     * @throws Exception 実行時例外
     */
    public int doEdit(
            Cir040knParamModel paramMdl,
            int userSid,
            String tempDir,
            MlCountMtController cntCon,
            String appRootPath)
    throws Exception {

        int cirSid = 0;
        boolean commit = false;
        try {

            if (ValidateUtil.isNumber(paramMdl.getCirEditInfSid())) {
                cirSid = Integer.valueOf(paramMdl.getCirEditInfSid());


                //新規追加宛先取得
                CirViewDao cirViewDao = new CirViewDao(con__);

                if (paramMdl.getCir040userSid() != null
                        && paramMdl.getCir040userSid().length > 0) {
                    CirCommonBiz cirBiz = new CirCommonBiz();
                    paramMdl.setCir040MemberList(
                            cirBiz.getAccountList(con__, paramMdl.getCir040userSid()));
                }

                /** 回覧板情報モデル */
                //回覧板情報を取得する
                CirInfDao infDao = new CirInfDao(con__);
                CirInfModel oldMdl = infDao.getCirInfo(cirSid);

                /** 旧回覧先*/
                List<String> accSidStrList = cirViewDao.getCirViewUserStr(cirSid);

                List<Integer> loadAccSidList = new ArrayList<>();
                for (String sidStr : accSidStrList) {
                    loadAccSidList.add(NullDefault.getInt(sidStr, 0));
                }
                /** 新回覧先*/
                List<Integer> newAccSidList = new ArrayList<>();
                for (CirAccountModel accMdl : paramMdl.getCir040MemberList()) {
                    newAccSidList.add(accMdl.getCacSid());
                }
                /** 追加回覧先*/
                @SuppressWarnings("unchecked")
                List<Integer> addAcc = ListUtils.subtract(newAccSidList, loadAccSidList);
                /** 削除回覧先*/
                @SuppressWarnings("unchecked")
                List<Integer> rmAcc = ListUtils.subtract(loadAccSidList, newAccSidList);
                /** 既存回覧先*/
                @SuppressWarnings("unchecked")
                List<Integer> edAcc = ListUtils.subtract(newAccSidList, addAcc);

                /** システム日付*/
                UDate now = new UDate();

                /** 回覧板情報モデル */
                CirInfModel ciMdl = new CirInfModel();
                ciMdl.setCifSid(cirSid);
                ciMdl.setCifTitle(NullDefault.getString(paramMdl.getCir040title(), ""));
                ciMdl.setGrpSid(NullDefault.getInt(paramMdl.getCir040groupSid(), -1));
                ciMdl.setCifValue(NullDefault.getString(paramMdl.getCir040value(), ""));
                ciMdl.setCifAuid(paramMdl.getCir040AccountSid());
                ciMdl.setCifAdate(now);
                ciMdl.setCifEuid(paramMdl.getCir040AccountSid());
                ciMdl.setCifEdate(now);
                ciMdl.setCifJkbn(GSConstCircular.DSPKBN_DSP_OK);
                ciMdl.setCifShow(paramMdl.getCir040show());
                ciMdl.setCifMemoFlg(paramMdl.getCir040memoKbn());
                // メモ欄修正期限を設定
                UDate memoLimit = new UDate();
                int year = paramMdl.getCir040memoPeriodYear();
                int month = paramMdl.getCir040memoPeriodMonth();
                int day = paramMdl.getCir040memoPeriodDay();

                if (year == -1 && month == -1 && day == -1) {
                    memoLimit = null;
                } else {
                    memoLimit.setDate(year, month, day);
                }
                ciMdl.setCifMemoDate(memoLimit);
                con__.setAutoCommit(false);

                /** 内容編集判定*/
                boolean edit = __isEdited(oldMdl, ciMdl, tempDir);

                if (edit) {
                    ciMdl.setCifEkbn(GSConstCircular.CIR_EDIT);
                    ciMdl.setCifEditDate(now);
                } else {
                    ciMdl.setCifEkbn(oldMdl.getCifEkbn());
                    ciMdl.setCifEditDate(oldMdl.getCifEditDate());
                }



                CircularDao cDao = new CircularDao(con__);

                /** 添付ファイルを登録 **********************************************/
                CirBinDao bdao = new CirBinDao(con__);
                List < CirBinModel > cbList
                           = bdao.getBinList(new String[] {String.valueOf(cirSid)});
                List<Long> cbSidList = new ArrayList<Long>();
                for (CirBinModel cbMdl : cbList) {
                    cbSidList.add(cbMdl.getBinSid());
                }
                //バイナリ情報を論理削除
                CmnBinfModel cbMdl = new CmnBinfModel();
                cbMdl.setBinJkbn(GSConst.JTKBN_DELETE);
                cbMdl.setBinUpuser(userSid);
                cbMdl.setBinUpdate(now);
                cDao.updateJKbn(cbMdl, cbSidList);

                //回覧板添付情報(CIR_BIN)を物理削除
                bdao.deleteCriBin(new String[] {paramMdl.getCirEditInfSid()});

                //テンポラリディレクトリパスにある添付ファイルを全て登録
                CommonBiz biz = new CommonBiz();
                List < String > binList =
                    biz.insertBinInfo(con__, tempDir, appRootPath, cntCon, userSid, now);


                log__.debug("shoukbn ===> " + paramMdl.getCir040show());



                //回覧板情報を登録する
                cDao.updateCir(
                   ciMdl, binList, addAcc, rmAcc);

                con__.commit();

                CirNotifyBiz notifyBiz = new CirNotifyBiz(con__, reqMdl__);
                //追加送信者へ受信ショートメール通知
                notifyBiz.doNotifiesJusin(cntCon, addAcc, ciMdl, appRootPath);

                if (edit) {

                    //既存送信者へ編集ショートメール通知
                    notifyBiz.doNotifiesEdit(cntCon, edAcc, ciMdl, appRootPath);

                }
                con__.commit();
                commit = true;
            }
            //テンポラリディレクトリのファイルを削除する
            IOTools.deleteDir(tempDir);
            log__.debug("テンポラリディレクトリのファイル削除");
        } catch (SQLException e) {
            log__.warn("回覧板登録に失敗", e);
            JDBCUtil.rollback(con__);
            throw e;
        } catch (TempFileException e) {
            log__.warn("回覧板添付ファイル登録に失敗", e);
            JDBCUtil.rollback(con__);
            throw e;
        } finally {
            if (!commit) {
                con__.rollback();
            }
        }


        return cirSid;
    }

    /**
     *
     * <br>[機  能] 回覧板編集判定を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param oldMdl 旧登録情報
     * @param ciMdl 新登録情報
     * @param tempDir テンポラリディレクトリパス
     * @return true : 変更有 false : 変更なし
     * @throws IOToolsException ファイルアクセス実行時例外
     * @throws IOException ファイルアクセス実行時例外
     */
    private boolean __isEdited(CirInfModel oldMdl, CirInfModel ciMdl,
            String tempDir) throws IOToolsException, IOException {
        //タイトル
        if (!ObjectUtils.equals(oldMdl.getCifTitle(), ciMdl.getCifTitle())) {
            return true;
        }
        //内容
        if (!ObjectUtils.equals(oldMdl.getCifValue(), ciMdl.getCifValue())) {
            return true;
        }
        //メモ欄の修正
        if (oldMdl.getCifMemoFlg() != ciMdl.getCifMemoFlg()) {
            return true;
        } else if (oldMdl.getCifMemoFlg() == GSConstCircular.CIR_INIT_MEMO_CHANGE_YES) {
            //修正期限
            UDate d1 = oldMdl.getCifMemoDate();
            UDate d2 = ciMdl.getCifMemoDate();
            if (d1 == null || d2 == null) {
                return true;
            }
            d1.setZeroHhMmSs();
            d2.setZeroHhMmSs();
            if (!d1.equalsTimeStamp(d2)) {
                return true;
            }
        }
        //回覧先確認状況
        if (oldMdl.getCifShow() != ciMdl.getCifShow()) {
            return true;
        }
        //添付ファイル
        CirFileEditCheckBiz fchkBiz = new CirFileEditCheckBiz();
        if (fchkBiz.isFileEdit(tempDir)) {
            return true;
        }
        return false;
    }

    /**
     * <br>[機  能] 添付ファイル情報をセット
     * <br>[解  説]
     * <br>[備  考]
     *
     * @param paramMdl パラメータ情報
     * @param tempDir テンポラリディレクトリ
     * @throws IOToolsException ファイルアクセス時例外
     */
    @SuppressWarnings("unchecked")
    public void setTempFiles(Cir040knParamModel paramMdl, String tempDir)
        throws IOToolsException {

        /** 画面に表示するファイルのリストを作成、セット **********************/
        CommonBiz commonBiz = new CommonBiz();
        List<LabelValueBean> sortList = commonBiz.getTempFileLabelList(tempDir);
        Collections.sort(sortList);
        paramMdl.setCir040FileLabelList(sortList);
    }
    /**
     *
     * <br>[機  能] オペレーションログ内容を出力する
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータモデル
     * @return オペレーションログ内容
     * @throws SQLException SQL実行時例外
     */
    public String getOperationLogForCommit(Cir040knParamModel paramMdl) throws SQLException {
        StringBuilder sb = new StringBuilder();
        GsMessage gsMsg = new GsMessage(reqMdl__);

        //送信者
        CirAccountDao cacDao = new CirAccountDao(con__);
        CirAccountModel cacMdl = null;

        cacMdl = cacDao.select(paramMdl.getCir040AccountSid());

        if (cacMdl != null) {
            sb.append(gsMsg.getMessage("cir.2")).append(":").append(cacMdl.getCacName());
        }
        sb.append(" \r\n");
        //タイトル
        sb.append(gsMsg.getMessage("cmn.title")).append(":").append(paramMdl.getCir040title());
        sb.append(" \r\n");
        //回覧先
        sb.append(gsMsg.getMessage("cir.20")).append(":");
        CirCommonBiz cirBiz = new CirCommonBiz();
        List<CirAccountModel> accList = cirBiz.getAccountList(con__, paramMdl.getCir040userSid());
        boolean first = true;
        for (CirAccountModel acc : accList) {
            if (!first) {
                sb.append(", ");
            }
            sb.append(acc.getCacName());
        }
        return sb.toString();
    }
}

package jp.groupsession.v2.cir.cir040;

import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.util.LabelValueBean;

import jp.co.sjts.util.NullDefault;
import jp.co.sjts.util.date.UDate;
import jp.co.sjts.util.date.UDateUtil;
import jp.co.sjts.util.io.IOTools;
import jp.co.sjts.util.io.IOToolsException;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.biz.CirCommonBiz;
import jp.groupsession.v2.cir.biz.CirFileEditCheckBiz;
import jp.groupsession.v2.cir.cir180.Cir180Dao;
import jp.groupsession.v2.cir.dao.CirAccountDao;
import jp.groupsession.v2.cir.dao.CirBinDao;
import jp.groupsession.v2.cir.dao.CirInfDao;
import jp.groupsession.v2.cir.dao.CirInitDao;
import jp.groupsession.v2.cir.dao.CirViewDao;
import jp.groupsession.v2.cir.model.AccountDataModel;
import jp.groupsession.v2.cir.model.CirAccountModel;
import jp.groupsession.v2.cir.model.CirBinModel;
import jp.groupsession.v2.cir.model.CirInfModel;
import jp.groupsession.v2.cir.model.CirInitModel;
import jp.groupsession.v2.cmn.biz.CommonBiz;
import jp.groupsession.v2.cmn.dao.WmlDao;
import jp.groupsession.v2.cmn.exception.TempFileException;
import jp.groupsession.v2.cmn.model.RequestModel;
import jp.groupsession.v2.cmn.model.WmlMailDataModel;
import jp.groupsession.v2.cmn.model.base.CmnBinfModel;
import jp.groupsession.v2.cmn.model.base.WmlTempfileModel;
import jp.groupsession.v2.struts.msg.GsMessage;

/**
 * <br>[機  能] 回覧板 新規作成画面のビジネスロジッククラス
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir040Biz {

    /** Logging インスタンス */
    private static Log log__ = LogFactory.getLog(Cir040Biz.class);
    /** 定数 メモ欄修正期限 1週間 */
    private static final int PERIOD_ONEWEEK = 0;
    /** 定数 メモ欄修正期限 2週間 */
    private static final int PERIOD_TWOWEEK = 2;
    /** 定数 メモ欄修正期限 1カ月 */
    private static final int PERIOD_ONEMONTH = 3;

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
     * @param con コネクション
     * @param paramMdl パラメータ情報
     * @param tempDir テンポラリディレクトリパス
     * @param reqMdl リクエスト情報
     * @throws Exception 実行例外
     */
    public void setInitData(
        Cir040ParamModel paramMdl,
        Connection con,
        String tempDir,
        RequestModel reqMdl) throws Exception {

        CirAccountDao cacDao = new CirAccountDao(con);
        CirAccountModel cacMdl = null;

        cacMdl = cacDao.select(paramMdl.getCir040AccountSid());

        if (cacMdl != null) {
            //アカウント
            paramMdl.setCir040AccountSid(cacMdl.getCacSid());
            //アカウント名
            paramMdl.setCirViewAccountName(cacMdl.getCacName());
            //アカウントテーマ
            paramMdl.setCir010AccountTheme(cacMdl.getCacTheme());

            paramMdl.setCirViewAccountUko(cacMdl.getUsrUkoFlg());
        }

        //使用可能なアカウントの一覧を取得する
        Cir180Dao dao = new Cir180Dao(con);
        List<AccountDataModel> accountList = dao.getAccountList(reqMdl.getSmodel().getUsrsid());
        paramMdl.setCir010AccountList(accountList);


        GsMessage gsMsg = new GsMessage(reqMdl);
        String strMonth = gsMsg.getMessage("cmn.month");
        String strDay = gsMsg.getMessage("cmn.day");

        CommonBiz commonBiz = new CommonBiz();
        paramMdl.setCir040FileLabelList(commonBiz.getTempFileLabelList(tempDir));

        /** 回覧先をセット ******************************************************/


        if (paramMdl.getCir040userSid() != null
                && paramMdl.getCir040userSid().length > 0) {
            CirCommonBiz cirBiz = new CirCommonBiz();
            paramMdl.setCir040MemberList(cirBiz.getAccountList(con, paramMdl.getCir040userSid()));

        }



        /** 日付をセット ********************************************************/
        UDate now = new UDate();
        String nowYear = now.getStrYear();
        String nextYear = Integer.toString(now.getYear() + 1);
        ArrayList<LabelValueBean> yearCmb = new ArrayList<LabelValueBean>();
        ArrayList<LabelValueBean> monthCmb = new ArrayList<LabelValueBean>();
        ArrayList<LabelValueBean> dayCmb = new ArrayList<LabelValueBean>();
        //過去はありえない、最大未来1年間なので
        yearCmb.add(
                new LabelValueBean(
                        gsMsg.getMessage("cmn.year", new String[] {nowYear}), nowYear));
        yearCmb.add(
                new LabelValueBean(
                        gsMsg.getMessage("cmn.year", new String[] {nextYear}), nextYear));

        for (int i = 1; i <= 12; i++) {
            String month = Integer.toString(i);
            monthCmb.add(new LabelValueBean(month + strMonth, month));
        }

        for (int j = 1; j <= 31; j++) {
            String day = Integer.toString(j);
            dayCmb.add(new LabelValueBean(day + strDay, day));
        }

        paramMdl.setCir040memoSelectYear(yearCmb);
        paramMdl.setCir040memoSelectMonth(monthCmb);
        paramMdl.setCir040memoSelectDay(dayCmb);

        int initYear = paramMdl.getCir040memoPeriodYear();
        int initMonth = paramMdl.getCir040memoPeriodMonth();
        int initDay = paramMdl.getCir040memoPeriodDay();

        if (initYear == -1 && initMonth == -1 && initDay == -1) {
            setInitDateData(paramMdl);
        }
    }

    /**
     * <br>[機  能] 初回表示のラジオボタンの値をセットする。
     * <br>[解  説] 初回表示用のラジオの値をDBから取得し、セットをする。
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param con コネクション
     * @param userSid ユーザSID
     * @throws SQLException SQL実行例外
     */
    public void setInitRadioData(Cir040ParamModel paramMdl, Connection con, int userSid)
            throws SQLException {
        //管理者設定の有無
        CirInitDao initDao = new CirInitDao(con);
        //管理者設定モデル
        CirInitModel initMdl = new CirInitModel();

        //管理者設定の有無チェック 0:無し
        if (initDao.getCount() != 0) {
            initMdl = initDao.select();
        } else if (initDao.getCount() == 0) {
            initMdl = getDefaultData();
        }

        //CirUserDao userDao = new CirUserDao(con);
        //CirUserModel userModel = userDao.getCirUserInfo(userSid);

        if (initMdl.getCinInitSetKen() == GSConstCircular.CIR_INIEDIT_STYPE_ADM) {
            //メモ欄の編集権限
            paramMdl.setCir040memoKbn(initMdl.getCinMemoKbn());
            paramMdl.setCir040memoPeriod(initMdl.getCinMemoDay());
            //回覧板公開区分
            paramMdl.setCir040show(initMdl.getCinKouKbn());
        } else if (initMdl.getCinInitSetKen() == GSConstCircular.CIR_INIEDIT_STYPE_USER) {

            CirAccountDao cacDao = new CirAccountDao(con);
            CirAccountModel cacMdl = new CirAccountModel();
            cacMdl = cacDao.select(paramMdl.getCir040AccountSid());

            //初期設定区分
            if (cacMdl.getCacInitKbn() == GSConstCircular.CIR_INIT_KBN_NOSET) {
                paramMdl.setCir040memoKbn(initMdl.getCinMemoKbn());
                paramMdl.setCir040memoPeriod(initMdl.getCinMemoDay());
                paramMdl.setCir040show(initMdl.getCinKouKbn());
            } else if (cacMdl.getCacInitKbn() == GSConstCircular.CIR_INIT_KBN_SET) {
                paramMdl.setCir040memoKbn(cacMdl.getCacMemoKbn());
                paramMdl.setCir040memoPeriod(cacMdl.getCacMemoDay());
                paramMdl.setCir040show(cacMdl.getCacKouKbn());
            }
        }

    }

    /**
     * <br>[機  能] 初期値をセットする
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @throws Exception 実行例外
     */
    public void setInitDateData(Cir040ParamModel paramMdl) throws Exception {

        UDate now = new UDate();

        //期限の初期値
        int kigenKbn = paramMdl.getCir040memoPeriod();
        switch (kigenKbn) {
        case GSConstCircular.CIR_INIT_MEMO_ONEWEEK :
            now.addDay(7);
            break;

        case GSConstCircular.CIR_INIT_MEMO_TWOWEEKS :
            now.addDay(14);
            break;

        case GSConstCircular.CIR_INIT_MEMO_ONEMONTH :
            now.addMonth(1);
            break;

        default:
            break;
        }

        paramMdl.setCir040memoPeriodYear(now.getYear());
        paramMdl.setCir040memoPeriodMonth(now.getMonth());
        paramMdl.setCir040memoPeriodDay(now.getIntDay());
    }

    /**
     * <br>[機  能] メモ欄修正期限ラジオクリック時に、日付に値をセットする
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @throws Exception 実行例外
     */
    public void setDateData(Cir040ParamModel paramMdl) throws Exception {

        UDate now = new UDate();
        int period = paramMdl.getCir040memoPeriod();

        //ラジオの値によって日付を設定
        if (period == PERIOD_ONEWEEK) {
            //1週間なので7日
            now.addDay(7);
        } else if (period == PERIOD_TWOWEEK) {
            //2週間なので14日
            now.addDay(14);
        } else if (period == PERIOD_ONEMONTH) {
            now.addMonth(1);
        }

        /** 日付の値をフォームにセット *************************************************/
        paramMdl.setCir040memoPeriodYear(now.getYear());
        paramMdl.setCir040memoPeriodMonth(now.getMonth());
        paramMdl.setCir040memoPeriodDay(now.getIntDay());
    }

    /**
     * <br>[機  能]デフォルト値を設定する。
     * <br>[解  説]初期値が設定されてない場合にデフォルト値を設定する。
     * <br>[備  考]
     * @return initMdl 初期値モデル(管理者)
     */
    private CirInitModel getDefaultData() {
        CirInitModel initMdl = new CirInitModel();
        initMdl.setCinInitSetKen(GSConstCircular.CIR_INIEDIT_STYPE_USER);
        initMdl.setCinMemoKbn(GSConstCircular.CIR_INIT_MEMO_CHANGE_NO);
        initMdl.setCinMemoDay(GSConstCircular.CIR_INIT_MEMO_ONEWEEK);
        initMdl.setCinKouKbn(GSConstCircular.CIR_INIT_SAKI_PUBLIC);

        return initMdl;
    }

    /**
     * <br>[機  能] 回覧板 新規作成画面のフォームへ回覧板情報を設定する
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param con コネクション
     * @param appRootPath アプリケーションルートパス
     * @param tempDir テンポラリディレクトリパス
     * @param reqMdl リクエスト情報
     * @throws SQLException SQL実行例外
     * @throws TempFileException 回覧板 添付ファイル情報の取得に失敗
     * @throws IOException 回覧板 添付ファイル情報の取得に失敗
     * @throws IOToolsException 回覧板 添付ファイル情報の取得に失敗
     */
    public void copyCirData(Cir040ParamModel paramMdl, Connection con,
                            String appRootPath, String tempDir,
                            RequestModel reqMdl)
    throws SQLException, TempFileException, IOException, IOToolsException {

        //回覧板SID
        int cifSid = NullDefault.getInt(paramMdl.getCir010selectInfSid(), -1);

        //回覧板情報を取得する
        CirInfDao infDao = new CirInfDao(con);
        CirInfModel cdMdl = infDao.getCirInfo(cifSid);

        //タイトル
        paramMdl.setCir040title(cdMdl.getCifTitle());
        //発信部署
        paramMdl.setCir040groupSid(Integer.toString(cdMdl.getGrpSid()));
        //内容
        paramMdl.setCir040value(cdMdl.getCifValue());
        //公開／非公開
        paramMdl.setCir040show(cdMdl.getCifShow());
        //メモ欄修正区分
        paramMdl.setCir040memoKbn(cdMdl.getCifMemoFlg());

        UDate memoDate = cdMdl.getCifMemoDate();
        if (memoDate != null) {
            //メモ欄修正期限(日付指定・年)
            paramMdl.setCir040memoPeriodYear(memoDate.getYear());
            //メモ欄修正期限(日付指定・月)
            paramMdl.setCir040memoPeriodMonth(memoDate.getMonth());
            //メモ欄修正期限(日付指定・日)
            paramMdl.setCir040memoPeriodDay(memoDate.getIntDay());
        }

        //添付ファイル情報
        CirBinDao cirBinDao = new CirBinDao(con);
        List<CirBinModel> cirBinList = cirBinDao.getBinList(new String[]{Integer.toString(cifSid)});
        if (cirBinList != null && !cirBinList.isEmpty()) {
            CommonBiz cmnBiz = new CommonBiz();
            UDate now = new UDate();
            String dateStr = now.getDateString();

            int fileIdx = 1;
            for (CirBinModel cirBinData : cirBinList) {
                CmnBinfModel binMdl
                    = cmnBiz.getBinInfo(con, cirBinData.getBinSid(), reqMdl.getDomain());
                if (binMdl != null) {
                    //添付ファイルをテンポラリディレクトリにコピーする。
                    cmnBiz.saveTempFile(dateStr, binMdl, appRootPath, tempDir, fileIdx++);
                }
            }
        }
        //テンポラリディレクトリにあるファイル目録の作成
        CirFileEditCheckBiz fileChkBiz = new CirFileEditCheckBiz();
        fileChkBiz.createMokulokuFile(tempDir);

        //回覧先
        CirViewDao cirViewDao = new CirViewDao(con);
        List<String> viewUserList;
        if (paramMdl.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_COPY) {
            viewUserList = cirViewDao.getCirViewUserStr(cifSid);
        } else {
            viewUserList = new ArrayList<String>();
            List<Integer> intSidList = cirViewDao.getCirViewUser(cifSid);
            for (Integer intSid : intSidList) {
                viewUserList.add(String.valueOf(intSid));
            }
        }
        if (viewUserList != null && !viewUserList.isEmpty()) {
            String[] cmn120UserSid = new String[viewUserList.size()];

            CirAccountDao cacDao = new CirAccountDao(con);
            List<CirAccountModel> accountMdlList = null;
            CirAccountModel accountMdl = null;
            accountMdlList = cacDao.getAccountList(
                    (String[]) viewUserList.toArray(new String[viewUserList.size()]));

            for (int idx = 0; idx < accountMdlList.size(); idx++) {
                accountMdl = accountMdlList.get(idx);
                if (accountMdl.getUsrSid() > 0) {
                    cmn120UserSid[idx] = String.valueOf(accountMdl.getUsrSid());
                } else {
                    cmn120UserSid[idx] = GSConstCircular.CIR_ACCOUNT_STR
                    + accountMdl.getCacSid();
                }

            }
            paramMdl.setCir040userSid(cmn120UserSid);

        }

        if (paramMdl.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_COPY) {
            //回覧板情報の複写完了後、登録モードを「新規作成」に変更する
            paramMdl.setCirEntryMode(GSConstCircular.CIR_ENTRYMODE_NEW);
        }
    }

    /**
     * <br>[機  能] WEBメール メール情報を設定する
     * <br>[解  説]
     * <br>[備  考]
     * @param con コネクション
     * @param paramMdl パラメータ情報
     * @param appRootPath アプリケーションルートパス
     * @param tempDir テンポラリディレクトリパス
     * @param reqMdl リクエスト情報
     * @throws Exception 実行例外
     */
    public void setWebmailData(
        Cir040ParamModel paramMdl,
        Connection con,
        String appRootPath,
        String tempDir,
        RequestModel reqMdl) throws Exception {

        long mailNum = paramMdl.getCir040webmailId();
        WmlDao wmlDao = new WmlDao(con);
        WmlMailDataModel mailData = wmlDao.getMailData(mailNum, reqMdl.getDomain());
        paramMdl.setCir040title(mailData.getSubject());

        GsMessage gsMsg = new GsMessage(reqMdl);
        String body = gsMsg.getMessage("cmn.subject") + ": "
                            + NullDefault.getString(mailData.getSubject(), "")
                            + "\r\n";
        body += gsMsg.getMessage("cmn.sender") + ": "
                    + NullDefault.getString(mailData.getFromAddress(), "")
                    + "\r\n";

        body += gsMsg.getMessage("cmn.send.date") + ": ";
        UDate sendDate = mailData.getSendDate();
        if (sendDate != null) {
            body += UDateUtil.getSlashYYMD(sendDate)
                    + " "
                    + UDateUtil.getSeparateHMS(sendDate);
        }
        body += "\r\n";

        body += gsMsg.getMessage("cmn.from") + ": "
                    + __createAddressStr(mailData.getToList())
                    + "\r\n";
        body += "CC: " + __createAddressStr(mailData.getCcList()) + "\r\n";
        body += "\r\n" + mailData.getBody();

        paramMdl.setCir040value(body);

        if (mailData.getTempFileList() != null) {
            UDate now = new UDate();
            String dateStr = now.getDateString();
            CommonBiz cmnBiz = new CommonBiz();
            int fileNum = 1;
            for (WmlTempfileModel fileMdl : mailData.getTempFileList()) {
                cmnBiz.saveTempFileForWebmail(dateStr, fileMdl, appRootPath, tempDir, fileNum);
                fileNum++;
            }
        }
    }
    /**
     * <br>[機  能] メールアドレス一覧から本文設定用メールアドレス文字列を作成する
     * <br>[解  説]
     * <br>[備  考]
     * @param addressList メールアドレス一覧
     * @return 本文設定用メールアドレス文字列
     */
    private String __createAddressStr(List<String> addressList) {
        String address = "";
        if (addressList != null && !addressList.isEmpty()) {
            address = addressList.get(0);
            for (int adrIdx = 1; adrIdx < addressList.size(); adrIdx++) {
                address += "," + addressList.get(adrIdx);
            }
        }
        return address;
    }
}

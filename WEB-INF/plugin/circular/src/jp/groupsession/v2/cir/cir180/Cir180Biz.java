package jp.groupsession.v2.cir.cir180;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import jp.co.sjts.util.StringUtil;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.biz.CirCommonBiz;
import jp.groupsession.v2.cir.dao.CirAccountDao;
import jp.groupsession.v2.cir.dao.CirAccountSortDao;
import jp.groupsession.v2.cir.model.AccountDataModel;
import jp.groupsession.v2.cir.model.CirAccountModel;
import jp.groupsession.v2.cir.model.CirAccountSortModel;
import jp.groupsession.v2.cir.model.CirInitModel;
import jp.groupsession.v2.cmn.model.RequestModel;

/**
 * <br>[機  能] 回覧板 アカウントの管理画面のビジネスロジッククラス
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir180Biz {

    /** Logging インスタンス */
    private static Log log__ = LogFactory.getLog(Cir180Biz.class);
    /** 並び順分割文字列 */
    private static final String SORT_SEPARATE = ":";

    /**
     * <br>[機  能] 初期表示を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param con コネクション
     * @param paramMdl パラメータ情報
     * @param userSid ユーザSID
     * @param reqMdl RequestModel
     * @throws SQLException SQL実行時例外
     */
    public void setInitData(Connection con,
                             Cir180ParamModel paramMdl,
                             int userSid,
                             RequestModel reqMdl) throws SQLException {

        //アカウント情報を取得する
        Cir180Dao dao = new Cir180Dao(con);
        List<AccountDataModel> accountList = dao.getAccountList(userSid);

        //アカウント並び順再登録
        CirAccountSortDao sortDao = new CirAccountSortDao(con);
        sortDao.deleteAllSort(userSid);
        CirAccountSortModel mdl = null;
        for (int i = 0; i < accountList.size(); i++) {
            AccountDataModel aMdl = accountList.get(i);
            mdl = new CirAccountSortModel();
            mdl.setCacSid(aMdl.getAccountSid());
            mdl.setUsrSid(userSid);
            mdl.setCasSort(i);
            sortDao.insert(mdl);
        }

        List<Cir180AccountDataDspModel> acDspList = new ArrayList<Cir180AccountDataDspModel>();
        Cir180AccountDataDspModel acDatadspMdl = null;
        int count = 0;
        accountList = dao.getAccountList(userSid);
        for (AccountDataModel acDataMdl : accountList) {
            acDatadspMdl = new Cir180AccountDataDspModel();

            acDatadspMdl.setAccountSid(acDataMdl.getAccountSid());
            acDatadspMdl.setAccountName(acDataMdl.getAccountName());
            acDatadspMdl.setAccountType(acDataMdl.getAccountType());
            acDatadspMdl.setAccountBiko(acDataMdl.getAccountBiko());
            acDatadspMdl.setAccountSort((int) acDataMdl.getAccountSort());
            acDatadspMdl.setAcValue(
                    __getRadioValueStr(acDatadspMdl.getAccountSid(),
                                       acDatadspMdl.getAccountSort(),
                                       count));
            acDatadspMdl.setUsrUkoFlg(acDataMdl.getUsrUkoFlg());
            count++;
            acDspList.add(acDatadspMdl);
        }

        paramMdl.setAccountList(acDspList);

        //チェックされている並び順がNULLの場合、初期値設定
        if (StringUtil.isNullZeroString(paramMdl.getCir180sortAccount())
            && accountList.size() > 0) {

            Cir180AccountDataDspModel addspMdl = acDspList.get(0);
            paramMdl.setCir180sortAccount(
                    __getRadioValueStr(addspMdl.getAccountSid(), addspMdl.getAccountSort(), 0));
        }

        //非管理者でもアカウントを登録できるかどうか
        CirCommonBiz cmnBiz = new CirCommonBiz(con);
        CirInitModel camMdl = cmnBiz.getCirInitConf(userSid, con);

        if (camMdl.getCinAcntMake() == GSConstCircular.KANRI_USER_ONLY) {
            paramMdl.setCir180MakeAcntHnt(GSConstCircular.ACCOUNT_ADD_NG);
        }

    }

    /**
     * <br>[機  能] radioにセットする値(文字列)を取得する
     * <br>[解  説] 「アカウントSID-表示順-画面上の表示順」のフォーマットの文字列を返す
     * <br>[備  考]
     * @param lbSid アカウントSID
     * @param lbSort 表示順
     * @param index 画面上の表示順
     * @return String radioにセットする値
     */
    private String __getRadioValueStr(int lbSid, int lbSort, int index) {

        String sort = lbSid + SORT_SEPARATE
                    + lbSort + SORT_SEPARATE
                    + index;
        return sort;
    }

    /**
     * <br>[機  能] 順序変更処理
     * <br>[解  説]
     * <br>[備  考]
     * @param con コネクション
     * @param paramMdl パラメータ情報
     * @param userSid ユーザSID
     * @param changeKbn 処理区分 0:順序をあげる 1:順序を下げる
     * @return updateフラグ
     * @throws SQLException SQL実行時例外
     */
    public boolean updateSort(Connection con, Cir180ParamModel paramMdl, int userSid, int changeKbn)
        throws SQLException {

        //画面表示全キーリスト取得
        String[] keyList = paramMdl.getCir180sortLabel();
        if (keyList == null || keyList.length < 1) {
            return false;
        }

        //ラジオ選択値取得
        String selectedKey = paramMdl.getCir180sortAccount();
        if (StringUtil.isNullZeroString(selectedKey)) {
            return false;
        }

        String[] selectKeyList = selectedKey.split(SORT_SEPARATE);

        //画面表示順
        int selectedKeyDispNum = Integer.parseInt(selectKeyList[2]);
        log__.debug("画面表示順 = " + selectedKeyDispNum);

        //画面の最初に表示されている項目 + 順位を上げる
        if (selectedKeyDispNum == 0 && changeKbn == GSConstCircular.SORT_UP) {
            return false;
        //画面の最後に表示されている項目 + 順位を下げる
        } else if (selectedKeyDispNum == keyList.length - 1
                && changeKbn == GSConstCircular.SORT_DOWN) {
            return false;
        }

        //選択された項目のフィルターSID + ソート順
        int motoSid = Integer.parseInt(selectKeyList[0]);
        int motoSort = Integer.parseInt(selectKeyList[1]);
        int sakiSid = -1;
        int sakiSort = -1;
        int target = selectedKeyDispNum;

        if (changeKbn == GSConstCircular.SORT_UP) {
            target -= 1;
        } else if (changeKbn == GSConstCircular.SORT_DOWN) {
            target += 1;
        }

        //画面表示全キーから入れ替え先のデータを探す
        for (String allKey : keyList) {

            String[] allKeyList = allKey.split(SORT_SEPARATE);
            int allKeyDispNum = Integer.parseInt(allKeyList[2]);
            if (allKeyDispNum == target) {
                sakiSid = Integer.parseInt(allKeyList[0]);
                sakiSort = Integer.parseInt(allKeyList[1]);
                break;
            }
        }

        if (sakiSid == -1 || sakiSort == -1) {
            return false;
        }

        //アカウント並び順の入替を行う
        CirAccountSortDao sortDao = new CirAccountSortDao(con);
        sortDao.delete(motoSid, userSid);
        sortDao.delete(sakiSid, userSid);

        CirAccountSortModel sortModel = new CirAccountSortModel();
        sortModel.setUsrSid(userSid);

        sortModel.setCacSid(motoSid);
        sortModel.setCasSort(target);
        sortDao.insert(sortModel);

        sortModel.setCacSid(sakiSid);
        sortModel.setCasSort(motoSort);
        sortDao.insert(sortModel);

        //新しいキーを設定
        paramMdl.setCir180sortAccount(__getRadioValueStr(motoSid, sakiSort, target));
        return true;
    }

    /**
     * <br>[機  能] ログ用メッセージ取得
     * <br>[解  説]
     * <br>[備  考]
     * @param selectedKey 選択SID
     * @param con コネクション
     * @return ログ用メッセージ
     * @throws SQLException SQLエラー
     */
    public String getTargetName(String selectedKey, Connection con) throws SQLException {

        String[] selectKeyList = selectedKey.split(SORT_SEPARATE);
        //選択された項目のフィルターSID + ソート順
        int motoSid = Integer.parseInt(selectKeyList[0]);
        CirAccountDao dao = new CirAccountDao(con);
        CirAccountModel mdl = dao.select(motoSid);

        return mdl.getCacName();
    }
}

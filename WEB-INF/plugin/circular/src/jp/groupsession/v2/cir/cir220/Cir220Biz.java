package jp.groupsession.v2.cir.cir220;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import jp.co.sjts.util.NullDefault;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.biz.CirCommonBiz;
import jp.groupsession.v2.cir.dao.CirArestDao;
import jp.groupsession.v2.cir.model.CirAconfModel;
import jp.groupsession.v2.cir.model.CirArestModel;
import jp.groupsession.v2.cmn.GSConst;
import jp.groupsession.v2.cmn.biz.GroupBiz;
import jp.groupsession.v2.cmn.biz.UserBiz;
import jp.groupsession.v2.cmn.dao.BaseUserModel;
import jp.groupsession.v2.cmn.dao.GroupDao;
import jp.groupsession.v2.cmn.dao.GroupModel;
import jp.groupsession.v2.cmn.dao.UsidSelectGrpNameDao;
import jp.groupsession.v2.cmn.dao.base.CmnCmbsortConfDao;
import jp.groupsession.v2.cmn.dao.base.CmnGroupmDao;
import jp.groupsession.v2.cmn.dao.base.CmnUsrmDao;
import jp.groupsession.v2.cmn.model.RequestModel;
import jp.groupsession.v2.cmn.model.base.CmnCmbsortConfModel;
import jp.groupsession.v2.cmn.model.base.CmnGroupmModel;
import jp.groupsession.v2.cmn.model.base.CmnUsrmInfModel;
import jp.groupsession.v2.struts.msg.GsMessage;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.util.LabelValueBean;

/**
 * <br>[機  能] 管理者設定 回覧板登録制限設定画面のビジネスロジッククラス
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir220Biz {

    /** Logging インスタンス */
    private static Log log__ = LogFactory.getLog(Cir220Biz.class);
    /** グループ一覧の接頭辞 */
    protected static final String GROUP_PREFIX = "G";

    /**
     * <p>デフォルトコンストラクタ
     */
    public Cir220Biz() {
    }

    /**
     * <br>[機  能] 回覧板登録許可対象者を設定する
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param reqMdl リクエスト情報
     * @param con コネクション
     * @throws SQLException SQL実行例外
     */
    public void setConfData(Cir220ParamModel paramMdl,
                            RequestModel reqMdl,
                            Connection con) throws SQLException {

        if (paramMdl.getCir220initFlg() != 1) {
            paramMdl.setCir220initFlg(1);

            // セッション情報を取得
            BaseUserModel usModel = reqMdl.getSmodel();
            int sessionUsrSid = usModel.getUsrsid();

            // 管理者設定を取得
            CirCommonBiz cirBiz = new CirCommonBiz();
            CirAconfModel aconf = cirBiz.getCirAdminData(con, sessionUsrSid);
            paramMdl.setCir220TaisyoKbn(aconf.getCafArestKbn());

            //回覧板登録制限設定を取得
            CirArestDao arestDao = new CirArestDao(con);
            List<CirArestModel> userList = arestDao.select();
            if (userList == null || userList.isEmpty()) {
                return;
            }

            // 回覧板送信対象者の一覧を作成
            String[] makeUser = null;
            List<String> senderList = new ArrayList<String>();
            for (CirArestModel userData : userList) {
                if (userData.getGrpSid() < 0) {
                    if (__checkUser(con, userData.getUsrSid())) {
                        senderList.add(String.valueOf(userData.getUsrSid()));
                    }
                } else {
                    if (__checkGroup(con, userData.getGrpSid())) {
                        senderList.add(GROUP_PREFIX + String.valueOf(userData.getGrpSid()));
                    }
                }
            }
            makeUser = (String[]) senderList.toArray(new String[senderList.size()]);

            paramMdl.setCir220MakeSenderList(makeUser);
        }
    }

    /**
     * <br>[機  能] 初期表示情報を取得する
     * <br>[解  説]
     * <br>[備  考]
     * @param cir220Model パラメータモデル
     * @param reqMdl リクエストモデル
     * @param con コネクション
     * @throws SQLException SQL実行例外
     */
    public void setInitData(Cir220ParamModel cir220Model,
                            RequestModel reqMdl,
                            Connection con) throws SQLException {

        log__.debug("初期表示情報取得処理");

        // グループラベルをセット
        cir220Model.setCir220GroupLabel(__createGroupLabel(reqMdl, con));

        // 回覧板登録許可対象者をセット
        cir220Model.setCir220AddSenderLabel(_createSenderLabel(cir220Model, con));
        // 回覧板非登録許可者をセット
        cir220Model.setCir220BelongSenderLabel(__createBelongSenderLabel(cir220Model, con));
    }

    /**
     * <br>[機  能] リスト中で選択されている登録許可対象者を追加する
     * <br>[解  説]
     * <br>[備  考]
     * @param list 元のグループリスト
     * @param selectSids 選択グループリスト
     * @return 選択グループを追加したグループリスト
     * @throws Exception 実行例外
     */
    public String[] getListToAdd(String[] list, String[] selectSids) throws Exception {
        String[] retList = null;
        List<String> newList = new ArrayList<String>();

        // 選択中リストの件数チェック
        if (selectSids == null || selectSids.length < 1) {
            return list;
        }

        if (list != null && list.length > 0) {
            for (String str : list) {
                newList.add(str);
            }
        }
        for (String str : selectSids) {
            newList.add(str);
        }
        if (newList.size() > 0) {
            retList = (String[]) newList.toArray(new String[newList.size()]);
        }

        return retList;
    }

    /**
     * <br>[機  能] リスト中で選択されている登録許可対象者を削除する
     * <br>[解  説]
     * <br>[備  考]
     * @param list 元のリスト
     * @param selectSids 選択中のリスト
     * @return 選択中のリストを削除したリスト
     * @throws Exception 実行例外
     */
    public String[] getListToRemove(String[] list, String[] selectSids) throws Exception {

        String[] retList = null;
        String[] select = null;
        List<String> newList = new ArrayList<String>();

        // 元のリスト、選択中リストの件数チェック
        if (list == null || list.length < 1) {
            return list;
        }
        if (selectSids == null || selectSids.length < 1) {
            return list;
        }

        // 元のリストから、選択されている登録許可対象者を除外したリストを作成する
        select = Arrays.copyOf(selectSids, selectSids.length);
        Arrays.sort(select);
        for (String str : list) {
            if (Arrays.binarySearch(select, str) < 0) {
                newList.add(str);
            }
        }
        if (newList.size() > 0) {
            retList = (String[]) newList.toArray(new String[newList.size()]);
        }

        return retList;
    }

    /**
     * <br>[機  能] グループラベルを取得する
     * <br>[解  説]
     * <br>[備  考]
     * @param reqMdl リクエスト情報
     * @param con コネクション
     * @return グループラベルリスト
     * @throws SQLException SQL実行時例外
     */
    private ArrayList<LabelValueBean> __createGroupLabel(
                                                         RequestModel reqMdl,
                                                         Connection con) throws SQLException {

        log__.debug("グループラベル取得処理");

        ArrayList<LabelValueBean> groupLabel = new ArrayList<LabelValueBean>();
        GsMessage gsMsg = new GsMessage(reqMdl);

        // グループリスト取得
        GroupBiz grpBiz = new GroupBiz();
        ArrayList<GroupModel> grpList = grpBiz.getGroupCombList(con);

        // グループラベル作成
        groupLabel.add(new LabelValueBean(gsMsg.getMessage("cmn.grouplist"),
                                          String.valueOf(GSConstCircular.ANSWER_GROUP_GRPLIST)));
        for (GroupModel grpBean : grpList) {
            groupLabel.add(new LabelValueBean(grpBean.getGroupName(),
                                             String.valueOf(grpBean.getGroupSid())));
        }

        return groupLabel;
    }

    /**
     * <br>[機  能] 対象者一覧を取得する
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param con コネクション
     * @return 対象者一覧
     * @throws SQLException SQL実行時例外
     */
    protected ArrayList<LabelValueBean> _createSenderLabel(Cir220ParamModel paramMdl,
                                                          Connection con) throws SQLException {

        ArrayList<LabelValueBean> ansCombo = new ArrayList<LabelValueBean>();

        ArrayList<Integer> grpSids = new ArrayList<Integer>();
        ArrayList<String> usrSids = new ArrayList<String>();

        //ユーザSIDとグループSIDを分離
        String[] selectAnsList = paramMdl.getCir220MakeSenderList();
        if (selectAnsList == null) {
            return ansCombo;
        }
        for (String ansSid : selectAnsList) {
            String str = NullDefault.getString(ansSid, "-1");
            if (str.contains(new String(GROUP_PREFIX).subSequence(0, 1))) {
                //グループ
                grpSids.add(new Integer(str.substring(1, str.length())));
            } else {
                //ユーザ
                usrSids.add(str);
            }
        }

        //グループ情報取得
        UsidSelectGrpNameDao gdao = new UsidSelectGrpNameDao(con);
        ArrayList<GroupModel> grpList = gdao.selectGroupNmListOrderbyConf(grpSids);
        for (GroupModel grpMdl : grpList) {
            ansCombo.add(new LabelValueBean(
                    grpMdl.getGroupName(), GROUP_PREFIX + grpMdl.getGroupSid()));
        }

        //ユーザ情報取得
        UserBiz userBiz = new UserBiz();
        ArrayList<BaseUserModel> userList
                = userBiz.getBaseUserList(con,
                                        (String[]) usrSids.toArray(new String[usrSids.size()]));
        for (BaseUserModel usrMdl : userList) {
            ansCombo.add(
                    new LabelValueBean(usrMdl.getUsisei() + " " + usrMdl.getUsimei(),
                                                String.valueOf(usrMdl.getUsrsid())));
        }

        return ansCombo;
    }

    /**
     * <br>[機  能] 対象者一覧(未選択)を取得する
     * <br>[解  説]
     * <br>[備  考]
     * @param paramMdl パラメータ情報
     * @param con コネクション
     * @return 対象者一覧
     * @throws SQLException SQL実行時例外
     */
    private ArrayList<LabelValueBean> __createBelongSenderLabel(
            Cir220ParamModel paramMdl, Connection con)
    throws SQLException {

     // 選択しているグループ一覧のSID
        int ansGrpSid = NullDefault.getInt(
                paramMdl.getCir220GroupSid(), GSConstCircular.ANSWER_GROUP_GRPLIST);

        ArrayList<LabelValueBean> ansCombo = new ArrayList<LabelValueBean>();

        String[] selectList = paramMdl.getCir220MakeSenderList();
        if (ansGrpSid == GSConstCircular.ANSWER_GROUP_GRPLIST) {
            //グループを全て取得
            GroupDao dao = new GroupDao(con);
            CmnCmbsortConfDao sortDao = new CmnCmbsortConfDao(con);
            CmnCmbsortConfModel sortMdl = sortDao.getCmbSortData();
            ArrayList<GroupModel> allGpList = dao.getGroupTree(sortMdl);

            //選択済みのグループを除外
            List<String> selectGrpList = new ArrayList<String>();
            if (selectList != null) {
                selectGrpList = Arrays.asList(selectList);
            }

            for (GroupModel bean : allGpList) {
                if (!selectGrpList.contains(GROUP_PREFIX + bean.getGroupSid())) {
                    ansCombo.add(new LabelValueBean(
                            bean.getGroupName(),
                            String.valueOf(GROUP_PREFIX + bean.getGroupSid())));
                }
            }
        } else {

            //除外するユーザSID
            ArrayList<Integer> usrSids = new ArrayList<Integer>();
            if (selectList != null) {
                for (String selectSid : selectList) {
                    usrSids.add(new Integer(NullDefault.getInt(selectSid, -1)));
                }
            }

            UserBiz userBiz = new UserBiz();
            List<CmnUsrmInfModel> userList
                = userBiz.getBelongUserList(con, ansGrpSid, usrSids);

            for (CmnUsrmInfModel userMdl : userList) {
                ansCombo.add(
                        new LabelValueBean(userMdl.getUsiSei() + " " + userMdl.getUsiMei(),
                                String.valueOf(userMdl.getUsrSid())));
            }
        }

        return ansCombo;
    }

    /**
     * <br>[機  能] 指定したグループが、削除されていないかチェック
     * <br>[解  説]
     * <br>[備  考]
     * @param con コネクション
     * @param grpSid グループSID
     * @return true:存在する、false:存在しない
     * @throws SQLException SQL実行例外
     */
    private boolean __checkGroup(Connection con, long grpSid) throws SQLException {

        boolean ret = false;
        CmnGroupmModel mdl = new CmnGroupmModel();
        CmnGroupmDao dao = new CmnGroupmDao(con);
        mdl = dao.select((int) grpSid);
        if (mdl != null && mdl.getGrpJkbn() == GSConst.JTKBN_TOROKU) {
            ret = true;
        }
        return ret;
    }

    /**
     * <br>[機  能] 指定したユーザが、削除されていないかチェック
     * <br>[解  説]
     * <br>[備  考]
     * @param con コネクション
     * @param usrSid ユーザSID
     * @return true:存在する、false:存在しない
     * @throws SQLException SQL実行例外
     */
    private boolean __checkUser(Connection con, long usrSid) throws SQLException {

        boolean ret = false;
        CmnUsrmDao dao = new CmnUsrmDao(con);
        int kbn = dao.getUserJkbn((int) usrSid);
        if (kbn == GSConst.JTKBN_TOROKU) {
            ret = true;
        }
        return ret;
    }
}

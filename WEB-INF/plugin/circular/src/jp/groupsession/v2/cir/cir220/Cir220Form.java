package jp.groupsession.v2.cir.cir220;

import java.util.ArrayList;

import jp.co.sjts.util.struts.StrutsUtil;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.cir100.Cir100Form;
import jp.groupsession.v2.cmn.model.RequestModel;
import jp.groupsession.v2.struts.msg.GsMessage;

import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionMessage;
import org.apache.struts.util.LabelValueBean;

/**
 * <br>[機  能] 管理者設定 回覧板登録制限設定画面のアクションフォーム
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir220Form extends Cir100Form {

    /** 初期表示フラグ */
    private int cir220initFlg__ = 0;
    /** 回覧板作成対象者区分 */
    private int cir220TaisyoKbn__ = 0;

    /** 回覧板作成可能ユーザリスト */
    private String[] cir220MakeSenderList__ = null;

    /** グループSID */
    private String cir220GroupSid__ = null;
    /** グループ一覧 */
    private ArrayList<LabelValueBean> cir220GroupLabel__ = null;

    /** 回覧板送信対象者リスト（左） */
    private ArrayList<LabelValueBean> cir220AddSenderLabel__ = null;
    /** 回覧板送信対象者リスト（右） */
    private ArrayList<LabelValueBean> cir220BelongSenderLabel__ = null;
    /** 回覧板送信対象者 選択SID （左） */
    private String[] cir220SelectAddSenderSid__ = null;
    /** 回覧板非送信対象者 選択SID （右） */
    private String[] cir220SelectBelongSenderSid__ = null;

    /**
     * <p>cir220initFlg を取得します。
     * @return cir220initFlg
     */
    public int getCir220initFlg() {
        return cir220initFlg__;
    }
    /**
     * <p>cir220initFlg をセットします。
     * @param cir220initFlg cir220initFlg
     */
    public void setCir220initFlg(int cir220initFlg) {
        cir220initFlg__ = cir220initFlg;
    }
    /**
     * <p>cir220TaisyoKbn を取得します。
     * @return cir220TaisyoKbn
     */
    public int getCir220TaisyoKbn() {
        return cir220TaisyoKbn__;
    }
    /**
     * <p>cir220TaisyoKbn をセットします。
     * @param cir220TaisyoKbn cir220TaisyoKbn
     */
    public void setCir220TaisyoKbn(int cir220TaisyoKbn) {
        cir220TaisyoKbn__ = cir220TaisyoKbn;
    }
    /**
     * <p>回覧板作成可能ユーザリスト を取得します。
     * @return cir220MakeSenderList
     */
    public String[] getCir220MakeSenderList() {
        return cir220MakeSenderList__;
    }
    /**
     * <p>回覧板作成可能ユーザリスト をセットします。
     * @param cir220MakeSenderList 回覧板作成可能ユーザリスト
     */
    public void setCir220MakeSenderList(String[] cir220MakeSenderList) {
        cir220MakeSenderList__ = cir220MakeSenderList;
    }
    /**
     * <p>グループSID を取得します。
     * @return cir220GroupSid
     */
    public String getCir220GroupSid() {
        return cir220GroupSid__;
    }
    /**
     * <p>グループSID をセットします。
     * @param cir220GroupSid グループSID
     */
    public void setCir220GroupSid(String cir220GroupSid) {
        cir220GroupSid__ = cir220GroupSid;
    }
    /**
     * <p>グループ一覧 を取得します。
     * @return cir220GroupLabel
     */
    public ArrayList<LabelValueBean> getCir220GroupLabel() {
        return cir220GroupLabel__;
    }
    /**
     * <p>グループ一覧 をセットします。
     * @param cir220GroupLabel グループ一覧
     */
    public void setCir220GroupLabel(ArrayList<LabelValueBean> cir220GroupLabel) {
        cir220GroupLabel__ = cir220GroupLabel;
    }
    /**
     * <p>回覧板送信対象者リスト（左） を取得します。
     * @return 回覧板送信対象者リスト（左）
     */
    public ArrayList<LabelValueBean> getCir220AddSenderLabel() {
        return cir220AddSenderLabel__;
    }
    /**
     * <p>回覧板送信対象者リスト（左） をセットします。
     * @param cir220AddSenderLabel 回覧板送信対象者リスト（左）
     */
    public void setCir220AddSenderLabel(
            ArrayList<LabelValueBean> cir220AddSenderLabel) {
        cir220AddSenderLabel__ = cir220AddSenderLabel;
    }
    /**
     * <p>回覧板送信対象者リスト（右） を取得します。
     * @return 回覧板送信対象者リスト（右）
     */
    public ArrayList<LabelValueBean> getCir220BelongSenderLabel() {
        return cir220BelongSenderLabel__;
    }
    /**
     * <p>回覧板送信対象者リスト（右） をセットします。
     * @param cir220BelongSenderLabel 回覧板送信対象者リスト（右）
     */
    public void setCir220BelongSenderLabel(
            ArrayList<LabelValueBean> cir220BelongSenderLabel) {
        cir220BelongSenderLabel__ = cir220BelongSenderLabel;
    }
    /**
     * <p>回覧板送信対象者 選択SID （左） を取得します。
     * @return 回覧板送信対象者 選択SID （左）
     */
    public String[] getCir220SelectAddSenderSid() {
        return cir220SelectAddSenderSid__;
    }
    /**
     * <p>回覧板送信対象者 選択SID （左） をセットします。
     * @param cir220SelectAddSenderSid 回覧板送信対象者 選択SID （左）
     */
    public void setCir220SelectAddSenderSid(String[] cir220SelectAddSenderSid) {
        cir220SelectAddSenderSid__ = cir220SelectAddSenderSid;
    }
    /**
     * <p>回覧板非送信対象者 選択SID （右） を取得します。
     * @return 回覧板非送信対象者 選択SID （右）
     */
    public String[] getCir220SelectBelongSenderSid() {
        return cir220SelectBelongSenderSid__;
    }
    /**
     * <p>回覧板非送信対象者 選択SID （右） をセットします。
     * @param cir220SelectBelongSenderSid 回覧板非送信対象者 選択SID （右）
     */
    public void setCir220SelectBelongSenderSid(String[] cir220SelectBelongSenderSid) {
        cir220SelectBelongSenderSid__ = cir220SelectBelongSenderSid;
    }

    /**
     * <br>[機  能] 入力チェックを行う
     * <br>[解  説]
     * <br>[備  考]
     * @param reqMdl リクエストモデル
     * @return エラー
     */
    public ActionErrors validateCir220(RequestModel reqMdl) {

        ActionErrors errors = new ActionErrors();

        // 回覧板送信対象者
        validateMakeSender(errors, reqMdl);

        return errors;
    }

    /**
     * <br>[機  能] 回覧板送信対象者の入力チェック
     * <br>[解  説]
     * <br>[備  考]
     * @param errors ActionErrors
     * @param reqMdl リクエストモデル
     * @return 入力チェック結果 true:正常、false:不正
     */
    public boolean validateMakeSender(ActionErrors errors, RequestModel reqMdl) {

        GsMessage gsMsg = new GsMessage();

        if (cir220TaisyoKbn__ == GSConstCircular.CAF_AREST_KBN_SELECT) {
            if ((cir220MakeSenderList__ == null || cir220MakeSenderList__.length < 1)) {
                String msgKey = "error.select.required.text";
                ActionMessage msg = new ActionMessage(msgKey, gsMsg.getMessage("cir.cir220.6"));
                StrutsUtil.addMessage(errors, msg, "cir220MakeSenderList." + msgKey);
                return false;
            }
        }
        return true;
    }

    /**
     * <br>[機  能] 回覧板作成対象者更新時のオペレーションログ内容を取得
     * <br>[解  説]
     * <br>[備  考]
     * @param reqMdl リクエストモデル
     * @return [対象者区分]制限あり or 制限なし
     */
    public String getTargetLog(RequestModel reqMdl) {

        GsMessage gsMsg = new GsMessage(reqMdl);
        String ret = "[" + gsMsg.getMessage("cir.cir220.6") + "]";
        if (cir220TaisyoKbn__ == GSConstCircular.CAF_AREST_KBN_SELECT) {
            ret += gsMsg.getMessage("wml.32");
        } else {
            ret += gsMsg.getMessage("wml.31");
        }

        return ret;
    }
}

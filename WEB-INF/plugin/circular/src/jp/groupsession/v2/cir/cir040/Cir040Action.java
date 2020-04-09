package jp.groupsession.v2.cir.cir040;

import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts.action.ActionErrors;
import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;
import org.apache.struts.util.MessageResources;

import jp.co.sjts.util.NullDefault;
import jp.co.sjts.util.StringUtil;
import jp.co.sjts.util.io.IOToolsException;
import jp.groupsession.v2.cir.AbstractCircularAction;
import jp.groupsession.v2.cir.GSConstCircular;
import jp.groupsession.v2.cir.biz.CirCommonBiz;
import jp.groupsession.v2.cir.exception.CirConfReadException;
import jp.groupsession.v2.cir.exception.CirException;
import jp.groupsession.v2.cir.exception.CirMaxLengthEleagalException;
import jp.groupsession.v2.cir.util.CirConfigBundle;
import jp.groupsession.v2.cmn.GSConst;
import jp.groupsession.v2.cmn.biz.CommonBiz;
import jp.groupsession.v2.cmn.cmn120.Cmn120Form;
import jp.groupsession.v2.cmn.cmn999.Cmn999Form;
import jp.groupsession.v2.cmn.dao.WmlDao;
import jp.groupsession.v2.cmn.model.RequestModel;
import jp.groupsession.v2.struts.msg.GsMessage;

/**
 * <br>[機  能] 回覧板 新規作成画面のアクションクラス
 * <br>[解  説]
 * <br>[備  考]
 *
 * @author JTS
 */
public class Cir040Action extends AbstractCircularAction {

    /** Logging インスタンス */
    private static Log log__ = LogFactory.getLog(Cir040Action.class);

    /**
     * <br>[機  能] アクション実行
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @throws Exception 実行例外
     * @return ActionForward
     */
    public ActionForward executeAction(
        ActionMapping map,
        ActionForm form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws Exception {

        log__.debug("START_Cir040");
        ActionForward forward = null;




        Cir040Form thisForm = (Cir040Form) form;

        //アクセス権限チェック
        forward = __imigurate(map, thisForm, req, res, con);
        if (forward != null) {
            return forward;
        }

        CirCommonBiz biz = new CirCommonBiz();

        //アカウントが未選択の場合、デフォルトアカウントを設定する
        //アカウントを取得
        if (thisForm.getCir040AccountSid() <= 0) {
            if (thisForm.getCirViewAccount() <= 0) {
                thisForm.setCirViewAccount(
                        biz.getDefaultAccount(con, getSessionUserSid(req)));

            }
            thisForm.setCir040AccountSid(thisForm.getCirViewAccount());
        }

        if (thisForm.getCirViewAccount() <= 0) {
            thisForm.setCirViewAccount(
                    biz.getDefaultAccount(con, getSessionUserSid(req)));
        }

        //コマンドパラメータ取得
        String cmd = NullDefault.getString(req.getParameter(GSConst.P_CMD), "");
        cmd = cmd.trim();

        if (cmd.equals("ok")) {
            log__.debug("OK");
            forward = __doOk(map, thisForm, req, res, con);

        } else if (cmd.equals("cir040back")) {
            log__.debug("戻る");
            forward = __doBack(map, thisForm, req, res, con);

        } else if (cmd.equals("delete")) {
            log__.debug("削除");
            forward = __doDelete(map, thisForm, req, res, con);

        } else if (cmd.equals("fromselect")) {
            log__.debug("回覧先選択");
            forward = __doUserSelect(map, thisForm, req, res, con);

        } else if (cmd.equals("dsp")) {
            log__.debug("回覧先選択から戻る");
            forward = __doDsp(map, thisForm, req, res, con);

        } else if (cmd.equals("cir040back")) {
            log__.debug("回覧作成確認から戻る");
            forward = __doDsp(map, thisForm, req, res, con);

        } else if (cmd.equals("clickPeriod")) {
            log__.debug("メモ欄修正期限リンククリック");
            forward = __doClickPeriod(map, thisForm, req, res, con);

        } else if (cmd.equals("memoKbnChange")) {
            log__.debug("メモ欄修正期限ラジオクリック");
            forward = __doDsp(map, thisForm, req, res, con);

        } else if (cmd.equals("calledWebmail")) {
            log__.debug("WEBメール連携");
            forward = __doCalledWebmail(map, thisForm, req, res, con);
        } else {
            log__.debug("初期表示");
            forward = __doInit(map, thisForm, req, res, con);
        }

        log__.debug("END_Cir040");
        return forward;
    }
    /**
     *
     * <br>[機  能] 不正アクセス判定を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @return 遷移先 不正アクセスでない場合はnull
     * @throws Exception 実行時例外
     */
    private ActionForward __imigurate(ActionMapping map, Cir040Form form,
            HttpServletRequest req, HttpServletResponse res, Connection con) throws Exception {
        //回覧板作成可能ユーザかを判定する
        CirCommonBiz biz = new CirCommonBiz();
        RequestModel reqMdl = getRequestModel(req);
        if (!biz.canCreateUserCir(con, reqMdl)) {
            return getSubmitErrorPage(map, req);
        }

        //回覧板設定ファイル エラー
        if (CirConfigBundle.isFileErr()) {
            return __getErrorPageForException(map, req, form, new CirConfReadException());

        }
        String maxLength = CirConfigBundle.getValue(GSConstCircular.CIRCONF_MAX_LENGTH);
        if (!StringUtil.isNullZeroString(maxLength)
                && NullDefault.getInt(maxLength, 0) == 0
                && NullDefault.getInt(maxLength, -1) < 0) {
            return __getErrorPageForException(map, req, form, new CirMaxLengthEleagalException());

        }

        return null;
    }
    /**
     *
     * <br>[機  能] エクセプション毎の「エラーメッセージ画面を返す
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param req リクエスト
     * @param form アクションフォーム
     * @param e エクセプション
     * @return メッセージ画面への遷移
     * @throws Exception 実行時例外
     */
    private ActionForward __getErrorPageForException(ActionMapping map,
            HttpServletRequest req, Cir040Form form, CirException e) throws Exception {
        Cmn999Form cmn999Form = new Cmn999Form();
        cmn999Form.setType(Cmn999Form.TYPE_OK);
        cmn999Form.setIcon(Cmn999Form.ICON_INFO);

        if (form.getCir040webmail() == 1) {
            //WEBメールからの呼び出し
            cmn999Form.setWtarget(Cmn999Form.WTARGET_SELF);
            cmn999Form.setType_popup(Cmn999Form.POPUP_TRUE);
            cmn999Form.setCloseScript("javascript:window.parent.webmailEntrySubWindowClose();");
        } else {
            cmn999Form.setWtarget(Cmn999Form.WTARGET_BODY);

            //OKボタンクリック時遷移先
            ActionForward forwardOk;
            if (form.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_EDIT) {
                forwardOk = map.findForward("cir030back");
            } else {
                forwardOk = map.findForward("back");
            }

            cmn999Form.setUrlOK(forwardOk.getPath());
        }


        MessageResources msgRes = getResources(req);
        if (e instanceof CirConfReadException) {
            cmn999Form.setMessage(
                    msgRes.getMessage("error.can.not.conffile.open.error"));
        } else if (e instanceof CirMaxLengthEleagalException) {
            cmn999Form.setMessage(
                    msgRes.getMessage("error.can.not.conffile.read.error"));
        }



        //画面パラメータをセット
        cmn999Form.addHiddenAll(form, Cir040Form.class, "");

        req.setAttribute("cmn999Form", cmn999Form);
        return map.findForward("gf_msg");
    }
    /**
     * <br>[機  能] 初期表示を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @return ActionForward
     * @throws Exception 実行例外
     */
    private ActionForward __doInit(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws Exception {

        //テンポラリディレクトリパスを取得
        form.setCir040pluginIdTemp(__getPluginIdTemp(req));
        String tempDir = __getPluginIdTempDir(req);
        log__.debug("テンポラリディレクトリ = " + tempDir);

        Cir040Biz biz = new Cir040Biz();

        //初期表示のとき、テンポラリディレクトリを削除する
        if (form.getCir040InitFlg() == 0) {
            biz.doDeleteFile(tempDir);
        }


        Cir040ParamModel paramMdl = new Cir040ParamModel();
        paramMdl.setParam(form);
        //「複写して新規登録」の場合、回覧板情報の設定を行う
        if ((form.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_COPY
                || form.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_EDIT)
                && form.getCir040InitFlg() == 0) {
            //回覧先の確認状況を確認できないユーザの場合、不正なアクセスとする
            CirCommonBiz cirCmnBiz = new CirCommonBiz();
            int cifSid = NullDefault.getInt(form.getCir010selectInfSid(), -1);
            if (!cirCmnBiz.canBrowseCirRoute(con, cifSid, form.getCirViewAccount())) {
                return getAuthErrorPage(map, req);
            }

            paramMdl.setCirEditInfSid(String.valueOf(cifSid));
            biz.copyCirData(paramMdl, con, getAppRootPath(), tempDir, getRequestModel(req));
        } else {
            //初回表示の時、ラジオの値をDBから取得し設定する
            if (form.getCir040InitFlg() == 0) {
                biz.setInitRadioData(paramMdl, con, getSessionUserSid(req));
            }
        }
        paramMdl.setFormData(form);

        //リクエストパラメータに回覧先がある場合、フォームにセット
        Object obj = req.getAttribute("cmn120userSid");
        if (obj != null) {
            form.setCir040userSid((String[]) obj);
        }

        form.setCir040InitFlg(1);

        return __doDsp(map, form, req, res, con);
    }

    /**
     * <br>[機  能] 再表示を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @return ActionForward
     * @throws Exception 実行例外
     */
    private ActionForward __doDsp(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws Exception {

        //テンポラリディレクトリパスを取得
        String tempDir = __getPluginIdTempDir(req);
        log__.debug("テンポラリディレクトリ = " + tempDir);


        //初期表示情報を画面にセットする
        con.setAutoCommit(true);
        Cir040ParamModel paramMdl = new Cir040ParamModel();
        paramMdl.setParam(form);
        Cir040Biz biz = new Cir040Biz();
        biz.setInitData(paramMdl, con, tempDir, getRequestModel(req));
        paramMdl.setFormData(form);
        con.setAutoCommit(false);

        // トランザクショントークン設定
        saveToken(req);

        return map.getInputForward();
    }

    /**
     * <br>[機  能] 戻るクリック時の処理を行う
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @throws IOToolsException ファイルアクセス時例外
     * @return ActionForward
     */
    private ActionForward __doBack(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws IOToolsException {

        //テンポラリディレクトリパスを取得
        String tempDir = __getPluginIdTempDir(req);
        log__.debug("テンポラリディレクトリ = " + tempDir);

        //テンポラリディレクトリのファイル削除を行う
        Cir040Biz biz = new Cir040Biz();
        biz.doDeleteFile(tempDir);

        ActionForward forward = null;

        if (form.getCirEntryMode() == GSConstCircular.CIR_ENTRYMODE_EDIT) {
            forward = map.findForward("cir030back");
        } else {
            forward = map.findForward("back");
        }

        return forward;
    }

    /**
     * <br>[機  能] 削除ボタンクリック時の処理
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @return ActionForward
     * @throws Exception 実行例外
     */
    private ActionForward __doDelete(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws Exception {

        //テンポラリディレクトリパスを取得
        CommonBiz cmnBiz = new CommonBiz();
        String tempDir = __getPluginIdTempDir(req);
        log__.debug("テンポラリディレクトリ = " + tempDir);

        //選択された添付ファイルを削除する
        cmnBiz.deleteFile(form.getCir040selectFiles(), tempDir);

        return __doDsp(map, form, req, res, con);
    }

    /**
     * <br>[機  能] 回覧先選択クリック時の処理
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @return ActionForward
     */
    private ActionForward __doUserSelect(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) {

        Cmn120Form cmn120Form = new Cmn120Form();
        GsMessage gsMsg = new GsMessage();
        String textMember = gsMsg.getMessage(req, "cir.20");

        //「戻る」ボタンURLセット
        ActionForward forward = map.findForward("init");
        cmn120Form.setCmn120BackUrl(forward.getPath() + "?" + GSConst.P_CMD + "=dsp");
        //機能名称セット
        cmn120Form.setCmn120FunctionName(textMember);
        //フォーム識別子
        cmn120Form.setCmn120FormKey("cir040Form");

        req.setAttribute("cmn120Form", cmn120Form);
        return map.findForward("selectuser");
    }

    /**
     * <br>[機  能] OKボタンクリック時の処理
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @throws Exception 実行例外
     * @return ActionForward
     */
    private ActionForward __doOk(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws Exception {

        if (!isTokenValid(req, true)) {
            log__.info("２重投稿");
            return getSubmitErrorPage(map, req);
        }

        //入力チェック
        ActionErrors errors = form.validateCheck(getRequestModel(req), con);
        if (!errors.isEmpty()) {
            addErrors(req, errors);
            return __doDsp(map, form, req, res, con);
        }
        log__.debug("入力エラーなし、登録を行う");

        return map.findForward("ok");
    }

    /**
     * <br>[機  能] メモ欄修正期限ラジオクリック時の処理
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @throws Exception 実行例外
     * @return ActionForward
     */
    private ActionForward __doClickPeriod(ActionMapping map,
            Cir040Form form, HttpServletRequest req,
            HttpServletResponse res, Connection con) throws Exception {

        //日付の設定
        Cir040ParamModel paramMdl = new Cir040ParamModel();
        paramMdl.setParam(form);
        Cir040Biz biz = new Cir040Biz();
        biz.setDateData(paramMdl);
        paramMdl.setFormData(form);

        return __doDsp(map, form, req, res, con);
    }

    /**
     * <br>[機  能] WEBメール連携
     * <br>[解  説]
     * <br>[備  考]
     * @param map アクションマッピング
     * @param form アクションフォーム
     * @param req リクエスト
     * @param res レスポンス
     * @param con コネクション
     * @return ActionForward
     * @throws Exception 実行例外
     */
    private ActionForward __doCalledWebmail(
        ActionMapping map,
        Cir040Form form,
        HttpServletRequest req,
        HttpServletResponse res,
        Connection con) throws Exception {

        //対象メールを閲覧可能かを判定
        WmlDao wmlDao = new WmlDao(con);
        if (!wmlDao.canReadMail(form.getCir040webmailId(), getSessionUserSid(req))) {
            return getAuthErrorPageWithPopup(map, req);
        }

        //テンポラリディレクトリを削除する
        String tempDir = __getPluginIdTempDir(req);
        Cir040Biz biz = new Cir040Biz();
        biz.doDeleteFile(tempDir);

        Cir040ParamModel paramMdl = new Cir040ParamModel();
        paramMdl.setParam(form);
        biz.setWebmailData(paramMdl, con,
                                    getAppRootPath(), tempDir,
                                    getRequestModel(req));
        paramMdl.setFormData(form);

        form.setCir040pluginIdTemp(__getPluginIdTemp(req));
        form.setCir040InitFlg(1);
        form.setCir040webmail(1);
        return __doDsp(map, form, req, res, con);
    }

    /**
     * <br>[機  能] 確認時添付用のテンポラリディレクトリを取得する
     * <br>[解  説]
     * <br>[備  考]
     * @param req リクエスト
     * @return テンポラリディレクトリパス
     */
    private String __getPluginIdTempDir(HttpServletRequest req) {
        String pluginIdTemp = __getPluginIdTemp(req);

        //テンポラリディレクトリパスを取得
        CommonBiz cmnBiz = new CommonBiz();
        String tempDir = cmnBiz.getTempDir(
                getTempPath(req), pluginIdTemp, getRequestModel(req));
        log__.debug("テンポラリディレクトリ = " + tempDir);
        return tempDir;
    }


    /**
     * <br>[機  能] 確認時添付用のテンポラリディレクトリ用のプラグインIDを取得する
     * <br>[解  説] プラグインID = プラグインID/セッションID/cirTempNew
     * <br>[備  考]
     * @param req リクエスト
     * @return プラグインID
     */
    private String __getPluginIdTemp(HttpServletRequest req) {
        StringBuilder pluginIdTemp = new StringBuilder();
        pluginIdTemp.append(GSConstCircular.PLUGIN_ID_CIRCULAR);
        pluginIdTemp.append("/");
        pluginIdTemp.append(req.getSession().getId());
        pluginIdTemp.append("/");
        pluginIdTemp.append(GSConstCircular.TEMP_DIR_NEW);

        return pluginIdTemp.toString();
    }

}

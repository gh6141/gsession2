package jp.groupsession.v2.cir;

import java.sql.Connection;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

import org.apache.struts.action.ActionForm;

/**
 * <br>[機  能] 回覧板プラグインで共通的に使用するアクションクラスです(管理者設定画面から遷移可能なページ用)
 * <br>[解  説] 管理者設定から遷移可能な為、システム管理者の場合にプラグインチェックしない判定付き
 * <br>[備  考]
 *
 * @author JTS
 */
public abstract class AbstractCircularSubAction extends AbstractCircularAction {

    /** プラグインが使用可能か判定します
     * @param req リクエスト
     * @param form アクションフォーム
     * @param con DBコネクション
     * @return boolean true:使用可能 false:使用不可
     * @throws SQLException SQL実行時例外
     */
    @Override
    protected boolean _isAccessPlugin(HttpServletRequest req, ActionForm form, Connection con)
    throws SQLException {
        if (_isSystemAdmin(req, con)) {
            return true; //システム管理者の場合はプラグインチェックをしない
        }
        return super._isAccessPlugin(req, form, con);
    }
}

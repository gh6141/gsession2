<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme"%>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg"%>
<%@ page import="jp.groupsession.v2.cir.GSConstCircular"%>
<%@ page import="jp.groupsession.v2.cmn.GSConst"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html:html>
<head>
<title>[Group Session] <gsmsg:write key="cmn.entry.label.kn" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
<theme:css filename="theme.css" />
<link rel="stylesheet" href="../common/css/default.css?<%=GSConst.VERSION_PARAM%>" type="text/css">
<script language="JavaScript" src="../common/js/cmd.js?<%=GSConst.VERSION_PARAM%>"></script>
</head>
<body class="body_03">
    <html:form action="/circular/cir240kn">

    <logic:notEqual name="cir240knForm" property="cirAccountMode" value="2">
      <input type="hidden" name="helpPrm" value="0" />
    </logic:notEqual>

    <logic:equal name="cir240knForm" property="cirAccountMode" value="2">
      <input type="hidden" name="helpPrm" value="1" />
    </logic:equal>

    <input type="hidden" name="CMD" value="">
    <html:hidden property="backScreen" />
    <html:hidden property="cirCmdMode" />
    <html:hidden property="cirViewAccount" />
    <html:hidden property="cirAccountMode" />
    <html:hidden property="cirAccountSid" />
    <html:hidden property="cir010cmdMode" />
    <html:hidden property="cir010orderKey" />
    <html:hidden property="cir010sortKey" />
    <html:hidden property="cir010pageNum1" />
    <html:hidden property="cir010pageNum2" />
    <html:hidden property="cir010SelectLabelSid"/>

    <html:hidden property="cir010adminUser" />
    <html:hidden property="cir150keyword" />
    <html:hidden property="cir150group" />
    <html:hidden property="cir150user" />
    <html:hidden property="cir150svKeyword" />
    <html:hidden property="cir150svGroup" />
    <html:hidden property="cir150svUser" />
    <html:hidden property="cir150sortKey" />
    <html:hidden property="cir150order" />
    <html:hidden property="cir150searchFlg" />
    <html:hidden property="cir230DspKbn" />
    <html:hidden property="cir230LabelCmdMode" />
    <html:hidden property="cir230EditLabelId" />
    <html:hidden property="cir240initKbn" />
    <html:hidden property="cir240LabelName" />
    <%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp"%>
    <table align="center" cellpadding="5" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="100%" align="center">
          <table cellpadding="0" cellspacing="0" border="0" width="50%">
            <tr>
              <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                  <tr>
                    <td width="0%">
                      <img src="../common/images/header_ktool_01.gif" border="0" alt="">
                    </td>
                    <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap>
                      <logic:equal name="cir240knForm" property="cir230DspKbn" value="<%=String.valueOf(GSConstCircular.DSPKBN_ADMIN)%>">
                        <span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span>
                      </logic:equal>
                      <logic:equal name="cir240knForm" property="cir230DspKbn" value="<%=String.valueOf(GSConstCircular.DSPKBN_PREF)%>">
                        <span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span>
                      </logic:equal>
                    </td>
                    <td width="100%" class="header_ktool_bg_text2">
                      <logic:equal name="cir240knForm" property="cir230LabelCmdMode" value="<%=String.valueOf(GSConstCircular.CMDMODE_ADD)%>">
                        [&nbsp;<gsmsg:write key="cmn.entry.label.kn" />&nbsp;]
                      </logic:equal>
                      <logic:equal name="cir240knForm" property="cir230LabelCmdMode" value="<%=String.valueOf(GSConstCircular.CMDMODE_EDIT)%>">
                        [&nbsp;<gsmsg:write key="cmn.edit.label.kn" />&nbsp;]
                      </logic:equal>
                    </td>
                    <td width="0%">
                      <img src="../common/images/header_ktool_05.gif" border="0" alt="">
                    </td>
                  </tr>
                </table>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                  <tr>
                    <td width="40%"></td>
                    <td width="0%">
                      <img src="../common/images/header_glay_1.gif" border="0" alt="">
                    </td>
                    <td class="header_glay_bg" width="60%">
                      <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('decision');">
                      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('backInput');">
                    </td>
                    <td width="0%">
                      <img src="../common/images/header_glay_3.gif" border="0" alt="">
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <img src="../common/images/spacer.gif" width="10" height="10" border="0" alt="">
              </td>
            </tr>
            <tr>
              <td>
                <table class="tl0" cellpadding="5" cellspacing="0" border="0" width="100%">
                  <tr>
                    <td class="table_bg_A5B4E1" width="30%" nowrap>
                      <span class="text_bb1"><gsmsg:write key="wml.102" /></span>
                    </td>
                    <td align="left" class="td_wt td_type1" width="70%">
                      <bean:write name="cir240knForm" property="cir230accountName" />
                    </td>
                  </tr>
                  <tr>
                    <td class="table_bg_A5B4E1" width="30%" nowrap>
                      <span class="text_bb1"><gsmsg:write key="wml.74" /></span>
                    </td>
                    <td align="left" class="td_wt td_type1" width="70%">
                      <bean:write name="cir240knForm" property="cir240LabelName" />
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr>
              <td>
                <img src="../common/images/spacer.gif" width="1px" height="10px" border="0" alt="<gsmsg:write key="cmn.space" />">
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                  <tr>
                    <td width="100%" align="right">
                      <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('decision');">
                      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('backInput');">
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </html:form>
  <%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp"%>
</body>
</html:html>
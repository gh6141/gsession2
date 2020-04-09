<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ taglib uri="/WEB-INF/ctag-jsmsg.tld" prefix="gsjsmsg" %>
<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<%@ page import="jp.groupsession.v2.cir.GSConstCircular" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Content-Script-Type" content="text/javascript">
<META http-equiv="Content-Style-Type" content="text/css">
<title>[Group Session] <gsmsg:write key="cmn.admin.setting.menu" /></title>
<link rel=stylesheet href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
<script type="text/javascript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script type="text/javascript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
</head>

<body class="body_03">
<html:form action="/circular/cir220kn">
<!-- BODY -->
<input type="hidden" name="CMD">
<html:hidden property="backScreen" />
<html:hidden property="cir220initFlg" />
<html:hidden property="cir220TaisyoKbn" />

<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>

<html:hidden property="backScreen" />

<logic:notEmpty name="cir220knForm" property="cir220MakeSenderList" scope="request">
    <logic:iterate id="ulBean" name="cir220knForm" property="cir220MakeSenderList" scope="request">
    <input type="hidden" name="cir220MakeSenderList" value="<bean:write name="ulBean" />">
    </logic:iterate>
</logic:notEmpty>

<!-- header -->
<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<!-- content -->
<table cellpadding="5" cellspacing="0" width="100%">
<tr>
<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" width="70%">
  <tr>
  <td align="center">

    <!-- タイトル -->
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt="<gsmsg:write key="cmn.admin.setting" />"></td>
        <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
        <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.cir220kn.1"/> ]</td>
        <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt="<gsmsg:write key="cmn.admin.setting" />"></td>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="50%"></td>
        <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt="<gsmsg:write key='cmn.function.btn' />"></td>
        <td class="header_glay_bg" width="50%">
          <input type="button" value="<gsmsg:write key='cmn.final' />" class="btn_base1" onClick="buttonPush('cir220kncommit');">
          <input type="button" value="<gsmsg:write key='cmn.back' />" class="btn_back_n1" onClick="buttonPush('cir220knback');">
        </td>
        <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt="<gsmsg:write key='cmn.function.btn' />"></td>
      </tr>
    </table>

    <img src="../common/images/spacer.gif" width="1" height="5" border="0" alt="<gsmsg:write key='cmn.spacer' />">

    <!-- エラーメッセージ -->
    <div style="text-align:left">
    <html:errors/>
    </div>

    <table cellpadding="10" cellspacing="0" border="0" width="100%" class="tl_u2">
    <tbody>

      <!-- 対象者区分 -->
      <tr>
        <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap>
          <span class="text_bb1"><gsmsg:write key="cir.cir220.3"/></span>
        </td>
        <td align="left" class="td_wt" width="80%">
          <span class="text_base">
            <logic:equal name="cir220knForm" property="cir220knTaisyoKbn" value="<%= String.valueOf(GSConstCircular.CAF_AREST_KBN_SELECT) %>" >
              <gsmsg:write key="wml.32" />
            </logic:equal>
            <logic:notEqual name="cir220knForm" property="cir220knTaisyoKbn" value="<%= String.valueOf(GSConstCircular.CAF_AREST_KBN_SELECT) %>" >
              <gsmsg:write key="wml.31" />
            </logic:notEqual>
          </span>
        </td>
      </tr>

    <logic:equal name="cir220knForm" property="cir220knTaisyoKbn" value="<%= String.valueOf(GSConstCircular.CAF_AREST_KBN_SELECT) %>" >
      <tr>
        <td valign="middle" align="left" class="table_bg_A5B4E1" nowrap>
          <span class="text_bb1"><gsmsg:write key="cir.cir220.6"/></span>
        </td>
        <td valign="middle" align="left" class="td_wt">
          <span class="text_base">
            <logic:notEmpty name="cir220knForm" property="cir220knAddSenderLabel" scope="request">
              <logic:iterate id="labelValueBean" name="cir220knForm" property="cir220knAddSenderLabel" scope="request">
                <bean:write name="labelValueBean" property="label" /><br>
              </logic:iterate>
            </logic:notEmpty>
          </span>
        </td>
      </tr>
    </logic:equal>

    </tbody>
    </table>

    <table cellpadding="0" cellspacing="0" width="100%" style="margin-top: 10px;">
      <tr>
        <td align="right">
          <input type="button" value="<gsmsg:write key='cmn.final' />" class="btn_base1" onClick="buttonPush('cir220kncommit');">
          <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('cir220knback');">
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
<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>
</body>
</html:html>
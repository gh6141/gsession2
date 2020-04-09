<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>

<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<title>[GroupSession] <gsmsg:write key="cmn.preferences.menu" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
</head>

<body class="body_03">
<html:form action="/circular/cir070">

<input type="hidden" name="CMD" value="">
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

<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<!--　BODY -->
<table width="100%" cellpadding="5" cellspacing="0">
<tr>
<td width="100%" align="center">

  <table width="70%" cellpadding="0" cellspacing="0">
  <tr>
  <td align="left">

    <!-- タイトル -->
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt="<gsmsg:write key="cmn.preferences2" />"></td>
    <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.5" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('backToCirList');">
    </td>
    </tr>
    </table>

    <table cellpadding="5" cellspacing="0" border="0" width="100%">


    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('circularAccount');"><span class="text_link"><gsmsg:write key="wml.100" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="wml.wml020.09" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirKsetting');"><span class="text_link"><gsmsg:write key="cir.48" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir070.1" /></li></div></dd>
      </dl>
    </td>
    </tr>
    <logic:equal name="cir070Form" property="cir070CirDelAdminConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_DEL_KBN_USER_SETTING) %>">
    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirAutoDelete');"><span class="text_link"><gsmsg:write key="cir.cir070.2" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir070.3" /></li></div></dd>
      </dl>
    </td>
    </tr>
    </logic:equal>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirManualDelete');"><span class="text_link"><gsmsg:write key="cir.21" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir070.4" /></li></div></dd>
      </dl>
    </td>
    </tr>

<%--
    <logic:equal name="cir070Form" property="cir070InitSettingDsp" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SET_DIS) %>">
    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirIniset');"><span class="text_link"><gsmsg:write key="cir.23" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir110.3" /></li></div></dd>
      </dl>
    </td>
    </tr>
    </logic:equal>
--%>
    </table>

  </td>
  </tr>
  </table>

</td>
</tr>
</table>

<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>
</html:form>
</body>
</html:html>
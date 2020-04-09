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
<title>[GroupSession] <gsmsg:write key="cmn.admin.setting.menu" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>

</head>

<body class="body_03">
<html:form action="/circular/cir100">

<input type="hidden" name="CMD" value="">
<html:hidden property="backScreen" />

<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>

<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<!-- BODY -->
<table width="100%" cellpadding="5" cellspacing="0">
<tr>
<td width="100%" align="center">

  <table width="70%" cellpadding="0" cellspacing="0">
  <tr>
  <td align="left">

    <!-- タイトル -->
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt="<gsmsg:write key="cmn.admin.setting" />"></td>
    <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.5" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt="<gsmsg:write key="cmn.admin.setting" />"></td>
    </tr>
    </table>

    <table cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('cir100back');">
    </td>
    </tr>
    </table>

    <table cellpadding="5" cellspacing="0" border="0" width="100%">

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('accountList');"><span class="text_link"><gsmsg:write key="wml.100" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="wml.wml020.09" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirConfAccount');"><span class="text_link"><gsmsg:write key="wml.wml020.07" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="wml.wml020.10" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirSender');"><span class="text_link"><gsmsg:write key="cir.cir220.1" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir220.2" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirIniset');"><span class="text_link"><gsmsg:write key="cir.23" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir110.3" /></li></div></dd>
      </dl>
    </td>
    </tr>
    <logic:equal name="cir100Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirAdminConf');"><span class="text_link"><gsmsg:write key="cmn.sml.notification.setting" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="ntp.159" /></li></div></dd>
      </dl>
    </td>
    </tr>
    </logic:equal>

    <logic:equal name="cir100Form" property="cir100autoDelKbn" value="0">
    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirAutoDelete');"><span class="text_link"><gsmsg:write key="cir.cir070.2" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir110.1" /></li></div></dd>
      </dl>
    </td>
    </tr>
    </logic:equal>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirManualDelete');"><span class="text_link"><gsmsg:write key="cir.21" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir110.2" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirLogCount');"><span class="text_link"><gsmsg:write key="cmn.statistical.info" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cir.cir100.1" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <logic:equal name="cir100Form" property="cir100GsAdminFlg" value="true">
    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirLogAutoDelete');"><span class="text_link"><gsmsg:write key="cmn.statistics.automatic.delete.setting" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cmn.statistics.automatic.delete.setting.comment" /></li></div></dd>
      </dl>
    </td>
    </tr>

    <tr>
    <td align="left">
      <dl class="decorate_textbox1">
      <dt><a href="#" onClick="return buttonPush('cirLogManualDelete');"><span class="text_link"><gsmsg:write key="cmn.statistics.manual.delete" /></span></a></dt>
      <dd><div class="text"><li><gsmsg:write key="cmn.statistics.manual.delete.comment" /></li></div></dd>
      </dl>
    </td>
    </tr>
    </logic:equal>

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
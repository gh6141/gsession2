<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ page import="jp.groupsession.v2.cir.GSConstCircular" %>
<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<title>[Group Session] <gsmsg:write key="wml.wml150.04" /></title>
  <meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
  <theme:css filename="theme.css"/>
  <link rel="stylesheet" href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
  <link rel="stylesheet" href="../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
  <script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
  <script type="text/javascript" src="../common/js/changestyle.js?<%= GSConst.VERSION_PARAM %>"></script>
  <script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
</head>

<body class="body_03">

<html:form action="/circular/cir190kn">


<input type="hidden" name="CMD" value="">
<html:hidden property="backScreen" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cirViewAccount" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>
<html:hidden property="cir190acntMakeKbn" />
<html:hidden property="cir190autoDelKbn" />
<html:hidden property="cir190acntUser" />
<html:hidden property="cir190initFlg" />

<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>
<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" border="0" width="70%">
  <tr>
  <td>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt=""></td>
        <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
        <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.wml150.04" /> ]</td>
        <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="50%"></td>
        <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
        <td class="header_glay_bg" width="50%">
          <input type="button" name="btn_add" class="btn_base1" value="<gsmsg:write key="cmn.final" />" onClick="buttonPush('decision');">
          <input type="button" name="btn_facilities_mnt" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onClick="buttonPush('backInput');">
        </td>
        <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
      </tr>
    </table>

  </td>
  </tr>

  <tr>
  <td>
    <br>


    <table id="normal_settings" class="tl0" width="100%" cellpadding="5">
    <tr>
    <td class="table_bg_A5B4E1" width="25%" nowrap><span class="text_bb1"><gsmsg:write key="wml.101" /></span></td>
    <td class="td_type1">
      <span class="text_base">
      <logic:equal name="cir190knForm" property="cir190acntMakeKbn" value="<%= String.valueOf(GSConstCircular.KANRI_USER_NO) %>">
      <gsmsg:write key="wml.31" />
      </logic:equal>
      <logic:equal name="cir190knForm" property="cir190acntMakeKbn" value="<%= String.valueOf(GSConstCircular.KANRI_USER_ONLY) %>">
      <gsmsg:write key="wml.70" />
      </logic:equal>
      </span>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="25%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.automatic.delete.categories" /></span></td>
    <td class="td_type1">
      <span class="text_base">
      <logic:equal name="cir190knForm" property="cir190autoDelKbn" value="<%= String.valueOf(GSConstCircular.AUTO_DEL_ADM) %>">
      <gsmsg:write key="cmn.set.the.admin" />
      </logic:equal>
      <logic:equal name="cir190knForm" property="cir190autoDelKbn" value="<%= String.valueOf(GSConstCircular.AUTO_DEL_ACCOUNT) %>">
      <gsmsg:write key="cmn.set.eachaccount" />
      </logic:equal>
      </span>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="25%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.employer" /></span></td>
    <td class="td_type1">
      <span class="text_base">
      <logic:equal name="cir190knForm" property="cir190acntUser" value="<%= String.valueOf(GSConstCircular.CIN_ACNT_USER_ONLY) %>">
      <gsmsg:write key="cmn.only.admin.setting" />
      </logic:equal>
      <logic:equal name="cir190knForm" property="cir190acntUser" value="<%= String.valueOf(GSConstCircular.CIN_ACNT_USER_NO) %>">
      <gsmsg:write key="wml.31" />
      </logic:equal>
      </span>
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
          <input type="button" name="btn_add" class="btn_base1" value="<gsmsg:write key="cmn.final" />" onClick="buttonPush('decision');">
          <input type="button" name="btn_facilities_mnt" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onClick="buttonPush('backInput');">
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
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>

<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<%@ page import="jp.groupsession.v2.cir.cir160kn.Cir160knForm" %>
<%-- 定数値 --%>
<%
  String  acModeNormal    = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.ACCOUNTMODE_NORMAL);
  String  acModePsn       = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.ACCOUNTMODE_PSNLSETTING);
  String  acModeCommon    = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.ACCOUNTMODE_COMMON);
  String  cmdModeAdd      = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CMDMODE_ADD);
  String  cmdModeEdit     = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CMDMODE_EDIT);
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<title>[Group Session] <gsmsg:write key="wml.wml040kn.05" /></title>
  <meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
  <theme:css filename="theme.css"/>
  <link rel="stylesheet" href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
  <link rel="stylesheet" href="../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
  <script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
  <script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
  <script language="JavaScript" src="../circular/js/cir160.js?<%= GSConst.VERSION_PARAM %>"></script>
<script>
function connectionEnd(){
  document.getElementById("connection").style.display="none";
  document.getElementById("connectionEnd").style.display="block";
}

function connectionTest(){
  document.getElementById("connection").style.display="block";
  document.getElementById("connectionEnd").style.display="none";
  setTimeout (connectionEnd, 2000);
}
</script>
</head>

<body class="body_03">

<html:form styleId="cir160kn" action="/circular/cir160kn">

<logic:notEqual name="cir160knForm" property="cir010adminUser" value="true">
  <input type="hidden" name="helpPrm" value="5">
</logic:notEqual>

<logic:equal name="cir160knForm" property="cir010adminUser" value="true">
  <input type="hidden" name="helpPrm" value="">
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

<html:hidden property="cir160initFlg" />
<html:hidden property="cir160AccountKbn" />
<html:hidden property="cir160DefActUsrSid" />
<html:hidden property="cir160elementKbn" />
<html:hidden property="cir160name" />
<html:hidden property="cir160biko" />

<html:hidden property="cir160JdelKbn" />
<html:hidden property="cir160JYear" />
<html:hidden property="cir160JMonth" />
<html:hidden property="cir160SdelKbn" />
<html:hidden property="cir160SYear" />
<html:hidden property="cir160SMonth" />
<html:hidden property="cir160DdelKbn" />
<html:hidden property="cir160DYear" />
<html:hidden property="cir160DMonth" />
<html:hidden property="cir160autoDelKbn" />
<html:hidden property="cir160cirInitKbn" />
<html:hidden property="cir160SelTab" />
<html:hidden property="cir160theme" />
<html:hidden property="cir160smlNtf" />
<html:hidden property="cir160smlMemo" />
<html:hidden property="cir160smlEdt" />

<html:hidden property="cir160memoKbn" />
<html:hidden property="cir160memoPeriod" />
<html:hidden property="cir160show" />
<html:hidden property="cir160SmlNtfKbn" />



<logic:notEmpty name="cir160knForm" property="cir160userKbnUser">
<logic:iterate id="permitId" name="cir160knForm" property="cir160userKbnUser">
  <input type="hidden" name="cir160userKbnUser" value="<bean:write name="permitId" />">
</logic:iterate>
</logic:notEmpty>

<html:hidden property="cir150keyword" />
<html:hidden property="cir150group" />
<html:hidden property="cir150user" />
<html:hidden property="cir150svKeyword" />
<html:hidden property="cir150svGroup" />
<html:hidden property="cir150svUser" />
<html:hidden property="cir150sortKey" />
<html:hidden property="cir150order" />
<html:hidden property="cir150searchFlg" />


<bean:define id="acctMode" name="cir160knForm" property="cirAccountMode" type="java.lang.Integer" />
<bean:define id="sCmdMode" name="cir160knForm" property="cirCmdMode" type="java.lang.Integer" />
<bean:define id="adminflg" name="cir160Form" property="cir010adminUser" type="java.lang.Boolean" />
<% int accountMode = acctMode.intValue(); %>
<% int cmdMode = sCmdMode.intValue(); %>
<% boolean adminFlg = adminflg; %>


<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>
<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" border="0" width="70%">
  <tr>
  <td>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <% if (adminflg && cmdMode == 0) { %>
          <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.wml040kn.05" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } else if (adminflg && cmdMode == 1) { %>
          <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.97" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } else if (!adminflg && cmdMode == 0) { %>
          <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.wml040kn.05" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } else if (!adminflg && cmdMode == 1) { %>
          <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.97" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } %>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="40%"></td>
        <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
        <td class="header_glay_bg" width="60%">
          <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('decision');">
          <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('backInput');">
        </td>
        <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
      </tr>
    </table>

  </td>
  </tr>

  <tr>
  <td>
    <img src="../common/images/spacer.gif" width="10" height="10" border="0" alt="">
    <div id="connection" style="text-align:center;padding:10px;display:none;"><img src="../webmail/js/assets/progress.gif" alt=""><gsmsg:write key="wml.wml040kn.02" /></div>
    <div id="connectionEnd" style="text-align:center;padding:10px;display:none;font-weight:bold;"><gsmsg:write key="wml.wml040kn.03" /></div>
  </td>
  </tr>

  <logic:messagesPresent message="false">
    <tr>
    <td>
    <table width="100%">
      <tr><td align="left"><html:errors/></td></tr>
    </table>
    </td>
    </tr>
  </logic:messagesPresent>

  <tr>
  <td>

    <table class="tl0" cellpadding="5" cellspacing="0" border="0" width="100%">
      <tr id="normal_tab" align="left">
        <td id="normal" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cmn.preferences" /></td>
        <logic:notEqual name="cir160knForm" property="cir160autoDelKbn" value="0">
          <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160knForm" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160knForm" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160knForm" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>
      </tr>
      <tr id="auto_del_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160knForm" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cmn.autodelete" /></td>
        </logic:notEqual>
        <logic:notEqual name="cir160knForm" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160knForm" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160knForm" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>

      <tr id="cirinit_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160knForm" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160knForm" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cir.23" /></td>
        </logic:notEqual>
        <logic:equal name="cir160knForm" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160knForm" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>
      <tr id="notify_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160knForm" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160knForm" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160knForm" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160knForm" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab now_forcus wml_tab_td2 tabWidth160" align="center" nowrap><gsmsg:write key="shortmail.notification" /></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>
      <tr id="other_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160knForm" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160knForm" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160knForm" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160knForm" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cmn.other" /></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>

    </table>

    <table id="normal_table" class="tl0" cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
    <td class="table_bg_A5B4E1" width="35%" nowrap><span class="text_bb1"><gsmsg:write key="wml.96" /></span></td>
    <td align="left" class="webmail_td1" width="65%">
    <bean:write name="cir160knForm" property="cir160name" />
    </td>
    </tr>


    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.memo" /></span></td>
    <td align="left" class="webmail_td1">
      <bean:write name="cir160knForm" property="cir160knBiko" filter="false" />
    </td>
    </tr>

<%--
    <logic:equal name="cir160knForm" property="cirAccountMode" value="2">
--%>
    <logic:equal name="cir160knForm" property="cir160acntUserFlg" value="true">
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.employer" /></span></td>
    <td align="left" class="webmail_td1">
    <%--
    <logic:equal name="cir160knForm" property="cir160userKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.cir160kn.Cir160knForm.USERKBN_GROUP) %>">
      <p><gsmsg:write key="wml.94" /></p>
      <logic:notEmpty name="cir160knForm" property="userKbnGroupSelectCombo">
        <ul>
          <logic:iterate id="userKbnLabel" name="cir160knForm" property="userKbnGroupSelectCombo">
          <li><bean:write name="userKbnLabel" property="label" /></li>
          </logic:iterate>
        </ul>
      </logic:notEmpty>
    </logic:equal>

      <p><gsmsg:write key="wml.77" /></p>
   --%>
      <logic:notEmpty name="cir160knForm" property="userKbnUserSelectCombo">
        <ul>
          <logic:iterate id="userKbnLabel" name="cir160knForm" property="userKbnUserSelectCombo">
          <bean:define id="mukouserClass" value=""/>
          <logic:equal name="userKbnLabel" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser_option</bean:define></logic:equal>
          <li><span class="<%=mukouserClass%>"><bean:write name="userKbnLabel" property="label" /></span></li>
          </logic:iterate>
        </ul>
      </logic:notEmpty>

    </td>
    </tr>
    </logic:equal>

    </table>

    <table id="auto_del_table" class="tl0 display_none" cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.25" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir160knForm" property="cir160JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.noset" />
      </logic:equal>
      <logic:equal name="cir160knForm" property="cir160JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="jyear" name="cir160knForm" property="cir160JYear" type="java.lang.String" />
        <bean:define id="jmonth" name="cir160knForm" property="cir160JMonth" type="java.lang.String" />
        <strong><gsmsg:write key="cmn.year" arg0="<%= jyear %>" /> <gsmsg:write key="cmn.months" arg0="<%= jmonth %>" /></strong> <gsmsg:write key="cmn.auto.del.data.older.than" />
      </logic:equal>
      </span>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.26" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir160knForm" property="cir160SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.noset" />
      </logic:equal>
      <logic:equal name="cir160knForm" property="cir160SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="syear" name="cir160knForm" property="cir160SYear" type="java.lang.String" />
        <bean:define id="smonth" name="cir160knForm" property="cir160SMonth" type="java.lang.String" />
        <strong><gsmsg:write key="cmn.year" arg0="<%= syear %>" /> <gsmsg:write key="cmn.months" arg0="<%= smonth %>" /></strong> <gsmsg:write key="cmn.auto.del.data.older.than" />
      </logic:equal>
      </span>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.27" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir160knForm" property="cir160DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.noset" />
      </logic:equal>
      <logic:equal name="cir160knForm" property="cir160DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="dyear" name="cir160knForm" property="cir160DYear" type="java.lang.String" />
        <bean:define id="dmonth" name="cir160knForm" property="cir160DMonth" type="java.lang.String" />
        <strong><gsmsg:write key="cmn.year" arg0="<%= dyear %>" /> <gsmsg:write key="cmn.months" arg0="<%= dmonth %>" /></strong> <gsmsg:write key="cmn.auto.del.data.older.than" />
      </logic:equal>
      </span>
    </td>
    </tr>
    </table>

    <table id="cirinit_table"  class="display_none" width="100%" class="tl0" border="0" cellpadding="5">

      <tr>
      <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap id="cirEditArea1" rowspan="2">
        <span class="text_bb1"><gsmsg:write key="cir.cir040.2" /></span>
      </td>
      </tr>


      <logic:equal name="cir160knForm" property="cir160memoKbn" value="0">
        <!-- メモ欄修正区分 -->
        <tr>
        <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
          <span class="text_base"><gsmsg:write key="cmn.not" /></span>
        </td>
        </tr>
      </logic:equal>

      <logic:equal name="cir160knForm" property="cir160memoKbn" value="1">
        <!-- メモ欄修正区分 -->
        <tr>
        <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
          <span class="text_base"><gsmsg:write key="cmn.accepted" /></span>
        <!-- メモ欄修正期限設定 -->
        <br>
        <br>
        <span class="text_base"><gsmsg:write key="cir.54" /></span>
        <br>

        <logic:equal name="cir160knForm" property="cir160memoPeriod" value="1">
            <span class="text_base"><gsmsg:write key="cmn.today" /></span>
        </logic:equal>
        <logic:equal name="cir160knForm" property="cir160memoPeriod" value="0">
            <span class="text_base">1<gsmsg:write key="cmn.weeks" /></span>
        </logic:equal>
        <logic:equal name="cir160knForm" property="cir160memoPeriod" value="2">
            <span class="text_base">2<gsmsg:write key="cmn.weeks" /></span>
        </logic:equal>
        <logic:equal name="cir160knForm" property="cir160memoPeriod" value="3">
            <span class="text_base"><gsmsg:write key="cmn.months" arg0="1" /></span>
        </logic:equal>



        </td>
        </tr>
      </logic:equal>


      <!-- 回覧先確認編集権限区分 -->
      <tr>
      <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap id="cirEditArea1" rowspan="2">
        <span class="text_bb1"><gsmsg:write key="cir.cir030.3" /></span>
      </td>
      </tr>


      <!-- 回覧先確認状況区分 -->
      <tr>
      <td align="left" class="td_wt" nowrap>
        <logic:equal name="cir160knForm" property="cir160show" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PUBLIC) %>">
            <span class="text_base"><gsmsg:write key="cmn.public" /></span>
        </logic:equal>
        <logic:equal name="cir160knForm" property="cir160show" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PRIVATE) %>">
            <span class="text_base"><gsmsg:write key="cmn.private" /></span>
        </logic:equal>
      </td>
      </tr>

    </table>
    <logic:equal name="cir160knForm" property="canSmlUse" value="<%=String.valueOf(GSConst.PLUGIN_USE) %>">
    <logic:equal name="cir160knForm" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
    <table id="notify_table" width="100%" class="tl0 display_none" border="0" cellpadding="5">
       <tr>
       <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.2" /></span></td>
       <td align="left" class="td_wt" width="100%">
          <div class="text_base" >
            <logic:equal name="cir160knForm" property="cir160smlNtf" value="0">
              <gsmsg:write key="cmn.notify" />
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160smlNtf" value="1">
              <gsmsg:write key="cmn.dont.notify" />
            </logic:equal>
          </div>
       </td>
       </tr>
       <tr>
         <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.4" /></span></td>
         <td class="td_wt" >
           <div class="text_base" >
             <logic:equal name="cir160knForm" property="cir160smlMemo" value="0">
               <gsmsg:write key="cmn.notify" />
             </logic:equal>
             <logic:equal name="cir160knForm" property="cir160smlMemo" value="1">
               <gsmsg:write key="cmn.dont.notify" />
             </logic:equal>
           </div>
         </td>
       </tr>
       <tr>
         <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.6" /></span></td>
         <td class="td_wt" >
           <div class="text_base" >
             <logic:equal name="cir160knForm" property="cir160smlEdt" value="0">
               <gsmsg:write key="cmn.notify" />
             </logic:equal>
             <logic:equal name="cir160knForm" property="cir160smlEdt" value="1">
               <gsmsg:write key="cmn.dont.notify" />
             </logic:equal>
           </div>
         </td>
       </tr>
    </table>


    </logic:equal>
    </logic:equal>

    <table id="other_table" class="tl0 display_none" cellpadding="5" cellspacing="0" border="0" width="100%">

      <tr>
      <td width="250" class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.theme" /></span></td>
      <td align="left" class="webmail_td1">

            <logic:equal name="cir160knForm" property="cir160theme" value="0">
              <bean:write name="cir160knForm" property="cir160knTheme" />
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160theme" value="1">
              <span class="theme_class_1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160theme" value="2">
              <span class="theme_class_2">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160theme" value="3">
              <span class="theme_class_3">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160theme" value="4">
              <span class="theme_class_4">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160theme" value="5">
              <span class="theme_class_5">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
            </logic:equal>
            <logic:equal name="cir160knForm" property="cir160theme" value="6">
             <span class="theme_class_6">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
            </logic:equal>

      </td>
      </tr>
    </table>


  </td>
  </tr>

  <tr>
  <td>
    <img src="../common/images/spacer.gif" width="1px" height="10px" border="0" alt="<gsmsg:write key="cmn.spacer" />">
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

<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>

</body>
</html:html>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>

<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%@ page import="jp.groupsession.v2.cir.cir160.Cir160Form" %>
<%-- 定数値 --%>
<%
  String  acModeNormal    = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.ACCOUNTMODE_NORMAL);
  String  acModePsn       = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.ACCOUNTMODE_PSNLSETTING);
  String  acModeCommon    = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.ACCOUNTMODE_COMMON);
  String  cmdModeAdd      = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CMDMODE_ADD);
  String  cmdModeEdit     = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CMDMODE_EDIT);
%>

<% String tuuchi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SMAIL_TSUUCHI); %>
<% String notuuchi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SMAIL_NOT_TSUUCHI); %>


<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src='../schedule/jquery_ui/js/jquery-ui-1.8.14.custom.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../circular/js/cir160.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/grouppopup.js?<%= GSConst.VERSION_PARAM %>"></script>

<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery/jquery-theme.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery_ui/css/jquery.ui.dialog.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>

<title>[Group Session] <gsmsg:write key="wml.wml040.05" /></title>
</head>

<body class="body_03" onunload="windowClose();">

<html:form styleId="cir160Form" action="/circular/cir160">

<logic:equal name="cir160Form" property="cirAccountMode" value="2">
<input type="hidden" name="helpPrm" value="" />
</logic:equal>

<logic:notEqual name="cir160Form" property="cirAccountMode" value="2">
<input type="hidden" name="helpPrm" value="5" />
</logic:notEqual>

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
<html:hidden property="cir160initFlg" />
<html:hidden property="cir160AccountKbn" />
<html:hidden property="cir160DefActUsrSid" />
<html:hidden property="cir160elementKbn" />
<html:hidden property="cir150keyword" />
<html:hidden property="cir150group" />
<html:hidden property="cir150user" />
<html:hidden property="cir150svKeyword" />
<html:hidden property="cir150svGroup" />
<html:hidden property="cir150svUser" />
<html:hidden property="cir150sortKey" />
<html:hidden property="cir150order" />
<html:hidden property="cir150searchFlg" />
<html:hidden property="cir160autoDelKbn" />
<html:hidden property="cir160cirInitKbn" />
<html:hidden property="cir160SelTab" />
<html:hidden property="cir160SmlNtfKbn" />

<logic:equal name="cir160Form" property="cir160cirInitKbn" value="0">
  <html:hidden property="cir160memoKbn" />
  <html:hidden property="cir160memoPeriod" />
  <html:hidden property="cir160show" />
</logic:equal>


<bean:define id="acctMode" name="cir160Form" property="cirAccountMode" type="java.lang.Integer" />
<bean:define id="wCmdMode" name="cir160Form" property="cirCmdMode" type="java.lang.Integer" />
<bean:define id="adminflg" name="cir160Form" property="cir010adminUser" type="java.lang.Boolean" />
<% int accountMode = acctMode.intValue(); %>
<% int cmdMode = wCmdMode.intValue(); %>
<% boolean adminFlg = adminflg; %>

<%--
<logic:notEmpty name="cir160Form" property="cir160userKbnGroup">
<logic:iterate id="accountGroup" name="cir160Form" property="cir160userKbnGroup">
  <input type="hidden" name="cir160userKbnGroup" value="<bean:write name="accountGroup" />">
</logic:iterate>
</logic:notEmpty>
--%>

<logic:notEmpty name="cir160Form" property="cir160userKbnUser">
<logic:iterate id="accountUser" name="cir160Form" property="cir160userKbnUser">
  <input type="hidden" name="cir160userKbnUser" value="<bean:write name="accountUser" />">
</logic:iterate>
</logic:notEmpty>

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
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.wml040.05" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } else if (adminflg && cmdMode == 1) { %>
          <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.98" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } else if (!adminflg && cmdMode == 0) { %>
          <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.wml040.05" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } else if (!adminflg && cmdMode == 1) { %>
          <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt=""></td>
          <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
          <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.98" /> ]</td>
          <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
        <% } %>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="50%"></td>
        <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
        <td class="header_glay_bg" width="50%">
          <input type="button" value="OK" class="btn_ok1" onClick="buttonPush('confirm');">
          <logic:equal name="cir160Form" property="cirCmdMode" value="1">
            <logic:equal name="cir160Form" property="cir160AccountKbn" value="1">
              <logic:equal name="cir160Form" property="cir160CanDelFlg" value="0">
                <input type="button" value="<gsmsg:write key="cmn.delete" />" class="btn_dell_n1" onClick="buttonPush('deleteAccount');">
              </logic:equal>
            </logic:equal>
          </logic:equal>
          <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('beforePage');">
        </td>
        <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
      </tr>
    </table>

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
    <img src="../common/images/spacer.gif" width="10" height="10" border="0" alt="">
  </td>
  </tr>

  <tr>
  <td>

    <table class="tl0" cellpadding="5" cellspacing="0" border="0" width="100%">
      <tr id="normal_tab" align="left">
        <td id="normal" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cmn.preferences" /></td>
        <logic:notEqual name="cir160Form" property="cir160autoDelKbn" value="0">
          <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160Form" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160Form" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>

        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>
      </tr>
      <tr id="auto_del_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160Form" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cmn.autodelete" /></td>
        </logic:notEqual>
        <logic:notEqual name="cir160Form" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160Form" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>

      <tr id="cirinit_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160Form" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160Form" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cir.23" /></td>
        </logic:notEqual>
        <logic:equal name="cir160Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160Form" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>
      <tr id="notify_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160Form" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160Form" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160Form" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab now_forcus wml_tab_td2 tabWidth160" align="center" nowrap><gsmsg:write key="shortmail.notification" /></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.other" /></a></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>
      <tr id="other_tab" class="display_none" align="left">
        <td id="normal" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#" style="color:#ffffff;"><gsmsg:write key="cmn.preferences" /></a></td>
        <logic:notEqual name="cir160Form" property="cir160autoDelKbn" value="0">
        <td id="auto_del" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cmn.autodelete" /></a></td>
        </logic:notEqual>
        <logic:notEqual name="cir160Form" property="cir160cirInitKbn" value="0">
          <td id="cirinit" class="cir_account_tab none_forcus wml_tab_td2" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="cir.23" /></a></td>
        </logic:notEqual>
        <logic:equal name="cir160Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
        <logic:equal name="cir160Form" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
          <td id="notify" class="cir_account_tab none_forcus wml_tab_td2 tabWidth160" align="center" nowrap><a href="#"  style="color:#ffffff;"><gsmsg:write key="shortmail.notification" /></a></td>
        </logic:equal>
        </logic:equal>
        <td id="other" class="cir_account_tab now_forcus wml_tab_td2" align="center" nowrap><gsmsg:write key="cmn.other" /></td>
        <td class="wml_tab_td2" width="100%">&nbsp;</td>
      </tr>


    </table>

    <table id="normal_table" class="tl0" cellpadding="5" cellspacing="0" border="0" width="100%">


      <tr>
        <td class="table_bg_A5B4E1" width="150px" nowrap><span class="text_bb1"><gsmsg:write key="wml.96" /></span><span class="text_r2"><gsmsg:write key="cmn.comments" /></span></td>
        <td align="left" class="td_wt" width="750px">
          <logic:equal name="cir160Form" property="cir160AccountKbn" value="1">
            <html:text name="cir160Form" property="cir160name" styleClass="width:60%;" maxlength="100" style="width:275px;"/>
          </logic:equal>
          <logic:equal name="cir160Form" property="cir160AccountKbn" value="0">
            <html:hidden property="cir160name" />
            <bean:write name="cir160Form" property="cir160name" />
          </logic:equal>
        </td>
      </tr>

      <tr>
        <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.memo" /></span></td>
        <td align="left" class="webmail_td1">
          <html:textarea name="cir160Form" property="cir160biko" style="width:442px;" rows="10" />
        </td>
      </tr>

<%--
      <logic:equal name="cir160Form" property="cir010adminUser" value="true">
--%>
      <logic:equal name="cir160Form" property="cir160acntUserFlg" value="true">

      <tr>
        <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.employer" /></span><span class="text_r2"><gsmsg:write key="cmn.comments" /></span></td>
        <td align="left" class="webmail_td1">
<%--
          <p>
          <html:radio name="cir160Form" property="cir160userKbn" styleId="usrKbn1" value="0" onclick="tensoCheck(0 ,2, -1);" /><label for="usrKbn1"><gsmsg:write key="wml.94" /></label>
          &nbsp;<html:radio name="cir160Form" property="cir160userKbn" styleId="usrKbn2" value="1" onclick="tensoCheck(1, 2, -1);" /><label for="usrKbn2"><gsmsg:write key="wml.77" /></label>
          </p>

          <table id="permissionGroup">

            <tr>
              <td width="50%">
                <span class="text_r1">
                  <logic:equal name="cir160Form" property="cir160AccountKbn" value="0">
                    <gsmsg:write key="wml.wml040.01" />:<bean:write name="cir160Form" property="cir160name" />
                  </logic:equal>
                </span>
              </td>
              <td width="0%"></td>
              <td width="50%"></td>
            </tr>

            <tr>
              <td class="table_bg_A5B4E1" align="center" width="50%"><span class="text_bb1"><gsmsg:write key="wml.wml040.02" /></span></td>
              <td width="0%"></td>
              <td class="table_bg_A5B4E1" align="center" width="50%"><span class="text_bb1"><gsmsg:write key="wml.wml040.04" /></span></td>
            </tr>
            <tr>
              <td class="td_type1">

                <html:select name="cir160Form" property="cir160userKbnGroupSelect" size="7" styleClass="circular_select01" multiple="true">
                  <logic:notEmpty name="cir160Form" property="userKbnGroupSelectCombo">
                  <html:optionsCollection name="cir160Form" property="userKbnGroupSelectCombo" value="value" label="label" />
                  </logic:notEmpty>
                </html:select>
              </td>
              <td valign="middle">
                <img alt="<gsmsg:write key="cmn.add" />" border="0" src="../common/images/arrow2_l.gif" onClick="return buttonPush('addGroup');">
                <img src="../common/images/spacer.gif" width="20" height="30">
                <img alt="<gsmsg:write key="cmn.delete" />" border="0" src="../common/images/arrow2_r.gif" onClick="deleteSelGroup();">
              </td>
              <td class="td_type1">
                <html:select name="cir160Form" property="cir160userKbnGroupNoSelect" size="7" styleClass="circular_select01" multiple="true">
                  <logic:notEmpty name="cir160Form" property="userKbnGroupNoSelectCombo">
                  <html:optionsCollection name="cir160Form" property="userKbnGroupNoSelectCombo" value="value" label="label" />
                  </logic:notEmpty>
                </html:select>
              </td>
            </tr>
          </table>
          --%>

          <table id="permissionUser">
            <tr>
              <td class="table_bg_A5B4E1" align="center" width="50%"><span class="text_bb1"><gsmsg:write key="wml.wml040.01" /></span></td>
              <td width="0%"></td>
              <td class="table_bg_A5B4E1" align="center" width="50%"><span class="text_bb1"><gsmsg:write key="wml.wml040.03" /></span></td>
            </tr>
            <tr>
              <td class="td_type1">

                <html:select name="cir160Form" property="cir160userKbnUserSelect" size="11" styleClass="circular_select01" multiple="true">
                  <logic:notEmpty name="cir160Form" property="userKbnUserSelectCombo">
                  <logic:iterate id="user" name="cir160Form" property="userKbnUserSelectCombo">
                    <bean:define id="mukouserClass" value=""/>
                    <bean:define id="userValue"><bean:write name="user" property="value" /></bean:define>
                    <logic:equal name="user" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser_option</bean:define></logic:equal>
                    <html:option styleClass="<%=mukouserClass %>" value="<%=userValue %>"><bean:write name="user" property="label" /></html:option>
                  </logic:iterate>
                  </logic:notEmpty>
                </html:select>
              </td>
              <td valign="middle">
                <img alt="<gsmsg:write key="cmn.add" />" border="0" src="../common/images/arrow2_l.gif" onClick="return buttonPush('addUser');">
                <img src="../common/images/spacer.gif" width="20" height="30">
                <img alt="<gsmsg:write key="cmn.delete" />" border="0" src="../common/images/arrow2_r.gif" onClick="return deleteSelUser();">
              </td>
              <td class="td_type1">
                <input class="btn_group_n1" value="<gsmsg:write key="cmn.sel.all.group" />" onclick="return openAllGroup(this.form.cir160userKbnUserGroup, 'cir160userKbnUserGroup', '<bean:write name="cir160Form" property="cir160userKbnUserGroup" />', '0', 'init', 'cir160userKbnUser', '-1', '0')" type="button">
                <html:select name="cir160Form" property="cir160userKbnUserGroup" styleClass="circular_select01" onchange="buttonPush('init');">
                  <html:optionsCollection name="cir160Form" property="userKbnGroupCombo" value="value" label="label" />
                </html:select>
                <input type="button" onclick="openGroupWindow(this.form.cir160userKbnUserGroup, 'cir160userKbnUserGroup', '0', 'init')" class="group_btn2" value="&nbsp;&nbsp;" id="cir160GroupBtn">
                <html:select name="cir160Form" property="cir160userKbnUserNoSelect" size="9" styleClass="circular_select01" multiple="true">
                  <logic:notEmpty name="cir160Form" property="userKbnUserNoSelectCombo">
                  <logic:iterate id="user" name="cir160Form" property="userKbnUserNoSelectCombo">
                    <bean:define id="mukouserClass" value=""/>
                    <bean:define id="userValue"><bean:write name="user" property="value" /></bean:define>
                    <logic:equal name="user" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser_option</bean:define></logic:equal>
                    <html:option styleClass="<%=mukouserClass %>" value="<%=userValue %>"><bean:write name="user" property="label" /></html:option>
                  </logic:iterate>
                  </logic:notEmpty>
                </html:select>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      </logic:equal>

    </table>

    <logic:notEqual name="cir160Form" property="cir160autoDelKbn" value="0">
    <table id="auto_del_table"  class="display_none" width="100%" class="tl0" border="0" cellpadding="5">
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.25" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir160Form" property="cir160JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir160JdelKbn_0" onclick="setDispState(this.form.cir160JdelKbn, this.form.cir160JYear, this.form.cir160JMonth)" /><label for="cir160JdelKbn_0"><gsmsg:write key="cmn.noset" /></label>&nbsp;
        <html:radio name="cir160Form" property="cir160JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir160JdelKbn_1" onclick="setDispState(this.form.cir160JdelKbn, this.form.cir160JYear, this.form.cir160JMonth)" /><label for="cir160JdelKbn_1"><gsmsg:write key="cmn.automatically.delete" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />

        <logic:notEmpty name="cir160Form" property="cir160YearLabelList">
          <html:select property="cir160JYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir160Form" property="cir160YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir160Form" property="cir160MonthLabelList">
          <html:select property="cir160JMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir160Form" property="cir160MonthLabelList" value="value" label="label" />
          </html:select>
           <gsmsg:write key="cmn.after.data" />
        </logic:notEmpty>

      </span>

    </td>
    </tr>
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.26" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir160Form" property="cir160SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir160SdelKbn_0" onclick="setDispState(this.form.cir160SdelKbn, this.form.cir160SYear, this.form.cir160SMonth)" /><label for="cir160SdelKbn_0"><gsmsg:write key="cmn.noset" /></label>&nbsp;
        <html:radio name="cir160Form" property="cir160SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir160SdelKbn_1" onclick="setDispState(this.form.cir160SdelKbn, this.form.cir160SYear, this.form.cir160SMonth)" /><label for="cir160SdelKbn_1"><gsmsg:write key="cmn.automatically.delete" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />

        <logic:notEmpty name="cir160Form" property="cir160YearLabelList">
          <html:select property="cir160SYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir160Form" property="cir160YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir160Form" property="cir160MonthLabelList">
          <html:select property="cir160SMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir160Form" property="cir160MonthLabelList" value="value" label="label" />
          </html:select>
           <gsmsg:write key="cmn.after.data" />
        </logic:notEmpty>

      </span>

    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.27" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir160Form" property="cir160DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir160DdelKbn_0" onclick="setDispState(this.form.cir160DdelKbn, this.form.cir160DYear, this.form.cir160DMonth)" /><label for="cir160DdelKbn_0"><gsmsg:write key="cmn.noset" /></label>&nbsp;
        <html:radio name="cir160Form" property="cir160DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir160DdelKbn_1" onclick="setDispState(this.form.cir160DdelKbn, this.form.cir160DYear, this.form.cir160DMonth)" /><label for="cir160DdelKbn_1"><gsmsg:write key="cmn.automatically.delete" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />

        <logic:notEmpty name="cir160Form" property="cir160YearLabelList">
          <html:select property="cir160DYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir160Form" property="cir160YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir160Form" property="cir160MonthLabelList">
          <html:select property="cir160DMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir160Form" property="cir160MonthLabelList" value="value" label="label" />
          </html:select>
           <gsmsg:write key="cmn.after.data" />
        </logic:notEmpty>

      </span>

    </td>
    </tr>
    </table>
    </logic:notEqual>


    <logic:notEqual name="cir160Form" property="cir160cirInitKbn" value="0">
    <table id="cirinit_table"  class="display_none" width="100%" class="tl0" border="0" cellpadding="5">

      <tr>
      <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap id="cirEditArea1" rowspan="2">
        <span class="text_bb1"><gsmsg:write key="cir.cir040.2" /></span>
      </td>
      </tr>

      <logic:equal name="cir160Form" property="cir160memoKbn" value="0">
        <html:hidden property="cir160memoPeriod" />
        <!-- メモ欄修正区分 -->
        <tr>
        <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
          <html:radio property="cir160memoKbn" styleId="memoNg" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_NO) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoNg"><span class="text_base"><gsmsg:write key="cmn.not" /></span>&nbsp;&nbsp;</label>
          <html:radio property="cir160memoKbn" styleId="memoOk" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_YES) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoOk"><span class="text_base"><gsmsg:write key="cmn.accepted" /></span></label>
        </td>
        </tr>
      </logic:equal>

      <logic:equal name="cir160Form" property="cir160memoKbn" value="1">
        <!-- メモ欄修正区分 -->
        <tr>
        <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
          <html:radio property="cir160memoKbn" styleId="memoNg" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_NO) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoNg"><span class="text_base"><gsmsg:write key="cmn.not" /></span>&nbsp;&nbsp;</label>
          <html:radio property="cir160memoKbn" styleId="memoOk" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_YES) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoOk"><span class="text_base"><gsmsg:write key="cmn.accepted" /></span></label>
        <!-- メモ欄修正期限設定 -->
        <br>
        <br>
        <span class="text_base"><gsmsg:write key="cir.54" /></span>
        <br>

          <html:radio property="cir160memoPeriod" styleId="today" value="1" /><label for="today"><span class="text_base"><gsmsg:write key="cmn.today" /></span></label>&nbsp;&nbsp;
          <html:radio property="cir160memoPeriod" styleId="1weeks" value="0" /><label for="1weeks"><span class="text_base">1<gsmsg:write key="cmn.weeks" /></span></label>&nbsp;&nbsp;
          <html:radio property="cir160memoPeriod" styleId="2weeks" value="2" /><label for="2weeks"><span class="text_base">2<gsmsg:write key="cmn.weeks" /></span></label>&nbsp;&nbsp;
          <html:radio property="cir160memoPeriod" styleId="months" value="3" /><label for="months"><span class="text_base"><gsmsg:write key="cmn.months" arg0="1" /></span></label>

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
        <html:radio name="cir160Form" property="cir160show" styleId="showPub" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PUBLIC) %>" /><label for="showPub"><span class="text_base"><gsmsg:write key="cmn.public" /></span>&nbsp;&nbsp;</label>
        <html:radio name="cir160Form" property="cir160show" styleId="showPri" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PRIVATE) %>" /><label for="showPri"><span class="text_base"><gsmsg:write key="cmn.private" /></span></label>
      </td>
      </tr>

    </table>
    </logic:notEqual>

    <!-- ショートメール通知タブボディ -->
    <logic:equal name="cir160Form" property="canSmlUse" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_USE) %>">
    <logic:equal name="cir160Form" property="cir160SmlNtfKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>">
    <table id="notify_table"  width="100%" class="tl0 display_none" border="0" cellpadding="5">
       <tr>
       <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.2" /></span></td>
       <td align="left" class="td_wt" width="100%">
           <div class="text_base" >
               <html:radio name="cir160Form" styleId="cir160smlNtf_01" property="cir160smlNtf" value="<%= tuuchi %>" /><label for="cir160smlNtf_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
               <html:radio name="cir160Form" styleId="cir160smlNtf_02" property="cir160smlNtf" value="<%= notuuchi %>" /><label for="cir160smlNtf_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
           </div>
           <div class="text_base7 margin_top10" >
             <gsmsg:write key="cir.cir160.3" />
           </div>
       </td>
       </tr>
       <tr>
         <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.4" /></span></td>
         <td class="td_wt" >
           <div class="text_base" >
               <html:radio name="cir160Form" styleId="cir160smlMemo_01" property="cir160smlMemo" value="<%= tuuchi %>" /><label for="cir160smlMemo_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
               <html:radio name="cir160Form" styleId="cir160smlMemo_02" property="cir160smlMemo" value="<%= notuuchi %>" /><label for="cir160smlMemo_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
           </div>
           <div class="text_base7 margin_top10" >
             <gsmsg:write key="cir.cir160.5" />
           </div>
         </td>
       </tr>
       <tr>
         <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.6" /></span></td>
         <td class="td_wt" >
           <div class="text_base" style="">
               <html:radio name="cir160Form" styleId="cir160smlEdt_01" property="cir160smlEdt" value="<%= tuuchi %>" /><label for="cir160smlEdt_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
               <html:radio name="cir160Form" styleId="cir160smlEdt_02" property="cir160smlEdt" value="<%= notuuchi %>" /><label for="cir160smlEdt_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
           </div>
           <div class="text_base7 margin_top10" >
             <gsmsg:write key="cir.cir160.7" />
           </div>
         </td>
       </tr>
    </table>
    </logic:equal>
    </logic:equal>


    <table id="other_table"  class="display_none" width="100%" class="tl0" border="0" cellpadding="5">

      <tr>
        <td width="150px"  class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.theme" /></span></td>
        <td  align="left" class="webmail_td1">
        <%--
          <html:select name="cir160Form" property="cir160theme">
            <logic:notEmpty name="cir160Form" property="cir160themeList">
              <html:optionsCollection name="cir160Form" property="cir160themeList" value="value" label="label" />
            </logic:notEmpty>
          </html:select>
        --%>

        <% String themeClass = "theme_class_0"; %>

        <logic:notEmpty name="cir160Form" property="cir160themeList">
          <logic:iterate id="themeMdl" name="cir160Form" property="cir160themeList" indexId="themeIdx" >

            <logic:equal name="themeMdl" property="value" value="1">
              <% themeClass = "theme_class_1"; %>
            </logic:equal>
            <logic:equal name="themeMdl" property="value" value="2">
              <% themeClass = "theme_class_2"; %>
            </logic:equal>
            <logic:equal name="themeMdl" property="value" value="3">
              <% themeClass = "theme_class_3"; %>
            </logic:equal>
            <logic:equal name="themeMdl" property="value" value="4">
              <% themeClass = "theme_class_4"; %>
            </logic:equal>
            <logic:equal name="themeMdl" property="value" value="5">
              <% themeClass = "theme_class_5"; %>
            </logic:equal>
            <logic:equal name="themeMdl" property="value" value="6">
              <% themeClass = "theme_class_6"; %>
            </logic:equal>

            <bean:define id="themeVal" name="themeMdl" property="value" type="java.lang.String"/>
            <html:radio name="cir160Form" property="cir160theme" styleId="<%= String.valueOf(themeIdx) %>" value="<%= themeVal %>" />
            <label for="<%= String.valueOf(themeIdx) %>">

              <logic:equal name="themeMdl" property="value" value="0">
                <span style="cursor:pointer;"><bean:write name="themeMdl" property="label" /></span>&nbsp;&nbsp;
              </logic:equal>

              <logic:notEqual name="themeMdl" property="value" value="0">
                <span class="<%= themeClass %>">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span>&nbsp;&nbsp;
              </logic:notEqual>

            </label>

          </logic:iterate>
        </logic:notEmpty>

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
          <input type="button" value="OK" class="btn_ok1" onClick="buttonPush('confirm');">
          <logic:equal name="cir160Form" property="cirCmdMode" value="1">
            <logic:equal name="cir160Form" property="cir160AccountKbn" value="1">
              <logic:equal name="cir160Form" property="cir160CanDelFlg" value="0">
                <input type="button" value="<gsmsg:write key="cmn.delete" />" class="btn_dell_n1" onClick="buttonPush('deleteAccount');">
              </logic:equal>
            </logic:equal>
          </logic:equal>
          <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('beforePage');">
        </td>
      </tr>
    </table>

  </td>
  </tr>
  </table>

</td>
</tr>
</table>

<div id="messagePop" title="" style="display:none">
  <p>
    <div style="float:left;"><span class="ui-icon ui-icon-info"></span></div><div style="float:left;padding-left:15px;padding-top:10px;"><b id="messageArea"></b></div>
  </p>
</div>

<div id="clearTensoPop" title="" style="display:none">
  <p>
    <div style="float:left;"><span class="ui-icon ui-icon-info"></span></div><div style="float:left;padding-left:15px;padding-top:10px;"><b><gsmsg:write key="sml.169" /></b></div>
  </p>
</div>

</html:form>

<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>

</body>
</html:html>
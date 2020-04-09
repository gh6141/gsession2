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
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src="../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src='../schedule/jquery_ui/js/jquery-ui-1.8.14.custom.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../circular/js/cir090.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../circular/js/ciraccountsel.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery/jquery-theme.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery_ui/css/jquery.ui.dialog.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[GroupSession] <gsmsg:write key="cir.21" /></title>
</head>

<body class="body_03" onload="changeEnableDisable();">
<html:form action="/circular/cir090">
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
<html:hidden property="cir090AccountSid" />
<html:hidden property="cir090AccountName" />

<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<!-- BODY -->
<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>
<td width="100%" align="center">
  <table cellpadding="0" cellspacing="0" border="0" width="70%">
  <tr>
  <td>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt=""></td>
    <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.21" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" value="OK" class="btn_ok1" onClick="submitStyleChange();buttonPush('syudo_del_kakunin');">
      <input type="button" value="<gsmsg:write key="cmn.back.preferences" />" class="btn_back_n3" onClick="buttonPush('backKjnTool');">
    </td>
    <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
    </tr>
    </table>
    <logic:messagesPresent message="false">
      <table width="100%">
      <tr>
        <td align="left"><span class="TXT02"><html:errors/></span></td>
      </tr>
      </table>
    </logic:messagesPresent>
    <img src="../common/images/spacer.gif" width="1px" height="10px" border="0">

    <table width="100%" class="tl0" border="0" cellpadding="5">

        <tr>
    <th class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.target" /><gsmsg:write key="wml.102" /></span></th>
    <td align="left" class="td_wt" width="100%">
      <div>
        <html:radio name="cir090Form" property="cir090SelKbn" styleClass="accountSelKbn" styleId="cir090SelKbn_0"  value="0"/><span class="text_base"><label for="cir090SelKbn_0"><gsmsg:write key="wml.wml010.12" /></label></span>&nbsp;
        <html:radio name="cir090Form" property="cir090SelKbn" styleClass="accountSelKbn" styleId="cir090SelKbn_1"  value="1"/><span class="text_base"><label for="cir090SelKbn_1"><gsmsg:write key="cmn.all" /></label></span>&nbsp;
      </div>
      <div id="accountSelArea" class="account_name_area"><span id="selAccountNameArea"><bean:write name="cir090Form" property="cir090AccountName" /></span>　<input id="accountSelBtn" type="button" name="btn_add" class="btn_base1_7" value="<gsmsg:write key="wml.102" /><gsmsg:write key="cmn.select" />" ></div>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.manual.delete2" /> <gsmsg:write key="cir.25" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir090Form" property="cir090JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir090JdelKbn_0" onclick="setDispState(this.form.cir090JdelKbn, this.form.cir090JYear, this.form.cir090JMonth)" /><label for="cir090JdelKbn_0"><gsmsg:write key="cmn.dont.delete" /></label>&nbsp;
        <html:radio name="cir090Form" property="cir090JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir090JdelKbn_1" onclick="setDispState(this.form.cir090JdelKbn, this.form.cir090JYear, this.form.cir090JMonth)" /><label for="cir090JdelKbn_1"><gsmsg:write key="cmn.delete.manual" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />

        <logic:notEmpty name="cir090Form" property="cir090YearLabelList">
          <html:select property="cir090JYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir090Form" property="cir090YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir090Form" property="cir090MonthLabelList">
          <html:select property="cir090JMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir090Form" property="cir090MonthLabelList" value="value" label="label" />
          </html:select>
           <gsmsg:write key="cmn.after.data" />
        </logic:notEmpty>

      </span>

    </td>
    </tr>
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.manual.delete2" /> <gsmsg:write key="cir.26" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir090Form" property="cir090SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir090SdelKbn_0" onclick="setDispState(this.form.cir090SdelKbn, this.form.cir090SYear, this.form.cir090SMonth)" /><label for="cir090SdelKbn_0"><gsmsg:write key="cmn.dont.delete" /></label>&nbsp;
        <html:radio name="cir090Form" property="cir090SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir090SdelKbn_1" onclick="setDispState(this.form.cir090SdelKbn, this.form.cir090SYear, this.form.cir090SMonth)" /><label for="cir090SdelKbn_1"><gsmsg:write key="cmn.delete.manual" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />
        <logic:notEmpty name="cir090Form" property="cir090YearLabelList">
          <html:select property="cir090SYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir090Form" property="cir090YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir090Form" property="cir090MonthLabelList">
          <html:select property="cir090SMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir090Form" property="cir090MonthLabelList" value="value" label="label" />
          </html:select>
           <gsmsg:write key="cmn.after.data" />
        </logic:notEmpty>

      </span>

    </td>
    </tr>
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.manual.delete2" /> <gsmsg:write key="cir.27" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir090Form" property="cir090DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir090DdelKbn_0" onclick="setDispState(this.form.cir090DdelKbn, this.form.cir090DYear, this.form.cir090DMonth)" /><label for="cir090DdelKbn_0"><gsmsg:write key="cmn.dont.delete" /></label>&nbsp;
        <html:radio name="cir090Form" property="cir090DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir090DdelKbn_1" onclick="setDispState(this.form.cir090DdelKbn, this.form.cir090DYear, this.form.cir090DMonth)" /><label for="cir090DdelKbn_1"><gsmsg:write key="cmn.delete.manual" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />

        <logic:notEmpty name="cir090Form" property="cir090YearLabelList">
          <html:select property="cir090DYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir090Form" property="cir090YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir090Form" property="cir090MonthLabelList">
          <html:select property="cir090DMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir090Form" property="cir090MonthLabelList" value="value" label="label" />
          </html:select>
           <gsmsg:write key="cmn.after.data" />
        </logic:notEmpty>

      </span>

    </td>
    </tr>
    </table>

    <img src="../common/images/spacer.gif" width="1px" height="10px" border="0">

    <table cellpadding="0" cellpadding="5" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" value="OK" class="btn_ok1" onClick="submitStyleChange();buttonPush('syudo_del_kakunin');">
      <input type="button" value="<gsmsg:write key="cmn.back.preferences" />" class="btn_back_n3" onClick="buttonPush('backKjnTool');">
    </td>
    </tr>
    </table>

  </td>
  </tr>
  </table>
</td>
</tr>
</table>

<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>

<div id="accountSelPop" title="<gsmsg:write key="wml.102" /><gsmsg:write key="cmn.select" />" style="display:none">
  <input type="hidden" id="selAccountElm" value="cir090AccountSid" />
  <input type="hidden" id="selAccountSubmit" value="true" />
  <input type="hidden" id="cir150user" value="<bean:write name="cir090Form" property="cirViewUser" />" />
  <div style="height:460px;overflow-y:auto;">
  <table width="100%" height="100%">
    <tr>
      <td id="accountListArea" valign="top"></td>
    </tr>
  </table>
  </div>
</div>

</html:form>
</body>
</html:html>
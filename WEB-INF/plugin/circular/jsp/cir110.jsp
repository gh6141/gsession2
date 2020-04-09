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
<script language="JavaScript" src="../circular/js/cir110.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[GroupSession] <gsmsg:write key="cir.22" /></title>
</head>

<body class="body_03" onload="changeEnableDisable();">
<html:form action="/circular/cir110">
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
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.22" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" value="OK" class="btn_ok1" onClick="submitStyleChange();buttonPush('ok');">
      <input type="button" value="<gsmsg:write key="cmn.back.admin.setting" />" class="btn_back_n3" onClick="buttonPush('backToKtool');">
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
    <td width="0%" colspan="2" nowrap><span class="text_r1">※<gsmsg:write key="cir.59" /></span></td>
    </tr>
    <%--
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.automatic.delete.categories" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
        <html:radio name="cir110Form" property="cir110DelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_DEL_KBN_ADM_SETTING) %>" styleId="cir110DelKbn_0" onclick="changeDelKbn();" /><label for="cir110DelKbn_0"><gsmsg:write key="cmn.set.the.admin" /></label>&nbsp;
        <html:radio name="cir110Form" property="cir110DelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_DEL_KBN_USER_SETTING) %>" styleId="cir110DelKbn_1" onclick="changeDelKbn();" /><label for="cir110DelKbn_1"><gsmsg:write key="cmn.set.eachuser" /></label>&nbsp;
      </span>
    </td>
    </tr>
    --%>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.25" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <span class="text_base">

        <html:radio name="cir110Form" property="cir110JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir110JdelKbn_0" onclick="setDispState(this.form.cir110JdelKbn, this.form.cir110JYear, this.form.cir110JMonth)" /><label for="cir110JdelKbn_0"><gsmsg:write key="cmn.noset" /></label>&nbsp;
        <html:radio name="cir110Form" property="cir110JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir110JdelKbn_1" onclick="setDispState(this.form.cir110JdelKbn, this.form.cir110JYear, this.form.cir110JMonth)" /><label for="cir110JdelKbn_1"><gsmsg:write key="cmn.automatically.delete" /></label>&nbsp;

        <gsmsg:write key="cmn.after.data.head" />

        <logic:notEmpty name="cir110Form" property="cir110YearLabelList">
          <html:select property="cir110JYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir110Form" property="cir110YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir110Form" property="cir110MonthLabelList">
          <html:select property="cir110JMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir110Form" property="cir110MonthLabelList" value="value" label="label" />
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

        <html:radio name="cir110Form" property="cir110SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir110SdelKbn_0" onclick="setDispState(this.form.cir110SdelKbn, this.form.cir110SYear, this.form.cir110SMonth)" /><label for="cir110SdelKbn_0"><gsmsg:write key="cmn.noset" /></label>&nbsp;
        <html:radio name="cir110Form" property="cir110SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir110SdelKbn_1" onclick="setDispState(this.form.cir110SdelKbn, this.form.cir110SYear, this.form.cir110SMonth)" /><label for="cir110SdelKbn_1"><gsmsg:write key="cmn.automatically.delete" /></label>&nbsp;

        <logic:notEmpty name="cir110Form" property="cir110YearLabelList">
          <html:select property="cir110SYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir110Form" property="cir110YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir110Form" property="cir110MonthLabelList">
          <html:select property="cir110SMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir110Form" property="cir110MonthLabelList" value="value" label="label" />
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

        <html:radio name="cir110Form" property="cir110DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>" styleId="cir110DdelKbn_0" onclick="setDispState(this.form.cir110DdelKbn, this.form.cir110DYear, this.form.cir110DMonth)" /><label for="cir110DdelKbn_0"><gsmsg:write key="cmn.noset" /></label>&nbsp;
        <html:radio name="cir110Form" property="cir110DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>" styleId="cir110DdelKbn_1" onclick="setDispState(this.form.cir110DdelKbn, this.form.cir110DYear, this.form.cir110DMonth)" /><label for="cir110DdelKbn_1"><gsmsg:write key="cmn.automatically.delete" /></label>&nbsp;

        <logic:notEmpty name="cir110Form" property="cir110YearLabelList">
          <html:select property="cir110DYear" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir110Form" property="cir110YearLabelList" value="value" label="label" />
          </html:select>
        </logic:notEmpty>

        <logic:notEmpty name="cir110Form" property="cir110MonthLabelList">
          <html:select property="cir110DMonth" styleClass="select01" style="width: 100px;">
            <html:optionsCollection name="cir110Form" property="cir110MonthLabelList" value="value" label="label" />
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
      <input type="button" value="OK" class="btn_ok1" onClick="submitStyleChange();buttonPush('ok');">
      <input type="button" value="<gsmsg:write key="cmn.back.admin.setting" />" class="btn_back_n3" onClick="buttonPush('backToKtool');">
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

</html:form>
</body>
</html:html>
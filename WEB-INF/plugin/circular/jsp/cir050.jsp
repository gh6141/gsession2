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
<script language="JavaScript" src="../circular/js/cir050.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='./css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[Group Session] <gsmsg:write key="cir.48" /></title>
</head>

<body class="body_03">

<html:form action="/circular/cir050">

<input type="hidden" name="CMD">
<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />
<html:hidden property="backScreen" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>


<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>
<td width="100%" align="center">

  <table width="70%" cellpadding="0" cellspacing="0" border="0">
  <tr>
  <td>

    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
    <td width="0%"><img src="../common/images/header_pset_01.gif" border="0" alt="<gsmsg:write key="cmn.preferences2" />"></td>
    <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span></td>
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.48" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt="<gsmsg:write key="cmn.preferences2" />"></td>
    </tr>
    </table>

    <table width="100%" cellpadding="0" cellspacing="0" border="0">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" value="<gsmsg:write key="cmn.setting" />" class="btn_setting_n1" onClick="buttonPush(1);">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush(2);">
    </td>
    <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
    </tr>
    </table>

    <img src="../circular/images/spacer.gif" width="1px" height="10px" border="0">

    <table width="100%" class="tl0" border="0" cellpadding="5">
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.number.display" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr>
      <td align="left" width="100%">
        <html:select name="cir050Form" property="cir050ViewCnt">
          <html:optionsCollection name="cir050Form" property="cir050DspCntList" value="value" label="label" />
        </html:select>
        <span class="text_base6"><gsmsg:write key="cmn.number" /></span>
        <br><span class="text_base7"><gsmsg:write key="cir.cir050.2" /></span>
      </td>
      </tr>
      </table>

    </td>
    </tr>


<%--
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="shortmail.notification" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr>
      <td align="left" width="100%">
        <html:radio name="cir050Form" styleId="cir050smlNtf_01" property="cir050smlNtf" value="<%= tuuchi %>" /><label for="cir050smlNtf_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
        <html:radio name="cir050Form" styleId="cir050smlNtf_02" property="cir050smlNtf" value="<%= notuuchi %>" /><label for="cir050smlNtf_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
        <div class="text_base7">
          <gsmsg:write key="cir.cir050.3" />
        </div>
      </td>
      </tr>
      </table>

    </td>
    </tr>
--%>


    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.auto.reload.time" /></span></td>
    <td align="left" class="td_wt" width="100%">

      <table width="100%" cellpadding="0" cellspacing="0" border="0">
      <tr>
      <td align="left" width="100%">
        <html:select name="cir050Form" property="cir050ReloadTime">
        <html:optionsCollection name="cir050Form" property="cir050TimeLabelList" value="value" label="label" />
        </html:select>
        <br><span class="text_base7"><gsmsg:write key="cir.cir050.5" /></span>
      </td>
      </tr>
      </table>

    </td>
    </tr>

    </table>

    <img src="./images/spacer.gif" width="1px" height="10px" border="0">

    <table width="100%" cellpadding="0" cellpadding="5" border="0">
    <tr>
    <td align="right">
      <input type="button" value="<gsmsg:write key="cmn.setting" />" class="btn_setting_n1" onClick="buttonPush(1);">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush(2);">
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
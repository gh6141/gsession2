<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ page import="jp.groupsession.v2.cir.GSConstCircular"%>
<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<title>[Group Session] <gsmsg:write key="wml.wml110.01" /></title>
  <meta http-equiv="Content-Type" content="text/html; charset=Shift_JIS">
  <theme:css filename="theme.css"/>
  <link rel="stylesheet" href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
  <script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
  <script language="JavaScript" src="../circular/js/cir230.js?<%= GSConst.VERSION_PARAM %>"></script>
</head>

<body class="body_03">

<html:form action="/circular/cir230">

<logic:notEqual name="cir230Form" property="cirAccountMode" value="2">
<input type="hidden" name="helpPrm" value="0" />
</logic:notEqual>

<logic:equal name="cir230Form" property="cirAccountMode" value="2">
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


<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>
<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" border="0" width="50%">
  <tr>
  <td>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt=""></td>
        <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap>
          <logic:equal name="cir230Form" property="cir230DspKbn" value="<%=String.valueOf(GSConstCircular.DSPKBN_ADMIN)%>">
            <span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span>
          </logic:equal>
          <logic:equal name="cir230Form" property="cir230DspKbn" value="<%=String.valueOf(GSConstCircular.DSPKBN_PREF)%>">
            <span class="settei_ttl"><gsmsg:write key="cmn.preferences2" /></span>
          </logic:equal>
        </td>
        <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="wml.wml110.01" /> ]</td>
        <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="50%"></td>
        <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
        <td class="header_glay_bg" width="50%">
          <input type="button" name="btn_add" class="btn_add_n1" value="<gsmsg:write key="cmn.add" />" onClick="addLabel();">
          <input type="button" name="btn_facilities_mnt" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onClick="buttonPush('backAccount');">
        </td>
        <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
      </tr>
    </table>

  </td></tr>
  <tr>
    <td>
    <logic:messagesPresent message="false">
      <tr>
      <td>
      <table width="100%">
        <tr><td align="left"><html:errors/></td></tr>
      </table>
      </td>
      </tr>
    </logic:messagesPresent>
    </td>
  </tr>



<tr><td>

    <br>
    <table class="tl0 table_td_border" cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
    <th class="table_bg_7D91BD text_tlw" width="0%" nowrap><gsmsg:write key="wml.28" /></th>
    <td align="left" class="smail_td1" width="100%">
      <bean:write name="cir230Form" property="cir230accountName" />
    </td>
    </tr>
    </table>

    <table class="tl0" cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
      <td style="white-space:nowrap;">
        <input type="button" class="btn_base0" value="<gsmsg:write key="cmn.up" />" name="btn_upper" onClick="buttonPush('upLabelData');">
        <input type="button" class="btn_base0" value="<gsmsg:write key="cmn.down" />" name="btn_downer" onClick="buttonPush('downLabelData');">
      </td>
    </tr>
    </table>

    <table class="tl0 table_td_border" cellpadding="5" cellspacing="0" border="0" width="100%">
    <tr>
    <th class="table_bg_7D91BD" width="0%" nowrap>&nbsp;</th>
    <th align="center" class="table_bg_7D91BD" width="100%"><span class="text_tlw"><gsmsg:write key="wml.74" /></span></th>
    <th align="center" class="table_bg_7D91BD" width="0%"><span class="text_tlw"><gsmsg:write key="cmn.fixed" /></span></th>
    <th align="center" class="table_bg_7D91BD" width="0%"><span class="text_tlw"><gsmsg:write key="cmn.delete" /></span></th>
    </tr>

    <logic:notEqual name="cir230Form" property="cirAccountSid" value="-1">
      <logic:iterate id="labelData" name="cir230Form" property="cir230LabelList" indexId="idx">
        <% String labelCheckId = "chkLabel" + String.valueOf(idx.intValue()); %>
        <bean:define id="labelValue" name="labelData" property="labelSid" />
        <tr>
          <td align="center" class="smail_td1" nowrap>
            <html:radio property="cir230SortRadio" value="<%= String.valueOf(labelValue)%>" styleId="<%= labelCheckId %>" />
          </td>
          <td align="left" class="smail_td1">
            <bean:write name="labelData" property="labelName" />
          </td>
          <td align="left" class="smail_td1">
            <input type="button" class="btn_edit_n3"
            value="<gsmsg:write key="cmn.fixed" />" name="btn_change" onClick="editLabel('<bean:write name="labelData" property="labelSid" />');">
          </td>
          <td align="left" class="smail_td1">
            <input type="button" class="btn_dell_n3"
            value="<gsmsg:write key="cmn.delete" />" name="btn_delete" onClick="deleteLabel('<bean:write name="labelData" property="labelSid" />');">
          </td>
      </tr>
      </logic:iterate>
    </logic:notEqual>
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
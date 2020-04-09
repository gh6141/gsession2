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
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[GroupSession] <gsmsg:write key="cir.31" /></title>
</head>

<body class="body_03">
<html:form action="/circular/cir120kn">
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

<html:hidden property="cir120JdelKbn" />
<html:hidden property="cir120JYear" />
<html:hidden property="cir120JMonth" />
<html:hidden property="cir120SdelKbn" />
<html:hidden property="cir120SYear" />
<html:hidden property="cir120SMonth" />
<html:hidden property="cir120DdelKbn" />
<html:hidden property="cir120DYear" />
<html:hidden property="cir120DMonth" />
<html:hidden property="cir120SelKbn" />
<html:hidden property="cir120AccountName" />
<html:hidden property="cir120AccountSid" />

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
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.31" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('delete');">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('back_syudo_input');">
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
      <logic:iterate id="accountMdl" name="cir120knForm" property="cir120knAccountList">
        <div class="text_base1"><bean:write name="accountMdl" property="accountName"/></div>
      </logic:iterate>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.manual.delete2" /> <gsmsg:write key="cir.25" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir120knForm" property="cir120JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.dont.delete" />
      </logic:equal>

      <% jp.groupsession.v2.struts.msg.GsMessage gsMsg = new jp.groupsession.v2.struts.msg.GsMessage(); %>

      <logic:equal name="cir120knForm" property="cir120JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="cir120Year1" name="cir120knForm" property="cir120JYear" type="java.lang.String" />
        <bean:define id="cir120Month1" name="cir120knForm" property="cir120JMonth" type="java.lang.String" />
        <% String kikanStr1 = "<strong>" + gsMsg.getMessage(request, "cmn.year", cir120Year1) + " " + gsMsg.getMessage(request, "cmn.months", cir120Month1) + "</strong>"; %>
        <gsmsg:write key="cmn.del.data.older.than" arg0="<%= kikanStr1 %>" />
      </logic:equal>
      </span>
    </td>
    </tr>
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.manual.delete2" /> <gsmsg:write key="cir.26" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir120knForm" property="cir120SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.dont.delete" />
      </logic:equal>
      <logic:equal name="cir120knForm" property="cir120SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="cir120Year2" name="cir120knForm" property="cir120SYear" type="java.lang.String" />
        <bean:define id="cir120Month2" name="cir120knForm" property="cir120SMonth" type="java.lang.String" />
        <% String kikanStr2 = "<strong>" + gsMsg.getMessage(request, "cmn.year", cir120Year2) + " " + gsMsg.getMessage(request, "cmn.months", cir120Month2) + "</strong>"; %>
        <gsmsg:write key="cmn.del.data.older.than" arg0="<%= kikanStr2 %>" />
      </logic:equal>
      </span>
    </td>
    </tr>
    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.manual.delete2" /> <gsmsg:write key="cir.27" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir120knForm" property="cir120DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.dont.delete" />
      </logic:equal>
      <logic:equal name="cir120knForm" property="cir120DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="cir120Year3" name="cir120knForm" property="cir120DYear" type="java.lang.String" />
        <bean:define id="cir120Month3" name="cir120knForm" property="cir120DMonth" type="java.lang.String" />
        <% String kikanStr3 = "<strong>" + gsMsg.getMessage(request, "cmn.year", cir120Year3) + " " + gsMsg.getMessage(request, "cmn.months", cir120Month3) + "</strong>"; %>
        <gsmsg:write key="cmn.del.data.older.than" arg0="<%= kikanStr3 %>" />
      </logic:equal>
      </span>
    </td>
    </tr>
    </table>

    <img src="../common/images/spacer.gif" width="1px" height="10px" border="0">

    <table cellpadding="0" cellpadding="5" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('delete');">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('back_syudo_input');">
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
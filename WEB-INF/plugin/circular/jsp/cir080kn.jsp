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
<title>[GroupSession] <gsmsg:write key="cir.29" /></title>
</head>

<body class="body_03">
<html:form action="/circular/cir080kn">
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
<html:hidden property="cir080JdelKbn" />
<html:hidden property="cir080JYear" />
<html:hidden property="cir080JMonth" />
<html:hidden property="cir080SdelKbn" />
<html:hidden property="cir080SYear" />
<html:hidden property="cir080SMonth" />
<html:hidden property="cir080DdelKbn" />
<html:hidden property="cir080DYear" />
<html:hidden property="cir080DMonth" />

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
    <td width="100%" class="header_ktool_bg_text">[ <gsmsg:write key="cir.29" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('update');">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('backToInput');">
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
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.25" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir080knForm" property="cir080JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.noset" />
      </logic:equal>
      <logic:equal name="cir080knForm" property="cir080JdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="jmonth" name="cir080knForm" property="cir080JMonth" type="java.lang.String" />
        <bean:define id="yr1" name="cir080knForm" property="cir080JYear" type="java.lang.String" />
        <strong><gsmsg:write key="cmn.year" arg0="<%= yr1 %>" /> <gsmsg:write key="cmn.months" arg0="<%= jmonth %>"/></strong> <gsmsg:write key="cmn.auto.del.data.older.than" />
      </logic:equal>
      </span>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.26" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir080knForm" property="cir080SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.noset" />
      </logic:equal>
      <logic:equal name="cir080knForm" property="cir080SdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="smonth" name="cir080knForm" property="cir080SMonth" type="java.lang.String" />
        <bean:define id="yr2" name="cir080knForm" property="cir080SYear" type="java.lang.String" />
        <strong><gsmsg:write key="cmn.year" arg0="<%= yr2 %>" /> <gsmsg:write key="cmn.months" arg0="<%= smonth %>" /></strong> <gsmsg:write key="cmn.auto.del.data.older.than" />
      </logic:equal>
      </span>
    </td>
    </tr>

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.autodelete" /> <gsmsg:write key="cir.27" /></span></td>
    <td align="left" class="td_wt" width="100%">
      <span class="text_base">
      <logic:equal name="cir080knForm" property="cir080DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_NO) %>">
        <gsmsg:write key="cmn.noset" />
      </logic:equal>
      <logic:equal name="cir080knForm" property="cir080DdelKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_AUTO_DEL_LIMIT) %>">
        <bean:define id="dmonth" name="cir080knForm" property="cir080DMonth" type="java.lang.String" />
        <bean:define id="yr3" name="cir080knForm" property="cir080DYear" type="java.lang.String" />
        <strong><gsmsg:write key="cmn.year" arg0="<%= yr3 %>" /> <gsmsg:write key="cmn.months" arg0="<%= dmonth %>" /></strong> <gsmsg:write key="cmn.auto.del.data.older.than" />
      </logic:equal>
      </span>
    </td>
    </tr>
    </table>

    <img src="../common/images/spacer.gif" width="1px" height="10px" border="0">

    <table cellpadding="0" cellpadding="5" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('update');">
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('backToInput');">
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
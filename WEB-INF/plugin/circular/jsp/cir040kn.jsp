<%@page import="jp.groupsession.v2.cir.cir040kn.Cir040knForm"%>
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
<script language="JavaScript" src="../common/js/cmn110.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../circular/js/cir040.js?<%= GSConst.VERSION_PARAM %>"></script>
<logic:notEqual name="cir040knForm" property="cir010AccountTheme" value="0">
<link rel=stylesheet href="../common/css/theme<bean:write name="cir040knForm" property="cir010AccountTheme" />/theme.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
</logic:notEqual>
<logic:equal name="cir040knForm" property="cir010AccountTheme" value="0">
<theme:css filename="theme.css"/>
</logic:equal>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[Group Session] <gsmsg:write key="cir.19" /></title>
</head>

<body class="body_03" onunload="windowClose();">

<html:form action="/circular/cir040kn">

<input type="hidden" name="CMD" value="">
<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cirEditInfSid" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cirEntryMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>
<html:hidden property="cir040InitFlg" />
<html:hidden property="cir040AccountSid" />
<html:hidden property="cir040title" />
<html:hidden property="cir040groupSid" />
<html:hidden property="cir040value" />
<html:hidden property="cir040show" />
<html:hidden property="cir040selectFiles" />
<html:hidden property="cir040memoKbn" />
<html:hidden property="cir040memoPeriod" />
<html:hidden property="cir040memoPeriodYear" />
<html:hidden property="cir040memoPeriodMonth" />
<html:hidden property="cir040memoPeriodDay" />
<html:hidden property="cir040knBinSid" />
<html:hidden property="cir040pluginIdTemp" />
<html:hidden property="cir040webmail" />



<logic:empty name="cir040knForm" property="cir040userSid" scope="request">
<html:hidden property="cir040userSid" />
</logic:empty>

<logic:notEmpty name="cir040knForm" property="cir040userSid" scope="request">
<logic:iterate id="users" name="cir040knForm" property="cir040userSid" indexId="idx" scope="request">
  <bean:define id="userSid" name="users" type="java.lang.String" />
  <html:hidden property="cir040userSid" value="<%= userSid %>" />
</logic:iterate>
</logic:notEmpty>

<logic:notEqual name="cir040knForm" property="cir040webmail" value="1">
<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>
</logic:notEqual>

<!-- BODY -->
<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>

<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr>
  <td>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="0%">
      <img src="../circular/images/header_circular.gif" border="0" alt="<gsmsg:write key="cir.5" />"></td>
    <td width="0%" class="header_white_bg_text" align="right" valign="middle" nowrap><span class="plugin_ttl"><gsmsg:write key="cir.5" /></span></td>
    <td width="0%" class="header_white_bg_text">
      <logic:notEqual name="cir040Form" property="cirEntryMode" value="2">[ <gsmsg:write key="cmn.new.create.edit" /> ]</logic:notEqual>
      <logic:equal name="cir040Form" property="cirEntryMode" value="2">[ <gsmsg:write key="ntp.4" /> ]</logic:equal>
    </td>

    <td width="100%" class="header_white_bg">
    <td width="0%">
      <img src="../common/images/header_white_end.gif" border="0" alt="<gsmsg:write key="cir.5" />"></td>
    </tr>
    </table>
  </td>
  </tr>

  <tr>
  <td>
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">

      <logic:notEqual name="cir040Form" property="cirEntryMode" value="2">
        <input type="button" value="<gsmsg:write key="cmn.sent" />" class="btn_base1" onClick="buttonPush('send');">
      </logic:notEqual>
      <logic:equal name="cir040Form" property="cirEntryMode" value="2">
        <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('editCir');">
      </logic:equal>

      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('cir040knback');">
    </td>
    <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
    </tr>
    </table>

    <logic:messagesPresent message="false">
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="tl0">
    <tr>
    <td align="left"><html:errors/><br></td>
    </tr>
    </table>
    </logic:messagesPresent>

    <img src="../circular/images/spacer.gif" width="1px" height="10px" border="0">

    <table width="100%" class="tl0" border="0" cellpadding="5">

    <tr>

    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.2" /></span></td>
    <bean:define id="mukouserClass" value=""/>
    <logic:equal name="cir040knForm" property="cirViewAccountUko" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
    <td align="left" class="td_wt" width="100%"><span class="text_base <%=mukouserClass%>"><bean:write name="cir040knForm" property="cirViewAccountName" /></span></td>
    </tr>

     <!-- 回覧先 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cir.20" /></span><span class="text_r2"></span></td>
    <td align="left" class="td_wt" width="90%">
      <table width="100%" cellspacing="0" cellpadding="0" border="0">
      <tr>
      <td>

      <span class="text_base">

      <logic:notEmpty name="cir040knForm" property="cir040MemberList" scope="request">
      <logic:iterate id="memMdl" name="cir040knForm" property="cir040MemberList" scope="request">
        <bean:define id="mukouserClass" value=""/>
        <logic:equal name="memMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
        <span class="<%=mukouserClass%>"><bean:write name="memMdl" property="cacName" /></span><br>
      </logic:iterate>
      </logic:notEmpty>
      <logic:equal name="cir040knForm" property="cir040knWarnAttesakiDel" value="<%=String.valueOf(Cir040knForm.DSP_WARN_ATTSAKI_DEL_YES) %>">
      <div class="text_red">
        <gsmsg:write key="cmn.comments" /><gsmsg:write key="cir.cir040kn.6"/>
      </div>
      </logic:equal>

      </span>

      </td>
      </tr>
      </table>

    </tr>

    <!-- タイトル -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cmn.title" /></span><span class="text_r2"></span></td>
    <td align="left" class="td_wt" width="90%">
    <span class="text_base"><bean:write name="cir040knForm" property="cir040title" /></span>
    </td>
    </tr>

    <!-- 内容 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cmn.content" /></span><span class="text_r2"></span></td>
    <td align="left" class="td_wt" width="90%">
    <span class="text_base"><bean:write name="cir040knForm" property="cir040knBody" filter="false" /></span>
    </td>
    </tr>

    <logic:equal name="cir040knForm" property="cir040memoKbn" value="0">
    <!-- メモ欄修正区分 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cir.cir040kn.3" /></span><span class="text_r2"></span></td>
    <td align="left" class="td_wt" width="90%">
      <span class="text_base"><gsmsg:write key="cir.cir040kn.4" /></span>
    </td>
    </tr>
    </logic:equal>

    <logic:equal name="cir040knForm" property="cir040memoKbn" value="1">
      <!-- メモ欄修正区分 -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cir.cir040kn.3" /></span><span class="text_r2"></span></td>
      <td align="left" class="td_wt" width="90%">
        <span class="text_base"><gsmsg:write key="cir.cir040kn.5" /></span>
      <!-- メモ欄修正期限設定 -->
      <br>
      <br>
      <span class="text_base"><gsmsg:write key="cir.54" /></span>
      <br>
        <bean:define id="memoPerYear" name="cir040knForm" property="cir040memoPeriodYear" type="java.lang.Integer" />
        <bean:define id="memoPerMonth" name="cir040knForm" property="cir040memoPeriodMonth" type="java.lang.Integer" />
        <bean:define id="memoPerDay" name="cir040knForm" property="cir040memoPeriodDay" type="java.lang.Integer" />
        <span class="text_base"><gsmsg:write key="cir.56.1" arg0="<%= String.valueOf(memoPerYear.intValue()) %>" arg1="<%= String.valueOf(memoPerMonth.intValue()) %>" arg2="<%= String.valueOf(memoPerDay.intValue()) %>" /></span>
      </td>
      </tr>
    </logic:equal>

    <!-- 添付 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cmn.attached" /></span></td>
    <td align="left" class="td_wt" width="90%">
      <logic:empty name="cir040knForm" property="cir040FileLabelList" scope="request">&nbsp;</logic:empty>

      <logic:notEmpty name="cir040knForm" property="cir040FileLabelList" scope="request">
      <table cellpadding="0" cellpadding="0" border="0">
      <logic:iterate id="fileMdl" name="cir040knForm" property="cir040FileLabelList" scope="request">

      <tr>
      <td><img src="../common/images/file_icon.gif" alt="<gsmsg:write key="cmn.file" />"></td>
      <td class="menu_bun"><a href="javascript:void(0);" onClick="return fileLinkClick('<bean:write name="fileMdl" property="value" />');"><span class="text_link"><bean:write name="fileMdl" property="label" /></span></a></td>
      </tr>

      </logic:iterate>
      </table>
      </logic:notEmpty>

    </td>
    </tr>

    <!-- 公開／非公開 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap width="10%"><span class="text_bb1"><gsmsg:write key="cir.cir030.3" /></span></td>
    <td align="left" class="td_wt" width="90%">
      <logic:equal name="cir040knForm" property="cir040show" value="0"><span class="text_base"><gsmsg:write key="cmn.public" /></span></logic:equal>
      <logic:notEqual name="cir040knForm" property="cir040show" value="0"><span class="text_base"><gsmsg:write key="cmn.private" /></span></logic:notEqual>
    </td>
    </tr>

    </table>
  </td>
  </tr>

  <tr>
  <td>

  <img src="../circular/images/spacer.gif" width="1px" height="10px" border="0">

    <table cellpadding="0" cellpadding="5" border="0" width="100%">
    <tr>
    <td align="right">
      <logic:notEqual name="cir040Form" property="cirEntryMode" value="2">
        <input type="button" value="<gsmsg:write key="cmn.sent" />" class="btn_base1" onClick="buttonPush('send');">
      </logic:notEqual>
      <logic:equal name="cir040Form" property="cirEntryMode" value="2">
        <input type="button" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onClick="buttonPush('editCir');">
      </logic:equal>
      <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('cir040knback');">
    </td>
    </tr>
    </table>

  </td>
  </tr>
  </table>

</td>
</tr>
</table>

<logic:notEqual name="cir040knForm" property="cir040webmail" value="1">
<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>
</logic:notEqual>

</html:form>

</body>
</html:html>

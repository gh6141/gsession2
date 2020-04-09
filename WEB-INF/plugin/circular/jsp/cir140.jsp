<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ taglib uri="/WEB-INF/ctag-jsmsg.tld" prefix="gsjsmsg" %>

<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<gsjsmsg:js filename="gsjsmsg.js"/>
<script language="JavaScript" src="../circular/js/cir140.js?<%= GSConst.VERSION_PARAM %>"></script>
<script type="text/javascript" src="../common/js/changestyle.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>

<title>[GroupSession] <gsmsg:write key="cir.23" /></title>
</head>

<body class="body_03" onload="lmtEnableDisable();">
<html:form action="/circular/cir140">

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
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.23" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" value="OK" class="btn_ok1" onClick="buttonPush('init_change_kakunin');">
      <input type="button" value="<gsmsg:write key="cmn.back.admin.setting" />" class="btn_back_n3" onClick="buttonPush('backKtool');">
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
    <td>
      <table cellpadding="10" cellspacing="0" border="0" width="100%" class="tl_u2">

      <tr>
      <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap id="cirEditArea1" >
        <span class="text_bb1"><gsmsg:write key="cmn.edit.permissions" /></span>
      </td>
      <!-- 編集権限 -->
      <td valign="middle" align="left" class="td_wt">
        <html:radio name="cir140Form" styleId="cir140EditType_01" property="cir140KenKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIEDIT_STYPE_ADM) %>" onclick="lmtEnableDisable();" /><label for="cir140EditType_01"><span class="text_base6_2"><gsmsg:write key="cmn.set.the.admin" /></span></label>&nbsp;
        <html:radio name="cir140Form" styleId="cir140EditType_02" property="cir140KenKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIEDIT_STYPE_USER) %>" onclick="lmtEnableDisable();" /><label for="cir140EditType_02"><span class="text_base6_2"><gsmsg:write key="cmn.set.eachaccount" /></span></label>
        <br>
        <span id="lmtinput">※<gsmsg:write key="cmn.view.account.defaultset" /><br></span>
      </td>
      </tr>

      <tr>
      <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap id="cirEditArea1" >
        <span class="text_bb1"><gsmsg:write key="cir.cir040.2" /></span>
      </td>

      <logic:equal name="cir140Form" property="cir140memoKbn" value="0">
        <html:hidden property="cir140memoPeriod" />
        <!-- メモ欄修正区分 -->
        <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
          <html:radio property="cir140memoKbn" styleId="memoNg" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_NO) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoNg"><span class="text_base"><gsmsg:write key="cmn.not" /></span>&nbsp;&nbsp;</label>
          <html:radio property="cir140memoKbn" styleId="memoOk" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_YES) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoOk"><span class="text_base"><gsmsg:write key="cmn.accepted" /></span></label>
        </td>
      </logic:equal>

      <logic:equal name="cir140Form" property="cir140memoKbn" value="1">
        <!-- メモ欄修正区分 -->
        <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
          <html:radio property="cir140memoKbn" styleId="memoNg" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_NO) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoNg"><span class="text_base"><gsmsg:write key="cmn.not" /></span>&nbsp;&nbsp;</label>
          <html:radio property="cir140memoKbn" styleId="memoOk" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_MEMO_CHANGE_YES) %>" onclick="buttonPush('memoKbnChange');" /><label for="memoOk"><span class="text_base"><gsmsg:write key="cmn.accepted" /></span></label>
        <!-- メモ欄修正期限設定 -->
        <br>
        <br>
        <span class="text_base"><gsmsg:write key="cir.54" /></span>
        <br>

        <html:radio property="cir140memoPeriod" styleId="today" value="1" /><label for="today"><span class="text_base"><gsmsg:write key="cmn.today" /></span></label>&nbsp;&nbsp;
        <html:radio property="cir140memoPeriod" styleId="1weeks" value="0" /><label for="1weeks"><span class="text_base">1<gsmsg:write key="cmn.weeks" /></span></label>&nbsp;&nbsp;
        <html:radio property="cir140memoPeriod" styleId="2weeks" value="2" /><label for="2weeks"><span class="text_base">2<gsmsg:write key="cmn.weeks" /></span></label>&nbsp;&nbsp;
        <html:radio property="cir140memoPeriod" styleId="months" value="3" /><label for="months"><span class="text_base"><gsmsg:write key="cmn.months" arg0="1" /></span></label>

        </td>
      </logic:equal>
      </tr>

      <!-- 回覧先確認状況区分 -->
      <tr>
      <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap id="cirEditArea1" >
        <span class="text_bb1"><gsmsg:write key="cir.cir030.3" /></span>
      </td>
      <td align="left" class="td_wt" nowrap>
        <html:radio name="cir140Form" property="cir140show" styleId="showPub" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PUBLIC) %>" /><label for="showPub"><span class="text_base"><gsmsg:write key="cmn.public" /></span>&nbsp;&nbsp;</label>
        <html:radio name="cir140Form" property="cir140show" styleId="showPri" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PRIVATE) %>" /><label for="showPri"><span class="text_base"><gsmsg:write key="cmn.private" /></span></label>
      </td>
      </tr>
      </table>

    </td>
    </tr>
    </table>

    <img src="../common/images/spacer.gif" width="1px" height="10px" border="0">

    <table cellpadding="0" cellpadding="5" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" value="OK" class="btn_ok1" onClick="buttonPush('init_change_kakunin');">
      <input type="button" value="<gsmsg:write key="cmn.back.admin.setting" />" class="btn_back_n3" onClick="buttonPush('backKtool');">
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
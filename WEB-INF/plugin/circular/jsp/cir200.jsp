<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ page import="jp.groupsession.v2.cmn.GSConst" %>


<html:html>
<head>
<title>[GroupSession] <gsmsg:write key="cir.5" /> <gsmsg:write key="cmn.sml.notification.setting" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../circular/js/cir200.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
<link rel=stylesheet href="../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
</head>

<body class="body_03">

<html:form action="/circular/cir200">
<input type="hidden" name="CMD" value="">
<html:hidden property="backScreen" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>
<html:hidden property="cir200InitFlg" />

<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<table cellpadding="5" cellspacing="0" width="100%">
<tr>
<td width="100%" align="center">

  <table  cellpadding="0" cellspacing="0"width="70%">
  <tr>
  <td align="center">

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
      <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt=""></td>
      <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
      <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.5" />　<gsmsg:write key="cmn.sml.notification.setting" /> ]</td>
      <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" name="btn_add" class="btn_ok1" value="OK" onClick="buttonPush('cir200ok');">
      <input type="button" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onclick="buttonPush('cir200back');">
    <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt=""></td>
    </tr>
    </table>

    <logic:messagesPresent message="false">
    <table cellpadding="0" cellspacing="0" border="0" width="100%" style="margin-top: 10px;">
    <tr><td width="100%"><html:errors /></td></tr>
    </table>
    </logic:messagesPresent>

    <table cellpadding="10" cellspacing="0" border="0" width="100%" class="tl_u2" style="margin-top: 10px;">

    <tr>
    <td width="20%" valign="middle" align="left" class="table_bg_A5B4E1">
    <span class="text_bb1"><gsmsg:write key="shortmail.notification" /><span class="text_r2">※</span></span>
    </td>
    <td width="80%" valign="middle" align="left" class="td_type1">
      <html:radio name="cir200Form" styleId="smailSendKbn_01" property="cir200SmlSendKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_ADMIN) %>" /><label for="smailSendKbn_01"><gsmsg:write key="cmn.set.the.admin" /></label>&nbsp;
      <html:radio name="cir200Form" styleId="smailSendKbn_02" property="cir200SmlSendKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>" /><label for="smailSendKbn_02"><gsmsg:write key="cmn.set.eachaccount" /></label>
    </td>
    </tr>

<% String tuuchi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_KBN_YES); %>
<% String notuuchi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_KBN_NO); %>


    <tr name="gsSmlNoticeKbnArea">
       <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.2" /></span></td>
       <td align="left" class="td_wt" width="100%">
           <div class="text_base" >
               <html:radio name="cir200Form" styleId="cir200smlNtf_01" property="cir200SmlSend" value="<%= tuuchi %>" /><label for="cir200smlNtf_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
               <html:radio name="cir200Form" styleId="cir200smlNtf_02" property="cir200SmlSend" value="<%= notuuchi %>" /><label for="cir200smlNtf_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
           </div>
           <div class="text_base7 margin_top10" >
             <gsmsg:write key="cir.cir160.3" />
           </div>
       </td>
    </tr>
    <tr name="gsSmlNoticeKbnArea">
       <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.4" /></span></td>
       <td class="td_wt" >
         <div class="text_base" >
             <html:radio name="cir200Form" styleId="cir200smlMemo_01" property="cir200SmlMemo" value="<%= tuuchi %>" /><label for="cir200smlMemo_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
             <html:radio name="cir200Form" styleId="cir200smlMemo_02" property="cir200SmlMemo" value="<%= notuuchi %>" /><label for="cir200smlMemo_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
         </div>
         <div class="text_base7 margin_top10" >
           <gsmsg:write key="cir.cir160.5" />
         </div>
       </td>
    </tr>
    <tr name="gsSmlNoticeKbnArea">
       <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.6" /></span></td>
       <td class="td_wt" >
         <div class="text_base" style="">
             <html:radio name="cir200Form" styleId="cir200smlEdt_01" property="cir200SmlEdt" value="<%= tuuchi %>" /><label for="cir200smlEdt_01"><span class="text_base6"><gsmsg:write key="cmn.notify" /></span></label>&nbsp;
             <html:radio name="cir200Form" styleId="cir200smlEdt_02" property="cir200SmlEdt" value="<%= notuuchi %>" /><label for="cir200smlEdt_02"><span class="text_base6"><gsmsg:write key="cmn.dont.notify" /></span></label>
         </div>
         <div class="text_base7 margin_top10" >
           <gsmsg:write key="cir.cir160.7" />
         </div>
       </td>
     </tr>


    </table>

    <table cellpadding="0" cellspacing="0" width="100%" style="margin-top: 10px;">
    <tr>
    <td align="right">
      <input type="button" name="btn_add" class="btn_ok1" value="OK" onClick="buttonPush('cir200ok');">
      <input type="button" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onclick="buttonPush('cir200back');">
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
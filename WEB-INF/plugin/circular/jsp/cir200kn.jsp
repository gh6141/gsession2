<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ page import="jp.groupsession.v2.cmn.GSConst" %>


<html:html>
<head>
<title>[GroupSession] <gsmsg:write key="cir.5" /> <gsmsg:write key="cmn.sml.notification.setting.kn" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
<link rel=stylesheet href="../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>" type="text/css">

</head>

<body class="body_03">

<html:form action="/circular/cir200kn">
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

<html:hidden property="cir200SmlSendKbn" />
<html:hidden property="cir200SmlSend" />
<html:hidden property="cir200SmlMemo" />
<html:hidden property="cir200SmlEdt" />

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
    <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.5" />　<gsmsg:write key="cmn.sml.notification.setting.kn" /> ]</td>
    <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt=""></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="50%"></td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="50%">
      <input type="button" name="btn_add" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onclick="buttonPush('cir200knok');">
      <input type="button" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onclick="buttonPush('cir200knback');">
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
    <td width="20%" valign="middle" align="left" class="table_bg_A5B4E1" nowrap>
    <span class="text_bb1"><gsmsg:write key="shortmail.notification" /></span>
    </td>
    <td width="80%" valign="middle" align="left" class="td_type1">
      <logic:equal name="cir200knForm" property="cir200SmlSendKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_ADMIN) %>"><gsmsg:write key="cmn.set.the.admin" /></logic:equal>
      <logic:equal name="cir200knForm" property="cir200SmlSendKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_USER) %>"><gsmsg:write key="cmn.set.eachaccount" /></logic:equal>
    </td>
    </tr>

<logic:equal name="cir200knForm" property="cir200SmlSendKbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_ADMIN) %>">
<% String tuuchi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_KBN_YES); %>
<% String notuuchi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAF_SML_NTF_KBN_NO); %>
       <tr>
       <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.2" /></span></td>
       <td align="left" class="td_type1" width="100%">
            <logic:equal name="cir200knForm" property="cir200SmlSend" value="0">
              <gsmsg:write key="cmn.notify" />
            </logic:equal>
            <logic:equal name="cir200knForm" property="cir200SmlSend" value="1">
              <gsmsg:write key="cmn.dont.notify" />
            </logic:equal>
       </td>
       </tr>
       <tr>
         <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.4" /></span></td>
         <td class="td_type1" >
             <logic:equal name="cir200knForm" property="cir200SmlMemo" value="0">
               <gsmsg:write key="cmn.notify" />
             </logic:equal>
             <logic:equal name="cir200knForm" property="cir200SmlMemo" value="1">
               <gsmsg:write key="cmn.dont.notify" />
             </logic:equal>
         </td>
       </tr>
       <tr>
         <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir160.6" /></span></td>
         <td class="td_type1" >
             <logic:equal name="cir200knForm" property="cir200SmlEdt" value="0">
               <gsmsg:write key="cmn.notify" />
             </logic:equal>
             <logic:equal name="cir200knForm" property="cir200SmlEdt" value="1">
               <gsmsg:write key="cmn.dont.notify" />
             </logic:equal>
         </td>
       </tr>
</logic:equal>
    </table>

    <table cellpadding="0" cellspacing="0" width="100%" style="margin-top: 10px;">
    <tr>
    <td align="right">
      <input type="button" name="btn_add" value="<gsmsg:write key="cmn.final" />" class="btn_base1" onclick="buttonPush('cir200knok');">
      <input type="button" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onclick="buttonPush('cir200knback');">
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
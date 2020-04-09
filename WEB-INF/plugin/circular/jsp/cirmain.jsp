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
<title>[GroupSession] <gsmsg:write key="cir.cir130.1" /></title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/check.js?<%= GSConst.VERSION_PARAM %>"></script>

<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<theme:css filename="theme.css"/>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>

</head>

<body class="body_03">
<html:form action="/circular/cirmain">

<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />

<logic:notEmpty name="cirmainForm" property="cir010CircularList" scope="request">
    <table width="100%" cellspacing="0" cellpadding="0" class="tl0">
    <tr>
    <td align="left" class="header_7D91BD_left" colspan="4">
      <img src="../circular/images/menu_icon_single.gif" class="img_border img_bottom img_menu_icon_single" alt="cir.cirmain.1"><a href="<bean:write name="cirmainForm" property="cirTopUrl" />"><gsmsg:write key="cir.5" /></a>
    </td>
    </tr>

    <tr class="text_base2">
    <th class="td_type30" width="15%" scope="col" nowrap><gsmsg:write key="wml.102" /></th>
    <th class="td_type30" width="40%" scope="col" nowrap><gsmsg:write key="cmn.title" /></th>
    <th class="td_type30" width="30%" scope="col" nowrap><gsmsg:write key="cmn.date" /></th>
    <th class="td_type30" width="15%" scope="col" nowrap><gsmsg:write key="cmn.sender" /></th>
    </tr>

<!-- 表BODY -->

    <% String[] tdClassList = {"td_type1", "td_type25_2"}; %>
    <logic:iterate id="cirMdl" name="cirmainForm" property="cir010CircularList" scope="request" indexId="idx">
    <% String tdClass = tdClassList[idx.intValue() % 2]; %>

<%
      String titleFont = "";
%>
    <logic:equal name="cirMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_UNOPEN) %>">
<%
      titleFont = "text_link";
%>
    </logic:equal>
    <logic:notEqual name="cirMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_UNOPEN) %>">
<%
      titleFont = "text_p";
%>
    </logic:notEqual>

    <tr class="text_base2">
    <!-- 受信者 -->
    <td class="<%= tdClass %>">
      <bean:define id="mukouserClass" value=""/>
      <logic:equal name="cirMdl" property="viewUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
      <span class="sc_ttl_def <%=mukouserClass%>"><bean:write name="cirMdl" property="posName" /></span>
    </td>
    <!-- タイトル -->
    <td class="<%= tdClass %>"><a href="../circular/cir020.do?cirViewAccount=<bean:write name="cirMdl" property="cacSid" />&cir010selectInfSid=<bean:write name="cirMdl" property="cifSid" />&cir010cmdMode=2"><span class="<%= String.valueOf(titleFont) %>"><bean:write name="cirMdl" property="cifTitle" /></span></a></td>
    <!-- 日付 -->
    <td class="<%= tdClass %>" align="center"><span class="sc_ttl_def"><bean:write name="cirMdl" property="dspCifAdate" /></span></td>
    <!-- 発信者 -->
    <td class="<%= tdClass %>">
      <logic:equal name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cmn.GSConst.JTKBN_TOROKU) %>">
        <bean:define id="mukouserClass" value=""/>
        <logic:equal name="cirMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
        <span class="sc_ttl_def  <%=mukouserClass%>"><bean:write name="cirMdl" property="cacName" /></span>
      </logic:equal>
      <logic:notEqual name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cmn.GSConst.JTKBN_TOROKU) %>">
      <del><span class="sc_ttl_def"><bean:write name="cirMdl" property="cacName" /></span></del>
      </logic:notEqual>
    </td>

      </logic:iterate>
    </tr>
    </table>
      </logic:notEmpty>

</html:form>


</body>
</html:html>
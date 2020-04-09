<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>

<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<%-- 回覧板種別 --%>
<%
String jusin = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_JUSIN);
String sosin = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_SOUSIN);
String gomi  = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_GOMI);
%>

<%-- キーワード区分 --%>
<%
String keyWordAnd = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.KEY_WORD_KBN_AND);
String keyWordOr  = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.KEY_WORD_KBN_OR);
%>

<%-- オーダー区分 --%>
<%
String orderAsc  = String.valueOf(jp.groupsession.v2.cmn.GSConst.ORDER_KEY_ASC);
String orderDesc = String.valueOf(jp.groupsession.v2.cmn.GSConst.ORDER_KEY_DESC);
%>

<%-- ソート区分 --%>
<%
String sortTitle  = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SORT_TITLE);
String sortDate  = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SORT_DATE);
String sortUser  = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SORT_USER);
%>

<%-- 検索対象 --%>
<%
String targetTitle   = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SEARCH_TARGET_TITLE);
String targetHonbun  = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.SEARCH_TARGET_BODY);
%>
<% String unopen = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_UNOPEN); %>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src='../schedule/jquery_ui/js/jquery-ui-1.8.14.custom.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/changestyle.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/webSearch.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/search.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/grouppopup.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../circular/js/cir060.js?<%= GSConst.VERSION_PARAM %>"></script>

<logic:notEqual name="cir060Form" property="cir010AccountTheme" value="0">
<link rel=stylesheet href="../common/css/theme<bean:write name="cir060Form" property="cir010AccountTheme" />/theme.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
</logic:notEqual>
<logic:equal name="cir060Form" property="cir010AccountTheme" value="0">
<theme:css filename="theme.css"/>
</logic:equal>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery/jquery-theme.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery_ui/css/jquery.ui.dialog.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[Group Session] <gsmsg:write key="cir.cir060.1" /></title>
</head>

<body class="body_03" onload="syubetsuChange();">

<html:form action="/circular/cir060">

<input type="hidden" name="CMD">
<input type="hidden" name="cir010selectInfSid">
<input type="hidden" name="cir010sojuKbn">
<input type="hidden" name="cir060dspId" value="cir060">
<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010SelectLabelSid"/>

<html:hidden property="cir060searchFlg" />
<html:hidden property="cir010svSearchWord" />
<html:hidden property="cir060svSyubetsu" />
<html:hidden property="cir060svGroupSid" />
<html:hidden property="cir060svUserSid" />
<html:hidden property="cir060svWordKbn" />
<html:hidden property="cir060svSort1" />
<html:hidden property="cir060svOrder1" />
<html:hidden property="cir060svSort2" />
<html:hidden property="cir060svOrder2" />

<%--
<logic:notEmpty name="cir060Form" property="cir060selUserSid" scope="request">
  <logic:iterate id="item" name="cir060Form" property="cir060selUserSid" scope="request">
    <input type="hidden" name="cir060selUserSid" value="<bean:write name="item"/>">
  </logic:iterate>
</logic:notEmpty>
--%>

<logic:notEmpty name="cir060Form" property="cir060svSelUserSid" scope="request">
  <logic:iterate id="item" name="cir060Form" property="cir060svSelUserSid" scope="request">
    <input type="hidden" name="cir060svSelUserSid" value="<bean:write name="item"/>">
  </logic:iterate>
</logic:notEmpty>

<logic:notEmpty name="cir060Form" property="cir060svSearchTarget" scope="request">
  <logic:iterate id="item" name="cir060Form" property="cir060svSearchTarget" scope="request">
    <input type="hidden" name="cir060svSearchTarget" value="<bean:write name="item"/>">
  </logic:iterate>
</logic:notEmpty>

<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<!--　BODY -->
<table align="center"  cellpadding="5" cellspacing="0" border="0" width="100%">
<tr>
<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" border="0" width="100%">
  <tr>
  <td>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
    <td width="0%"><img src="../circular/images/header_circular.gif" border="0" alt="<gsmsg:write key="cir.5" />"></td>
    <td width="0%" class="header_white_bg_text" align="right" valign="middle" nowrap><span class="plugin_ttl"><gsmsg:write key="cir.5" /></span></td>
    <td width="0%" class="header_white_bg_text">[ <gsmsg:write key="cir.cir060.1" /> ]</td>
    <td width="100%" class="header_white_bg">&nbsp;</td>
    <td width="0%"><img src="../common/images/header_white_end.gif" border="0" alt="<gsmsg:write key="cir.5" />"></td>
    </tr>
    </table>

    <table cellpadding="5" cellspacing="0" width="100%">
    <tr>
    <td align="right">
      <input type="button" name="btn_prjadd" class="btn_back_n1" value="<gsmsg:write key="cmn.back" />" onClick="buttonPush('backList');">
    </td>
    </tr>
    </table>

    <IMG SRC="../circular/images/spacer.gif" width="1px" height="10px" border="0">

    <logic:messagesPresent message="false">
    <table width="100%">
    <tr><td colspan="4" align="left"><html:errors/></td></tr>
    </table>
    </logic:messagesPresent>

    <!-- ページコンテンツ start -->
    <table width="100%" class="tl0 tbl_base">
    <tr>
    <td width="100%" height="30px" colspan="4" class="table_bg_7D91BD_search">
        <img src="../circular/images/spacer.gif" width="1" height="20" align="left">
        <img src="../common/images/search_icon.gif" class="img_bottom" alt="<gsmsg:write key="cmn.advanced.search" />"><span class="text_tlw3"><gsmsg:write key="cmn.advanced.search" /></span>
    </td>
    </tr>

    <tr>
    <th width="10%" class="td_gray text_bb2" nowrap><gsmsg:write key="cmn.target" /><gsmsg:write key="wml.102" /></th>
    <td width="90%" class="td_sub_detail" colspan="3">
      <bean:define id="mukouserClass" value=""/>
      <logic:equal name="cir060Form" property="cirViewAccountUko" value="1"><bean:define id="mukouserClass" >mukouser_option</bean:define></logic:equal>
      <span class="text_base <%=mukouserClass%>"><bean:write name="cir060Form" property="cirViewAccountName" /></span>
    </td>
    </tr>

    <tr>
    <th width="10%" class="td_gray text_bb2" nowrap><gsmsg:write key="cir.cir060.2" /></th>
    <td width="90%" class="td_sub_detail" colspan="3">
      <html:radio property="cir060syubetsu" styleId="radio_jushin" value="<%= jusin %>" onclick="syubetsuChange();" /><label for="radio_jushin"><gsmsg:write key="cmn.receive2" /></label>
      <html:radio property="cir060syubetsu" styleId="radio_soushin" value="<%= sosin %>" onclick="syubetsuChange();" /><label for="radio_soushin"><gsmsg:write key="cmn.sent2" /></label>
      <html:radio property="cir060syubetsu" styleId="radio_gomi" value="<%= gomi %>" onclick="syubetsuChange();" /><label for="radio_gomi"><gsmsg:write key="cmn.trash" /></label>
    </td>
    </tr>

    <tr>
    <th width="10%" class="td_gray text_bb2" nowrap><gsmsg:write key="cir.2" /></th>
    <td width="53%" class="td_sub_detail">
      <html:select property="cir060groupSid" styleClass="select01" onchange="hassinChange('searchAgain');">
        <logic:notEmpty name="cir060Form" property="groupLabel">
          <logic:iterate id="gpBean" name="cir060Form" property="groupLabel" scope="request">
          <bean:define id="gpValue" name="gpBean" property="value" type="java.lang.String" />
          <logic:equal name="gpBean" property="styleClass" value="0">
            <html:option value="<%= gpValue %>"><bean:write name="gpBean" property="label" /></html:option>
          </logic:equal>
          <logic:equal name="gpBean" property="styleClass" value="1">
            <html:option styleClass="select03" value="<%= gpValue %>"><bean:write name="gpBean" property="label" /></html:option>
          </logic:equal>
          <logic:equal name="gpBean" property="styleClass" value="2">
            <html:option styleClass="select06" value="<%= gpValue %>"><bean:write name="gpBean" property="label" /></html:option>
          </logic:equal>
          </logic:iterate>
        </logic:notEmpty>
      </html:select>
      <input type="button" onclick="openGroupWindowForCircular(this.form.cir060groupSid, 'cir060groupSid', '0', 'searchAgain', 0)" class="group_btn" value="&nbsp;&nbsp;" id="cir060GroupBtn">
      <html:select property="cir060userSid" styleClass="select01">

          <logic:notEmpty name="cir060Form" property="userLabel" >
          <logic:iterate id="usrList" name="cir060Form" property="userLabel" >
            <bean:define id="mukouserClass" value=""/>
            <logic:equal name="usrList" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" value="mukouser_option"/></logic:equal>
            <bean:define id="usrValue"  >-1</bean:define>
            <logic:notEmpty name="usrList" property="cacSid">
              <bean:define id="usrValue" ><bean:write name="usrList" property="cacSid"/></bean:define>
              <bean:define id="usrLabel" ><bean:write name="usrList" property="cacName" /></bean:define>
            </logic:notEmpty>
            <logic:empty name="usrList" property="cacSid">
              <logic:notEmpty name="usrList" property="usrSid">
                <bean:define id="usrValue" ><bean:write name="usrList" property="usrSid"/></bean:define>
              </logic:notEmpty>
              <bean:define id="usrLabel" ><bean:write name="usrList" property="usiSei" /> <bean:write name="usrList" property="usiMei" /></bean:define>
            </logic:empty>
            <html:option styleClass="<%=mukouserClass %>" value="<%=usrValue %>"><bean:write name="usrLabel" /></html:option>
          </logic:iterate>
          </logic:notEmpty>


      </html:select>
    </td>

    <th width="10%" class="td_gray text_bb2" nowrap><gsmsg:write key="cir.20" /></th>
    <td width="27%" class="td_sub_detail">
      <input type="button" id="<gsmsg:write key="cmn.from" />" class="cir_send_sel_btn btn_base0" value="<gsmsg:write key="cmn.select2" />" name="selectBtn" />&nbsp;&nbsp;
      <input type="button" class="btn_base0" value="<gsmsg:write key="cmn.clear" />" name="clearBtn" onClick="clearUserList();"><br>
      <span id="atesaki_to_area">
      <logic:notEmpty name="cir060Form" property="memberList" scope="request">
      <logic:iterate id="memMdl" name="cir060Form" property="memberList" scope="request">
        <div class="atesaki_to_user" id="0">
        <logic:greaterThan name="memMdl" property="cacSid" value="0">
          <bean:define id="mukouserClass" value=""/>
          <logic:equal name="memMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser_option</bean:define></logic:equal>
          <span class="<%=mukouserClass%>"><bean:write name="memMdl" property="cacName" /></span>

          <logic:greaterThan name="memMdl" property="usrSid" value="0">
            <input type="hidden" name="cir060selUserSid" value="<bean:write name="memMdl" property="usrSid" />" />&nbsp;&nbsp;[<span class="add_usr_del">削除</span>]</div>
          </logic:greaterThan>

          <logic:lessThan name="memMdl" property="usrSid" value="1">
            <input type="hidden" name="cir060selUserSid" value="cac<bean:write name="memMdl" property="cacSid" />" />&nbsp;&nbsp;[<span class="add_usr_del">削除</span>]</div>
          </logic:lessThan>

        </logic:greaterThan>
        </div>
      </logic:iterate>
      </logic:notEmpty>
      </span>
    </td>
    </tr>

    <tr>
    <th class="td_gray text_bb2" nowrap><gsmsg:write key="cmn.keyword" /></th>
    <td class="td_sub_detail">
      <html:text property="cir010searchWord" styleClass="text_base" maxlength="100" style="width:283px;"/>
      <div class="text_base2">
        <html:radio property="cir060wordKbn" value="<%= keyWordAnd %>" styleId="keyKbn_01" /><label for="keyKbn_01"><gsmsg:write key="cmn.contains.all" />(AND)</label>&nbsp;<html:radio property="cir060wordKbn" value="<%= keyWordOr %>" styleId="keyKbn_02" /><label for="keyKbn_02"><gsmsg:write key="cmn.containing.either" />(OR)</label>
      </div>
    </td>

    <th class="td_gray text_bb2" nowrap><gsmsg:write key="cmn.search2" /></th>
    <td class="td_sub_detail">
      <html:multibox styleId="search_scope_01" property="cir060searchTarget" value="<%= targetTitle %>" /><label for="search_scope_01"><gsmsg:write key="cmn.title" /></label>
      <html:multibox styleId="search_scope_02" property="cir060searchTarget" value="<%= targetHonbun %>" /><label for="search_scope_02"><gsmsg:write key="cmn.content" /></label>
    </td>
    </tr>

    <tr>
    <th class="td_gray text_bb2" nowrap><gsmsg:write key="cmn.sort.order" /></th>
    <td class="td_sub_detail" colspan="3">
    <span class="text_bb2"><gsmsg:write key="cmn.first.key" /></span>
      <html:select property="cir060sort1" styleClass="select04">
        <html:optionsCollection name="cir060Form" property="sortLabel" value="value" label="label" />
      </html:select>
      <html:radio property="cir060order1" value="<%= orderAsc %>" styleId="sort1_up" /><label for="sort1_up"><gsmsg:write key="cmn.order.asc" /></label>
      <html:radio property="cir060order1" value="<%= orderDesc %>" styleId="sort1_dw" /><label for="sort1_dw"><gsmsg:write key="cmn.order.desc" /></label>
      &nbsp;&nbsp;&nbsp;&nbsp;
    <span class="text_bb2"><gsmsg:write key="cmn.second.key" /></span>
      <html:select property="cir060sort2" styleClass="select04">
        <html:optionsCollection name="cir060Form" property="sortLabel" value="value" label="label" />
      </html:select>
      <html:radio property="cir060order2" value="<%= orderAsc %>" styleId="sort2_up" /><label for="sort2_up"><gsmsg:write key="cmn.order.asc" /></label>
      <html:radio property="cir060order2" value="<%= orderDesc %>" styleId="sort2_dw" /><label for="sort2_dw"><gsmsg:write key="cmn.order.desc" /></label>
    </td>
    </tr>
    </table>

    <div><img src="../circular/images/spacer.gif" width="1" height="10" class="img_bottom"></div>
    <div align="center"><input type="button" value="<gsmsg:write key="cmn.search" />" class="btn_search_n1" onclick="buttonPush('searchCir');"></div>
    <br class="clear">


<logic:notEmpty name="cir060Form" property="circularList" scope="request">

    <bean:size id="count1" name="cir060Form" property="pageLabel" scope="request" />
    <logic:greaterThan name="count1" value="1">
    <table width="100%" cellpadding="5" cellspacing="0">
    <tr>
      <td align="right">
        <img src="../common/images/arrow2_l.gif" alt="<gsmsg:write key="cmn.previous.page" />" class="img_bottom" height="20" width="20" onClick="buttonPush('prev');">
        <html:select property="cir060pageNum1" onchange="changePage(1);" styleClass="text_i">
          <html:optionsCollection name="cir060Form" property="pageLabel" value="value" label="label" />
        </html:select>
        <img src="../common/images/arrow2_r.gif" alt="<gsmsg:write key="cmn.next.page" />" class="img_bottom" height="20" width="20" onClick="buttonPush('next');">
      </td>
    </tr>
    </table>
    </logic:greaterThan>

    <table class="tl0 table_td_border" width="100%" cellpadding="0" cellspacing="0">
    <logic:equal name="cir060Form" property="cir060svSyubetsu" value="<%= jusin %>">
      <%@ include file="/WEB-INF/plugin/circular/jsp/cir060_sub01.jsp" %>
    </logic:equal>

    <logic:equal name="cir060Form" property="cir060svSyubetsu" value="<%= sosin %>">
      <%@ include file="/WEB-INF/plugin/circular/jsp/cir060_sub02.jsp" %>
    </logic:equal>

    <logic:equal name="cir060Form" property="cir060svSyubetsu" value="<%= gomi %>">
      <%@ include file="/WEB-INF/plugin/circular/jsp/cir060_sub03.jsp" %>
    </logic:equal>
    </table>

    <logic:notEqual name="cir060Form" property="cir060searchUse" value="<%= String.valueOf(jp.groupsession.v2.cmn.GSConst.PLUGIN_NOT_USE) %>">
    <logic:notEmpty name="cir060Form" property="cir060WebSearchWord">
    <table width="100%" cellpadding="5" cellspacing="0">
    <tr>
      <td align="left">
      <bean:define id="searchKeyword" name="cir060Form" property="cir060HtmlSearchWord" type="java.lang.String" />
      <a href="javascript:void(0);" class="" onmouseover="overSearch();" onmouseout="outSearch();" onClick="webSearch('<bean:write name="cir060Form" property="cir060WebSearchWord" />');">
        <span id="webSearchArea" class="text_normal">
        <gsmsg:write key="cmn.websearch" arg0="<%= searchKeyword %>" />
        </span>
      </a>
      </td>
    </tr>
    </logic:notEmpty>
    </logic:notEqual>

    <bean:size id="count2" name="cir060Form" property="pageLabel" scope="request" />
    <logic:greaterThan name="count2" value="1">
    <table width="100%" cellpadding="5" cellspacing="0">
    <tr>
      <td align="right">
        <img src="../common/images/arrow2_l.gif" alt="<gsmsg:write key="cmn.previous.page" />" class="img_bottom" height="20" width="20" onClick="buttonPush('prev');">
        <html:select property="cir060pageNum2" onchange="changePage(2);" styleClass="text_i">
          <html:optionsCollection name="cir060Form" property="pageLabel" value="value" label="label" />
        </html:select>
        <img src="../common/images/arrow2_r.gif" alt="<gsmsg:write key="cmn.next.page" />" class="img_bottom" height="20" width="20" onClick="buttonPush('next');">
      </td>
    </tr>
    </table>
    </logic:greaterThan>

</logic:notEmpty>

<!-- ページコンテンツ end -->
  </td>
  </tr>
  </table>

</td>
</tr>
</table>

<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>

</html:form>

<div id="atesakiSelPop" title="ユーザ選択" style="display:none;">

  <table width="100%" height="100%">
    <tr>
      <td id="atesakiSelArea" width="100%"></td>
    </tr>
  </table>

</div>

</body>
</html:html>

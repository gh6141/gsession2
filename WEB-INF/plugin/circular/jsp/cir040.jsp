<%@page import="jp.groupsession.v2.cir.biz.CirCommonBiz"%>
<%@page import="jp.groupsession.v2.cir.GSConstCircular"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ taglib uri="/WEB-INF/ctag-jsmsg.tld" prefix="gsjsmsg" %>

<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<% int maxLengthNaiyou = CirCommonBiz.getBodyLimitLength(); %>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<gsjsmsg:js filename="gsjsmsg.js"/>
<script language="JavaScript" src="../common/js/cmn110.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src='../schedule/jquery_ui/js/jquery-ui-1.8.14.custom.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../common/js/count.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/changestyle.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/calendar.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../circular/js/cir040.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/grouppopup.js?<%= GSConst.VERSION_PARAM %>"></script>
<logic:notEqual name="cir040Form" property="cir010AccountTheme" value="0">
<link rel=stylesheet href="../common/css/theme<bean:write name="cir040Form" property="cir010AccountTheme" />/theme.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
</logic:notEqual>
<logic:equal name="cir040Form" property="cir010AccountTheme" value="0">
<theme:css filename="theme.css"/>
</logic:equal>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery/jquery-theme.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery_ui/css/jquery.ui.dialog.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[Group Session] <gsmsg:write key="cir.19" /></title>
</head>


<% if (maxLengthNaiyou <= 0) {%>
<body class="body_03" onunload="windowClose();" onload="">
<% } else { %>
<body class="body_03" onunload="windowClose();" onload="showLengthId($('#inputstr')[0], <%= String.valueOf(maxLengthNaiyou) %>, 'inputlength');">
<% } %>
<html:form action="/circular/cir040">

<input type="hidden" name="CMD" value="ok">
<bean:define id="mode" value="0"/>
<logic:equal name="cir040Form" property="cirEntryMode" value="2">
<bean:define id="mode" value="2"/>
</logic:equal>
<input type="hidden" name="helpPrm" value="<bean:write name="mode"/>">
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
<%-- <html:hidden property="cir040pluginId" /> --%>
<html:hidden property="cir040InitFlg" />
<html:hidden property="cir040memoPeriod" />
<html:hidden property="cir040pluginIdTemp" />
<html:hidden property="cir040webmail" />


<% boolean callWebmail = true; %>
<logic:notEqual name="cir040Form" property="cir040webmail" value="1">
<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>
<% callWebmail = false; %>
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
      <logic:notEqual name="cir040Form" property="cirEntryMode" value="2">[ <gsmsg:write key="cmn.create.new" /> ]</logic:notEqual>
      <logic:equal name="cir040Form" property="cirEntryMode" value="2">[ <gsmsg:write key="cmn.edit" /> ]</logic:equal>
    </td>

    <td width="100%" class="header_white_bg"></td>
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
      <input type="submit" value="OK" class="btn_ok1">
      <% if (callWebmail) { %>
        <input type="button" name="btn_close" class="btn_close_n1" value="<gsmsg:write key="cmn.close" />" onClick="window.parent.webmailEntrySubWindowClose();">
      <% } else { %>
        <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('cir040back');">
      <% } %>
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
  </td>
  </tr>

  <tr>
  <td>
    <img src="../circular/images/spacer.gif" width="1px" height="10px" border="0">

    <table width="100%" class="tl0" border="0" cellpadding="5">

    <tr>
    <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.2" /></span></td>
    <bean:define id="mukouserClass" value=""/>
    <logic:equal name="cir040Form" property="cirViewAccountUko" value="1"><bean:define id="mukouserClass" value="mukouser"/></logic:equal>

    <td align="left" class="td_wt" width="100%">
    <logic:equal name="cir040Form" property="cirEntryMode" value="<%=String.valueOf(GSConstCircular.CIR_ENTRYMODE_EDIT) %>">
      <html:hidden name="cir040Form" property="cir040AccountSid"/>
      <span class="text_base <%=mukouserClass%>"><bean:write name="cir040Form" property="cirViewAccountName" /></span></td>
    </logic:equal>
    <logic:notEqual name="cir040Form" property="cirEntryMode" value="<%=String.valueOf(GSConstCircular.CIR_ENTRYMODE_EDIT) %>">
      <html:select property="cir040AccountSid" styleId="account_comb_box" styleClass="text_base account_select">
        <logic:notEmpty name="cir040Form" property="cir010AccountList">
          <logic:iterate id="accountMdl" name="cir040Form" property="cir010AccountList">
            <bean:define id="mukouserClass" value=""/>
            <logic:equal name="accountMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" value="mukouser_option" /></logic:equal>
            <bean:define id="accoutVal" name="accountMdl" property="accountSid" type="java.lang.Integer" />
            <html:option styleClass="<%= mukouserClass %>" value="<%= String.valueOf(accoutVal) %>"><bean:write name="accountMdl" property="accountName" /></html:option>
          </logic:iterate>
        </logic:notEmpty>
      </html:select>
    </logic:notEqual>


    </tr>

    <!-- 回覧先 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.20" /></span><span class="text_r2">※</span></td>
    <td align="left" class="td_wt">
      <table width="100%" cellspacing="0" cellpadding="0" border="0">

      <tr>

        <td width="5%">
          <input type="button" id="<gsmsg:write key="cmn.from" />" value="<gsmsg:write key="sml.sml020.05" />" class="btn_user_n1 cir_send_sel_btn">
        </td>

      <logic:notEmpty name="cir040Form" property="cir040MemberList" scope="request">
      <td width="95%" style="padding-left:10px;" align="left">
      <div id="atesaki_area" class="atesaki_scroll_area">
      <div id="atesaki_to_area" class="atesaki_add_area">

        <logic:iterate id="memMdl" name="cir040Form" property="cir040MemberList" scope="request">
          <div class="atesaki_to_user" id="0">

          <logic:greaterThan name="memMdl" property="cacSid" value="0">
            <bean:define id="mukouserClass" value=""/>
            <logic:equal name="memMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
            <logic:equal name="memMdl" property="cacJkbn" value="1"><bean:define id="mukouserClass" >deluser</bean:define></logic:equal>
            <span class="<%=mukouserClass%>"><bean:write name="memMdl" property="cacName" /></span>

            <logic:greaterThan name="memMdl" property="usrSid" value="0">
              <input type="hidden" name="cir040userSid" value="<bean:write name="memMdl" property="usrSid" />" />&nbsp;&nbsp;[<span class="add_usr_del">削除</span>]</div>
            </logic:greaterThan>

            <logic:lessThan name="memMdl" property="usrSid" value="1">
              <input type="hidden" name="cir040userSid" value="cac<bean:write name="memMdl" property="cacSid" />" />&nbsp;&nbsp;[<span class="add_usr_del">削除</span>]</div>
            </logic:lessThan>

          </logic:greaterThan>

        </logic:iterate>

      </div>
      </div>
      <div id="alldsp_to_area">
        <span id="all_dsp_to_link" class="all_disp_txt"></span>
      </div>

      </td>
      </logic:notEmpty>

      <logic:empty name="cir040Form" property="cir040MemberList" scope="request">
        <td width="95%" style="padding-left:10px;" align="left">
            <div id="atesaki_area" class="atesaki_scroll_area">
              <div id="atesaki_to_area" class="atesaki_add_area"></div>
            </div>
            <div id="alldsp_to_area">
              <span id="all_dsp_to_link" class="all_disp_txt"></span>
            </div>
        </td>
      </logic:empty>

      </tr>

      </table>
    </td>
    </tr>

    <!-- タイトル -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.title" /></span><span class="text_r2">※</span></td>
    <td align="left" class="td_wt" ><html:text maxlength="70" property="cir040title" styleClass="text_base" style="width:637px;"/></td>
    </tr>

    <!-- 内容 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.content" /></span><span class="text_r2">※</span></td>
    <td align="left" class="td_wt">
    <textarea class="text_base" name="cir040value" style="width:717px;" rows="10" onkeyup="showLengthStr(value, <%= String.valueOf(maxLengthNaiyou) %>, 'inputlength');" id="inputstr"><bean:write name="cir040Form" property="cir040value" /></textarea>
    <% if (maxLengthNaiyou > 0) {%>
       <br>
       <span class="font_string_count"><gsmsg:write key="cmn.current.characters" />:</span><span id="inputlength" class="font_string_count">0</span>&nbsp;<span class="font_string_count_max">/&nbsp;<%= String.valueOf(maxLengthNaiyou) %>&nbsp;<gsmsg:write key="cmn.character" /></span>
    <% } %>

    </td>
    </tr>

    <logic:equal name="cir040Form" property="cir040memoKbn" value="0">
      <!-- メモ欄修正区分 -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir040.2" /></span><span class="text_r2">※</span></td>
      <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
        <html:radio value="0" property="cir040memoKbn" styleId="memoNg" onclick="buttonPush('memoKbnChange');" /><label for="memoNg"><span class="text_base"><gsmsg:write key="cmn.not" /></span>&nbsp;&nbsp;</label>
        <html:radio value="1" property="cir040memoKbn" styleId="memoOk" onclick="buttonPush('memoKbnChange');" /><label for="memoOk"><span class="text_base"><gsmsg:write key="cmn.accepted" /></span></label>
      </td>
      </tr>
    </logic:equal>

    <logic:equal name="cir040Form" property="cir040memoKbn" value="1">
      <!-- メモ欄修正区分 -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir040.2" /></span><span class="text_r2">※</span></td>
      <td align="left" class="td_wt" nowrap><span class="text_base"><gsmsg:write key="cir.cir040.3" />&nbsp;&nbsp;</span>
        <html:radio value="0" property="cir040memoKbn" styleId="memoNg" onclick="buttonPush('memoKbnChange');" /><label for="memoNg"><span class="text_base"><gsmsg:write key="cmn.not" /></span>&nbsp;&nbsp;</label>
        <html:radio value="1" property="cir040memoKbn" styleId="memoOk" onclick="buttonPush('memoKbnChange');" /><label for="memoOk"><span class="text_base"><gsmsg:write key="cmn.accepted" /></span></label>
      <!-- メモ欄修正期限設定 -->
      <br>
      <br>
      <span class="text_base"><gsmsg:write key="cir.54" /></span>
      <br>
        <!-- 期間指定の場合 -->
        <a href="javascript:void(0);" onClick="return clickPeriod('clickPeriod', '1');"><span class="text_link2"><gsmsg:write key="cmn.today" /></span></a>&nbsp;&nbsp;
        <a href="javascript:void(0);" onClick="return clickPeriod('clickPeriod', '0');"><span class="text_link2">1<gsmsg:write key="cmn.weeks" /></span></a>&nbsp;&nbsp;
        <a href="javascript:void(0);" onClick="return clickPeriod('clickPeriod', '2');"><span class="text_link2">2<gsmsg:write key="cmn.weeks" /></span></a>&nbsp;&nbsp;
        <a href="javascript:void(0);" onClick="return clickPeriod('clickPeriod', '3');"><span class="text_link2"><gsmsg:write key="cmn.months" arg0="1" /></span></a>&nbsp;&nbsp;
        <br>
        <!-- 日付指定の場合 -->
        <html:select property="cir040memoPeriodYear" styleId="selYear">
          <html:optionsCollection name="cir040Form" property="cir040memoSelectYear" value="value" label="label" />
        </html:select>
        <html:select property="cir040memoPeriodMonth" styleId="selMonth">
          <html:optionsCollection name="cir040Form" property="cir040memoSelectMonth" value="value" label="label" />
        </html:select>
        <html:select property="cir040memoPeriodDay" styleId="selDay">
          <html:optionsCollection name="cir040Form" property="cir040memoSelectDay" value="value" label="label" />
        </html:select>
        <input type="button" value="Cal" onclick="wrtCalendarByBtn(this.form.selDay, this.form.selMonth, this.form.selYear, 'cir040FrCalBtn')" class="calendar_btn"　id="cir040FrCalBtn">
        <input type="button" class="btn_arrow_l" value="&nbsp;" onclick="return moveDay($('#selYear')[0], $('#selMonth')[0], $('#selDay')[0], 1)">
        <input type="button" class="btn_today" value="<gsmsg:write key="cmn.today" />" onClick="return moveDay($('#selYear')[0], $('#selMonth')[0], $('#selDay')[0], 2)">
        <input type="button" class="btn_arrow_r" value="&nbsp;" onclick="return moveDay($('#selYear')[0], $('#selMonth')[0], $('#selDay')[0], 3)">
        &nbsp;&nbsp;&nbsp;<span class="text_r1"><gsmsg:write key="cir.cir040.4" /></span>

      </td>
      </tr>
    </logic:equal>


    <!-- 添付 -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.attached" /></span></td>
    <td align="left" class="td_wt">
      <input type="button" class="btn_delete" value="<gsmsg:write key="cmn.delete" />" name="dellBtn" onClick="buttonPush('delete');">&nbsp;
      <input type="button" class="btn_attach" value="<gsmsg:write key="cmn.attached" />" name="attacheBtn" onClick="opnTemp('cir040selectFiles', '<bean:write name="cir040Form" property="cir040pluginIdTemp" />', '0', '0');">
      <br>

      <html:select property="cir040selectFiles" styleClass="select01" multiple="true">
        <html:optionsCollection name="cir040Form" property="cir040FileLabelList" value="value" label="label" />
      </html:select>
    </td>
    </tr>

    <!-- 公開／非公開   -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir030.3" /></span></td>
    <td align="left" class="td_wt" >
      <html:radio name="cir040Form" property="cir040show" styleId="kokai"   value="0" /><label for="kokai"  ><span class="text_base"><gsmsg:write key="cmn.public" /></span>&nbsp;&nbsp;</label>
      <html:radio name="cir040Form" property="cir040show" styleId="hikokai" value="1" /><label for="hikokai"><span class="text_base"><gsmsg:write key="cmn.private" /></span></label>
    </td>
    </tr>
    </table>

    <img src="../circular/images/spacer.gif" width="1px" height="10px" border="0">

    <table cellpadding="0" cellpadding="5" border="0" width="100%">
    <tr>
    <td align="right">
      <input type="submit" value="OK" class="btn_ok1">
      <% if (callWebmail) { %>
        <input type="button" name="btn_close" class="btn_close_n1" value="<gsmsg:write key="cmn.close" />" onClick="window.parent.webmailEntrySubWindowClose();">
      <% } else { %>
        <input type="button" value="<gsmsg:write key="cmn.back" />" class="btn_back_n1" onClick="buttonPush('cir040back');">
      <% } %>
    </td>
    </tr>
    </table>

  </td>
  </tr>
  </table>

</td>
</tr>
</table>

<logic:notEqual name="cir040Form" property="cir040webmail" value="1">
<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>
</logic:notEqual>

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
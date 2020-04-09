<%@page import="org.apache.commons.codec.language.Nysiis"%>
<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>

<%@page import="jp.groupsession.v2.cir.GSConstCircular"%>
<%@page import="jp.groupsession.v2.cmn.GSConst"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<% String maxLengthMemo = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MAX_LENGTH_MEMO); %>
<% String jusin = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_JUSIN); %>
<% String main = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_JUSIN_MAIN); %>
<% String gomi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_GOMI); %>

<gsmsg:define id="syainno" msgkey="cmn.employee.staff.number" />
<gsmsg:define id="simei" msgkey="cmn.name" />
<gsmsg:define id="post" msgkey="cmn.post" />
<gsmsg:define id="kakunin" msgkey="cmn.check" />
<gsmsg:define id="memo" msgkey="cir.11" />
<gsmsg:define id="temp" msgkey="cmn.attach.file" />
<gsmsg:define id="koushin" msgkey="cmn.last.modified" />

<%

  int[] sortKeyList = new int[] {
                       jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_SNO,
                       jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_NAME,
                       jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_POST,
                       jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_KAKU,
                       jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_MEMO,
                       -1,
                       jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_SAISYU
                       };
  String[] title_width = new String[] { "5", "10", "8", "12", "40", "20", "5"};
  String[] titleList = new String[] {
                        syainno,
                        simei,
                        post,
                        kakunin,
                        memo,
                        temp,
                        koushin
                       };
  int order_desc = jp.groupsession.v2.cmn.GSConst.ORDER_KEY_DESC;
  int order_asc = jp.groupsession.v2.cmn.GSConst.ORDER_KEY_ASC;
%>

<logic:empty name="cir020Form" property="cir060dspId" scope="request">
<bean:define id="cmdMode" name="cir020Form" property="cir010cmdMode" />
</logic:empty>
<logic:notEmpty name="cir020Form" property="cir060dspId" scope="request">
<bean:define id="cmdMode" name="cir020Form" property="cir060svSyubetsu" />
</logic:notEmpty>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<logic:notEqual name="cir020Form" property="cir010AccountTheme" value="0">
<link rel=stylesheet href="../common/css/theme<bean:write name="cir020Form" property="cir010AccountTheme" />/theme.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
</logic:notEqual>
<logic:equal name="cir020Form" property="cir010AccountTheme" value="0">
<theme:css filename="theme.css"/>
</logic:equal>
<link rel=stylesheet href='../common/css/default.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../common/css/selection.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[Group Session] <gsmsg:write key="cir.cir020.1" /></title>
<script language="JavaScript" src="../common/js/cmn110.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../circular/js/cir020.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/imageView.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/count.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/changestyle.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../common/js/jquery.selection-min.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/selectionSearch.js?<%= GSConst.VERSION_PARAM %>"></script>
<script language="JavaScript" src="../common/js/grouppopup.js?<%= GSConst.VERSION_PARAM %>"></script>
</head>

<body class="body_03" onload="">

<html:form action="/circular/cir020">

<bean:define id="dspMdl" name="cir020Form" property="cir020dspMdl" />
<bean:define id="orderKey" name="cir020Form" property="cir030orderKey" />
<bean:define id="sortKbn" name="cir020Form" property="cir030sortKey" />
<% int iOrderKey = ((Integer) orderKey).intValue(); %>
<% int iSortKbn = ((Integer) sortKbn).intValue(); %>

<logic:equal name="cmdMode" value="<%= main %>">
<input type="hidden" name="helpPrm" value="<%= jusin %>">
</logic:equal>
<logic:notEqual name="cmdMode" value="<%= main %>">
<input type="hidden" name="helpPrm" value="<bean:write name="cmdMode" />">
</logic:notEqual>

<input type="hidden" name="CMD" value="conf">
<input type="hidden" name="cmdMode" value="<bean:write name="cmdMode" />">
<input type="hidden" name="cir020cvwConf" value="<bean:write name="dspMdl" property="cvwConf" />">
<input type="hidden" name="cir020downLoadFlg" value="">
<input type="hidden" name="cir020memoEdit" value="<bean:write name="cir020Form" property="memoFlg" />">
<html:hidden property="cirViewAccount" />
<html:hidden property="cirAccountMode" />
<html:hidden property="cirAccountSid" />
<html:hidden property="cir020binSid" />
<html:hidden property="cir020cacSid" />
<html:hidden property="cir010cmdMode" />
<html:hidden property="cir010orderKey" />
<html:hidden property="cir010sortKey" />
<html:hidden property="cir010pageNum1" />
<html:hidden property="cir010pageNum2" />
<html:hidden property="cir010selectInfSid" />
<html:hidden property="cir010SelectLabelSid"/>
<html:hidden property="mikakkuCount" />
<html:hidden property="schWeekDate" />
<html:hidden property="schDailyDate" />
<html:hidden property="cir030orderKey" />
<html:hidden property="cir030sortKey" />
<html:hidden property="cirDelFlg" />

<html:hidden property="cir020pluginIdTemp" />

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
<html:hidden property="cir010searchWord" />
<html:hidden property="cir060syubetsu" />
<html:hidden property="cir060groupSid" />
<html:hidden property="cir060userSid" />
<html:hidden property="cir060wordKbn" />
<html:hidden property="cir060sort1" />
<html:hidden property="cir060order1" />
<html:hidden property="cir060sort2" />
<html:hidden property="cir060order2" />
<html:hidden property="cir060pageNum1" />
<html:hidden property="cir060pageNum2" />
<html:hidden property="cir060dspId" />

<logic:notEmpty name="cir020Form" property="cir060selUserSid" scope="request">
  <logic:iterate id="item" name="cir020Form" property="cir060selUserSid" scope="request">
    <input type="hidden" name="cir060selUserSid" value="<bean:write name="item"/>">
  </logic:iterate>
</logic:notEmpty>

<logic:notEmpty name="cir020Form" property="cir060svSelUserSid" scope="request">
  <logic:iterate id="item" name="cir020Form" property="cir060svSelUserSid" scope="request">
    <input type="hidden" name="cir060svSelUserSid" value="<bean:write name="item"/>">
  </logic:iterate>
</logic:notEmpty>

<logic:notEmpty name="cir020Form" property="cir060searchTarget" scope="request">
  <logic:iterate id="item" name="cir020Form" property="cir060searchTarget" scope="request">
    <input type="hidden" name="cir060searchTarget" value="<bean:write name="item"/>">
  </logic:iterate>
</logic:notEmpty>

<logic:notEmpty name="cir020Form" property="cir060svSearchTarget" scope="request">
  <logic:iterate id="item" name="cir020Form" property="cir060svSearchTarget" scope="request">
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
    <td width="0%" class="header_white_bg_text">[ <gsmsg:write key="cir.cir020.2" /> ]</td>
    <td width="100%" class="header_white_bg">
    <td width="0%"><img src="../common/images/header_white_end.gif" border="0" alt="<gsmsg:write key="cir.5" />"></td>
    </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%" class="tl0">
    <tr>
    <td width="40%">&nbsp;</td>
    <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt=""></td>
    <td class="header_glay_bg" width="60%">
      <input type="button" value="<gsmsg:write key="cmn.pdf" />" class="btn_pdf_n1" onClick="buttonPush('pdf');">
      <logic:equal name="cir020Form" property="cir020PrevBound" value="false">
        <input type="button" value="<gsmsg:write key="cmn.previous" />" class="btn_base1_dis_previous" disabled="true">
      </logic:equal>
      <logic:equal name="cir020Form" property="cir020PrevBound" value="true">
        <input type="button" value="<gsmsg:write key="cmn.previous" />" class="btn_previous_n1" onClick="buttonPush('prev020');">
      </logic:equal>

      <logic:equal name="cir020Form" property="cir020NextBound" value="false">
        <input type="button" value="<gsmsg:write key="cmn.next" />" class="btn_base1_dis_next" disabled="true">
      </logic:equal>
      <logic:equal name="cir020Form" property="cir020NextBound" value="true">
        <input type="button" value="<gsmsg:write key="cmn.next" />" class="btn_next_n1" onClick="buttonPush('next020');">
      </logic:equal>

      <logic:equal name="cmdMode" value="<%= gomi %>">
        <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
        <input type="button" value="<gsmsg:write key="cmn.undo" />" class="btn_modosu_n1" onClick="buttonPush('comeback');">
        <input type="button" value="<gsmsg:write key="cmn.back2" />" class="btn_back_n1" onClick="buttonPush('back');">
      </logic:equal>

      <logic:notEqual name="cmdMode" value="<%= gomi %>">
        <logic:equal name="dspMdl" property="cvwConf" value="<%= String.valueOf(GSConstCircular.CONF_UNOPEN) %>">
          <input type="submit" value="<gsmsg:write key="cir.cir020.2" />" class="btn_base1" onClick="confClick();">
          <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
          <input type="button" value="<gsmsg:write key="cmn.back2" />" class="btn_back_n1" onClick="buttonPush('back');">
        </logic:equal>

        <logic:notEqual name="dspMdl" property="cvwConf" value="<%= String.valueOf(GSConstCircular.CONF_UNOPEN) %>">
          <logic:equal name="cir020Form" property="memoFlg" value="0">
            <input type="submit" value="<gsmsg:write key="cmn.edit2" />" class="btn_base1" onClick="memoEdit();">
          </logic:equal>
          <logic:equal name="cir020Form" property="memoFlg" value="1">
            <img src="../common/images/damy.gif" width="100" height="1">
          </logic:equal>
          <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
          <input type="button" value="<gsmsg:write key="cmn.back2" />" class="btn_back_n1" onClick="buttonPush('back');">
        </logic:notEqual>
      </logic:notEqual>

    </td>
    <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt="" width="5"></td>
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

    <table width="100%" class="tl0" border="0" cellpadding="5" id="selectionSearchArea">

      <logic:equal name="cmdMode" value="<%= gomi %>">
      <tr>
      <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir020.3" /></span></td>
      <td align="left" class="td_wt" width="100%"><span class="text_base"><bean:write name="cir020Form" property="kakuninStr" /></span></td>
      </tr>
      </logic:equal>

      <tr>
      <td class="table_bg_A5B4E1" width="0%" nowrap><span class="text_bb1"><gsmsg:write key="cmn.title" /></span></td>
      <td align="left" class="td_wt" width="100%"><span class="text_base"><bean:write name="dspMdl" property="cifTitle" /></span></td>
      </tr>
<!-- 受信アカウント -->
      <tr>
      <td class="table_bg_A5B4E1" width="0%" nowrap>
        <span class="text_bb1"><gsmsg:write key="cmn.receive" /><gsmsg:write key="wml.102" /></span></td>
        <bean:define id="mukouserClass" value=""/>
      <logic:equal name="cir020Form" property="cirViewAccountUko" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>

      <td align="left" class="td_wt" width="100%"><span class="text_base <%=mukouserClass%>"><bean:write name="cir020Form" property="cirViewAccountName" /></span></td>
      </tr>
<!-- 発信者 -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.2" /></span></td>
      <td align="left" class="td_wt">
        <span class="text_base">
        <logic:equal name="dspMdl" property="cacJkbn" value="<%= String.valueOf(GSConstCircular.CAC_JKBN_NORMAL) %>">
        <bean:define id="mukouserClass" value=""/>
        <logic:equal name="dspMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
        <span class="<%=mukouserClass%>"><bean:write name="dspMdl" property="cacName" /></span>
        </logic:equal>
        <logic:notEqual name="dspMdl" property="cacJkbn" value="<%= String.valueOf(GSConstCircular.CAC_JKBN_NORMAL) %>">
        <del><bean:write name="dspMdl" property="cacName" /></del>
        </logic:notEqual>
        </span>
      </td>
      </tr>
<!-- 日時 -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.13" /></span></td>
      <td align="left" class="td_wt"><span class="text_base"><bean:write name="dspMdl" property="dspCifAdate" /></span></td>
      </tr>
<!-- 内容 -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.content" /></span></td>
      <td align="left" class="td_wt">
        <logic:equal name="dspMdl" property="cifEkbn" value="1">
          <bean:define id="edate" name="dspMdl" property="dspCifEditDate" type="java.lang.String" />
          <span class="text_base4">※<gsmsg:write key="bbs.bbs080.4" arg0="<%= edate %>" /></span>
          <br>
        </logic:equal>
        <span class="text_cir_base"><bean:write name="dspMdl" property="cifValue" filter="false" /></span>
      </td>
      </tr>

      <tr>
<!-- 発信時の添付 -->

      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cmn.attached" /></span></td>
      <td align="left" class="td_wt">
        <logic:notEmpty name="cir020Form" property="cir020fileList" scope="request">
        <logic:iterate id="fileMdl" name="cir020Form" property="cir020fileList" scope="request">

            <logic:notEmpty name="fileMdl" property="binFileExtension">
               <bean:define id="fext" name="fileMdl" property="binFileExtension"  type="java.lang.String" />
               <%
                String dext = ((String)pageContext.getAttribute("fext",PageContext.PAGE_SCOPE));
                if (dext != null) {
                    dext = dext.toLowerCase();
                    if (jp.groupsession.v2.cmn.biz.CommonBiz.isViewFile(dext)) {
                %>
               <img src="../circular/cir020.do?CMD=tempview&cir020binSid=<bean:write name="fileMdl" property="binSid" />&cir010selectInfSid=<bean:write name="cir020Form" property="cir010selectInfSid" />&cirViewAccount=<bean:write name="cir020Form" property="cirViewAccount" />" name="pictImage<bean:write name="fileMdl" property="binSid" />" onload="initImageView('pictImage<bean:write name="fileMdl" property="binSid" />');">
               <br>
                <%
                    }
                }
                %>
            </logic:notEmpty>

        <a href="javascript:void(0);" onClick="return fileLinkClick('<bean:write name="fileMdl" property="binSid" />');"><span class="text_link_min"><bean:write name="fileMdl" property="binFileName" /><bean:write name="fileMdl" property="binFileSizeDsp" /></span></a>
        <br><br>
        </logic:iterate>
        </logic:notEmpty>
      </td>
      </tr>

<!-- メモ -->
      <tr>
      <td class="table_bg_A5B4E1" nowrap><span class="text_bb1"><gsmsg:write key="cir.11" /></span></td>
      <td align="left" class="td_wt">

      <logic:equal name="dspMdl" property="cifMemoFlg" value="1">
        <span class="font_string_count"><gsmsg:write key="cir.53" />&nbsp;&nbsp;&nbsp;
        <bean:write name="dspMdl" property="dspCifMemoDate" /></span><br>
      </logic:equal>

      <textarea class="text_cir_base" name="cir020memo" style="width:717px;" rows="10" onkeyup="showLengthStr(value, <%= maxLengthMemo %>, 'inputlength');" id="inputstr"><bean:write name="cir020Form" property="cir020memo" /></textarea>
      <br>
      <span class="font_string_count"><gsmsg:write key="cmn.current.characters" />:</span><span id="inputlength" class="font_string_count">0</span>&nbsp;<span class="font_string_count_max">/&nbsp;<%= maxLengthMemo %>&nbsp;<gsmsg:write key="cmn.character" /></span>
      </td>
      </tr>

<!-- 添付ファイル -->
    <tr>
    <td class="table_bg_A5B4E1" nowrap><span class="text_bb1">確認時<gsmsg:write key="cmn.attached" /></span></td>
    <td align="left" class="td_wt">
      <input type="button" class="btn_delete" value="<gsmsg:write key="cmn.delete" />" name="dellBtn" onClick="buttonPush('tmpDelete');">&nbsp;
      <input type="button" class="btn_attach" value="<gsmsg:write key="cmn.attached" />" name="attacheBtn" onClick="opnTemp('cir020UserTmpSelectFiles', '<bean:write name="cir020Form" property="cir020pluginIdTemp" />', '0', '0');">
      <br>

      <html:select property="cir020UserTmpSelectFiles" styleClass="select01" multiple="true">
        <html:optionsCollection name="cir020Form" property="cir020UserTmpFileLabelList" value="value" label="label" />
      </html:select>
    </td>
    </tr>

      <logic:equal name="dspMdl" property="cifShow" value="0">


      <tr>
      <td class="td_wt2" colspan="2" nowrap>
         <table width="100%">
         <tr>
            <td>
               <span class="text_bb1"><gsmsg:write key="cir.14" /></span>&nbsp;&nbsp;
               <html:select name="cir020Form" property="cirMemListGroup" onchange="buttonPush('changeGroup');" styleClass="select01">
                 <logic:notEmpty name="cir020Form" property="cirMemListGroupCombo">
                   <logic:iterate id="gpBean" name="cir020Form" property="cirMemListGroupCombo" scope="request">
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
               <input type="button" onclick="openGroupWindow(this.form.cirMemListGroup, 'cirMemListGroup', '0', 'changeGroup', 0)" class="group_btn2" value="&nbsp;&nbsp;" id="cir020GroupBtn">
               <br>
            </td>
            <td align="right">
            <input type="button" class="btn_file_export" value="<gsmsg:write key="cir.allTmep.download" />" onClick="buttonPush('allTmpExp');">
            </td>
         </tr>
         </table>

      <table width="100%" border="0" cellpadding="5" cellspacing="0" class="tl0">
      <tr>
<%
      int titlecol = 1;
      for (int i = 0; i < sortKeyList.length; i++) {
        if (jp.groupsession.v2.cir.GSConstCircular.SAKI_SORT_KAKU == sortKeyList[i]) {
            titlecol = 2;
        } else {
            titlecol = 1;
        }

        if (iSortKbn == sortKeyList[i] && sortKeyList[i] != -1) {
          if (iOrderKey == order_desc) {
%>
            <th width="<%= title_width[i] %>%" class="td_type14" colspan="<%= titlecol %>" nowrap><a href="javascript:void(0);" onClick="return onTitleLinkSubmit(<%= sortKeyList[i] %>, <%= order_asc %>);"><span class="text_tlw"><%= titleList[i] %>▼</span></a></th>
<%
          } else {
%>
            <th width="<%= title_width[i] %>%" class="td_type14" colspan="<%= titlecol %>" nowrap><a href="javascript:void(0);" onClick="return onTitleLinkSubmit(<%= sortKeyList[i] %>, <%= order_desc %>);"><span class="text_tlw"><%= titleList[i] %>▲</span></a></th>
<%
          }
        } else if (sortKeyList[i] == -1) {
%>
            <th width="<%= title_width[i] %>%" class="td_type14" colspan="<%= titlecol %>" nowrap><span class="text_tlw"><%= titleList[i] %></span></th>
<%
        } else {
%>
            <th width="<%= title_width[i] %>%" class="td_type14" colspan="<%= titlecol %>" nowrap><a href="javascript:void(0);" onClick="return onTitleLinkSubmit(<%= sortKeyList[i] %>, <%= order_asc %>);"><span class="text_tlw"><%= titleList[i] %></span></a></th>
<%
        }
      }
%>
      </tr>

      <logic:notEmpty name="cir020Form" property="cir030memList" scope="request">
      <logic:iterate id="memMdl" name="cir020Form" property="cir030memList" scope="request">
      <tr>

      <td class="td_wt">

        <span class="text_base">
        <bean:write name="memMdl" property="syainNo" />
        </span>

      </td>

      <td class="td_wt" nowrap>

        <span class="text_base">
        <logic:equal name="memMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
          <bean:define id="mukouserClass" value=""/>
          <logic:equal name="memMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
          <span class="<%=mukouserClass%>"><bean:write name="memMdl" property="cacName" /></span>
        </logic:equal>
        <logic:notEqual name="memMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
        <del><bean:write name="memMdl" property="cacName" /></del>
        </logic:notEqual>
        </span>

      </td>

      <td class="td_wt">

        <span class="text_base">
        <bean:write name="memMdl" property="posName" />
        </span>

      </td>

      <td class="td_wt" align="center" valign="middle" nowrap>

        <logic:equal name="memMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_OPEN) %>">
        <img alt="<gsmsg:write key="cmn.confirmed" />" height="16" src="../common/images/check.gif" width="16">
        </logic:equal>
        <logic:notEqual name="memMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_OPEN) %>">
        &nbsp;
        </logic:notEqual>

      </td>

      <td class="td_wt" align="center" valign="middle" nowrap>

        <logic:equal name="memMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_OPEN) %>">
        <span class="text_base"><bean:write name="memMdl" property="openTimeDate" /><br><bean:write name="memMdl" property="openTimeTime" /></span>
        </logic:equal>
        <logic:notEqual name="memMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_OPEN) %>">
        &nbsp;
        </logic:notEqual>

      </td>

      <td class="td_wt" valign="top">
      <span class="text_base"><bean:write name="memMdl" property="cvwMemo" filter="false" /></span>
      <logic:equal name="memMdl" property="circularUse" value="false">
        <logic:notEmpty name="memMdl" property="cvwMemo"><br></logic:notEmpty>
        <span class="text_error">※<gsmsg:write key="cir.15" /></span>
      </logic:equal>
      </td>

<!-- 添付 -->
      <td align="left" class="td_wt">
        <logic:notEmpty name="memMdl" property="dspUserTmpFileList">
        <logic:iterate id="usrFileMdl" name="memMdl" property="dspUserTmpFileList">
        <a href="javascript:void(0);" onClick="return usrFileLinkClick('<bean:write name="memMdl" property="cacSid" />','<bean:write name="usrFileMdl" property="binSid" />');"><span class="text_link_min"><bean:write name="usrFileMdl" property="binFileName" /><bean:write name="usrFileMdl" property="binFileSizeDsp" /></span></a>
        <br>
        </logic:iterate>
        </logic:notEmpty>
      </td>

      <td class="td_wt" align="center" valign="middle" nowrap>

        <logic:equal name="memMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_OPEN) %>">
          <span class="text_base"><bean:write name="memMdl" property="dspCvwEdateDate" /><br><bean:write name="memMdl" property="dspCvwEdateTime" /></span>
        </logic:equal>
        <logic:notEqual name="memMdl" property="cvwConf" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_OPEN) %>">
        &nbsp;
        </logic:notEqual>

      </td>

      </tr>
      </logic:iterate>
      </logic:notEmpty>
      </table>

    </td>
    </tr>

    </logic:equal>

    </table>

      <img src="./images/spacer.gif" width="1px" height="10px" border="0">

      <table cellpadding="0" cellpadding="5" border="0" width="100%">
      <tr>
      <td align="right">
        <input type="button" value="<gsmsg:write key="cmn.pdf" />" class="btn_pdf_n1" onClick="buttonPush('pdf');">
        <logic:equal name="cir020Form" property="cir020PrevBound" value="false">
          <input type="button" value="<gsmsg:write key="cmn.previous" />" class="btn_base1_dis_previous" disabled="true">
        </logic:equal>
        <logic:equal name="cir020Form" property="cir020PrevBound" value="true">
          <input type="button" value="<gsmsg:write key="cmn.previous" />" class="btn_previous_n1" onClick="buttonPush('prev020');">
        </logic:equal>

        <logic:equal name="cir020Form" property="cir020NextBound" value="false">
          <input type="button" value="<gsmsg:write key="cmn.next" />" class="btn_base1_dis_next" disabled="true">
        </logic:equal>
        <logic:equal name="cir020Form" property="cir020NextBound" value="true">
          <input type="button" value="<gsmsg:write key="cmn.next" />" class="btn_next_n1" onClick="buttonPush('next020');">
        </logic:equal>

        <logic:equal name="cmdMode" value="<%= gomi %>">
        <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
        <input type="button" value="<gsmsg:write key="cmn.undo" />" class="btn_modosu_n1" onClick="buttonPush('comeback');">
        <input type="button" value="<gsmsg:write key="cmn.back2" />" class="btn_back_n1" onClick="buttonPush('back');">
        </logic:equal>

        <logic:notEqual name="cmdMode" value="<%= gomi %>">
          <logic:equal name="dspMdl" property="cvwConf" value="<%= String.valueOf(GSConstCircular.CONF_UNOPEN) %>">
            <input type="submit" value="<gsmsg:write key="cir.cir020.2" />" class="btn_base1" onClick="confClick();">
            <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
            <input type="button" value="<gsmsg:write key="cmn.back2" />" class="btn_back_n1" onClick="buttonPush('back');">
          </logic:equal>

          <logic:notEqual name="dspMdl" property="cvwConf" value="<%= String.valueOf(GSConstCircular.CONF_UNOPEN) %>">
          <logic:equal name="cir020Form" property="memoFlg" value="0">
            <input type="submit" value="<gsmsg:write key="cmn.edit2" />" class="btn_base1" onClick="memoEdit();">
          </logic:equal>
          <logic:equal name="cir020Form" property="memoFlg" value="1">
            <img src="../common/images/damy.gif" width="100" height="1">
          </logic:equal>
            <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
            <input type="button" value="<gsmsg:write key="cmn.back2" />" class="btn_back_n1" onClick="buttonPush('back');">
          </logic:notEqual>
        </logic:notEqual>

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

<IFRAME type="hidden" src="../common/html/damy.html" style="display: none" name="navframe"></IFRAME>
<logic:equal name="cir020Form" property="cir020searchUse" value="<%= String.valueOf(GSConst.PLUGIN_USE) %>">
<span id="tooltip_search" class="tooltip_search"></span>
</logic:equal>
</body>
</html:html>
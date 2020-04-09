<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme" %>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg" %>
<%@ taglib uri="/WEB-INF/ctag-jsmsg.tld" prefix="gsjsmsg" %>
<%@ page import="jp.groupsession.v2.cmn.GSConst" %>
<%@ page import="jp.groupsession.v2.enq.GSConstEnquete" %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<META http-equiv="Content-Script-Type" content="text/javascript">
<META http-equiv="Content-Style-Type" content="text/css">
<title>[Group Session] <gsmsg:write key="cmn.admin.setting.menu" /></title>
<script type="text/javascript" src='../common/js/jquery-1.5.2.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script type="text/javascript" src="../common/js/jquery.selection-min.js?<%= GSConst.VERSION_PARAM %>"></script>
<script type="text/javascript" src="../common/js/grouppopup.js?<%= GSConst.VERSION_PARAM %>"></script>
<script type="text/javascript" src="../common/js/cmd.js?<%= GSConst.VERSION_PARAM %>"></script>
<script type="text/javascript" src="../circular/js/cir220.js?<%= GSConst.VERSION_PARAM %>"></script>
<theme:css filename="theme.css"/>
<link rel=stylesheet href="../common/css/default.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
<link rel=stylesheet href="../circular/css/circular.css?<%= GSConst.VERSION_PARAM %>" type="text/css">
</head>

<body class="body_03" onload="cir220Init(<bean:write name='cir220Form' property='cir220TaisyoKbn' />);">
<html:form action="/circular/cir220">
<!-- BODY -->
<input type="hidden" name="CMD">
<html:hidden property="backScreen" />
<html:hidden property="cir220initFlg" />

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

<logic:notEmpty name="cir220Form" property="cir220MakeSenderList" scope="request">
    <logic:iterate id="ulBean" name="cir220Form" property="cir220MakeSenderList" scope="request">
    <input type="hidden" name="cir220MakeSenderList" value="<bean:write name="ulBean" />">
    </logic:iterate>
</logic:notEmpty>


<!-- header -->
<%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

<!-- content -->
<table cellpadding="5" cellspacing="0" width="100%">
<tr>
<td width="100%" align="center">

  <table cellpadding="0" cellspacing="0" width="70%">
  <tr>
  <td align="center">

    <!-- タイトル -->
    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="0%"><img src="../common/images/header_ktool_01.gif" border="0" alt="<gsmsg:write key="cmn.admin.setting" />"></td>
        <td width="0%" class="header_ktool_bg_text2" align="left" valign="middle" nowrap><span class="settei_ttl"><gsmsg:write key="cmn.admin.setting" /></span></td>
        <td width="100%" class="header_ktool_bg_text2">[ <gsmsg:write key="cir.cir220.1"/> ]</td>
        <td width="0%"><img src="../common/images/header_ktool_05.gif" border="0" alt="<gsmsg:write key="cmn.admin.setting" />"></td>
      </tr>
    </table>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="50%"></td>
        <td width="0%"><img src="../common/images/header_glay_1.gif" border="0" alt="<gsmsg:write key='cmn.function.btn' />"></td>
        <td class="header_glay_bg" width="50%">
          <input type="button" value="OK" class="btn_ok1" onClick="buttonPush('cir220ok');">
          <input type="button" value="<gsmsg:write key='cmn.back.admin.setting' />" class="btn_back_n3" onClick="buttonPush('cir220back');">
        </td>
        <td width="0%"><img src="../common/images/header_glay_3.gif" border="0" alt="<gsmsg:write key='cmn.function.btn' />"></td>
      </tr>
    </table>

    <img src="../common/images/spacer.gif" width="1" height="5" border="0">

    <!-- エラーメッセージ -->
    <div style="text-align:left">
    <html:errors/>
    </div>


    <table cellpadding="10" cellspacing="0" border="0" width="100%" class="tl_u2">
    <thead>
      <!-- 対象者区分 -->
      <tr>
        <td valign="middle" align="left" class="table_bg_A5B4E1" width="20%" nowrap>
          <span class="text_bb1"><gsmsg:write key="cir.cir220.3"/></span>
        </td>
        <td align="left" class="td_wt" width="80%">
          <span class="text_base">
            <html:radio styleId="taisyo0" styleClass="taisyoKbn" name="cir220Form" property="cir220TaisyoKbn" value="<%= String.valueOf(GSConstEnquete.CONF_TAISYO_LIMIT) %>" onclick="changeTaisyoKbn(0);" />
            <label for="taisyo0"><gsmsg:write key="wml.31"/></label>&nbsp;
            <html:radio styleId="taisyo1" styleClass="taisyoKbn" name="cir220Form" property="cir220TaisyoKbn" value="<%= String.valueOf(GSConstEnquete.CONF_TAISYO_ALL) %>" onclick="changeTaisyoKbn(1);" />
            <label for="taisyo1"><gsmsg:write key="wml.32"/></label>&nbsp;
          </span>
        </td>
      </tr>
    </thead>

    <tbody id="taisyoArea">
      <tr>
        <td valign="middle" align="left" class="table_bg_A5B4E1" nowrap>
          <span class="text_bb1"><gsmsg:write key="cir.cir220.6"/></span>
        </td>
        <td valign="middle" align="left" class="td_wt">
          <table width="100%" border="0">
            <tr>
              <td width="40%" class="table_bg_A5B4E1 td_comboBox" align="center" nowrap><span class="text_bb1"><gsmsg:write key="cir.cir220.6"/></span></td>
              <td width="20%" align="center">&nbsp;</td>
              <td width="40%" align="left" class="td_comboBox">

                <!-- 全グループから選択 -->
                <input class="btn_group_n1" value="<gsmsg:write key="cmn.sel.all.group" />" onclick="return openAllGroup(this.form.cir220GroupSid, 'cir220GroupSid', '<bean:write name="cir220Form" property="cir220GroupSid" />', '0', 'cir220ChangeGroup', 'cir220MakeSenderList', '-1', '1')" type="button"><br>

                <!-- グループコンボボックス -->
                <logic:notEmpty name="cir220Form" property="cir220GroupLabel" scope="request">

                  <html:select property="cir220GroupSid" onchange="buttonPush('cir220ChangeGroup');" styleClass="select05">
                    <logic:notEmpty name="cir220Form" property="cir220GroupLabel" scope="request">
                      <logic:iterate id="gpBean" name="cir220Form" property="cir220GroupLabel" scope="request">
                        <bean:define id="gpValue" name="gpBean" property="value" type="java.lang.String" />
                        <html:option value="<%= gpValue %>"><bean:write name="gpBean" property="label" /></html:option>
                      </logic:iterate>
                    </logic:notEmpty>
                  </html:select>

                </logic:notEmpty>
                <input type="button" onclick="openGroupWindow(this.form.cir220GroupSid, 'cir220GroupSid', '0', 'cir220ChangeGroup')" class="group_btn2" value="&nbsp;" id="groupBtn">
              </td>
            </tr>

            <tr>
              <!-- アンケート発信対象者リスト -->
              <td align="center" valign="top">
                <select size="10" name="cir220SelectAddSenderSid" class="select01" style="width:100%;" multiple>
                  <logic:notEmpty name="cir220Form" property="cir220AddSenderLabel" scope="request">
                    <logic:iterate id="labelValueBean" name="cir220Form" property="cir220AddSenderLabel" scope="request">
                      <option value="<bean:write name="labelValueBean" property="value"/>"><bean:write name="labelValueBean" property="label"/></option>
                    </logic:iterate>
                  </logic:notEmpty>
                </select>
              </td>

              <td align="center">
                <input type="button" class="btn_base1add" value="<gsmsg:write key="cmn.add"/>" name="addSenderBtn" onClick="buttonPush('cir220AddSender');"><br><br>
                <input type="button" class="btn_base1del" value="<gsmsg:write key="cmn.delete" />" name="removeSenderBtn" onClick="buttonPush('cir220RemoveSender');">
              </td>

              <!-- グループ所属ユーザリスト -->
              <td align="center" valign="top" rowspan="3">
                <select size="10" name="cir220SelectBelongSenderSid" class="select01" style="width:100%;" multiple>
                  <logic:notEmpty name="cir220Form" property="cir220BelongSenderLabel" scope="request">
                    <logic:iterate id="labelValueBean" name="cir220Form" property="cir220BelongSenderLabel" scope="request">
                      <option value="<bean:write name="labelValueBean" property="value" scope="page"/>"><bean:write name="labelValueBean" property="label" scope="page"/></option>
                    </logic:iterate>
                  </logic:notEmpty>
                </select>
              </td>
            </tr>
          </table>
        </td>
      </tr>

    </tbody>
    </table>

    <table cellpadding="0" cellspacing="0" width="100%" style="margin-top: 10px;">
      <tr>
        <td align="right">
          <input type="button" value="OK" class="btn_ok1" onClick="buttonPush('cir220ok');">
          <input type="button" value="<gsmsg:write key='cmn.back.admin.setting' />" class="btn_back_n3" onClick="buttonPush('cir220back');">
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
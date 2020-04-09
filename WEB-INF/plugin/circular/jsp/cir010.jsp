<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<%@ taglib uri="http://struts.apache.org/tags-html" prefix="html"%>
<%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean"%>
<%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic"%>
<%@ taglib uri="/WEB-INF/ctag-css.tld" prefix="theme"%>
<%@ taglib uri="/WEB-INF/ctag-message.tld" prefix="gsmsg"%>

<%@ page import="jp.groupsession.v2.cmn.GSConst"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">

<% String jusin = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_JUSIN); %>
<% String sosin = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_SOUSIN); %>
<% String gomi = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_GOMI); %>
<% String label = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.MODE_LABEL); %>
<% String unopen = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CONF_UNOPEN); %>
<%
   int order_desc = jp.groupsession.v2.cmn.GSConst.ORDER_KEY_DESC;
   int order_asc = jp.groupsession.v2.cmn.GSConst.ORDER_KEY_ASC;
%>

<html:html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<logic:notEqual name="cir010Form" property="cir010AccountTheme" value="0">
  <link rel=stylesheet href="../common/css/theme<bean:write name="cir010Form" property="cir010AccountTheme" />/theme.css?<%=GSConst.VERSION_PARAM%>" type="text/css">
</logic:notEqual>
<logic:equal name="cir010Form" property="cir010AccountTheme" value="0">
  <theme:css filename="theme.css" />
</logic:equal>

<link rel=stylesheet href='../common/css/default.css?<%=GSConst.VERSION_PARAM%>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular.css?<%=GSConst.VERSION_PARAM%>' type='text/css'>
<link rel=stylesheet href='../circular/css/circular010.css?<%=GSConst.VERSION_PARAM%>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery/jquery-theme.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../schedule/jquery_ui/css/jquery.ui.dialog.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<link rel=stylesheet href='../common/css/glayer.css?<%= GSConst.VERSION_PARAM %>' type='text/css'>
<title>[Group Session] <gsmsg:write key="cir.5" /></title>
<script language="JavaScript" src='../common/js/jquery-1.5.2.min.js?<%=GSConst.VERSION_PARAM%>'></script>
<script language="JavaScript" src='../schedule/jquery_ui/js/jquery-ui-1.8.14.custom.min.js?<%= GSConst.VERSION_PARAM %>'></script>
<script language="JavaScript" src="../common/js/cmd.js?<%=GSConst.VERSION_PARAM%>"></script>
<script language="JavaScript" src="../common/js/check.js?<%=GSConst.VERSION_PARAM%>"></script>
<script language="JavaScript" src="../circular/js/cir010.js?<%=GSConst.VERSION_PARAM%>"></script>
<jsp:include page="/WEB-INF/plugin/circular/jsp/cir010_message.jsp" />
<script type="text/javascript">
<!--
	//自動リロード
	<logic:notEqual name="cir010Form" property="cir010Reload" value="0">
	var reloadinterval = <bean:write name="cir010Form" property="cir010Reload" />;
	setTimeout("buttonPush('reload')", reloadinterval);
	</logic:notEqual>
	-->
</script>
</head>
<body class="body_03">
  <html:form styleId="cir010Form" action="/circular/cir010">
    <input type="hidden" name="helpPrm" value="<bean:write name="cir010Form" property="cir010cmdMode" />">
    <input type="hidden" name="CMD" value="search">
    <input type="hidden" name="cir010selectInfSid">
    <input type="hidden" name="cir010sojuKbn">
    <html:hidden property="cirAccountSid" />
    <html:hidden property="cir010cmdMode" />
    <html:hidden property="cir010orderKey" />
    <html:hidden property="cir010sortKey" />
    <html:hidden property="cir010SelectLabelSid"/>
    <html:hidden property="cir010addLabelType"/>
    <html:hidden property="cir010addLabel"/>
    <html:hidden property="cir010addLabelName"/>
    <html:hidden property="cir010delLabel"/>

    <%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp"%>
    <bean:define id="orderKey" name="cir010Form" property="cir010orderKey" />
    <bean:define id="sortKbn" name="cir010Form" property="cir010sortKey" />
    <%int iOrderKey = ((Integer) orderKey).intValue();%>
    <%int iSortKbn = ((Integer) sortKbn).intValue();%>
    <!-- BODY -->
    <table align="center" cellpadding="5" cellspacing="0" border="0" width="100%">
      <tr>
        <td width="100%" align="center">
          <table cellpadding="0" cellspacing="0" border="0" width="100%">
            <tr>
              <td>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                  <tr>
                    <td width="0%">
                      <img src="../circular/images/header_circular.gif" border="0" alt="<gsmsg:write key="cir.5" />">
                    </td>
                    <td width="0%" class="header_white_bg_text" align="right" valign="middle" nowrap>
                      <span class="plugin_ttl"><gsmsg:write key="cir.5" /></span>
                    </td>
                    <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=jusin%>">
                      <td width="0%" class="header_white_bg_text">
                        [&nbsp;<gsmsg:write key="cmn.receive2" />&nbsp;]
                      </td>
                    </logic:equal>
                    <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=sosin%>">
                      <td width="0%" class="header_white_bg_text">
                        [&nbsp;<gsmsg:write key="cmn.sent2" />&nbsp;]
                      </td>
                    </logic:equal>
                    <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=gomi%>">
                      <td width="0%" class="header_white_bg_text">
                        [&nbsp;<gsmsg:write key="cmn.trash2" />&nbsp;]
                      </td>
                    </logic:equal>
                    <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=label%>">
                      <td width="0%" class="header_white_bg_text">
                        [&nbsp;<bean:write name="cir010Form" property="cir010TitleLabelName" />&nbsp;]
                      </td>
                    </logic:equal>
                    <td width="100%" class="header_white_bg">
                      <input type="button" value="<gsmsg:write key="cmn.reload" />" class="btn_reload_n1" onClick="buttonPush('reload');">
                      <input type="button" name="btn_account" class="btn_base1_7" value="<gsmsg:write key="wml.100" />" onClick="return buttonPush('accountConf');">
                      <logic:equal name="cir010Form" property="adminFlg" value="<%=String.valueOf(jp.groupsession.v2.cmn.GSConst.USER_ADMIN)%>">
                        <input type="button" name="settingAdmin" class="btn_setting_admin_n1" value="<gsmsg:write key="cmn.admin.setting" />" onClick="buttonPush('admConf');">
                      </logic:equal>
                      <input type="button" name="btn_prjadd" class="btn_setting_n1" value="<gsmsg:write key="cmn.preferences2" />" onClick="buttonPush('pset');">
                    <td width="0%">
                      <img src="../common/images/header_white_end.gif" border="0" alt="<gsmsg:write key="cir.5" />">
                    </td>
                  </tr>
                </table>

                <table class="clear_table" width="100%">
                <tr><td><div class="margin_top_10"></div></td></tr>
                  <tr>
                    <!-- アカウント -->
                    <td class="left_menu_area">
                      <div id="js_account_area" class="left_menu_content_area menu_head_area">
                        <span class="menu_head_txt menu_head_sel"><gsmsg:write key="wml.102" /></span>
                      </div>
                      <!-- コンボ -->
                      <div id="js_account_child_area" class="left_menu_content_area menu_head_account_area">
                        <div class="cir_padding_top_3">
                          <html:select property="cirViewAccount" styleId="account_comb_box" styleClass="text_base account_select">
                            <logic:notEmpty name="cir010Form" property="cir010AccountList">
                              <logic:iterate id="accountMdl" name="cir010Form" property="cir010AccountList">
                                <bean:define id="mukouserClass" value=""/>
                                <logic:equal name="accountMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" value="mukouser_option" /></logic:equal>
                                <bean:define id="accoutVal" name="accountMdl" property="accountSid" type="java.lang.Integer" />
                                <html:option styleClass="<%= mukouserClass %>" value="<%= String.valueOf(accoutVal) %>"><bean:write name="accountMdl" property="accountName" /></html:option>
                              </logic:iterate>
                            </logic:notEmpty>
                          </html:select>
                        </div>
                        <!-- セル -->
                        <div class="account_sel_bottom">
                         <logic:notEmpty name="cir010Form" property="cir010AccountList">
                           <bean:define id="viewAccoutVal" name="cir010Form" property="cirViewAccount" type="java.lang.Integer" />
                           <logic:iterate id="accountMdl" name="cir010Form" property="cir010AccountList">
                             <logic:notEqual name="accountMdl" property="accountSid" value="<%= String.valueOf(viewAccoutVal) %>">
                              <div class="js_account_sel account_sel_txt <logic:equal name="accountMdl" property="usrUkoFlg" value="1">mukouser</logic:equal>" id="<bean:write name="accountMdl" property="accountSid" />">
                              <bean:write name="accountMdl" property="accountName" />
                              <!-- 受信件数表示 -->
                              <logic:notEqual name="accountMdl" property="accountMidokuCount" value="0">
                                  (<bean:write name="accountMdl" property="accountMidokuCount" />)
                                </logic:notEqual>
                              </div>
                             </logic:notEqual>
                          </logic:iterate>
                        </logic:notEmpty>
                      </div>
                    </div>
                    <!-- フォルダ -->
                    <div id="js_folder_area" class="left_menu_content_area menu_head_area ">
                      <span class="menu_head_txt menu_head_sel"><gsmsg:write key="cmn.folder" /></span>
                    </div>
                    <div id="js_folder_child_area" class="left_menu_content_area left_menu_child_content_area_top0 ">
                      <div class="child_spacer"></div>
                      <!-- 受信 -->
                      <div class="content_div">
                        <div class="cir_left_line_top folder_clear_float"></div>
                        <div class="cir_jushin folder_float"></div>
                        <div id="menu_jushin_txt" class="cir_box_txt  folder_float pointer" onclick="changeMode('jusin');">
                        <gsmsg:write key="cmn.receive" />
                        <!-- 受信件数表示 -->
                        <logic:notEqual name="cir010Form" property="cir010JusinMidokuCnt" value="0">
                          <span class="text_bb1">(<bean:write name="cir010Form" property="cir010JusinMidokuCnt"/>)</span>
                        </logic:notEqual>
                        </div>
                        <div id="midoku_txt" class="midoku_txt"></div>
                        <!-- 送信 -->
                        <div class="clear_div">
                          <div class="cir_left_line  folder_clear_float"></div>
                          <div class="cir_soshin folder_float"></div>
                          <div class="cir_box_txt folder_float changeLabelDir pointer" id="1" onclick="changeMode('sousin');">
                            <gsmsg:write key="cmn.sent" />
                          </div>
                        </div>
                        <!-- ゴミ -->
                        <div class="clear_div">
                          <logic:notEmpty name="cir010Form" property="cir010LabelList" >
                            <div class="cir_left_line  folder_clear_float"></div>
                          </logic:notEmpty>
                           <logic:empty name="cir010Form" property="cir010LabelList" >
                             <div class="cir_left_line_bottom  folder_clear_float"></div>
                          </logic:empty>
                          <div class="cir_dust folder_float"></div>
                          <div class="cir_box_txt folder_float" id="1" >
                            <span id="kara_area" class="pointer" onclick="changeMode('gomi');"><gsmsg:write key="cmn.trash" /></span>
                         <logic:notEqual name="cir010Form" property="cir010GomiMidokuCnt" value="0">
                           &nbsp;<span class="text_bb1">(<bean:write name="cir010Form" property="cir010GomiMidokuCnt"/>)</span>
                        </logic:notEqual>
                              &nbsp;&nbsp;[<span class="all_del_txt js_all_dust"><gsmsg:write key="wml.js.111" /></span>]
                          </div>
                        </div>
                        <!-- ラベル -->
                          <logic:notEmpty name="cir010Form" property="cir010LabelList" >
                           <div class="clear_div">
                              <div class="js_line_plus_minus cir_left_line_minus_bottom  folder_clear_float"></div>
                              <div class="cir_label folder_float"></div>
                              <div class="cir_box_txt folder_float js_label pointer">
                                <gsmsg:write key="cmn.label" />
                              </div>
                            </div>
                            <bean:size name="cir010Form" property="cir010LabelList" id="labelSize" />
                            <logic:iterate id="labelData" name="cir010Form" property="cir010LabelList"  indexId="idx">
                            <div class="clear_div js_label_area">
                            <div class="cir_folder_null folder_clear_float"></div>
                               <logic:notEqual name="idx" value="<%= String.valueOf(labelSize.intValue()-1) %>">
                                    <div class="cir_left_line folder_float"></div>
                               </logic:notEqual>
                               <logic:equal name="idx" value="<%= String.valueOf(labelSize.intValue()-1) %>">
                                    <div class="cir_left_line_bottom folder_float"></div>
                               </logic:equal>
                            <div class="cir_box_lable_txt folder_float" >
                              <span class="pointer" onclick="changeFolder('label', <bean:write name="labelData" property="labelSid" />);"><bean:write name="labelData" property="labelName" />
                              <!-- 未読件数 -->
                              <logic:greaterThan name="labelData" property="midokuCount" value="0">
                                <span class="text_bb1">(<bean:write name="labelData" property="midokuCount" />)</span>
                              </logic:greaterThan>
                              </span>
                            </div>
                          </div>
                            </logic:iterate>
                          </logic:notEmpty>
                      </div>
                    </div>
                    <div class="menu_head_area_none"></div>
                    </td>
                    <!-- 右 -->
                    <td class="right_content_area">
                     <table width="100%" cellpadding="5" cellspacing="0">
                        <tr valign="top">
                          <td align="right">
                        <img src="../common/images/search.gif" alt="<gsmsg:write key="cmn.search" />" class="img_bottom">
                        <html:text property="cir010searchWord" styleClass="text_base cir_search_form" maxlength="100" />
                        <input type="button" value="<gsmsg:write key="cmn.search" />" class="btn_base0" onClick="buttonPush('search');">
                            <logic:notEqual name="cir010Form" property="cir010cmdMode" value="<%= gomi %>">
                              <button type="button" name="btn_send" class="btn_add_label js_add_label">
                               <gsmsg:write key="cmn.add.label2" />
                              </button>
                              <button type="button" name="btn_send" class="btn_del_label js_del_label">
                               <gsmsg:write key="wml.js.108" />
                              </button>
                            </logic:notEqual>
                            <%boolean canCirCreate = false;%>
                            <logic:equal name="cir010Form" property="cirCreateFlg" value="true">
                              <input type="button" value="<gsmsg:write key="cir.cir010.3" />" class="btn_add_n2" onClick="buttonPush('add');">
                              <%canCirCreate = true;%>
                            </logic:equal>
                            <%boolean cirSendTab = false;%>
                            <logic:equal name="cir010Form" property="cir010cmdMode" value="<%= sosin %>">
                              <% cirSendTab = true; %>
                            </logic:equal>
                            <% if (!cirSendTab || canCirCreate) { %>
                            <input type="button" value="<gsmsg:write key="cmn.delete2" />" class="btn_dell_n1" onClick="buttonPush('delete');">
                            <% } %>
                            <logic:equal name="cir010Form" property="cir010cmdMode" value="<%= gomi %>">
                              <input type="button" value="<gsmsg:write key="cmn.undo" />" class="btn_modosu_n1" onClick="buttonPush('comeback');">
                            </logic:equal>
                          </td>
                        </tr>
                      </table>

                  <span class="text_bb8">
                  <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=jusin%>">
                      &nbsp;<gsmsg:write key="cmn.receive" />
                  </logic:equal>
                  <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=sosin%>">
                      &nbsp;<gsmsg:write key="cmn.sent" />
                  </logic:equal>
                  <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=gomi%>">
                      &nbsp;<gsmsg:write key="cmn.trash" />
                  </logic:equal>
                  <logic:equal name="cir010Form" property="cir010cmdMode" value="<%=label%>">
                      &nbsp;<bean:write name="cir010Form" property="cir010TitleLabelName" />
                  </logic:equal>
                  </span>
                <table cellpadding="0" cellspacing="0" border="0" width="100%">
                  <!-- エラーメッセージ -->
                  <logic:messagesPresent message="false">
                  <tr><td><div class="margin_top_10"></div></td></tr>
                    <tr>
                      <td align="left">
                        <html:errors />
                      </td>
                    </tr>
                  </logic:messagesPresent>
                </table>
                      <div align="right">
                          <!-- ページング -->
                        <bean:size id="count1" name="cir010Form" property="cir010PageLabel" scope="request" />
                        <logic:greaterThan name="count1" value="1">
                          <img src="../common/images/arrow2_l.gif" alt="<gsmsg:write key="cmn.previous.page" />" align ="img_bottom" height="20" width="20" onClick="buttonPush('prev');">
                          <html:select property="cir010pageNum1" onchange="changePage(1);" styleClass="text_i">
                            <html:optionsCollection name="cir010Form" property="cir010PageLabel" value="value" label="label" />
                          </html:select>
                          <img src="../common/images/arrow2_r.gif" alt="<gsmsg:write key="cmn.next.page" />" align ="img_bottom" width="20" height="20" onClick="buttonPush('next');">
                        </logic:greaterThan>
                      </div>
                        <logic:equal name="cir010Form" property="cir010cmdMode" value="<%= jusin %>">
                          <%@ include file="/WEB-INF/plugin/circular/jsp/cir010_sub01.jsp" %>
                        </logic:equal>
                        <logic:equal name="cir010Form" property="cir010cmdMode" value="<%= sosin %>">
                          <%@ include file="/WEB-INF/plugin/circular/jsp/cir010_sub02.jsp" %>
                        </logic:equal>
                        <logic:equal name="cir010Form" property="cir010cmdMode" value="<%= gomi %>">
                          <%@ include file="/WEB-INF/plugin/circular/jsp/cir010_sub03.jsp" %>
                        </logic:equal>
                        <logic:equal name="cir010Form" property="cir010cmdMode" value="<%= label %>">
                          <%@ include file="/WEB-INF/plugin/circular/jsp/cir010_sub04.jsp" %>
                        </logic:equal>
                     <div align="right">
                          <!-- ページング -->
                        <bean:size id="count2" name="cir010Form" property="cir010PageLabel" scope="request" />
                        <logic:greaterThan name="count2" value="1">
                          <img src="../common/images/arrow2_l.gif" alt="<gsmsg:write key="cmn.previous.page" />" align="top" class="text_i" height="20" width="20" onClick="buttonPush('prev');">
                          <html:select property="cir010pageNum2" onchange="changePage(2);" styleClass="text_i">
                            <html:optionsCollection name="cir010Form" property="cir010PageLabel" value="value" label="label" />
                          </html:select>
                          <img src="../common/images/arrow2_r.gif" alt="<gsmsg:write key="cmn.next.page" />" align="top" class="text_i" height="20" width="20" onClick="buttonPush('next');">
                        </logic:greaterThan>
                      </div>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
   <!-- ダイアログエラーメッセージ -->
   <div id="messagePop" title="" class="display_none">
    <table width="100%" height="100%">
      <tr>
        <td width="15%">
          <span class="ui-icon ui-icon-info"></span>
        </td>
        <td width="85%">
          <b id="messageArea" class="errorMsgStr"></b>
        </td>
      </tr>
    </table>
   </div>
   <!-- ラベル追加ダイアログ -->
  <div id="labelAddPop" title="<gsmsg:write key="wml.wml010.16" />" class="display_none">
    <table id="labelAddContentArea" class="label_add_dialog_style" width="100%" height="100%" >
    </table>
  </div>
  <!-- ラベル削除ダイアログ -->
  <div id="labelDelPop" title="<gsmsg:write key="wml.js.108" />" class="display_none">
    <table id="labelDelContentArea" width="100%" height="100%"></table>
  </div>
  <!-- ゴミ箱を空にする -->
  <div id="delMailMsgPop" title="" class="display_none">
    <table width="100%" height="100%">
      <tr>
        <td width="15%">
          <span class="ui-icon ui-icon-info"></span>
        </td>
        <td width="85%"  id="delMailMsgArea" class="trash_kara_font">
        </td>
      </tr>
    </table>
  </div>

  <%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp"%>

 </html:form>

</body>
</html:html>
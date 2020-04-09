<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>

<gsmsg:define id="title" msgkey="cmn.title" />
<gsmsg:define id="kakunin" msgkey="cmn.check" />
<gsmsg:define id="nitiji" msgkey="cmn.date" />
<gsmsg:define id="hassinsya" msgkey="cir.2" />


<table class="tl0 table_td_border2" width="100%" cellpadding="5" cellspacing="0">
 <tr>
  <bean:define id="cir010sortKey" name="cir010Form" property="cir010sortKey" type="java.lang.Integer" />
  <bean:define id="cir010orderKey" name="cir010Form" property="cir010orderKey" type="java.lang.Integer" />
  <%
              String cif_show_open = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PUBLIC);
              String sortSign = "";
              String nextOrder = "";
              jp.groupsession.v2.struts.msg.GsMessage gsMsg = new jp.groupsession.v2.struts.msg.GsMessage();
              String[] widthList = {
                      "3",
                      "56",
                      "5",
                      "18",
                      "18",
                      };
              String[] titleList = {
                      "<input type=\"checkbox\" name=\"allChk\" onClick=\"changeChk();\">",
                      gsMsg.getMessage(request, "cmn.title"),
                      gsMsg.getMessage(request, "cmn.check"),
                      gsMsg.getMessage(request, "cmn.date"),
                      gsMsg.getMessage(request, "cir.2")
                      };
              int[] sortKeyList = {
                      -1,
                      jp.groupsession.v2.cir.GSConstCircular.SORT_TITLE,
                      -1,
                      jp.groupsession.v2.cir.GSConstCircular.SORT_DATE,
                      jp.groupsession.v2.cir.GSConstCircular.SORT_USER
                      };
              for (int titleIdx = 0; titleIdx < titleList.length; titleIdx++) {
                  if(sortKeyList[titleIdx]  == -1) {
                      %>
                      <th width="<%=widthList[titleIdx]%>%" class="detail_tbl">
                        <span class="text_base3"><%=titleList[titleIdx]%></span>
                      </th>
                      <%

                  } else {
                  if (cir010sortKey.intValue() == sortKeyList[titleIdx]) {
                      if (cir010orderKey.intValue() == 1) {
                          sortSign = "▼";
                          nextOrder = "0";
                      } else {
                          sortSign = "▲";
                          nextOrder = "1";
                      }
                  } else {
                      nextOrder = "0";
                      sortSign = "";
                  }
  %>
  <th width="<%=widthList[titleIdx]%>%" class="detail_tbl">
    <a href="#" onClick="clickTitle(<%=String.valueOf(sortKeyList[titleIdx])%>, <%= nextOrder %>);" > <span class="text_base3"><%=titleList[titleIdx]%><%=sortSign%></span>
    </a>
  </th>
  <%
                    }
                }
  %>
    </tr>


  <!-- 表BODY -->
  <logic:notEmpty name="cir010Form" property="cir010CircularList" scope="request">
  <logic:iterate id="cirMdl" name="cir010Form" property="cir010CircularList" scope="request" indexId="idx">


<%
  String font = "text_p";
  String titleFont = "text_p";
%>

  <tr>
  <!-- チェックボックス -->
  <td class="td_type1" align="center">
    <html:multibox name="cir010Form" property="cir010delInfSid">
       <bean:write name="cirMdl" property="cifSid" />-<bean:write name="cirMdl" property="jsFlg" />
    </html:multibox>
  </td>

  <!-- タイトル -->
  <td class="td_type1">
    <logic:notEmpty name="cirMdl" property="labelName">
        <span class="cirLabel"><bean:write name="cirMdl" property="labelName" /></span>
    </logic:notEmpty>
    <a href="javascript:void(0)" onClick="return buttonPush('view', '<bean:write name="cirMdl" property="cifSid" />');">
      <span class="<%= String.valueOf(titleFont) %>"><bean:write name="cirMdl" property="cifTitle" /></span>
    </a>
  </td>

  <td class="td_type1" align="center">
  <span class="text_base2">
  <logic:equal name="cirMdl" property="cifShow" value="<%= cif_show_open %>"><bean:write name="cirMdl" property="openCount" />/<bean:write name="cirMdl" property="allCount" /></logic:equal>
  <logic:notEqual name="cirMdl" property="cifShow" value="<%= cif_show_open %>">-</logic:notEqual>
  </span>
  </td>

  <!-- 日付 -->
  <td class="td_type1" align="center"><span class="text_base2"><bean:write name="cirMdl" property="dspCifAdate" /></span></td>

  <!-- 発信者 -->
  <td class="td_type1">
    <logic:equal name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
    <bean:define id="mukouserClass" value=""/>
    <logic:equal name="cirMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" value="mukouser" /></logic:equal>

    <span class="text_base2 <%=mukouserClass%>"><bean:write name="cirMdl" property="cacName" /></span>
    </logic:equal>
    <logic:notEqual name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
    <del><span class="text_base2"><bean:write name="cirMdl" property="cacName" /></span></del>
    </logic:notEqual>
  </td>
  </tr>

  </logic:iterate>
  </logic:notEmpty>

  </table>


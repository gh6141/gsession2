<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>


      <tr class="table_bg_7D91BD_search">
        <th width="60%"><a href="javascript:void(0)" onClick="clickSortTitle(<%= sortTitle %>);"><span class="text_tlw"><gsmsg:write key="cmn.title" /></span></a></th>
        <th width="20%"><a href="javascript:void(0)" onClick="clickSortTitle(<%= sortDate %>);"><span class="text_tlw"><gsmsg:write key="cmn.date" /></span></a></th>
        <th width="20%"><a href="javascript:void(0)" onClick="clickSortTitle(<%= sortUser %>);"><span class="text_tlw"><gsmsg:write key="cir.2" /></span></a></th>
      </tr>

      <bean:define id="backclass" value="smail_td" />
      <logic:iterate id="cirMdl" name="cir060Form" property="circularList" scope="request" indexId="idx">
      <bean:define id="backpat" value="<%= String.valueOf((idx.intValue() % 2) + 1) %>" />
      <bean:define id="back" value="<%= String.valueOf(backclass) + String.valueOf(backpat) %>" />

      <%
        String font = "";
        String titleFont = "";
        String sojuStr = "";
      %>

      <logic:equal name="cirMdl" property="cvwConf" value="<%= unopen %>">
      <%
        font = "sc_ttl_sat";
        titleFont = "text_link";
      %>
      </logic:equal>

      <logic:notEqual name="cirMdl" property="cvwConf" value="<%= unopen %>">
      <%
        font = "text_p";
        titleFont = "text_p";
      %>
      </logic:notEqual>

      <% jp.groupsession.v2.struts.msg.GsMessage gsMsg = new jp.groupsession.v2.struts.msg.GsMessage(); %>
      <logic:equal name="cirMdl" property="jsFlg" value="<%= jusin %>">
      <%
        sojuStr = gsMsg.getMessage(request, "sml.100");
      %>
      </logic:equal>
      <logic:equal name="cirMdl" property="jsFlg" value="<%= sosin %>">
      <%
        sojuStr = gsMsg.getMessage(request, "sml.102");
      %>
      </logic:equal>

      <tr>
        <td class="<%= String.valueOf(back) %>" align="left"><a href="javascript:void(0)" onClick="return viewItem('view', '<bean:write name="cirMdl" property="cifSid" />', '<bean:write name="cirMdl" property="jsFlg" />');"><span class="<%= String.valueOf(titleFont) %>"><%= String.valueOf(sojuStr) %>&nbsp;<bean:write name="cirMdl" property="cifTitle" /></span></a></td>

        <td class="<%= String.valueOf(back) %>" nowrap align="center"><span class="<%= String.valueOf(font) %>"><bean:write name="cirMdl" property="dspCifAdate" /></span></td>

        <td class="<%= String.valueOf(back) %>" align="left">
          <logic:equal name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cmn.GSConst.JTKBN_TOROKU) %>">
          <bean:define id="mukouserClass" value=""/>
          <logic:equal name="cirMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
          <span class="<%= String.valueOf(font)%> <%=mukouserClass%>"><bean:write name="cirMdl" property="cacName" /></span>
          </logic:equal>
          <logic:notEqual name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cmn.GSConst.JTKBN_TOROKU) %>">
          <del><span class="<%= String.valueOf(font) %>"><bean:write name="cirMdl" property="cacName" /></span></del>
          </logic:notEqual>
        </td>
      </tr>

      </logic:iterate>

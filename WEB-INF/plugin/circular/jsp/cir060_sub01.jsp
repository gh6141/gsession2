<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<% String cif_show_open = String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CIR_INIT_SAKI_PUBLIC); %>

      <tr class="table_bg_7D91BD_search">
        <th width="55%"><a href="javascript:void(0)" onClick="clickSortTitle(<%= sortTitle %>);"><span class="text_tlw"><gsmsg:write key="cmn.title" /></span></a></th>
        <th width="5%"><span class="text_tlw"><gsmsg:write key="cmn.check" /></span></th>
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

      <tr>
        <td class="<%= String.valueOf(back) %>" align="left"><a href="javascript:void(0)" onClick="return viewItem('view', '<bean:write name="cirMdl" property="cifSid" />', '0');"><span class="<%= String.valueOf(titleFont) %>"><bean:write name="cirMdl" property="cifTitle" /></span></a></td>

        <td class="<%= String.valueOf(back) %>" nowrap align="center">
        <span class="<%= String.valueOf(font) %>"">
          <logic:equal name="cirMdl" property="cifShow" value="<%= cif_show_open %>"><bean:write name="cirMdl" property="openCount" />/<bean:write name="cirMdl" property="allCount" /></logic:equal>
          <logic:notEqual name="cirMdl" property="cifShow" value="<%= cif_show_open %>">-</logic:notEqual>
        </td>

        <td class="<%= String.valueOf(back) %>" nowrap align="center"><span class="<%= String.valueOf(font) %>"><bean:write name="cirMdl" property="dspCifAdate" /></span></td>

        <td class="<%= String.valueOf(back) %>" align="left">
          <logic:equal name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
          <bean:define id="mukouserClass" value=""/>
          <logic:equal name="cirMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
          <span class="<%= String.valueOf(font) %> <%=mukouserClass%>"><bean:write name="cirMdl" property="cacName" /></span>
          </logic:equal>
          <logic:notEqual name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
          <del><span class="<%= String.valueOf(font) %>"><bean:write name="cirMdl" property="cacName" /></span></del>
          </logic:notEqual>
        </td>
      </tr>

      </logic:iterate>

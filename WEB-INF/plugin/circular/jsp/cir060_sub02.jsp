<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>


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

      <tr>
        <td class="<%= String.valueOf(back) %>" align="left"><a href="javascript:void(0)" onClick="return viewItem('view', '<bean:write name="cirMdl" property="cifSid" />', '1');"><span class="text_p"><bean:write name="cirMdl" property="cifTitle" /></span></a></td>

        <td class="<%= String.valueOf(back) %>" nowrap align="center"><span class="text_p"><bean:write name="cirMdl" property="openCount" />/<bean:write name="cirMdl" property="allCount" /></span></td>

        <td class="<%= String.valueOf(back) %>" nowrap align="center"><span class="text_p"><bean:write name="cirMdl" property="dspCifAdate" /></span></td>

        <td class="<%= String.valueOf(back) %>" align="left">
          <logic:equal name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
          <bean:define id="mukouserClass" value=""/>
          <logic:equal name="cirMdl" property="usrUkoFlg" value="1"><bean:define id="mukouserClass" >mukouser</bean:define></logic:equal>
          <span class="text_p <%=mukouserClass%>"><bean:write name="cirMdl" property="cacName" /></span>
          </logic:equal>
          <logic:notEqual name="cirMdl" property="cacJkbn" value="<%= String.valueOf(jp.groupsession.v2.cir.GSConstCircular.CAC_JKBN_NORMAL) %>">
          <del><span class="text_p"><bean:write name="cirMdl" property="cacName" /></span></del>
          </logic:notEqual>
        </td>
      </tr>

      </logic:iterate>

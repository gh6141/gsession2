<%@ page pageEncoding="Windows-31J"
    contentType="text/html; charset=UTF-8"%>
  <%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
  <%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
  <%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
  <%@ taglib uri="http://struts.apache.org/tags-nested" prefix="nested" %>


  <html:html>
  <head>
  <title>[GroupSession] Asu Iko Yotei</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel=stylesheet href='../common/css/default.css' type='text/css'>
  </head>

  <body class="body_03">



  <html:form action="/plugins2/helloworlds2">
  <table cellpadding="5" width="100%" class="td_sub_detail">
    <tr>
  <td  class="header_white_bg_text" valign="middle" ><span class="plugin_ttl">–¾“úˆÈ~‚Ì—\’è</span></td>
  </tr>
  <tr><td>
<font size=4>
<bean:write name="helloworldForms2" property="text" filter="false"/>
</font>
  </td></tr>
  </table>

  </html:form>
  </body>
  </html:html>


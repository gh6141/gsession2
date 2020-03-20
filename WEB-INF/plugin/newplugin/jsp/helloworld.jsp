<%@ page pageEncoding="Windows-31J"
    contentType="text/html; charset=UTF-8"%>
  <%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
  <%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
  <%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
  <%@ taglib uri="http://struts.apache.org/tags-nested" prefix="nested" %>

<%@ page import="java.net.*" %>
<%@ page import="java.sql.*"%>
<%@page import="java.util.*" %>
<%@page import="java.text.*" %>
<%@page import="java.io.File" %>


<%

GregorianCalendar cal = new GregorianCalendar();

Calendar cal1 = Calendar.getInstance();  //(1)オブジェクトの生成
int month = cal1.get(Calendar.MONTH) + 1;
String tuki="00"+Integer.toString(month);
tuki = tuki.substring(tuki.length()-2,tuki.length());

%>

  <html:html>
  <head>
  <title>Plugin 予定表</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel=stylesheet href='../common/css/default.css' type='text/css'>
  </head>

  <body class="body_03">

  <%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>




<bean:write name="helloworldForm" property="text" filter="false"/>


<%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>


  </body>
  </html:html>

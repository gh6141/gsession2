<%@ page pageEncoding="Windows-31J"
    contentType="text/html; charset=UTF-8"%>
  <%@ taglib uri="http://struts.apache.org/tags-html" prefix="html" %>
  <%@ taglib uri="http://struts.apache.org/tags-bean" prefix="bean" %>
  <%@ taglib uri="http://struts.apache.org/tags-logic" prefix="logic" %>
  <%@ taglib uri="http://struts.apache.org/tags-nested" prefix="nested" %>


  <html:html>
  <head>
  <title>[GroupSession] Yotei</title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <link rel=stylesheet href='../common/css/default.css' type='text/css'>
  </head>

  <body class="body_03">

<html:form action="/gyoji/yotei">

  <%@ include file="/WEB-INF/plugin/common/jsp/header001.jsp" %>

  <table width="100%">
  <tr>
  <td width="100%" align="center">
    <p>行事予定（エクセル）の設定</p>
  </td>
  </tr>
  </table>

　　　<html:submit property="submit" value="更新" />
<br>
〇行事予定のエクセルファイルのパス<br>
　(1)<html:text property="text" size="80"  /><br>
　(2)<html:text property="text_s" size="80"  /><br>
　※予定表のエクセルファイルの場所（パス）を入れてください。￥などの記号は￥￥（実際は半角の円記号）のように２重にしてください。２つまで登録可。

<br><br>
〇月予定の場合<br>
　行事予定の項目名<br>
　<html:text property="text4" size="80" /><br>
　※,,[行事],[○部],,,,のように、エクセルの項目名を入れてください。空欄だと表示されません。<br>
　エクセルデータの形式について
　※エクセルデータでは、セルの結合は使わないでください。<br>
　※月のタブは４月、５月、、、３月の順に並んでいる必要があります。 <br>
<br><br>
〇節予定の場合<br>
　元号と元年度の西暦<br>
　<html:text property="text5" size="20"  /><br>
　※エクセルの予定表の最初の行の年号を読み取り、月日計算するために元号（漢字２文字）と元年度の西暦（半角数字4桁）をカンマ(,)区切りで入力してください。<br>
　エクセルデータの形式について<br>
　※日付が重複している場合、後のシート、先頭行に「休業」の文字があるシートを優先的に表示します。<br>
　※日付の先頭は月/日の形式にしてください。
<br>



  <%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>

  </html:form>
  </body>
  </html:html>
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
    <p>�s���\��i�G�N�Z���j�̐ݒ�</p>
  </td>
  </tr>
  </table>

�@�@�@<html:submit property="submit" value="�X�V" />
<br>
�Z�s���\��̃G�N�Z���t�@�C���̃p�X<br>
�@<html:text property="text" size="80"  /><br>
�@���\��\�̃G�N�Z���t�@�C���̏ꏊ�i�p�X�j�����Ă��������B���Ȃǂ̋L���́����i���ۂ͔��p�̉~�L���j�̂悤�ɂQ�d�ɂ��Ă��������B
<br><br>
�Z���\��̏ꍇ<br>
�@�s���\��̍��ږ�<br>
�@<html:text property="text4" size="80" /><br>
�@��,,[�s��],[����],,,,�̂悤�ɁA�G�N�Z���̍��ږ������Ă��������B�󗓂��ƕ\������܂���B<br>
�@�G�N�Z���f�[�^�̌`���ɂ���
�@���G�N�Z���f�[�^�ł́A�Z���̌����͎g��Ȃ��ł��������B<br>
�@�����̃^�u�͂S���A�T���A�A�A�R���̏��ɕ���ł���K�v������܂��B <br>
<br><br>
�Z�ߗ\��̏ꍇ<br>
�@�����ƌ��N�x�̐���<br>
�@<html:text property="text5" size="20"  /><br>
�@���G�N�Z���̗\��\�̍ŏ��̍s�̔N����ǂݎ��A�����v�Z���邽�߂Ɍ����i�����Q�����j�ƌ��N�x�̐���i���p����4���j���J���}(,)��؂�œ��͂��Ă��������B<br>
�@�G�N�Z���f�[�^�̌`���ɂ���<br>
�@�����t���d�����Ă���ꍇ�A��̃V�[�g�A�擪�s�Ɂu�x�Ɓv�̕���������V�[�g��D��I�ɕ\�����܂��B<br>
�@�����t�̐擪�͌�/���̌`���ɂ��Ă��������B
<br>



  <%@ include file="/WEB-INF/plugin/common/jsp/footer001.jsp" %>

  </html:form>
  </body>
  </html:html>
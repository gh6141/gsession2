package jp.groupsession.v2.plugin2.helloworld2;

  import java.util.ArrayList;

import jp.groupsession.v2.cmn.dao.GroupModel;
import jp.groupsession.v2.struts.AbstractGsForm;


  public class HelloWorldForm2 extends AbstractGsForm {

	  private String text__ ="";
	  private String opt＿="";

	  public void setText(String text) {
	      text__  = text;
	  }

	  public String getText() {
	      return text__ ;
	  }

	  public void setOpt(String text) {
		  opt＿  = text;
	  }

	  public String getOpt() {
	      return opt＿ ;
	  }



  }
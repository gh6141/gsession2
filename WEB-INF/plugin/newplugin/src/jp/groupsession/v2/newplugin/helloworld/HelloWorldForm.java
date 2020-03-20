package jp.groupsession.v2.newplugin.helloworld;

  import java.util.ArrayList;

import jp.groupsession.v2.cmn.dao.GroupModel;
import jp.groupsession.v2.struts.AbstractGsForm;


  public class HelloWorldForm extends AbstractGsForm {

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
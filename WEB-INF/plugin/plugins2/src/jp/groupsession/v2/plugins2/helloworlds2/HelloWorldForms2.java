package jp.groupsession.v2.plugins2.helloworlds2;

  import java.util.ArrayList;

import jp.groupsession.v2.cmn.dao.GroupModel;
import jp.groupsession.v2.struts.AbstractGsForm;


  public class HelloWorldForms2 extends AbstractGsForm {

	  private String text__ ="";

	  public void setText(String text) {
	      text__  = text;
	  }

	  public String getText() {
	      return text__ ;
	  }



  }
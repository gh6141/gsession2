package jp.groupsession.v2.gyoji.yotei;



import javax.servlet.http.HttpServletRequest;



import jp.groupsession.v2.sch.model.SchDataModel;
import jp.groupsession.v2.struts.AbstractGsForm;

import java.util.ArrayList;
import java.util.List;

import jp.groupsession.v2.cmn.dao.GroupModel;

  /**
   * <br>[機  能] HelloWorldのフォームクラス
   * <br>[解  説]
   * <br>[備  考]
   *
   * @author JTS
   */
  public class YoteiForm extends AbstractGsForm {

private String text__ ="";

public void setText(String text) {
    text__  = text;
}

public String getText() {
    return text__ ;
}

private String text4__ ="";

public void setText4(String text4) {
    text4__  = text4;
}

public String getText4() {
    return text4__ ;
}

private String text5__ ="";

public void setText5(String text5) {
    text5__  = text5;
}

public String getText5() {
    return text5__ ;
}

//*****************List hairetu?

ArrayList<GroupModel> gpList＿ = new ArrayList<GroupModel>();


public void setGpList(ArrayList<GroupModel> gpList) {
    gpList＿ = gpList;
}

public ArrayList<GroupModel> getGpList() {
    return gpList＿ ;
}


//********************sch data

List<SchDataModel> schList＿ = new ArrayList<SchDataModel>();

public void setSchList(List<SchDataModel> schList) {
    schList＿ = schList;
}

public List<SchDataModel> getSchList() {
    return schList＿ ;
}


  }
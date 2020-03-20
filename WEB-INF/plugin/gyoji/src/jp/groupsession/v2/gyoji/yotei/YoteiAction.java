package jp.groupsession.v2.gyoji.yotei;

  import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;

  import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import jp.co.sjts.util.date.UDate;
import jp.groupsession.v2.cmn.GSConst;
import jp.groupsession.v2.cmn.dao.BaseUserModel;
import jp.groupsession.v2.cmn.dao.GroupModel;
import jp.groupsession.v2.cmn.dao.UsidSelectGrpNameDao;
import jp.groupsession.v2.sch.dao.SchDataDao;
import jp.groupsession.v2.sch.model.SchDataModel;
import jp.groupsession.v2.struts.AbstractGsAction;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.*;
import java.text.*;


  public class YoteiAction extends AbstractGsAction {

      /**
       * <br>[機  能] アクションを実行する
       * <br>[解  説]
       * <br>[備  考]
       * @param map ActionMapping
       * @param form ActionForm
       * @param req HttpServletRequest
       * @param res HttpServletResponse
       * @param con DB Connection
       * @return ActionForward
       * @throws Exception 実行時例外
       */
      public ActionForward executeAction(ActionMapping map,
                                          ActionForm form,
                                          HttpServletRequest req,
                                          HttpServletResponse res,
                                          Connection con)
          throws Exception {

     //     SchDataDao sDao = new SchDataDao(con);
           //  int cc=sDao.delete(3);
           //  System.out.print("sakujosu:"+cc);


    	 YoteiForm yoteiForm = (YoteiForm)form;

    	String t3= yoteiForm.getText();
        String t4= yoteiForm.getText4();
        String t5= yoteiForm.getText5();

         String path3="";
         String path4k="";
         String path5="";
     	String tmp3=null;

         try{
        	  path3 = this.getServlet().getServletContext().getRealPath("/WEB-INF/plugin/newplugin/excel_path.txt");
        	  path4k = this.getServlet().getServletContext().getRealPath("/WEB-INF/plugin/newplugin/excel_komoku.txt");
        	  path5 = this.getServlet().getServletContext().getRealPath("/WEB-INF/plugin/newplugin/gengo.txt");

           	 if (t3!=null && t3.length()!=0){
        		 FileWriter filewriter = new FileWriter(path3);
                 filewriter.write(t3);
                 filewriter.close();
        	 }


           	 if (t4!=null && t4.length()!=0){
             FileWriter filewriter2 = new FileWriter(path4k);
             filewriter2.write(t4);
             filewriter2.close();
           	 }

           	 if (t5!=null && t5.length()!=0){
                 FileWriter filewriter3 = new FileWriter(path5);
                 filewriter3.write(t5);
                 filewriter3.close();
               	 }

         }catch(Exception e){
        	 tmp3="Err:/WEB-INF/plugin/newplugin/excel_path.txtやexcel_komoku.txt,gengo.txtがありません";



         }





    	 String str3 = null;String str4k = null;String tmp4k=null;String tmp5=null;String str5=null;
    	 try{

        	 BufferedReader in3=new BufferedReader(new FileReader(path3));
        	 while((str3=in3.readLine())!=null) {
        	 tmp3=str3;
        	 }
        	 in3.close();

        	 BufferedReader in4k=new BufferedReader(new FileReader(path4k));
        	 while((str4k=in4k.readLine())!=null) {
        	 tmp4k=str4k;
        	 }
        	 in4k.close();

        	 BufferedReader in5=new BufferedReader(new FileReader(path5));
        	 while((str5=in5.readLine())!=null) {
        	 tmp5=str5;
        	 }
        	 in5.close();
    	 }catch(Exception e){

    	 }


          yoteiForm.setText(tmp3);
          yoteiForm.setText4(tmp4k);
          yoteiForm.setText5(tmp5);


          //*************************************
             return map.getInputForward();

         }








  }
package jp.groupsession.v2.newplugins.helloworlds;

  import java.sql.Connection;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jp.groupsession.v2.cmn.dao.GroupModel;
import jp.groupsession.v2.struts.AbstractGsAction;

import org.apache.struts.action.ActionForm;
import org.apache.struts.action.ActionForward;
import org.apache.struts.action.ActionMapping;

  import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.*;
import java.text.*;

import java.util.stream.Collectors;





import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;

import java.util.regex.Pattern;
import java.util.regex.Matcher;


import java.util.HashMap;
import java.util.Map;


  public class HelloWorldActions extends AbstractGsAction {

  String tmp;
  Integer nichi;
  static String Gengo;
  static int Gannen_Seireki;
//**********

  private  String TxtRead(String fname) {
	  String path3 = this.getServlet().getServletContext().getRealPath(fname);
	  String str3 = null;	String tmp3=null;
	  try {
		  BufferedReader in3=new BufferedReader(new FileReader(path3));
		  while((str3=in3.readLine())!=null) {
		  tmp3=str3;
		  	//System.out.println("/"+tmp3+"/"+"/");
		  }
		  in3.close();
	  }catch(Exception e) {
           tmp=tmp+fname+"がありません";
	  }

	  return tmp3;
  }



//*****************クラス内で使う関数******************
	  public static String ZtoH(String s) {
		    StringBuffer sb = new StringBuffer(s);
		    for (int i = 0; i < sb.length(); i++) {
		      char c = sb.charAt(i);
		      if (c >= '０' && c <= '９') {
		        sb.setCharAt(i, (char)(c - '０' + '0'));
		      }
		    }
		    return sb.toString();
		  }

	  public static String HtoZ(String str) {
	        if (str == null){
	            throw new IllegalArgumentException();
	        }
	        StringBuffer sb = new StringBuffer(str);
	        for (int i = 0; i < str.length(); i++) {
	            char c = str.charAt(i);
	            if ('0' <= c && c <= '9') {
	                sb.setCharAt(i, (char) (c - '0' + '０'));
	            }
	        }
	        return sb.toString();

	    }


	  public static boolean isNumber(String val) {
		  try {
			  Integer.parseInt(val);
			  return true;
		  } catch (NumberFormatException nfex) {
			  return false;
		  }
	  }

	  private static String nullShori(String s1) {
		  String s2;
		  if (s1==null) {
			  s2="";
		  }else {
			  s2=s1;
		  }
		  return s2;
	  }

	  private static String Cval(int dValue) {
			 Calendar cal = Calendar.getInstance();
     	 cal.set(1900, 0, 1, 12, 0, 0);

     	 //1900/1/1のシリアルが1なので、加算する値は取得した値 - 1になる
     	 int serial = dValue - 1;
     	 //1900/2/29は存在しないがエクセル内では存在しているらしいので
     	 //その日付以降であればさらに -1
     	 serial -= (serial > 60 ? 1 : 0);
     	 //基準日に加算
     	 cal.add(Calendar.DATE, serial);
     	 //確認のために表示
     	 String cellValue=String.format("%1$tm/%1$td",cal);
     	 return cellValue;
	  }

	  //****************************************************************************

	   private void sheetshori(int i,Workbook wb,String sfdate,String sfdate2,int fyear,int fmonth,String kname){
		    String tuki,hi[];
		    String gyo="";String gatu="";String dt="";String st[];String knm[];String nen;String his;
		    String mae,ato;
		    String[] w = {"日","月","火","水","木","金","土"};

		   Calendar today = new GregorianCalendar();
		   today.add(Calendar.DATE,-1);


		     Sheet sheet = wb.getSheetAt(i);
		        gatu=wb.getSheetName(i);//シート名は　○月の形式だとする
	      	tuki="00"+ZtoH(gatu).replace("月","");
	     	 tuki = tuki.substring(tuki.length()-2,tuki.length());


	 		  // 行数分繰返す
			        for (Row row : sheet) {
			           // out.print("<" + row.getRowNum()+"> ");
	                 gyo="";
			            for (Cell cell : row) {
			                String cellValue = null;
			                int cellType = cell.getCellType();

			                switch (cellType) {
			                case Cell.CELL_TYPE_NUMERIC:
			                    double dValue = cell.getNumericCellValue();
			                    cellValue = String.valueOf(dValue);
			                    break;
			                case Cell.CELL_TYPE_STRING:
			                    cellValue = cell.getStringCellValue();
			                    break;
			                default:
			                	 cellValue="";
			                    break;
			                }
			                // セル値の出力
			                //out.print(cellValue+",");
			                gyo=gyo+cellValue.replace(",","、")+",";
			            }
			            //月日がそろっているかチェック	 *************************************

		            	dt=tuki+"/"+gyo;
		            	st=dt.split(",",-1);
		            	st[0]=st[0].replace(".0", "");//  MM/D

		            	hi=st[0].split("/");
		            	if(hi.length>1)	{
		            	 hi[1]="00"+hi[1];//日付がないとエラーになる

		            	hi[1]=hi[1].substring(hi[1].length()-2,hi[1].length());
		            		// System.out.print("("+hi[1]+")");
		            	// }

		            	  his=hi[1];
		            	}else{
		            	  his="00";
		            	}

			            if (tuki.matches("[0-9][0-9]") && his.matches("[0-9][0-9]") && !(his.equals("00"))){ //月のシートで日付が０でないとき



			            		if (tuki.matches("[0-9][0-9]")){
			            			//今が４月～１１月、１月～３月であれば問題なし、スタート月１２月のときのみカレント月が１月は＋１年に
			            			if(fmonth==12 && Integer.parseInt(tuki)==1){
			            				nen=Integer.toString(fyear+1);
			            			}else {
			            				nen=Integer.toString(fyear);
			            			}
			            		}else{
			            			nen="0000";
			            			tuki="00";
			            			his="00";
			            		}



	                     //***********************************************************:
				            st[0]=nen+"/"+tuki+"/"+his; // YYYY/MM/DD に整形 エクセルから抽出したデータの日付

	                 	knm=kname.split(",");

			              if((st[0].compareTo(sfdate)>=0) && (st[0].compareTo(sfdate2)<=0) ){

			            	 //out.print(gatu+gyo+"<br>");
			            	  gyo="";

				            	for (int j=0;j<knm.length;j++){
				            	  if (j<st.length){// 項目か、データの少ない方にあわせて表示
				            		if (st[j].equals("") || knm[j].equals("") ){}else{

				 	            		gyo=gyo+"<span style=font-size:80%;>"+knm[j]+st[j]+"</span><br>";
				 	            		gyo=gyo.replaceAll("\n","<br>");
				            		}//if owari
				            	  }
				            	}// for owari


				            	if(st[1].length()<1){
				            		//曜日が取得できないときは、ここで計算
				            		today.add(Calendar.DATE, 1);
				            		int dayOfWeek = today.get(Calendar.DAY_OF_WEEK);
				            		st[1]=w[dayOfWeek-1];
				            	}
				            	 nichi=nichi+1;


				                switch(nichi){
				                   	case 1:
				                		mae="<b>明日　　";ato="";
				                		gyo=st[0].substring(st[0].length()-5,st[0].length())+"("+st[1]+")</b><br>"+gyo;
				                		break;
				                	case 2:
				                		mae="<b>明後日　";ato="";
				                		gyo=st[0].substring(st[0].length()-5,st[0].length())+"("+st[1]+")</b><br>"+gyo;
				                		break;
				                	default:
				                    	mae="<b>"+HtoZ(Integer.toString(nichi))+"日後　";ato="";
				                    	gyo=st[0].substring(st[0].length()-5,st[0].length())+"("+st[1]+")</b><br>"+gyo;
				                    	break;
				                }

				            	tmp=tmp+"<tt>"+mae+gyo+"<br>"+ato+"</tt>";

			              }// if owari hiduke kakunin
			            } //1gyo owari  日付がはいっているかチェックして実行

	 	       }// 1sheet owari


	   }

	//***************tsuruyoshori用の内部クラス
	   static class DtInfo {
		   public String gappi;
		   public int gyobango;
		   public String chohuku;
		   public ShtInfo shinf;



	        public void innerSample() {
	          //  System.out.println(str);
	        }
	    }

	   static class ShtInfo{
		  public int sheetbango;
		  public List<String> retumeiLst;
		  public int yusendo;

	   }
	   //***********************

		public static Cell getCell(Sheet sheet, int rowIndex, int columnIndex) {
			Row row = sheet.getRow(rowIndex);
			if (row != null) {
				Cell cell = row.getCell(columnIndex);
				return cell;
			}
			return null;
		}
		// セルの値をStringとして取得する例
		public static String getStringValue(Cell cell,int cct) {
			if (cell == null) {
				return null;
			}
			switch (cell.getCellType()) {
			case Cell.CELL_TYPE_STRING:
				return cell.getStringCellValue();
		//	case Cell.CELL_TYPE_NUMERIC:
		//		return Double.toString(cell.getNumericCellValue());
			case Cell.CELL_TYPE_NUMERIC:
                  int dValue = (int)cell.getNumericCellValue();
                  String cellValue="";
                  if(DateUtil.isCellDateFormatted(cell)) {

                       cellValue=Cval(dValue); //serail>mm/dd


                    } else {
                  	  if (dValue>31&&cct==0) {
                  		  cellValue=Cval(dValue); //serail>mm/dd
                  	  }else {
                  		  cellValue = String.valueOf(dValue);
                  	  }

                    }

                  return cellValue;

		//	case Cell.CELL_TYPE_BOOLEAN:
		//		return Boolean.toString(cell.getBooleanCellValue());
		//	case Cell.CELL_TYPE_FORMULA:
				// return cell.getCellFormula();
		//		return getStringFormulaValue(cell);
		//	case Cell.CELL_TYPE_BLANK:
		//		return getStringRangeValue(cell);
			default:
				//System.out.println(cell.getCellType()+":getcellType");
				return null;
			}
		}


		private static List<String> gyoStLst(Sheet sheet,int j) {  //指定行jの文字リスト取得
			List<String> gsl= new ArrayList<String>();
			Row row = sheet.getRow(j);
			for(int i=0;i<row.getLastCellNum();i++) {
				//  System.out.println("Col:"+i);
				gsl.add(nullShori(getStringValue(getCell(sheet,j,i),-1)));
			}
			return gsl;
		}

		private static boolean findSt(Sheet sheet,int j,String st) {		//指定文字 stが指定行jにあるかチェック
			List<String> gsl= new ArrayList<String>();
			 gsl= gyoStLst(sheet,j);//指定行の文字リスト取得

			 if(gsl.size()==0) {
				 return false;  //naitoki false
			 }else {
				 try {
					 String stx=gsl.stream().collect( Collectors.joining(""));
					 return stx.contains(st);  //あるときtrue
				 }catch(Exception e) {
					 return false;
				 }

			 }

		}

		private static int seireki(Sheet sheet,int j) { //指定行からあれば　和暦を変換して西暦で取得
			if(findSt(sheet,j,Gengo)) {
				List<String> gsl= new ArrayList<String>();
				gsl= gyoStLst(sheet,j);
				String srk=gsl.stream().filter(x->nenChushutu(x)>0).findFirst().orElse("");
				return nenChushutu(srk);
			}else {
				return 0;
			}

		}


        private static int nenChushutu(String str) {
        	String regex="";
        	if (str.isEmpty()) {
        		return 0;
        	}else {
        		try {
        			String chushutu="";
        			int gen=str.indexOf(Gengo);
        			int ned=str.indexOf("年度");
        			if (gen>=0 && ned>=0) {
        				chushutu=str.substring(gen+2,ned);
        			}

        			if (chushutu.equals("元")) {
        				return Gannen_Seireki;
        			}else {
        				int nen=0;
        				try {
        					nen=Integer.parseInt(ZtoH(chushutu))+Gannen_Seireki-1;
        				}catch(Exception e) {

        				}

        				return nen;
        			}


        		}catch(Exception e) {

        			return 0;
        		}

        	}

        }

	 //****************************
	   private void tsuruyoshori(Workbook wb){
            //シート情報取得
			int n = wb.getNumberOfSheets();
			List<DtInfo> dtinf=new ArrayList<DtInfo>();
			String sseireki="";
//***********************シート情報取得****************************************
			for (int i=0;i<n;i++) {
				   Sheet sheet = wb.getSheetAt(i);
				   ShtInfo stif=new ShtInfo();
				   int skipc=0;
				   boolean komokuflg=true;
				   int dmon=0;
				   int cseireki=0;
				   for(int j=0;j<sheet.getLastRowNum();j++)
					{


                      if (j==0) {//先頭行だけの処理

                    	 // tmp=tmp+"seireki="+Integer.toString(seireki(sheet,j));

                    	  cseireki=seireki(sheet,j);

                    	  if (findSt(sheet,j,"年度始")) {
                    		  dmon=4;
                    	  }
                    	  if (findSt(sheet,j,"年度末")) {
                    		  dmon=3;
                    	  }

                    	  if (findSt(sheet,j,"休業")) {
                    		  stif.yusendo=20;
                    	  }else {
                    		  stif.yusendo=i;
                    	  }


                      }

                     // System.out.println("gyo441");
                      String dt= nullShori(getStringValue(getCell(sheet,j,0),0));   //日付のみ取得
                      //System.out.println(dt+"<=dt gyo443");

                      int dday=0;
                      if(dt!="") {

                    	  if(dt.contains("/")) {
                        	  try {
                        		  dday=Integer.parseInt(dt.split("/")[1]);
                        		  dmon=Integer.parseInt(dt.split("/")[0]);
                        	  }catch(Exception e) {
                        		 // System.out.println(dt+"<=dt  er449:"+e.getMessage());
                        		  dday=0;
                        	  }

                          }else {
                        	  try {
                        		  dday=Integer.parseInt(dt);
                        	  }catch(Exception e) {
                        		 // System.out.println(dt+"<=dt er:457"+e.getMessage());
                        		  dday=0;
                        	  }
                          }
                      }

                      //System.out.println("gyo459");
                      if (j>0 && j<15 && dday>0 && komokuflg) {//項目名の取得 日付取得が開始なるまで 日付の最初のみ実行

                    	  if (!dt.contains("/")) {
                    		  tmp=tmp+"日付の先頭は月/日の形式にしてください:"
                    		  		+ "(sheet No."+(i+1)+")";
                    	  }
                    	  //System.out.println("sakusei:");
                    	  List<String> lstKomoku1=gyoStLst(sheet,j-2);
                    	  List<String> lstKomoku2=gyoStLst(sheet,j-1);
                    	  //System.out.println(lstKomoku1.stream().collect( Collectors.joining(":")));
                    	  //System.out.println(lstKomoku2.stream().collect( Collectors.joining(":")));
                    	//  int minlc=Math.min(lstKomoku1.size(),lstKomoku2.size());bug saidaini subeki
                    	  int minlc=Math.max(lstKomoku1.size(),lstKomoku2.size());
                    	  List<String> lstKomoku=new ArrayList<String>();
                    	  for (int ii=0;ii<minlc;ii++) {
                    		  String awaseS;
                    		  String s1="";
                    		  try {
                    			  s1=nullShori(lstKomoku1.get(ii));
                    		  }catch(Exception e1) {
                    			  s1="";
                    		  }
                              String s2="";
                              try {
                            	  s2=nullShori(lstKomoku2.get(ii));
                              }catch(Exception e2) {
                            	  s2="";
                              }

                              if (s1.length()>0&&s2.length()>0) {
                            	   awaseS=s1+"/"+s2;
                              }else {
                            	   awaseS=s1+s2;
                              }

                              lstKomoku.add(awaseS);
                    	  }

                          stif.retumeiLst =lstKomoku;
                          stif.sheetbango=i;

                    	  komokuflg=false;
                      }

                   	  if(dmon>0&&dmon<4) {
                		  sseireki=Integer.toString(cseireki+1);
                	  }else {
                		  sseireki=Integer.toString(cseireki);
                	  }


                      if(dday>0) {
                    	  DtInfo dtif=new DtInfo();

    					  dtif.gappi=sseireki+"/"+String.format("%02d", dmon)+"/"+String.format("%02d", dday);
    					  dtif.gyobango=j;
    					  dtif.shinf=stif;


    					 // tmp=tmp+dt+"("+j+")";
    					  dtinf.add(dtif);
                      }



					  if(dt=="") {
						  skipc++;
					  }else {
						  skipc=0;
					  }
					  if(skipc>5) {
						  break;
					  }
					}





			}

			//System.out.println("gyo556::::::::::::::");


		   //************** ここまでで、全シートの月日、行番号、（シート番号、列名,読み取り優先度）　のみ読み取る

			//************:ここから先　　１０日間のデータのみ取得する***********************

			Map<String, DtInfo> map = new HashMap<String, DtInfo>();

			for (int ix=0;ix<dtinf.size();ix++) {
				//System.out.println("gyo571:gappi="+dtinf.get(ix).gappi+"dtinf_yusendo("+ix+")="+dtinf.get(ix).shinf.yusendo);
				String dtx=dtinf.get(ix).gappi;
				//System.out.println("gyo568:dtx="+dtx);
			    if(map.containsKey(dtx)) {
			    	//System.out.println("gyo573:dtinf_yusendo="+dtinf.get(ix).shinf.yusendo+"<> map.yusendo="+map.get(dtx).shinf.yusendo);
			    	if(dtinf.get(ix).shinf.yusendo>map.get(dtx).shinf.yusendo) { //優先度高いものであれば、入れ替える
			    		map.remove(dtx);
			    		dtinf.get(ix).chohuku="*";// dtinf.get(ix).shinf.sheetbango+"を優先表示)";//重複ある時は*
			    		map.put(dtx,dtinf.get(ix));
			    		//System.out.println("gyo574:chohuku="+dtinf.get(ix).chohuku);
			    	}

			    }else {//新規の日付なら　追加
			    	dtinf.get(ix).chohuku="";//重複ない時は空文字
			    	map.put(dtx,dtinf.get(ix));
			    	//System.out.println("gyo580:");
			    }
				// tmp=tmp+dtinf.get(ix).shinf.retumeiLst.stream().collect(Collectors.joining(","));
				// tmp=tmp+"\n"+dtinf.get(ix).gappi+">"+dtinf.get(ix).gyobango+" "+gyoStLst(wb.getSheetAt(dtinf.get(ix).shinf.sheetbango),dtinf.get(ix).gyobango).get(2);
			}

			//System.out.println("gyo566:::::::::"+map.get("2019/12/01").gappi);

			//cal_s2からcal_eまで順に　日付をふやしながら　tmpに追加していく
	         SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
			   Calendar today = new GregorianCalendar();
			   today.add(Calendar.DATE,1);
			 String gyo;String mae;String hday;

	         for (int ic=0;ic<9;ic++) {
                 gyo="";mae="";hday="";
	        	 String tmpdt=format2.format(today.getTime());
	        	 if(map.containsKey(tmpdt)) {
	        	  	 DtInfo tmpDi=map.get(tmpdt);
	            	 List<String> gsl=gyoStLst(wb.getSheetAt(tmpDi.shinf.sheetbango),tmpDi.gyobango);
		        	 hday=tmpdt.split("/")[1]+"/"+tmpdt.split("/")[2]+"("+gsl.get(1)+")"+tmpDi.chohuku+"<br>";

		        	 //int mini=Math.min(gsl.size(), tmpDi.shinf.retumeiLst.size()); //列名の数か、該当行の数の小さいほうにあわせる？　bug
		        	 int mini=tmpDi.shinf.retumeiLst.size();
		        	 for (int jj=2;jj<mini;jj++){ //日付、曜日の列はスキップ
		        		try {
		        			String stmp=gsl.get(jj).replaceAll(" ","").replaceAll("　","").trim();
			        		 if (stmp.length()>0) {
			        				 gyo=gyo+"<b><span style=font-size:80%;>["+tmpDi.shinf.retumeiLst.get(jj)+"]</span></b><span style=font-size:80%;>"+gsl.get(jj).replaceAll("\n","<br>").trim()+"</span><br>";
			        		 }

		        		}catch(Exception e4) {//  tuika

		        		}


		        	 }


	        	 }else {
	        		gyo="Error:該当する日付のデータ行がありません。（エクセルデータ要確認）";
	        	 }

	        	  switch(ic+1){
                 	case 1:
                 		mae="<b>明日　　"+hday+"</b>";
              			break;
                 	case 2:
                 		mae="<b>明後日　"+hday+"</b>";
              			break;
                 	default:
                 		mae="<b>"+HtoZ(Integer.toString(ic+1))+"日後　"+hday+"</b>";
                  		break;
              }

	        	 tmp=tmp+"<tt>"+mae+gyo+"<br></tt>";
	        	 today.add(Calendar.DATE,1);

	         }





	   }




//*************************************************
public ActionForward executeAction(ActionMapping map,
                                          ActionForm form,
                                          HttpServletRequest req,
                                          HttpServletResponse res,
                                          Connection con)
          throws Exception {

	  tmp="";

     	 HelloWorldForms helloworldForms = (HelloWorldForms)form;
        // String tmp=yoteiForm.getText();

 //******************************************hyoji bu shori****************




     	   GregorianCalendar cal = new GregorianCalendar();

         SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");

         String datestr_s = format2.format(cal.getTime());
         cal.add(Calendar.DATE,1);
             String datestr_s2 =format2.format(cal.getTime());
         cal.add(Calendar.DATE,8);
         String datestr_e = format2.format(cal.getTime());


 		    String freset="false";




			 Calendar calendar = Calendar.getInstance();
			    int hour = calendar.get(Calendar.HOUR_OF_DAY);
			    int minute = calendar.get(Calendar.MINUTE);
			    int cmin=hour*60+minute;//現在時刻　整数値




try	{


	String tmp3=TxtRead("/WEB-INF/plugin/newplugin/excel_path.txt");
	String tmp4k=TxtRead("/WEB-INF/plugin/newplugin/excel_komoku.txt");
	String[] tmpGG=TxtRead("/WEB-INF/plugin/newplugin/gengo.txt").split(",");
	 Gengo=tmpGG[0];
	 Gannen_Seireki=Integer.parseInt(tmpGG[1]);


   // System.out.print(Gengo+"=Gengo");
	//tmp=tmp+Gengo+"<=Gengo";


		String kname = tmp4k;
//******************************************************

		File fl =new File(tmp3);
		if (fl.exists()){
			 InputStream inp = new FileInputStream(tmp3);

			    //（2）入力ファイルを表すワークブックオブジェクトの生成
			    Workbook wb= WorkbookFactory.create(inp);

			    Calendar ffday  = new GregorianCalendar();
			    int fyear=ffday.get(Calendar.YEAR);
			    int fmonth=ffday.get(Calendar.MONTH)+1;//今月


					//高速化のため、今月、１０日分表示では、今月と来月しか読み込まない
					//************シートは４月から順に並んでいる必要あり
					Integer sm;//シート読み取り開始
					Integer em;//シート読み取り終了
					sm=fmonth-4;
					em=fmonth-3;
					if(fmonth>0 && fmonth<=3){
						sm=fmonth+8;
						em=fmonth+9;
					}


					  nichi=0;


					   String gatu=wb.getSheetName(0);//シート名は　先頭が４月なら　定型処理
			         	String tuki=gatu.replace("月","");

		                //System.out.print(tuki);

			         	if(tuki.equals("4")||tuki.equals("４")) {// teikeishori
			         			for (int i = 0; i <= 12; i++) {
		                          if (i==sm||i==em){
		    				     	  sheetshori(i % 12,wb,datestr_s2,datestr_e,fyear,fmonth,kname);
		                          }
			         			}

		            	 }else {// tsuruyoshori

		            		          tsuruyoshori(wb);

		            	 }






			       inp.close();

		}else{
			 //System.out.println(path3+":見つかりません！");
			 //out.print("<tt>*****</tt>\t<tt>予定表示のためには["+tmp3+"]のファイルが必要です</tt>");
		 tmp=tmp+"<tt>*****</tt>\t<tt>予定表示のためには["+tmp3+"]のファイルが必要です。「予定の設定」を再確認してください。</tt>";
		}


	} catch (Exception e) {
		//System.out.println("エラー！予定ファイルの項目の設定は、実際のファイルと対応していますか？");
		//out.print("<tt>読み取りエラー。エクセル形式が違います。シート数が13か確認してください。</tt>");
         tmp=tmp+"<tt>読み取りエラー。エクセル形式が違う可能性があります。"+e.getMessage()+"</tt>";
		//e.printStackTrace();
	}





//*********************************************hyojibu shori owari***************
       helloworldForms.setText(tmp);


        return map.getInputForward();

}


  }
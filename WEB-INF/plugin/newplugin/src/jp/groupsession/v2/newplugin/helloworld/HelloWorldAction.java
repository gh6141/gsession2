package jp.groupsession.v2.newplugin.helloworld;

  import java.sql.Connection;



import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
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
import java.util.*;
import java.text.*;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.DateUtil;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellReference;



import java.util.stream.Collectors;
import java.util.stream.IntStream;




  public class HelloWorldAction extends AbstractGsAction {

	  static String	 Gengo;
      static int Gannen_Seireki;
      static String tmp;

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


//*****************クラス内で使う関数******************test
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


		//***************tsuruyoshori用の内部クラス
	   static class DtInfo {
		   public String gappi;
		   public int gyobango;
		   public String chohuku;
		   public ShtInfo shinf;


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
				 String stx="";
				 try {
					 stx=gsl.stream().collect( Collectors.joining(""));
					// System.out.println("gyo206:stx="+stx);
					 return stx.contains(st);  //あるときtrue
				 }catch(Exception e) {
					 //System.out.println("gyo210:st="+st+" stx="+stx);
					 return false;
				 }

			 }

		}

//*****************************************************************************************************************************
	  private static String teikeishori(Workbook wb,String month) {
		   String tmp="";
		    String tuki,hi[];
		    Integer konnendo;

		    Calendar ffday  = new GregorianCalendar();
		    int fyear=ffday.get(Calendar.YEAR);
		    konnendo=fyear;
		    int fmonth=ffday.get(Calendar.MONTH)+1;//今月
		    if (fmonth<=3) konnendo=konnendo-1;

 		   String gatu="";

 		   Integer sm=Integer.parseInt(month)-4;

					if(Integer.parseInt(month)>0 && Integer.parseInt(month)<=3){
						sm=Integer.parseInt(month)+8;

					}

					if (Integer.parseInt(month)==4 && fmonth==3){//３月に次の４月シートを表示させるため
						sm=12;

					}


			        Sheet sheet = wb.getSheetAt(sm);
			        gatu=wb.getSheetName(sm);//シート名は　○月の形式だとする
		         	tuki="00"+ZtoH(gatu).replace("月","");
	            	 tuki = tuki.substring(tuki.length()-2,tuki.length());


            		  if(month.equals(tuki)){

            			  //out.print("<div><table id=hyo width=95% border=1 style='font-size:12px;border-collapse:collapse;'>");
                           tmp=tmp+"<div><table id=hyo width=95% border=1 style='font-size:12px;border-collapse:collapse;'>";

            			  for (Row row : sheet) {//各行移動
					       //out.print("<tr>");
					      tmp=tmp+"<tr>";
            				  int cct=0;
					            for (Cell cell : row) {//各セル移動
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
					                cellValue=cellValue.replace(".0","").replace(",","、");

					                	String width="";
					                	switch (cct){
					                	case 0:
					                		width="width=25";
					                		break;
					                	case 1:
					                		width="width=15";
					                		break;

					                	default:
					                		width="";
					                		break;
					                	}

					                	//out.print("<td "+width+" align=left>"+cellValue+"</td>");
					                   tmp=tmp+"<td "+width+" align=left>"+cellValue+"</td>";


					                cct=cct+1;
					            }
					            //out.print("</tr>");
					            tmp=tmp+"</tr>";

	            	       }
            		   //out.print("</table><div>");
            		   tmp=tmp+"</table><div>";
            		  }

          	 List<String> TkStLst= List.of("04","05","06","07","08","09","10","11","12","01","02","03");
   			 String mon=month;
   			 String opts=TkStLst.stream().map(x -> mon.equals(x) ? "<option value=\""+x+"\" selected >"+x+"月</option>" :	"<option value=\""+x+"\" >"+x+"月</option>" )
   			 .collect(Collectors.joining(" "));
   			 tmp= "<div style=\"margin-left:10px;padding-left=10px;\"><form method=\"post\" action=\"#\">" +
   			 	  		"<select property=\"opt\" name=\"opt\" onchange=\"submit(this.form)\">"+
   			 				opts+
   			 			"</select>"
   			 		+ "</form><div>"+tmp;


		  return tmp;
	  }

	  //*************************
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

        private static Map<String, DtInfo> datemap(Workbook wb) {
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
                    	 // System.out.println("gyo392:"+cseireki);

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

                      //System.out.println("gyo441");
                      String dt= nullShori(getStringValue(getCell(sheet,j,0),0));   //日付のみ取得
                    //  System.out.println(dt+"<=dt gyo443");

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
                    	  int minlc=Math.min(lstKomoku1.size(),lstKomoku2.size());
                    	  List<String> lstKomoku=new ArrayList<String>();
                    	  for (int ii=0;ii<minlc;ii++) {
                    		  String awaseS;
                              String s1=nullShori(lstKomoku1.get(ii));
                              String s2=nullShori(lstKomoku2.get(ii));
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

    					  //System.out.println("gyo480:gappi="+dtif.gappi+"sheetbango="+dtif.shinf.sheetbango);

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

			return map;
        }


	  //*************************************

	  private static String tsuruyoshori(Workbook wb,String month) {
		 //System.out.print("1:");
tmp="";
		  try {

			  //System.out.println("gyo545: month="+month);
			     String mon=month;

			     List<String>  TkStLst=IntStream.range(0, wb.getNumberOfSheets())
	            .mapToObj(wb::getSheetAt)
	            .map(Sheet::getSheetName)
	            .collect(Collectors.toList());

                 Sheet sheet=null;
                 int sidx=sheet_idx(wb,month,TkStLst);
                // System.out.println("gyo555: month="+month+" sidx="+sidx);
                 if(sidx==-1) {
                	// sheet = wb.getSheetAt(0);//month（シート名）の一致するものが見つからないときは、今日の日付からシートをさがす
                	 Map<String, DtInfo> map = datemap(wb);

                  	SimpleDateFormat format2 = new SimpleDateFormat("yyyy/MM/dd");
                    Calendar today = new GregorianCalendar();
		        	 String tmpdt=format2.format(today.getTime());
		        	 //System.out.println("gyo562: tmpdf="+tmpdt+" map_no_gappi="+map.get(tmpdt).gappi+" map_shinf.sheetbango="+map.get(tmpdt).shinf.sheetbango);
		        	// System.out.println("gyo562: tmpdf="+tmpdt);
		        	 if(map.containsKey(tmpdt)) {
		        	  	 DtInfo tmpDi=map.get(tmpdt);
		                 month=TkStLst.get(tmpDi.shinf.sheetbango);
		                 sheet = wb.getSheetAt(tmpDi.shinf.sheetbango);
		        	 }else {
		        		tmp=tmp+"Error:今日の日付のデータ行がありません。（エクセルデータ要確認）";
		        		sheet = wb.getSheetAt(0);
		        	 }

                 }else {
                	 sheet = wb.getSheetAt(sheet_idx(wb,month,TkStLst));
                 }


				// System.out.print("2:");

			     List<CellRangeAddress> rangeLst=new ArrayList<CellRangeAddress>();
				 //System.out.print("3a:");



	             for(int i=0;i<sheet.getNumMergedRegions();i++) {
	            //	 System.out.print(""+i);
	            	 rangeLst.add(sheet.getMergedRegion(i));
	             }

		        // List<CellRangeAddress> rangeLst = IntStream.range(0, sheet.getNumMergedRegions()).map( i ->  sheet.getMergedRegion(i)  ).collect(Collectors.toList());

			     //IntStream.range(0, sheet.getNumMergedRegions()).forEach(i->System.out.println(sheet.getMergedRegion(i).getFirstRow()));

	     			  //out.print("<div><table id=hyo width=95% border=1 style='font-size:12px;border-collapse:collapse;'>");

	        	 //System.out.print("3b:");
	                    tmp=tmp+"<center><div><table id=hyo width=95% border=1 style='font-size:12px;border-collapse:collapse;'>";
	                 int yi=0;
	                 int kugyo=0;
	                 boolean flg=true;
	     			  for (Row row : sheet) {//各行移動
					       //out.print("<tr>");
                          flg=true;
					      tmp=tmp+"<tr>";
	     				  int cct=0;

					            for (Cell cell : row) {//各セル移動
					                String cellValue = null;
					                int cellType = cell.getCellType();

					                switch (cellType) {
					                case Cell.CELL_TYPE_NUMERIC:
					                    int dValue = (int)cell.getNumericCellValue();

					                    if(DateUtil.isCellDateFormatted(cell)) {

					                         cellValue=Cval(dValue); //serail>mm/dd


					                      } else {
					                    	  if (dValue>31&&cct==0) {
					                    		  cellValue=Cval(dValue); //serail>mm/dd
					                    	  }else {
					                    		  cellValue = String.valueOf(dValue);
					                    	  }

					                      }

					                    break;
					                case Cell.CELL_TYPE_STRING:
					                    cellValue = cell.getStringCellValue();
					                    break;
					                default:
					                	 cellValue="";
					                    break;
					                }
					                // セル値の出力
					                cellValue=cellValue.replace(".0","").replace(",","、");

					                	String width="";
					                	switch (cct){
					                	case 0:
					                		width="width=25";
					                		break;
					                	case 1:
					                		width="width=15";
					                		break;

					                	default:
					                		width="";
					                		break;

					                	}
					                	//out.print("<td "+width+" align=left>"+cellValue+"</td>");

					                	String cksr=cellketugoshori(cct,yi,width,rangeLst,cellValue);
					                	if (cksr.replaceAll("<.+?>", "").isEmpty()) {
					                		flg=flg&&true;
					                	}else {
					                		flg=flg&&false;
					                	}
	                                  tmp=tmp+ cksr;
					                  // tmp=tmp+"<td "+width+" align=left>"+cellValue+"</td>";


					                cct=cct+1;
					            }
					            //out.print("</tr>");


					            tmp=tmp+"</tr>";
	                     yi++;

				            if(flg==true) {
				            	kugyo++;
				            }else {
				            	kugyo=0;
				            }
				            if(kugyo>4) {
				            	break;
				            }



	         	       }
	     		   //out.print("</table><div>");
	     		   tmp=tmp+"</table><div></center>";


	     			// System.out.print("3L:");

                 String mon2=month;
	   			 String opts=TkStLst.stream().map(x -> mon2.equals(x) ? "<option value=\""+x+"\" selected >"+x+"</option>" :	"<option value=\""+x+"\" >"+x+"</option>" )
	   			 .collect(Collectors.joining(" "));
	   			 tmp= "　　<form method=\"post\" action=\"#\" <div style=\"margin-left:10px;padding-left=10px;\">" +
	   			 	  		"<select property=\"opt\" name=\"opt\" onchange=\"submit(this.form)\">"+
	   			 				opts+
	   			 			"</select>"
	   			 		+ "</form>"+tmp;



		  }catch(Exception e) {
			  tmp=tmp+e.getMessage();
			  System.out.print("error:gyo704");
		  }


	   return tmp;
	  }

	  private static int sheet_idx(Workbook wb,String month,List<String> TkStLst) {


		     String mon=month;
		     int index = IntStream.range(0, TkStLst.size()).filter(i->TkStLst.get(i).equals(mon)).findAny().orElse(-1);
		     return index;
	  }


	  private static String cellketugoshori(int cct,int yi,String width, List<CellRangeAddress> rangeLst,String cellValue) {

		  // final int size = sheet.getNumMergedRegions();
	        //    for (int i = 0; i < size; i++) {
	        //        final CellRangeAddress range = sheet.getMergedRegion(i);
	        //        final int firstRow = range.getFirstRow();
	        //        final int firstColumn = range.getFirstColumn();
	        //        final int lastRow = range.getLastRow();
	        //        final int lastColumn = range.getLastColumn();
	               // System.out.println("結合セル" + (i + 1) + "個目");
	               // System.out.println("開始：" + CellReference.convertNumToColString(firstColumn) + (firstRow + 1));
	               // System.out.println("終了：" + CellReference.convertNumToColString(lastColumn) + (lastRow + 1));
	                // セルの左上の値を取得
	                // 左上のセル以外にもし値が入っていても表示上見えないはずなので無視する
	            //    final Row row = sheet.getRow(firstRow);
	              //  if (row != null) {
	             //      System.out.println("値：" + getCellValue(row.getCell(firstColumn)));
	              //  }
	               // System.out.println("--------------------------------------------");
	          //  }
			String cst="";

		  try {
				String LTdt=  rangeLst.stream().filter(x->x.getFirstRow()==yi&&x.getFirstColumn()==cct).map(x->cct+","+yi+","+x.getLastColumn()+","+x.getLastRow()).findAny().orElse("");
		        String LTdt2= rangeLst.stream().filter(
		        		x->x.getFirstRow()<yi && x.getLastRow()>=yi && x.getFirstColumn()<cct && x.getLastColumn()>=cct
		        		   || x.getFirstRow()==yi && x.getFirstColumn()<cct && x.getLastColumn()>=cct
		        		   || x.getFirstRow()<yi && x.getLastRow()>=yi && x.getFirstColumn()==cct
		        		).map(x->"DEL").findAny().orElse("");


		        if(LTdt.isEmpty()&&LTdt2.isEmpty() ) { //左上でない　かつ　結合範囲にない

		        	cst="<td "+width+" align=left>"+cellValue+"</td>";


		        }else if(!LTdt.isEmpty()&&LTdt2.isEmpty()){//左上である　かつ　結合範囲にない
		        	String CrSt[]=LTdt.split(",");
		        	String tdst="";
		        	if(!CrSt[0].equals(CrSt[2])) {
		        		tdst=" colspan=\""+  ( Integer.parseInt(CrSt[2])-Integer.parseInt(CrSt[0]) +1 )+"\"";
		        	}
		        	if(!CrSt[1].equals(CrSt[3])) {
		        		tdst=tdst+" rowspan=\""+  ( Integer.parseInt(CrSt[3])-Integer.parseInt(CrSt[1]) +1 )+"\"";
		        	}
		        	cst="<td "+width+" align=left "+tdst+">"+cellValue+"</td>";
		        }

		        else if(LTdt.isEmpty()&&!LTdt2.isEmpty()){//左上でない　かつ　結合範囲である

		        	cst="";

		        }else {		  //左上である　かつ　結合範囲である
		        	cst=""; //ここはありえない

		        }

		  }catch(Exception e) {
			  System.out.print(e.getMessage());
		  }




		  return cst;
	  }


	  //*********************************************************************************************************************
      public ActionForward executeAction(ActionMapping map,
                                          ActionForm form,
                                          HttpServletRequest req,
                                          HttpServletResponse res,
                                          Connection con)
          throws Exception {

     	 HelloWorldForm helloworldForm = (HelloWorldForm)form;



     	  GregorianCalendar cal = new GregorianCalendar();
          SimpleDateFormat format2 = new SimpleDateFormat("MM");
          String datestr_s = format2.format(cal.getTime());
          String hget=helloworldForm.getOpt();
//System.out.print("1:"+datestr_s);
//System.out.print("2:"+ helloworldForm.getOpt());

          String month="00";
          if(hget==null||hget.length()==0)
          {
        	  month=datestr_s;
          }else{
        	  month=hget;
          }



     	 String tmp= helloworldForm.getText();
 //******************************************hyoji bu shori****************


 		    String freset="false";


		    String[] w = {"日","月","火","水","木","金","土"};





String tmp3=TxtRead("/WEB-INF/plugin/newplugin/excel_path.txt");
String tmp4k=TxtRead("/WEB-INF/plugin/newplugin/excel_komoku.txt");
String[] tmpGG=TxtRead("/WEB-INF/plugin/newplugin/gengo.txt").split(",");
Gengo=tmpGG[0];
Gannen_Seireki=Integer.parseInt(tmpGG[1]);

try	{

		//tmp3: xlsx file path;

//******************************************************

		File fl =new File(tmp3);
		if (fl.exists()){


			 InputStream inp = new FileInputStream(tmp3);

			    //（2）入力ファイルを表すワークブックオブジェクトの生成
			    Workbook wb	 = WorkbookFactory.create(inp);

		        String gatu=wb.getSheetName(0);//シート名は　先頭が４月なら　定型処理
	         	String tuki=gatu.replace("月","");

                //System.out.print(tuki);

            	 if(tuki.equals("4")||tuki.equals("４")) {
            		 tmp=tmp+teikeishori(wb,month);
            	 }else {


            		 tmp=tmp+tsuruyoshori(wb,month);//monthには、シート名を指定する
            		 //System.out.print("tsuruyo");
            		// tmp="tsuruyo:"+tmp;
            	 }



			       inp.close();


		}else{
			 //System.out.println(path3+":見つかりません！");
			 //out.print("<tt>*****</tt>\t<tt>予定表示のためには["+tmp3+"]のファイルが必要です</tt>");
		 tmp=tmp+"<tt>*****</tt>\t<tt>予定表示のためには["+tmp3+"]のファイルが必要です</tt>";
		}


	} catch (Exception e) {
         tmp=tmp+"<tt>読み取りエラー。エクセル形式が違います。"+e.getMessage()+"</tt>";
		//　１３以外のシートのときこちらで処理





	}



//*********************************************hyojibu shori owari***************



       helloworldForm.setText(tmp);
       helloworldForm.setOpt(month);


        return map.getInputForward();

}


  }
package cn.nova.bus.base.service.impl;

import cn.nova.bus.base.dao.TicketPrintDao;
import cn.nova.bus.base.model.Ticketprint;
import cn.nova.bus.ticketprint.param.TicketPrintParam;

public class TicketPrintStrServiceImpl {
     private TicketPrintDao dao = new TicketPrintDao();
     
     public String getPrintStrByTicketno( String ticketno) {
    	 
    	 TicketPrintParam param = dao.getPrintParam(ticketno);

    	 return genPrintStr(param);
     }
     
     private String genPrintStr(TicketPrintParam param ) {
 		
    	Ticketprint ticketprint = dao.getTicketprint();
    	if(ticketprint == null) {
    		return null;
    	}
    	
    	String printmode = ticketprint.getValue();
    	
 		//用来按字符遍历
 		char[] modearray = printmode.toCharArray();
 		StringBuilder builder = new StringBuilder();
 		
 		int j = 0; //记录起始位置或者‘#’字符之后的位置
 		for(int i=0; i<modearray.length; i++) {
 			
 			if(modearray[i] != '@') {
 				continue;
 			}
 			//copy modearray j到i间的字符到builder
 			builder.append(modearray, j, i-j);
 			
 			//解析@与#间的值，并添加到builder
 			parseindex(modearray, i, param, builder);
 			
 			//i跳转到#之后
 			for(; i<modearray.length; i++) {
 				if(modearray[i] == '#') {
 					break;
 				}
 			}		
 			j=i+1;
 									
 		}
 			
 		return builder.toString();
 	}
 	
 	//解析@与#之间的值
 	private void parseindex(char[] array, int startindex, TicketPrintParam param, StringBuilder builder) {
 		char[] codeArray = new char[10];
 		char[] lengthArray = new char[10];
 		
 		startindex = startindex + 1;
 		int i=0, j=0;
 		for(i=startindex; i<array.length; i++) {
 			
 			if(array[i] != ',') {
 				codeArray[j]=array[i];
 				j++;
 			}else {
 				codeArray[j]='\0';
 				break;
 			}
 		}
 		
 		
         for(j=0, i=i+1; i<array.length; i++) {
 			
 			if(array[i] != '#') {
 				lengthArray[j]=array[i];
 				j++;
 			}else {
 				lengthArray[j] = '\0';
 				break;
 			}
 		}
 		
         //
         String printcode = arrayToStr(codeArray);
         String lengthStr = arrayToStr(lengthArray);
         int printlength = Integer.valueOf(lengthStr);
         //票号
         if(printcode.equals("PH")) {
         	String ticketno = param.getTicketno();
         	builder.append(ticketno);
         	appendSpace(builder, printlength-ticketno.length());
         }
         //到达站
         if(printcode.equals("DDZ")) {
         	String reachStation = param.getReachStation();
         	builder.append(reachStation);
         	appendSpace(builder, printlength-reachStation.length());
         }
         //发车日期
         if(printcode.equals("FCRQ")) {
         	String departdate = param.getDepartdate();
         	builder.append(departdate);
         	appendSpace(builder, printlength-departdate.length());
         }
            
         		
 	}
 	
 	//定长array直接转换为字符串时，会出错误结果
 	private String arrayToStr(char array[]) {
 		StringBuilder builder = new StringBuilder();
 		
 		for(int i=0; i<array.length; i++) {
 			if(array[i] != '\0') {
 				builder.append(array[i]);
 			}else {
 				break;
 			}
 		}
 		
 		return builder.toString();
 		
 	}
 	
 	//添加空格
 	private void appendSpace(StringBuilder builder, int count){
 		
 		for(int i=0; i<count; i++) {
 			builder.append(' ');
 		}
 	}
     
}

package controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.persistence.Entity;

//import org.apache.cxf.binding.corba.wsdl.Array;

import play.db.jpa.JPA;

public class TvScheduleAction extends BaseController {
	private static int  PAGESIZE=7;
	public static void tvSchedule(String index,int pagesize) {
		pagesize=pagesize==0?PAGESIZE:pagesize;
		String sql="select code,endstation,departtime,vehcilepark,status,ticketentrance  from tv_hcs_window where ticketentrance like '"+index+"%'";
		List<Object[]> results=JPA.em().createNativeQuery(sql).getResultList();
		if(results==null){
			results=new ArrayList<Object[]>();
		}
		List<List<Object[]>> datas=new ArrayList<List<Object[]>>();
		List<Object[]> data=new ArrayList<Object[]>();
		for(int i=0;i<results.size();i++){
			data.add(results.get(i));
			if(((i+1)%pagesize==0&&i!=0)||i==results.size()-1){
				datas.add(data);
				data=new ArrayList<Object[]>();
			}
		}
		renderArgs.put("datas", datas);
		render("/Application/schedule.html");
	}
	public static void index(){
		render("/Application/tvSchedule.html");
	}

}

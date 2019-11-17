package cn.nova.bus.datasource.plugin;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.Logger;
import play.db.jpa.JPA;
import play.mvc.Scope.Session;
import plugin.DSPluginInterface;
import util.CommonUtil;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.TypeReference;

public class HolidayBalancePlugin implements DSPluginInterface{

	String tempTable_name ="";
	public void prepareTempTable(String params) {
		String  departdatebegin= null;
        String  departdateend= null;
        String  orgids= null;
        String  workovertimes= null;
        String  vehicleworktypes= null;
        Long  unitid= null;
        Long  balanceunitid= null;
        Long  vehicleid= null;
        String  departinvoicesno= "";
        Long routeid = null;
        Long schedulecode = null;
        
        //获取查询参数
        Map<String, String> paramMap = JSON.parseObject(params, new TypeReference<Map<String,String>>(){});
        for(String key : paramMap.keySet()) {
            String subkey= key.split("#")[1];
            String value = paramMap.get(key);
            if("t!departdate".equals(subkey)){
                departdatebegin = value.split("&")[0].replaceAll("-", "");
                departdateend  =  value.split("&")[1].replaceAll("-", "");
                
            }else if("t!orgids".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		orgids = "(" + value.replaceAll("&", ",") + ")";
            	}else{
            		Query query =JPA.em().createNativeQuery("select org.id from organization org where org.isactive = 1 and org.type in (0,1,2)");
            		query.executeUpdate();
            		List list = query.getResultList();
            		orgids = Object2Str(list);
            	}
            }else if("t!workovertimes".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		workovertimes = "(" + value.replaceAll("&", ",") + ")";
            	}else {
            		workovertimes=" (0,1) ";
            	}
            }else if("v!vehicleworktypes".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){	
            		vehicleworktypes = "(" + value.replaceAll("&", ",") + ")";
            	}else {
            		Query query =JPA.em().createNativeQuery("select td.code from digitaldictionary t, digitaldictionarydetail td  where t.id = td.digitaldictionaryid    and t.tablename = 'vehicle'    and t.columnname = 'type'");
            		query.executeUpdate();
            		List list = query.getResultList();
            		vehicleworktypes =Object2Str(list);
            	}
            }else if("t!unitid".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		unitid = Long.parseLong(value);
            	}
            }else if("t!balanceunitid".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		balanceunitid =  Long.parseLong(value);
            	}
            }else if("t!vehicleid".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		vehicleid =  Long.parseLong(value);
            	}
            }else if("t!departinvoicesno".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		departinvoicesno = value;
            	}
            	
            }else if("t!routeid".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		routeid =  Long.parseLong(value);
            	}
            }else if("t!schedulecode".equals(subkey)){
            	if(CommonUtil.isNotEmptyString(value)){
            		schedulecode =  Long.parseLong(value);
            	}
            }  
        }
        String str = "{call querybalanceupfloat('"+departdatebegin+"','"+departdateend+"','"+orgids+"','"+workovertimes+"','"+vehicleworktypes+"',"+unitid+","+balanceunitid+","+vehicleid+",'"+departinvoicesno+"',"+routeid+","+schedulecode+",'"+tempTable_name+"')}";
        Query query = JPA.em().createNativeQuery(str);
        query.executeUpdate();
       
	}
	
	@Override
	public String getSql(String params, boolean isPagination) {
		
		String sessionid=Session.current().getId();
		tempTable_name="hoyb_" + sessionid.hashCode();
		if (!isPagination) //如果是查询则执行存储过程
		{
			RegisterTempTable();
			prepareTempTable(params);
		}
		String sql="Select * from " + tempTable_name;
		return sql;
	}

	private void RegisterTempTable()
	{
		JPA.em().createNativeQuery("delete tmp_table where tablename = '" + tempTable_name + "'").executeUpdate();
		JPA.em().createNativeQuery("Insert into tmp_table (ID,SessionID,TableName,CreateBy,UserID) values(SEQ_PUB.nextval, " + "'reportsession','" + tempTable_name +"',101,101)").executeUpdate();
		try
		{
			JPA.em().createNativeQuery("Drop Table " + tempTable_name).executeUpdate();
		}
		catch(Exception e)
		{
		}
		
		
	}

	@Override
	public String getCountSql(String params) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String getSummarysql(String params) {
		String str = "select cast('合计' as varchar(10)),sum(departnum),sum(departamount),sum(upfloatamount) from  "+ tempTable_name;
		return str;
	}
	public String Object2Str(List list){
		Object [] objs=list.toArray();
		StringBuilder sb = new StringBuilder();
		sb.append("(");
		for(Object o:objs){
			sb.append(o.toString());
		    sb.append(",");
		}
		sb.deleteCharAt(sb.length()-1);
	    sb.append(")");
	    return sb.toString();
	}
	

	
}

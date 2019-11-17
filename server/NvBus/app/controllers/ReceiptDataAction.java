package controllers;

import models.Result;
import bp.ReceiptDataBP;
import bpinterface.ReceiptDataInterface;

import com.alibaba.fastjson.JSON;

public class ReceiptDataAction extends Application {

	public static void save(String formkey,String params,String items,String delids) throws Exception{
		ReceiptDataInterface receiptbp = new ReceiptDataBP();
		Result result = receiptbp.save(formkey, params,items,delids);
		if(validation.hasErrors()){
			response.status = 550;
			renderText(JSON.toJSONString(validation.errors()));
		}
		renderText(JSON.toJSONString(result));
	}

	public static void delete(String formkey,String ids) {
		ReceiptDataInterface receiptbp = new ReceiptDataBP();
		Result result = receiptbp.bulkDelete(formkey, ids);
		renderText(JSON.toJSONString(result));
	}
}

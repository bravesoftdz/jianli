package controllers;

import java.util.HashMap;
import java.util.Map;

import util.Encryption;

public class EncryptionAction extends BaseController {

	public static void chk() {
		String urlparam=request.url;
		//System.out.println("urlparam:"+urlparam);		
		urlparam=urlparam.substring(urlparam.indexOf("?")+1, urlparam.length());
		String[] paramArray = urlparam.split("&");
		Map<String,String> temp = new HashMap<String,String>();
		for(String s : paramArray){
			if(s.contains("=")){
				String key = s.substring(0, s.indexOf("="));
				String value = s.substring(s.indexOf("=")+1, s.length());
				temp.put(key, value);
			}
		}
		String dsstr=temp.get("dsstr");
		String tikstr=temp.get("tikstr");
		if (Encryption.chkTicketno(dsstr, tikstr)) {
			renderText("1");
		} else {
			renderText("0");
		}
	}

}

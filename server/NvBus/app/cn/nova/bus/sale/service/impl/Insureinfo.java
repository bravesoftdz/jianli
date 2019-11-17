package cn.nova.bus.sale.service.impl;

import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.dom4j.Document;
import org.dom4j.DocumentHelper;
import org.dom4j.Element;

import cn.nova.utils.commons.ThreeDES;

public class Insureinfo {

	public static final String XML = "<?xml version=\"1.0\" encoding=\"GBK\"?>";
//	public static final String REQUESTURL = "http://e.picclife.com:7002/picc/Policy/ProcessPartnerRequest.jspx?type=tradeParter";
//	public static final String CANCELURL = "http://e.picclife.com:7002/picc/Policy/ProcessPartnerCanelPolicyRequest.jspx?type=tradeParter";

	private String fullname;// 乘客姓名
	private String govtID;// 证件号
	private String productCode;// 保险产品代码
	private String transExeTime;// 交易时间
	private String departdate;// 发车日期
	private String transExeDate;// 交易日期
	private String planName;// 保险公司名称
	private String bankCode;// 保险公司代码
	private String selladdress;//售保接口地址
	private String returnaddress;//退保接口地址

	private String polNumber;// 返回的保单号


	private String resultCode;// 返回状态标志,1:Success,5:fail

	private String ResultInfoDesc;// 返回信息,交易成功,撤单成功

	public Insureinfo(String planname, String bankCode, String productCode,
			String fullname, String govtID, String departdate,String selladdress,String returnaddress) {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		transExeDate = sf.format(new Date());
		sf.applyPattern("HH:mm:ss");
		transExeTime = sf.format(new Date());
		this.planName = planname;
		this.productCode = productCode;
		this.fullname = fullname;
		this.govtID = govtID;
		this.departdate = departdate;
		this.bankCode = bankCode;
		this.selladdress = selladdress;
		this.returnaddress = returnaddress;	
	}

	public String toRequestXML() {
		StringBuffer insureinfo = new StringBuffer(XML);
		insureinfo
				.append("<TXLife><TXLifeRequest><TransRefGUID>00000000</TransRefGUID><TransType tc=\"15\">EBSCBS_NB_AP_0003</TransType>")
				.append("<TransExeDate>" + transExeDate
						+ "</TransExeDate><TransExeTime>" + transExeTime
						+ "</TransExeTime>")
				.append("<OLifE><Holding id=\"Holding_1\"><Policy><ProductCode>"
						+ productCode + "</ProductCode>")
				.append("<PlanName>" + planName + "</PlanName><EffDate>"
						+ departdate + "</EffDate></Policy></Holding>")
				.append("<Relation OriginatingObjectID=\"Holding_1\" RelatedObjectID=\"Party_1\" id=\"Relation_1\">")
				.append("<OriginatingObjectType tc=\"4\">Holding</OriginatingObjectType>")
				.append("<RelatedObjectType tc=\"6\">Party</RelatedObjectType><RelationRoleCode tc=\"8\">Owner</RelationRoleCode>")
				.append("</Relation><Relation OriginatingObjectID=\"Holding_1\" RelatedObjectID=\"Party_2\" id=\"Relation_2\">")
				.append("<OriginatingObjectType tc=\"4\">Holding</OriginatingObjectType>")
				.append("<RelatedObjectType tc=\"6\">Party</RelatedObjectType><RelationRoleCode tc=\"32\">Insured</RelationRoleCode>")
				.append("</Relation><Relation OriginatingObjectID=\"Party_1\" RelatedObjectID=\"Party_2\" id=\"Relation_3\">")
				.append("<OriginatingObjectType tc=\"6\">Party</OriginatingObjectType><RelatedObjectType tc=\"6\">Party</RelatedObjectType>")
				.append("<RelationRoleCode tc=\"5\">self</RelationRoleCode></Relation>")
				.append("<FormInstance><id>Form_1</id><FormName>1</FormName><DocumentType></DocumentType>")
				.append("<DocumentControlNumber></DocumentControlNumber></FormInstance>")
				.append("<Party id=\"Party_1\"><FullName>" + fullname
						+ "</FullName><GovtID>" + govtID + "</GovtID>")
				.append("<GovtIDTC tc=\"2\">2</GovtIDTC><Person><Gender tc=\"1\">1</Gender><BirthDate>1976-03-31</BirthDate>")
				.append("</Person></Party><Party id=\"Party_2\"><FullName>"
						+ fullname + "</FullName>")
				.append("<GovtID>"
						+ govtID
						+ "</GovtID><GovtIDTC tc=\"2\">2</GovtIDTC><Person><Gender tc=\"1\">1</Gender>")
				.append("<BirthDate>1976-03-31</BirthDate></Person></Party></OLifE>")
				.append("<OLifEExtension VendorCode=\"1\"><CarrierCode>PICC</CarrierCode><Branch>JD13602001</Branch>")
				.append("<BankCode>"
						+ bankCode
						+ "</BankCode></OLifEExtension></TXLifeRequest></TXLife>");

		return insureinfo.toString();
	}

	public String toCancelXML() {
		StringBuffer insureinfo = new StringBuffer(XML);
		insureinfo
				.append("<TXLife><TXLifeRequest><TransRefGUID>00000000</TransRefGUID>")
				.append("<TransType tc=\"119\">EBSCBS_NB_CA_0001</TransType><TransExeDate>"
						+ this.transExeDate + "</TransExeDate>")
				.append("<TransExeTime>"
						+ this.transExeTime
						+ "</TransExeTime><OLifE><Holding id=\"Holding_1\"><Policy>")
				.append("<PolNumber>"
						+ this.polNumber
						+ "</PolNumber></Policy></Holding></OLifE><OLifEExtension VendorCode=\"1\">")
				.append("<CarrierCode>PICC</CarrierCode><Branch>JD1940085</Branch><BankCode>"
						+ bankCode + "</BankCode></OLifEExtension>")
				.append("</TXLifeRequest></TXLife>");
		return insureinfo.toString();
	}

	public boolean request(String xml) {
		try {
			// long a = System.currentTimeMillis();
			System.out.println("发送报文："+xml);
			// ThreeDES是加密解密类
			ThreeDES threeDES = new ThreeDES();
			String s = threeDES.createEncryptor(xml);

			byte[] bytes = s.getBytes();
			System.out.println("加密后发送报文 ：");
			System.out.println(s);
			URL url = new URL(selladdress);
			HttpURLConnection g_URLConnection = (HttpURLConnection) url
					.openConnection();
			g_URLConnection.setRequestProperty("content-type",
					"text/html;charset=utf-8");
			g_URLConnection.setDoOutput(true);
			g_URLConnection.setDoInput(true);
			// 生成输出流对象
			OutputStream v_OutputStream = g_URLConnection.getOutputStream();
			v_OutputStream.write(bytes);
			// 刷新输出流
			v_OutputStream.flush();
			// long b = System.currentTimeMillis();
			int code = g_URLConnection.getResponseCode();
			System.out.println("code   " + code);
			// long c = System.currentTimeMillis();

			// 获得服务器相应的输入流
			InputStream g_return = g_URLConnection.getInputStream();
			// System.out.println(System.currentTimeMillis() - b);

			ByteArrayOutputStream bos2 = new ByteArrayOutputStream();
			int x = 0;
			while ((x = g_return.read()) != -1) {
				bos2.write(x);
			}
			bos2.flush();

			// 关闭URL
			v_OutputStream.close();
			g_return.close();
			System.out.println("解密前返回报文：");
			String requestXML = new String(bos2.toByteArray());
			System.out.println(requestXML);
			requestXML = threeDES.createDecryptor(requestXML);
			System.out.println("解密后返回报文：");
			System.out.println(requestXML);

			Document document = DocumentHelper.parseText(requestXML);
			document.setXMLEncoding("UTF-8");
			Element root = document.getRootElement();
			Element ePolNumber = root.element("TXLifeResponse")
					.element("OLifE").element("Holding").element("Policy")
					.element("PolNumber");
			Element eResultCode = root.element("TXLifeResponse")
					.element("TransResult").element("ResultCode");
			Element eResultInfoDesc = root.element("TXLifeResponse")
					.element("TransResult").element("ResultInfo")
					.element("ResultInfoDesc");
			setPolNumber(ePolNumber.getText());
			setResultCode(eResultCode.attributeValue("tc"));
			// System.out.println(System.currentTimeMillis() - c);
			setResultInfoDesc(eResultInfoDesc.getText());
			return true;
		} catch (Exception e) {
			System.out.println(e.getMessage());
			setPolNumber(null);
			setResultCode("5");
			setResultInfoDesc("交易失败");
			return false;
		}
	}

	/**
	 * 
	 * cancel方法：该方法暂时不用<br/>
	 * <br/>
	 * 
	 * @param xml
	 * @exception
	 */
	public void cancel(String xml) {
		try {
			// ThreeDES是加密解密类
			ThreeDES threeDES = new ThreeDES();
			String s = threeDES.createEncryptor(xml);
			byte[] bytes = s.getBytes();
			URL url = new URL(returnaddress);
			HttpURLConnection g_URLConnection = (HttpURLConnection) url
					.openConnection();
			g_URLConnection.setRequestProperty("content-type",
					"text/html;charset=utf-8");
			g_URLConnection.setDoOutput(true);
			g_URLConnection.setDoInput(true);
			// 生成输出流对象
			OutputStream v_OutputStream = g_URLConnection.getOutputStream();
			v_OutputStream.write(bytes);
			// 刷新输出流
			v_OutputStream.flush();
			int code = g_URLConnection.getResponseCode();
			System.out.println("code   " + code);
			// 获得服务器相应的输入流
			InputStream g_return = g_URLConnection.getInputStream();
			// System.out.println(System.currentTimeMillis() - b);

			ByteArrayOutputStream bos2 = new ByteArrayOutputStream();
			int x = 0;
			while ((x = g_return.read()) != -1) {
				bos2.write(x);
			}
			bos2.flush();

			// 关闭URL
			v_OutputStream.close();
			g_return.close();
			String requestXML = new String(bos2.toByteArray());
			System.out.println(requestXML);
			requestXML = threeDES.createDecryptor(requestXML);
			Document document = DocumentHelper.parseText(requestXML);
			document.setXMLEncoding("UTF-8");
			Element root = document.getRootElement();
			Element ePolNumber = root.element("TXLifeResponse")
					.element("OLifE").element("Holding").element("Policy")
					.element("PolNumber");
			Element eResultCode = root.element("TXLifeResponse")
					.element("TransResult").element("ResultCode");
			Element eResultInfoDesc = root.element("TXLifeResponse")
					.element("TransResult").element("ResultInfo")
					.element("ResultInfoDesc");
			setPolNumber(ePolNumber.getText());
			setResultCode(eResultCode.attributeValue("tc"));
			setResultInfoDesc(eResultInfoDesc.getText());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setPolNumber(null);
			setResultCode("5");
			setResultInfoDesc("撤销失败");
		}
	}

	public String getPolNumber() {
		return polNumber;
	}

	public void setPolNumber(String polNumber) {
		this.polNumber = polNumber;
	}

	public String getResultCode() {
		return resultCode;
	}

	public void setResultCode(String resultCode) {
		this.resultCode = resultCode;
	}

	public String getResultInfoDesc() {
		return ResultInfoDesc;
	}

	public void setResultInfoDesc(String resultInfoDesc) {
		ResultInfoDesc = resultInfoDesc;
	}

	public String getReturnaddress() {
		return returnaddress;
	}

	public void setReturnaddress(String returnaddress) {
		this.returnaddress = returnaddress;
	}

	public String getSelladdress() {
		return selladdress;
	}

	public void setSelladdress(String selladdress) {
		this.selladdress = selladdress;
	}
}

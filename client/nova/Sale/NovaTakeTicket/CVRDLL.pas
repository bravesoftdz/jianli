{**************************************************
	深圳华视电子读写设备有限公司 
	    版权所有 (c) 2007.04
 
	By: 吴为龙 Kim.Wu 
	Tel: 0755-26955558
	Http://www.chinaidcard.com
***************************************************}


unit CVRDLL;

interface

  //-------------------------------------------------------------------------
  function CVR_InitComm(iPort :integer):integer;stdcall;       						 //	初始化串口
  function CVR_CloseComm():integer;stdcall;                                // 关闭串口
  function CVR_Authenticate():integer;stdcall;										 	       // 卡认证
  function CVR_Read_Content(Active :integer):integer;stdcall;					     //	读卡操作
  //-------------------------------------------------------------------------
  function InitComm(iPort :integer):integer;stdcall;       						 //	初始化串口
  function CloseComm():integer;stdcall;                                // 关闭串口
  function Authenticate():integer;stdcall;										 	       // 卡认证
  function Read_Content(Active :integer):integer;stdcall;					     //	读卡操作

  function GetManuID(ID:PCardinal): integer;stdcall;

  function  GetPeopleName(strTmp:PChar; strLen:Pinteger): integer;stdcall;
  function  GetPeopleSex(strTmp:PChar; strLen:Pinteger): integer;stdcall;
  function  GetPeopleNation(strTmp:PChar; strLen:Pinteger): integer;stdcall;
  function  GetPeopleBirthday(strTmp:PChar; strLen:Pinteger): integer;stdcall;
  function  GetPeopleAddress(strTmp:PChar; strLen:Pinteger): integer;stdcall;
  function  GetPeopleIDCode(strTmp:PChar; strLen:Pinteger): integer;stdcall;


implementation

  //---------------------------------------------------
  function CVR_InitComm; external 'termb.dll';       					 //	初始化串口
  function CVR_CloseComm; external 'termb.dll';                // 关闭串口
  function CVR_Authenticate; external 'termb.dll'; 						 // 卡认证
  function CVR_Read_Content; external 'termb.dll'; 				     //	读卡操作
  //---------------------------------------------------
  function InitComm; external 'termb.dll';       					 //	初始化串口
  function CloseComm; external 'termb.dll';                // 关闭串口
  function Authenticate; external 'termb.dll'; 						 // 卡认证
  function Read_Content; external 'termb.dll'; 				     //	读卡操作
  //---------------------------------------------------
  function GetManuID;  external 'termb.dll';

  function  GetPeopleName ;external 'termb.dll';
  function  GetPeopleSex;external 'termb.dll';
  function  GetPeopleNation ;external 'termb.dll';
  function  GetPeopleBirthday;external 'termb.dll';
  function  GetPeopleAddress;external 'termb.dll';
  function  GetPeopleIDCode;external 'termb.dll';

end.

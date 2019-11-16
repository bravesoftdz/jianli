unit LoginUser;

interface
uses SysUtils,FunctionItemIntf,Generics.Collections, PubFn;
Type
  TLoginUserInfo = class
  public
    UserID:Int64;
    UserCode:String;
    UserName:String;
    RoleID:Int64;
    RoleName:string;
    IsAdmin:Boolean;
    OrgID:Int64;//当前登录的机构ID
    OrgIDs:String;//该用户拥有的机构,如'(2,12)'
    OrgName:String;
    POrgID :Int64;//上级机构
    POrgName:String;//上级机构
    ticketoutletsid:int64;//登录售票点ID
    ticketoutletsname:string;//登录售票点名称
    departmentID :Int64;
    departmentName :String;
    stationName :String;
    StationID:Int64;//当前登录的站点ID
    //登录用户当前使用的票据号码 eg: Ticket表示当前车票号 0123456789
    curBillNo:TDictionary<String,string>;
    //登录用户当前剩余票据数量 eg: Ticket表示剩余车票号
    curBillNum:TDictionary<String,Int64>;
//    functionItemList:Tlist<TFunctionItem>;  //该用户所拥有的功能
    constructor Create();
//    function getSubFunctions(functionKey:TGUID):TList<TSubfunction>;
//    function getFunctionEnable(key:TGUID):Boolean;
//    function getSubFunctionEnable(key:TGUID):Boolean;
    function increaseBillNo(bill:string;num:Integer):Boolean;//改变指定票据的当前使用号码及剩余数量
  end;

implementation
uses Services;
{ TLoginUserInfo }

constructor TLoginUserInfo.Create;
begin
  curBillNo := TDictionary<String,string>.create;
  curBillNum := TDictionary<String,Int64>.create;
//  functionItemList := TList<TFunctionItem>.create;
end;

//function TLoginUserInfo.getFunctionEnable(key: TGUID): Boolean;
//var functionItem:TFunctionPermission;
//begin
//  Result:=True;
//  if Assigned(functionItemList) then
//  begin
//    for functionItem in functionItemList do
//    begin
//      if guidtostring(functionItem.key)=GUIDToString(key) then
//      begin
//        Result:=functionItem.enable;
//      end;
//    end;
//  end;
//end;
//
//function TLoginUserInfo.getSubFunctionEnable(key: TGUID): Boolean;
//var functionItem:TFunctionPermission;
//    subFunction:TSubfunction;
//begin
//  Result:=False;
//  if Assigned(functionItemList) then
//  begin
//    for functionItem in functionItemList do
//    begin
//      for subFunction in functionItem.subFunctionList do
//      begin
//        if guidtostring(subFunction.key)=GUIDToString(key) then
//        begin
//          Result:=subFunction.enable;
//        end;
//      end;
//    end;
//  end;
//end;
//
//function TLoginUserInfo.getSubFunctions(
//  functionKey: TGUID): TList<TSubfunction>;
//var functionItem:TFunctionPermission;
//begin
//  Result:=nil;
//  if Assigned(functionItemList) then
//  begin
//    for functionItem in functionItemList do
//    begin
//      if guidtostring(functionItem.key)=GUIDToString(functionKey) then
//      begin
//        Result:=functionItem.subFunctionList;
//        Break;
//      end;
//    end;
//  end;
//end;

function TLoginUserInfo.increaseBillNo(bill: string; num: Integer): Boolean;
begin
  if curBillNo.ContainsKey(bill) then
  begin
    if curBillNum.Items[bill]>=num then
    begin
      curBillNum.AddOrSetValue(bill,curBillNum.Items[bill]-num);
      if curBillNum.Items[bill]=0 then
        curBillNo.AddOrSetValue(bill,'')
      else
        curBillNo.AddOrSetValue(bill,zerofill(IntToStr(StrToInt64(curBillNo.Items[bill])+num),Length(curBillNo.Items[bill])));
      Result:=true;
    end
    else
    begin
      Result:=false;
      SysDialogs.ShowError('剩余票张数不足！');
      exit;
    end;
  end
  else
  begin
    Result:=false;
    SysDialogs.ShowError(bill+'类型票据没有初始化！');
    exit;
  end;
end;

end.

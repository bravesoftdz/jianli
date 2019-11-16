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
    OrgID:Int64;//��ǰ��¼�Ļ���ID
    OrgIDs:String;//���û�ӵ�еĻ���,��'(2,12)'
    OrgName:String;
    POrgID :Int64;//�ϼ�����
    POrgName:String;//�ϼ�����
    ticketoutletsid:int64;//��¼��Ʊ��ID
    ticketoutletsname:string;//��¼��Ʊ������
    departmentID :Int64;
    departmentName :String;
    stationName :String;
    StationID:Int64;//��ǰ��¼��վ��ID
    //��¼�û���ǰʹ�õ�Ʊ�ݺ��� eg: Ticket��ʾ��ǰ��Ʊ�� 0123456789
    curBillNo:TDictionary<String,string>;
    //��¼�û���ǰʣ��Ʊ������ eg: Ticket��ʾʣ�೵Ʊ��
    curBillNum:TDictionary<String,Int64>;
//    functionItemList:Tlist<TFunctionItem>;  //���û���ӵ�еĹ���
    constructor Create();
//    function getSubFunctions(functionKey:TGUID):TList<TSubfunction>;
//    function getFunctionEnable(key:TGUID):Boolean;
//    function getSubFunctionEnable(key:TGUID):Boolean;
    function increaseBillNo(bill:string;num:Integer):Boolean;//�ı�ָ��Ʊ�ݵĵ�ǰʹ�ú��뼰ʣ������
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
      SysDialogs.ShowError('ʣ��Ʊ�������㣡');
      exit;
    end;
  end
  else
  begin
    Result:=false;
    SysDialogs.ShowError(bill+'����Ʊ��û�г�ʼ����');
    exit;
  end;
end;

end.

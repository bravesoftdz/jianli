{ ------------------------------------
  功能说明：公共函数
  创建日期：2010/11/11
  作者：ice
  版权：nova
  ------------------------------------- }
unit PubFn;

interface

uses Constant, Classes, StdCtrls, SysUtils, UDMPublic, db, jsonClientDataSet,
  CheckLst,windows,ExtCtrls,Gdiplus,ActiveX,Math,
  Graphics, Jpeg, ComCtrls, Variants, Generics.Collections, FunctionItemIntf;

type
  TCommInfo = Class(Tobject) // 一个通用的类用于保存一下几个信息，比如机构,有TCombobox的用途都可调用
    ID: Integer;
    Value: String;
    Name: String;
    IsSelected: boolean;
  end;
  TGraphicType = (Bmp,Jpg);

const
  _roadbill = 'Roadbill';
function incEx(var i: Integer; increment: Integer = 1): Integer; overload;
function incEx(var i: int64; increment: Integer = 1): int64; overload;

procedure RiaseIntfNotFoundErr(IID: TGUID);

procedure InitCombox(var ACb_Org: TComboBox;
  jsonClientDataSet: TjsonClientDataSet);
procedure InitComboxDefult(var ACb_Org: TComboBox;
  jsonClientDataSet: TjsonClientDataSet);
procedure InitCheckListBox(var ACb_Role: TCheckListBox;
  jsonClientDataSet: TjsonClientDataSet);

function getComboxIndexByid(comboBox: TComboBox; ID: Integer): Integer;

// 日期转换
Function _strtodate(Value: string): Tdate;
function _strtodatetime(Strdate: string): Tdatetime;
Function _formatdatetime(FormatStr: string; Dt: Tdatetime): string;

function MemoryStreamToHexStr(mem: TMemoryStream): String;

function HexStrToGraphic(HexStr: String): TBitmap;
function HexStrToJpg(HexStr: String): TJpegImage;
function getSubStrNum(SubStr: string; Sstr: string): Integer;

// 补零
function zerofill(source: string; totalLength: Integer): string;
// 获取系统参数公共方法
function getParametervalue(code: string; orgid: int64 = 0): String;
// 根据班次ID取班次座位状态
function getScheduleSeatstatus(scheduleplanid: int64): TDictionary<Word,
  String>;
// 动态创建字段
function createField(_fieldname, _DisplayLabel: String; _fieldtype: TFieldType;
  _fieldlength, _Index: Integer; _dataset: TDataSet): TField;
// 动态创建查找字段
function createLookupField(_fieldname, _DisplayLabel, _KeyFields,
  _LookupKeyFields, _LookupResultField: String; _fieldtype: TFieldType;
  _fieldlength, _Index: Integer; _dataset, _LookupDataSet: TDataSet): TField;
// 动态创建数据字典数据集
function createCdsDDD(tablename, columnname: String;
  Aowner: TComponent): TjsonClientDataSet;
// 初始化单号
function initBillNo(billname: String): boolean;
// 如果value等于空返加defaultvalue，否则返回value
function nvl(Value, defaultvalue: variant): variant;
// 校验单据
function checkBillno(billname: String): boolean;
//校验身份证号码
function ValidatePID(const APID: string): string;
//校验手机号
function ValidateMobilephone(const Amobilephone: string): string;
//设置本机时间
procedure SetSystemTimeEx(ADateTime: TDateTime);
//校验IP
function checkip(ip: string): Boolean;
//缩小并转换图像格式
function convertAndshrinkImage(imgFilename:String;destImg:Timage;destType:TGraphicType;maxWidth,maxHeight:integer):boolean;
//经典四舍五入算法
function round(const Value: Extended): Int64;
//math增强
function CeilEx(const X: Extended;precision:Byte):Extended;
function FloorEx(const X: Extended;precision:Byte): Extended;
function roundEx(const X: Extended;precision:Byte): Extended;
function getWeekNum(week:integer):string;
//生成汉子首写字母
function GetPyChar(const HZ: AnsiString): string;
//
function getNotprintValue(orgid,vehicleid:Int64;templatename: string): TList<String>;
function setPrintValue(notprintvalue: TList<String>;printname:string; printvalue: String): string;
implementation

uses Services;

var
  cdsParameter, jcdsQryScheduleSeatstatus,jcsdQryprintitem: TjsonClientDataSet;
  curseatsStatus: TDictionary<Word, String>;
  curnotprintValue: TList<string>; // 不打印项目

function CeilEx(const X: Extended;precision:Byte):Extended;
begin
  result:=Ceil(IntPower(10,precision)*X)*IntPower(10,-1*precision);
end;

function FloorEx(const X: Extended;precision:Byte): Extended;
begin
  result:=Floor(IntPower(10,precision)*X)*IntPower(10,-1*precision);
end;

function roundEx(const X: Extended;precision:Byte): Extended;
begin
  result:=round(IntPower(10,precision)*X)*IntPower(10,-1*precision);
end;

function round(const Value: Extended): Int64;
begin
  if Value>0 then
    result:=Trunc(value+0.5)
  else
    result:=Trunc(value-0.5);
end;

function convertAndshrinkImage(imgFilename:String;destImg:Timage;destType:TGraphicType;maxWidth,maxHeight:integer):boolean;
var
  gImg1,gImg2: IGPImage;
  g: IGPGraphics;
  MemStream,imgStream: TMemoryStream;
  destGraphic:TGraphic;
  MyIStream: IStream;
begin
  result:=false;
  destImg.Picture.LoadFromFile(imgFilename);
  MemStream := TMemoryStream.Create;
  destImg.Picture.Graphic.SaveToStream(MemStream);
  MyIStream := TStreamAdapter.Create(MemStream);
  gimg1 := TGPImage.Create(MyIStream);
  if (gImg1.Width>maxWidth) or (gImg1.Height>maxHeight) then
  begin
    if gImg1.Width/maxWidth>=gImg1.Height/maxHeight then
    begin
      gImg2 := TGPBitmap.Create(maxWidth,maxWidth*gImg1.Height div gImg1.Width, PixelFormat32bppARGB);
    end
    else
    begin
      gImg2 := TGPBitmap.Create(maxHeight*gImg1.Width div gImg1.Height,maxHeight, PixelFormat32bppARGB);
    end;
  end
  else
  begin
    gImg2 := TGPBitmap.Create(gimg1.Width,gimg1.Height, PixelFormat32bppARGB);
  end;
  g := TGPGraphics.Create(gImg2);
  g.InterpolationMode := InterpolationModeHighQualityBicubic;
  g.DrawImage(gImg1, 0, 0, gImg2.Width, gImg2.Height, 0, 0, gImg1.Width, gImg1.Height, UnitPixel);

  imgStream := TMemoryStream.Create;
  MyIStream := TStreamAdapter.Create(imgStream);
  case destType of
    TGraphicType.Bmp:begin
      gImg2.Save(MyIStream,TGPImageFormat.Bmp);
      destGraphic:=TBitmap.Create;
    end;
    TGraphicType.Jpg:begin
      gImg2.Save(MyIStream,TGPImageFormat.Jpeg);
      destGraphic:=TJPEGImage.Create;
    end;
    else
      raise Exception.Create('未知的目标图像类型');
  end;
  imgStream.Position:=0;
  destGraphic.LoadFromStream(imgStream);
  destImg.Picture.Free;
  destImg.Picture:=TPicture.Create;
  destImg.Picture.Graphic:=destGraphic;
  MemStream.Free;
  imgStream.free;
  destImg.Repaint;
end;

procedure SetSystemTimeEx(ADateTime: TDateTime);
var
  tzi: TTimeZoneInformation;
  dtGMT :TDateTime;  // 格林尼治标准时间
  dtSystem : TSystemTime;
begin
  // 获取时区信息
  GetTimeZoneInformation( tzi );
  // 计算出格林尼治标准时间
  dtGMT := ADateTime + tzi.Bias / MinsPerDay;
  // 将标准时间转换为系统时间类型
  DateTimeToSystemTime( dtGMT, dtSystem );
  // 修改系统时间
  SetSystemTime( dtSystem );
end;


function ValidatePID(const APID: string): string;
  {内部函数,取身份证号校验位,最后一位,对18位有效}
  function GetVerifyBit(sIdentityNum: string): Char;
  var
    nNum: Integer;
  begin
    Result := #0;
    nNum := StrToInt(sIdentityNum[1]) * 7 +
            StrToInt(sIdentityNum[2]) * 9 +
            StrToInt(sIdentityNum[3]) * 10 +
            StrToInt(sIdentityNum[4]) * 5 +
            StrToInt(sIdentityNum[5]) * 8 +
            StrToInt(sIdentityNum[6]) * 4 +
            StrToInt(sIdentityNum[7]) * 2 +
            StrToInt(sIdentityNum[8]) * 1 +
            StrToInt(sIdentityNum[9]) * 6 +
            StrToInt(sIdentityNum[10]) * 3 +
            StrToInt(sIdentityNum[11]) * 7 +
            StrToInt(sIdentityNum[12]) * 9 +
            StrToInt(sIdentityNum[13]) * 10 +
            StrToInt(sIdentityNum[14]) * 5 +
            StrToInt(sIdentityNum[15]) * 8 +
            StrToInt(sIdentityNum[16]) * 4 +
            StrToInt(sIdentityNum[17]) * 2;
    nNum := nNum mod 11;
    case nNum of
      0: Result := '1';
      1: Result := '0';
      2: Result := 'X';
      3: Result := '9';
      4: Result := '8';
      5: Result := '7';
      6: Result := '6';
      7: Result := '5';
      8: Result := '4';
      9: Result := '3';
      10: Result := '2';
    end;
  end;
var
  L : Integer;
  sCentury : string;
  sYear2Bit : string;
  sMonth : string;
  sDate : string;
  iCentury : Integer;
  iMonth : Integer;
  iDate : Integer;
  CRCFact : string;//18位证号的实际值
  CRCTh : string; //18位证号的理论值
  FebDayAmt: Byte;//2月天数
begin
  L := Length(APID);
  if (L in [15, 18]) = False then
  begin
     Result := Format('身份证号不是15位或18位(%0:s, 实际位数:%1:d)', [APID, L]);
     Exit;
  end;
  CRCFact := '';
  if L = 18 then
  begin
     sCentury := Copy(APID, 7, 2);
     iCentury := StrToInt(sCentury);
     if (iCentury in [18..20]) = False then
     begin
        Result := Format('身份证号码无效:18位证号的年份前两位必须在18-20之间(%0:S)', [sCentury]);
        Exit;
     end;
     sYear2Bit := Copy(APID, 9, 2);
     sMonth := Copy(APID, 11, 2);
     sDate := Copy(APID, 13, 2);
     CRCFact := Copy(APID, 18, 1);
  end else
  begin
     sCentury := '19';
     sYear2Bit := Copy(APID, 7, 2);
     sMonth := Copy(APID, 9, 2);
     sDate := Copy(APID, 11, 2);
  end;
  iMonth := StrToInt(sMonth);
  iDate := StrToInt(sDate);
  if (iMonth in [01..12]) = False then
  begin
     Result := Format('身份证号码无效:月份必须在01-12之间(%0:s)', [sMonth]);
     Exit;
  end;
  if (iMonth in [1, 3, 5, 7, 8, 10, 12]) then
  begin
     if (iDate in [01..31]) = False then
     begin
        Result := Format('身份证号码无效:日期无效,不能为零或超出当月最大值(%0:s)', [sDate]);
        Exit;
     end;
  end;
  if (iMonth in [4, 6, 9, 11]) then
  begin
     if (iDate in [01..30]) = False then
     begin
        Result := Format('身份证号码无效:日期无效,不能为零或超出当月最大值(%0:s)', [sDate]);
        Exit;
     end;
  end;
  if IsLeapYear(StrToInt(sCentury + sYear2Bit)) = True then
  begin
     FebDayAmt := 29;
  end else
  begin
     FebDayAmt := 28;
  end;
  if (iMonth in [2]) then
  begin
     if (iDate in [01..FebDayAmt]) = False then
     begin
        Result := Format('身份证号码无效:日期无效,不能为零或超出当月最大值(%0:s)', [sDate]);
        Exit;
     end;
  end;
  if CRCFact <> '' then
  begin
     CRCTh := GetVerifyBit(APID);
     if CRCFact <> CRCTh then
     begin
        Result := Format('身份证号码无效:校验位(第18位)错:(%0:s)', [APID]);
        Exit;
     end;
  end;
end;

function ValidateMobilephone(const Amobilephone: string): string;
var
  L,i:Integer;
begin
  L := Length(Amobilephone);
  if  L<>11 then
  begin
     Result := Format('手机号不是11位(%0:s, 实际位数:%1:d)', [Amobilephone, L]);
     Exit;
  end
  else
  begin
    for i := 1 to L do
    begin
       if not (Amobilephone[i] in ['0','1','2','3','4','5','6','7','8','9']) then
       begin
          Result := '手机号只能是数字，请重新输入！';
          Exit;
       end
    end;
    Result := '';
    Exit;
  end;
end;


function nvl(Value, defaultvalue: variant): variant;
begin
  if Value = null then
  begin
    result := defaultvalue;
  end
  else
  begin
    result := Value;
  end;
end;

function incEx(var i: Integer; increment: Integer = 1): Integer;
begin
  inc(i);
  result := i;
end;

function incEx(var i: int64; increment: Integer = 1): int64;
begin
  inc(i);
  result := i;
end;

procedure RiaseIntfNotFoundErr(IID: TGUID);
begin
  Raise Exception.CreateFmt(ERR_IntfNotFound, [GUIDToString(IID)]);
end;

// 机构
procedure InitCombox(var ACb_Org: TComboBox;
  jsonClientDataSet: TjsonClientDataSet);
var
  CommInfo: TCommInfo;
begin
  if (not jsonClientDataSet.Active) then
    exit;
  if jsonClientDataSet.RecordCount < 1 then
    exit;
  with jsonClientDataSet do
  begin
    ACb_Org.Items.Clear;
    while not eof do
    begin
      CommInfo := TCommInfo.Create;
      CommInfo.ID := Fieldbyname('ID').AsInteger;
      CommInfo.Name := Fieldbyname('Name').AsString;
      CommInfo.Value := Fieldbyname('CODE').AsString;
      ACb_Org.Items.AddObject(CommInfo.Name, CommInfo);
      Next;
    end;
    Active := false;
  end;
end;

procedure InitComboxDefult(var ACb_Org: TComboBox;
  jsonClientDataSet: TjsonClientDataSet);
var
  CommInfo: TCommInfo;
begin

  with jsonClientDataSet do
  begin
    ACb_Org.Items.Clear;
    CommInfo := TCommInfo.Create;
    // CommInfo.ID:=0;
    CommInfo.Name := '全部';
    CommInfo.Value := '全部';
    ACb_Org.Items.AddObject(CommInfo.Name, CommInfo);
    if (not jsonClientDataSet.Active) then
      exit;
    if jsonClientDataSet.RecordCount < 1 then
      exit;
    while not eof do
    begin
      CommInfo := TCommInfo.Create;
      CommInfo.ID := Fieldbyname('ID').AsInteger;
      CommInfo.Name := Fieldbyname('Name').AsString;
      CommInfo.Value := Fieldbyname('CODE').AsString;
      ACb_Org.Items.AddObject(CommInfo.Name, CommInfo);
      Next;
    end;
    Active := false;
  end;
end;

procedure InitCheckListBox(var ACb_Role: TCheckListBox;
  jsonClientDataSet: TjsonClientDataSet);
var
  CommInfo: TCommInfo;
begin
  if (not jsonClientDataSet.Active) then
    exit;
  if jsonClientDataSet.RecordCount < 1 then
    exit;
  with jsonClientDataSet do
  begin
    ACb_Role.Items.Clear;
    while not eof do
    begin
      CommInfo := TCommInfo.Create;
      CommInfo.ID := Fieldbyname('ID').AsInteger;
      CommInfo.Name := Fieldbyname('Name').AsString;
      ACb_Role.Items.AddObject(CommInfo.Name, CommInfo);
      Next;
    end;
    Active := false;
  end;
end;

function getComboxIndexByid(comboBox: TComboBox; ID: Integer): Integer;
var
  i: Integer;
begin
  result := -1;
  for i := 0 to comboBox.Items.Count - 1 do
  begin
    try
      if TCommInfo(comboBox.Items.Objects[i]).ID = ID then
      begin
        result := i;
        Break;
      end;
    except

    end;
  end;
end;

// 日期转换
Function _strtodate(Value: string): Tdate;
// var
// oldSeparator: char;
begin
  // oldSeparator := DateSeparator;
  try
    if pos('-', Value) > 0 then
    begin
      DateSeparator := '-';
    end
    else if pos('.', Value) > 0 then
    begin
      DateSeparator := '.';
    end;
    result := strtodate(Value);
  finally
    DateSeparator := '-';
  end;
  // DateSeparator := oldSeparator;
end;

function _strtodatetime(Strdate: string): Tdatetime;
begin
  try
    if pos('.', Strdate) > 0 then
    begin
      DateSeparator := '.';
    end
    else
    begin
      DateSeparator := '-';
    end;
    result := strtodatetime(Strdate) finally DateSeparator := '-';
  end;
end;

Function _formatdatetime(FormatStr: string; Dt: Tdatetime): string;
begin
  try
    if pos('.', FormatStr) > 0 then
    begin
      DateSeparator := '.';
      result := formatdatetime(FormatStr, Dt);
    end
    else
    begin
      DateSeparator := '-';
      result := formatdatetime(FormatStr, Dt);
    end;
  finally
    DateSeparator := '-';
  end;
end;

function MemoryStreamToHexStr(mem: TMemoryStream): String;
var
  // bmp: TBitmap;
  c: char;
  s1, s2: string;
  memstr: TStringStream;
begin
  try
    memstr := TStringStream.Create;
    memstr.LoadFromStream(mem);
    s1 := '';
    s2 := '';
    mem.Position := 0; { 指针到开始 }
    while mem.Position < mem.Size do
    begin
      mem.Read(c, 1);
      s1 := s1 + c;
      s2 := s2 + IntToHex(Byte(c), 2);
    end;
  finally
    // memstr.Free;
  end;
  result := s2;
end;

function HexStrToGraphic(HexStr: String): TBitmap;
var
  Stream: TMemoryStream;
  tempimage: TBitmap;
begin
  Stream := TMemoryStream.Create;
  Stream.SetSize(Length(HexStr) div 2);
  HexToBin(Pchar(HexStr), Pchar(Integer(Stream.Memory)), Stream.Size);
  Stream.Seek(0, soFromBeginning);
  tempimage := TBitmap.Create;
  tempimage.LoadFromStream(Stream);
  // Image1.Picture.Bitmap.Assign(tempimage);
  Stream.Free;
  result := tempimage;
end;

function HexStrToJpg(HexStr: String): TJpegImage;
var
  Stream: TMemoryStream;
  // tempimage:Tbitmap;
  jpg1: TJpegImage;
begin
  Stream := TMemoryStream.Create;
  Stream.SetSize(Length(HexStr) div 2);
  HexToBin(Pchar(HexStr), Pchar(Integer(Stream.Memory)), Stream.Size);
  Stream.Seek(0, soFromBeginning);
  jpg1 := TJpegImage.Create;
  jpg1.LoadFromStream(Stream);
  Stream.Free;
  result := jpg1;
end;

{ 功能：获取SubStr字段串在Sstr字符串中存在的数量
  参数：       SubStr:string  子字符串
  Sstr:string    字符串
  返回值   integer  整型
}
function getSubStrNum(SubStr: string; Sstr: string): Integer;
var
  i, Count: Integer;
begin
  i := -1;
  Count := 0;
  while Length(Trim(Sstr)) > 0 do
  begin
    i := pos(Trim(SubStr), Trim(Sstr));
    if i > 0 then
    begin
      Count := Count + 1;
      Sstr := Copy(Trim(Sstr), i + Length(Trim(SubStr)),
        Length(Trim(Sstr)) - i + Length(Trim(SubStr)) + 1);
    end
    else
    begin
      Sstr := '';
    end;
  end;
  result := Count;
end;

function zerofill(source: string; totalLength: Integer): string;
begin
  result := source;
  while Length(result) < totalLength do
  begin
    result := '0' + result;
  end;
end;

function getParametervalue(code: string; orgid: int64 = 0): String;
begin
  if cdsParameter = nil then
  begin
    cdsParameter := TjsonClientDataSet.Create(nil);
    with cdsParameter do
    begin
      RemoteServer := DMPublic.jcon;
      SaveAddress := 'system/findParameterValue';
      Params.CreateParam(ftString, 'code', ptInput);
      Params.CreateParam(ftString, 'orgid', ptInput);
      Params.CreateParam(ftString, 'parametervalue', ptOutput);
    end;
  end;
  with cdsParameter do
  begin
    Active := false;
    Params.ParamValues['code'] := code;
    if orgid <= 0 then
    begin
      Params.ParamValues['orgid'] := null;
    end
    else
    begin
      Params.ParamValues['orgid'] := orgid;
    end;
    Execute;
    result := Params.ParamValues['parametervalue'];
  end;
end;

function getScheduleSeatstatus(scheduleplanid: int64): TDictionary<Word,
  String>;
var
  status: String;
  seatno: Integer;
begin
  if jcdsQryScheduleSeatstatus = nil then
  begin
    jcdsQryScheduleSeatstatus := TjsonClientDataSet.Create(nil);
    with jcdsQryScheduleSeatstatus do
    begin
      RemoteServer := DMPublic.jcon;
      DataSourceName := 'scheduleseatlist';
      QueryAddress := 'ticketprice/qryScheduleseatinfo';
      Params.CreateParam(ftString, 'scheduleplan.id', ptInput);
    end;
  end;
  if not Assigned(curseatsStatus) then
    curseatsStatus := TDictionary<Word, String>.Create;
 // if Assigned(curseatsStatus) and  (curseatsStatus<>nil)
//     and (curseatsStatus.Count>0) then
    curseatsStatus.Clear;
  with jcdsQryScheduleSeatstatus do
  begin
    Active := false;
    Params.ParamValues['scheduleplan.id'] := scheduleplanid;
    Active := true;
    if RecordCount > 0 then
    begin
      first;
      while (not eof) do
      begin
        if Fieldbyname('status').AsString = '2' then
          status := Fieldbyname('tickettype').AsString
        else
          status := Fieldbyname('status').AsString;
        seatno := Fieldbyname('seatno').AsInteger;
        curseatsStatus.Add(seatno, status);
        Next;
      end;
    end;
  end;
  result := curseatsStatus;
end;

function createField(_fieldname, _DisplayLabel: String; _fieldtype: TFieldType;
  _fieldlength, _Index: Integer; _dataset: TDataSet): TField;
begin
  result := DefaultFieldClasses[_fieldtype].Create(_dataset);
  with result do
  begin
    size:=_fieldlength;
    FieldName := _fieldname;
    DisplayLabel := _DisplayLabel;
    Index := _Index;
    DataSet := _dataset;
  end;
end;

function createLookupField(_fieldname, _DisplayLabel, _KeyFields,
  _LookupKeyFields, _LookupResultField: String; _fieldtype: TFieldType;
  _fieldlength, _Index: Integer; _dataset, _LookupDataSet: TDataSet): TField;
begin
  result := DefaultFieldClasses[_fieldtype].Create(_dataset);
  with result do
  begin
    FieldName := _fieldname;
    DisplayLabel := _DisplayLabel;
    Index := _Index;
    size:=_fieldlength;

    FieldKind := fkLookup;
    KeyFields := _KeyFields;
    LookupKeyFields := _LookupKeyFields;
    LookupResultField := _LookupResultField;
    LookupDataset := _LookupDataSet;
    DataSet := _dataset;
  end;
end;

function createCdsDDD(tablename, columnname: String;
  Aowner: TComponent): TjsonClientDataSet;
begin
  result := TjsonClientDataSet.Create(Aowner);
  with result do
  begin
    RemoteServer := DMPublic.jcon;
    QueryAddress := 'system/querydictionary';
    DataSourceName := 'diclist';
    Params.CreateParam(ftString, 'tablename', ptInput);
    Params.CreateParam(ftString, 'columnname', ptInput);

    Params.ParamValues['tablename'] := tablename;
    Params.ParamValues['columnname'] := columnname;
    Active := true;
  end;
end;

// 初始化单号
function initBillNo(billname: String): boolean;
var
  functionParm: TFunctionItemParameters;
begin
  functionParm := TFunctionItemParameters.Create;
  functionParm.CommaText := billname;
  SysFunctionMgr.exec(StringToGUID('{B2ECC99A-7644-452D-9CCB-982A7C81F51E}'),
    functionParm);
  result := Sysinfo.LoginUserInfo.curBillNo.ContainsKey(billname);
end;

// 校验单据
function checkBillno(billname: String): boolean;
begin
  result := false;
  if (not Sysinfo.LoginUserInfo.curBillNo.ContainsKey(billname)) or
    (not Sysinfo.LoginUserInfo.curBillNum.ContainsKey(billname)) then
  begin
    if (initBillNo(billname)) then
    begin
      if (Sysinfo.LoginUserInfo.curBillNum.Items[billname] = 0) then
      begin
        SysDialogs.Warning('您当前的单据已用完，请重新领取单票！');
        result := false;
      end
      else
        result := true;
    end;
  end
  else
  begin
    if (Sysinfo.LoginUserInfo.curBillNum.Items[billname] = 0) then
    begin
      SysDialogs.Warning('您当前的单据已用完，请重新领取单票！');
      result := false;
    end
    else
      result := true;
  end;

end;



function checkip(ip: string): Boolean;
  function checknum(item: string): Boolean;
  var
    i: Integer;
  begin
    try
      i := StrToInt(item);
      if (i >= 0) and (i <=255) then
        result := True
      else
        result := False;
    except
      on E: Exception do
        result := False;
    end;
  end;
  function checkbeginOrend(item: string): Boolean;
  var
    i: Integer;
  begin
    try
      i := StrToInt(item);
      if (i > 0) and (i < 255) then
        result := True
      else
        result := False;
    except
      on E: Exception do
        result := False;
    end;
  end;
var
  temp, item: string;
  i,poscount: Integer;
begin
  if Pos('.', ip) = 0 then
  begin
    result := False;
    exit;
  end;
  temp := ip;
  i := 0;
  poscount:=0;
  while Length(temp) > 0 do
  begin
    if Pos('.', temp) > 0 then
    begin
      item := Copy(temp, 1, Pos('.', temp) - 1);
      temp := Copy(temp, Pos('.', temp) + 1, Length(temp));
      poscount:=poscount+1;
    end
    else
    begin
      item := temp;
      temp := '';
    end;
    i := i + 1;
    if((i=1) or(i=4)) then
    begin
      if not (checkbeginOrend(item)) then
        begin
          result := False;
          exit;
        end;
    end
    else
    begin
    if not checknum(item) then
      begin
          result := False;
          exit;
      end;
    end;
  end;
  if poscount <> 3 then
  begin
    result := False;
    exit;
  end;
  result := True;
end;
//生成汉子首写字母
function GetPyChar(const HZ: AnsiString): string;
const
  HZCode: array[0..25, 0..1] of Integer = ((1601, 1636), (1637, 1832), (1833, 2077),
    (2078, 2273), (2274, 2301), (2302, 2432), (2433, 2593), (2594, 2786), (9999, 0000),
    (2787, 3105), (3106, 3211), (3212, 3471), (3472, 3634), (3635, 3722), (3723, 3729),
    (3730, 3857), (3858, 4026), (4027, 4085), (4086, 4389), (4390, 4557), (9999, 0000),
    (9999, 0000), (4558, 4683), (4684, 4924), (4925, 5248), (5249, 5589));
var
  i,j,HzOrd: Integer;
begin
  i := 1;
  while i <= Length(HZ) do
    begin
    if (HZ[i] >= #160) and (HZ[i + 1] >= #160) then
    begin
      HzOrd := (Ord(HZ[i]) - 160) * 100 + Ord(HZ[i + 1]) - 160;
      for j := 0 to 25 do
      begin
        if (HzOrd >= HZCode[j][0]) and (HzOrd <= HZCode[j][1]) then
        begin
          Result := Result + Char(Byte('A') + j);
          Break;
        end;
      end;
      Inc(i);
    end else Result := Result + HZ[i];
      Inc(i);
  end;
end;

function getNotprintValue(orgid,vehicleid:Int64;templatename: string): TList<String>;
begin
  //初始化不打印项目信息
  if not Assigned(curnotprintValue) then
      curnotprintValue := TList<String>.Create
  else
      curnotprintValue.Clear;


  if jcsdQryprintitem = nil then
  begin
    jcsdQryprintitem := TjsonClientDataSet.Create(nil);
    with jcsdQryprintitem do
    begin
      RemoteServer := DMPublic.jcon;
      DataSourceName:='printlist';
      QueryAddress := 'system/qryprintitem';
      Params.CreateParam(ftString, 'orgid', ptInput);
      Params.CreateParam(ftString, 'vehicleid', ptInput);
      Params.CreateParam(ftString, 'templatename', ptInput);
    end;
  end;
  with jcsdQryprintitem do
  begin
     Active:=false;
     Params.ParamValues['orgid']:=SysInfo.LoginUserInfo.OrgID;
     Params.ParamValues['vehicleid']:= vehicleid;
     Params.ParamValues['templatename']:=templatename;
     Active:=true;
     if RecordCount>0 then
     begin
       First;
       while not Eof do
       begin
         curnotprintValue.Add(FieldByName('itemcode').AsString);
         Next;
       end;
     end;
  end;
  result:=curnotprintValue;
end;


function setPrintValue(notprintvalue: TList<String>;
    printname:string; printvalue: String): string;
begin
   result:=printvalue;
   if(notprintvalue=nil) then
   begin
     exit;
   end;
   if (notprintvalue.Count>0) and
     (notprintvalue.Contains(printname)) then
   begin
      result:='';
   end;
end;



function getWeekNum(week: integer): string;
begin
  case week of
     1:
     result:='日';
     2:
     result:='一';
     3:
     result:='二';
     4:
     result:='三';
     5:
     result:='四';
     6:
     result:='五';
     7:
     result:='六';
    else
      result:='日';
  end;
end;
initialization

DateSeparator := '-';

end.

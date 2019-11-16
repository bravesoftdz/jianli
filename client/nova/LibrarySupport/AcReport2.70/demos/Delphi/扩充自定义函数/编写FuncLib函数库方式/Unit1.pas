unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AcReport_TLB, DB, ADODB;

type

 // 从 TComponent 派生一个自己的类，并实现 IAcFunctionLib 接口
  TMyFuncLib = class(TComponent, IAcFunctionLib)
  public
    function GetFuncCount: Integer; safecall;
    procedure GetFuncInfo(AFuncID: Integer; var AFuncKind: Integer; var AFuncName: WideString; 
                          var AParamDesc: WideString; var AFuncDesc: WideString); safecall;
    function DoFunction(const ARptEgine: IAcRptEngine; AFuncID: Integer; 
                        const AFuncName: WideString; AParam1: OleVariant; AParam2: OleVariant; 
                        AParam3: OleVariant): OleVariant; safecall;
  end;

  TForm1 = class(TForm)
    Button1: TButton;
    conn1: TADOConnection;
    ADOQuery1: TADOQuery;
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    FAcRptEngine: TAcRptEngine;
    FMyFuncLib: TMyFuncLib; //定义函数库成员变量
    
    function DoGetBySQL(SQL: string): Variant;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  FAcRptEngine := TAcRptEngine.Create(nil);
  //创建函数库，并加入到ACReportEngine中
  FMyFuncLib := TMyFuncLib.Create(nil);
  FAcRptEngine.AddFunctionLib(FMyFuncLib, 0);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FAcRptEngine.RemoveFuncionLib(FMyFuncLib);
  FAcRptEngine.Free;
  FMyFuncLib.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  sfile: string;
begin
  sfile := ExtractFilePath(ParamStr(0))+ 'addfunc.apt';
  if FileExists(sfile) then
    FAcRptEngine.LoadFromFile(sfile); 
  FAcRptEngine.ShowDesigner;
end;

function TForm1.DoGetBySQL(SQL: string): Variant;
begin
  if not conn1.Connected then
  begin
    conn1.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;'+
     'Data Source=' + ExtractFilePath(ParamStr(0))+ '..\..\..\Data\ReportDemo.mdb;Persist Security Info=False';
    conn1.Connected := true;
  end;
  ADOQuery1.Close; 
  ADOQuery1.SQL.Text := SQL;
  ADOQuery1.Open;
  Result := ADOQuery1.Fields[0].Value;
end;


{ TMyFuncLib }

function TMyFuncLib.DoFunction(const ARptEgine: IAcRptEngine;
  AFuncID: Integer; const AFuncName: WideString; AParam1, AParam2,
  AParam3: OleVariant): OleVariant;
var
  y,m,d: Word;
  v1, v2: Variant;
  i, n: integer;
  str,str2: string;
begin
  //ACReportEngine在计算报表公式、处理脚本的过程中，就会触发此过程，可以根据AFuncID或AFuncName来确定要处理哪个函数请求

  if AnsiCompareText(AFuncName, 'GetMyStr2') = 0 then //也可以写成 if AFuncID = 0 then
  begin
    Result := 'HI,这是一个自定义函数!';  //Result是返回值。
  end

  else
  if AnsiCompareText(AFuncName, 'DayOf2') = 0 then
  begin
    DecodeDate(ARptEgine.Calac(AParam1), y, m, d);  //注意是 ARptEgine.Calac(P1)，而不是直接使用AParam1，因为AParam1可能是一个公式
    Result := d;
  end

  else
  if AnsiCompareText(AFuncName, 'GetMax2') = 0 then
  begin
    v1 := ARptEgine.Calac(AParam1);
    v2 := ARptEgine.Calac(AParam2);
    if v1 < v2 then
      Result := v2
    else
      Result := v1;
  end

  else
  if AnsiCompareText(AFuncName, 'RepeatStr2') = 0 then
  begin
    str := ARptEgine.Calac(AParam1);
    n := ARptEgine.Calac(AParam2);
    str2 := '';
    for i := 0 to n - 1 do
      str2 := str2 + str;
    Result := str2;
  end

  else
  if AnsiCompareText(AFuncName, 'GetBySQL2') = 0 then
  begin
    Result := Form1.DoGetbySQL(ARptEgine.Calac(AParam1));
  end;
  
end;

function TMyFuncLib.GetFuncCount: Integer;
begin
  Result := 5;  //返回本库中函数的个数
end;

procedure TMyFuncLib.GetFuncInfo(AFuncID: Integer; var AFuncKind: Integer;
  var AFuncName, AParamDesc, AFuncDesc: WideString);

  procedure _RetInfo(AKind: integer; AName, AParam, ADesc: string);
  begin
    AFuncKind := AKind;
    AFuncName := AName;
    AParamDesc := AParam;
    AFuncDesc := AFuncDesc;
  end;
  
begin
  //询问本库中函数的描述, 在此过程中将函数的描述返回给ACReportEngine，AFuncID 从0到FuncCount - 1
  case AFuncID of
   0: _RetInfo(6, 'GetMyStr2', '', '返回一个固定字符串');
   1: _RetInfo(6, 'DayOf2', 'DateValue', '返回一个日期的天数部分');
   2: _RetInfo(6, 'GetMax2', 'Value1, Value2', '返回两个值中的较大值');
   3: _RetInfo(6, 'RepeatStr2', 'Str, Count', '将指定的字符串重复N遍并返回');
   4: _RetInfo(6, 'GetBySQL2', 'SQL', '执行SQL，并返回一个值');
  end;
end;

end.
 
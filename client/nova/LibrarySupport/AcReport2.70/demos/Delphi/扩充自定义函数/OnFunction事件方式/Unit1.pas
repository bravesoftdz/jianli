unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AcReport_TLB, DB, ADODB;

type
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
    procedure OnFunction(ASender: TObject; const RptEngine: IAcRptEngine; const FuncName: WideString; P1: OleVariant;
                                                       P2: OleVariant; P3: OleVariant; 
                                                       var Value: OleVariant);

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
  FAcRptEngine.OnFunction := OnFunction; //指定事件处理过程

  //加入函数描述，这样用户可以在函数选择窗口看到加入的函数，第一个参数是类别，6表示加入到"其它"类别中
 
  FAcRptEngine.AddFunctionName(6, 'GetMyStr', '', '返回一个固定字符串');
  FAcRptEngine.AddFunctionName(6, 'DayOf', 'DateValue', '返回一个日期的天数部分');
  FAcRptEngine.AddFunctionName(6, 'GetMax', 'Value1, Value2', '返回两个值中的较大值');
  FAcRptEngine.AddFunctionName(6, 'RepeatStr', 'Str, Count', '将指定的字符串重复N遍并返回');
  FAcRptEngine.AddFunctionName(6, 'GetBySQL', 'SQL', '执行SQL，并返回一个值');

  //加入函数描述后，并无实际函数功能，需要响应OnFunction事件，对相应的函数请求进行处理
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FAcRptEngine.Free;
end;

procedure TForm1.OnFunction(ASender: TObject; const RptEngine: IAcRptEngine; const FuncName: WideString;
  P1, P2, P3: OleVariant; var Value: OleVariant);
var
  y,m,d: Word;
  v1, v2: Variant;
  i, n: integer;
  str,str2: string;
begin
  //ACReportEngine在计算报表公式、处理脚本的过程中，如果碰到无法识别的函数，就会触发此过程

  if AnsiCompareText(FuncName, 'GetMyStr') = 0 then //也可以写成 if FuncName = 'GETMYSTR' then
  begin
    Value := 'HI,这是一个自定义函数!';  //Value是返回值。
  end

  else
  if AnsiCompareText(FuncName, 'DayOf') = 0 then
  begin
    DecodeDate(FAcRptEngine.Calac(P1), y, m, d);  //注意是 FAcRptEngine.Calac(P1)，而不是直接使用P1，因为P1可能是一个公式
    Value := d;
  end

  else
  if AnsiCompareText(FuncName, 'GetMax') = 0 then
  begin
    v1 := FAcRptEngine.Calac(P1);
    v2 := FAcRptEngine.Calac(P2);
    if v1 < v2 then
      Value := v2
    else
      Value := v1;  
  end

  else
  if AnsiCompareText(FuncName, 'RepeatStr') = 0 then
  begin
    str := FAcRptEngine.Calac(P1);
    n := FAcRptEngine.Calac(P2);
    str2 := '';
    for i := 0 to n - 1 do
      str2 := str2 + str;
    Value := str2;  
  end

  else
  if AnsiCompareText(FuncName, 'GetBySQL') = 0 then
  begin
    Value := DoGetbySQL(FAcRptEngine.Calac(P1));
  end;
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


end.
 
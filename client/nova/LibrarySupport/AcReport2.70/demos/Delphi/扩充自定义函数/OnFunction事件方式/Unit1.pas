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
  FAcRptEngine.OnFunction := OnFunction; //ָ���¼��������

  //���뺯�������������û������ں���ѡ�񴰿ڿ�������ĺ�������һ�����������6��ʾ���뵽"����"�����
 
  FAcRptEngine.AddFunctionName(6, 'GetMyStr', '', '����һ���̶��ַ���');
  FAcRptEngine.AddFunctionName(6, 'DayOf', 'DateValue', '����һ�����ڵ���������');
  FAcRptEngine.AddFunctionName(6, 'GetMax', 'Value1, Value2', '��������ֵ�еĽϴ�ֵ');
  FAcRptEngine.AddFunctionName(6, 'RepeatStr', 'Str, Count', '��ָ�����ַ����ظ�N�鲢����');
  FAcRptEngine.AddFunctionName(6, 'GetBySQL', 'SQL', 'ִ��SQL��������һ��ֵ');

  //���뺯�������󣬲���ʵ�ʺ������ܣ���Ҫ��ӦOnFunction�¼�������Ӧ�ĺ���������д���
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
  //ACReportEngine�ڼ��㱨��ʽ������ű��Ĺ����У���������޷�ʶ��ĺ������ͻᴥ���˹���

  if AnsiCompareText(FuncName, 'GetMyStr') = 0 then //Ҳ����д�� if FuncName = 'GETMYSTR' then
  begin
    Value := 'HI,����һ���Զ��庯��!';  //Value�Ƿ���ֵ��
  end

  else
  if AnsiCompareText(FuncName, 'DayOf') = 0 then
  begin
    DecodeDate(FAcRptEngine.Calac(P1), y, m, d);  //ע���� FAcRptEngine.Calac(P1)��������ֱ��ʹ��P1����ΪP1������һ����ʽ
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
 
unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, AcReport_TLB, DB, ADODB;

type

 // �� TComponent ����һ���Լ����࣬��ʵ�� IAcFunctionLib �ӿ�
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
    FMyFuncLib: TMyFuncLib; //���庯�����Ա����
    
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
  //���������⣬�����뵽ACReportEngine��
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
  //ACReportEngine�ڼ��㱨��ʽ������ű��Ĺ����У��ͻᴥ���˹��̣����Ը���AFuncID��AFuncName��ȷ��Ҫ�����ĸ���������

  if AnsiCompareText(AFuncName, 'GetMyStr2') = 0 then //Ҳ����д�� if AFuncID = 0 then
  begin
    Result := 'HI,����һ���Զ��庯��!';  //Result�Ƿ���ֵ��
  end

  else
  if AnsiCompareText(AFuncName, 'DayOf2') = 0 then
  begin
    DecodeDate(ARptEgine.Calac(AParam1), y, m, d);  //ע���� ARptEgine.Calac(P1)��������ֱ��ʹ��AParam1����ΪAParam1������һ����ʽ
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
  Result := 5;  //���ر����к����ĸ���
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
  //ѯ�ʱ����к���������, �ڴ˹����н��������������ظ�ACReportEngine��AFuncID ��0��FuncCount - 1
  case AFuncID of
   0: _RetInfo(6, 'GetMyStr2', '', '����һ���̶��ַ���');
   1: _RetInfo(6, 'DayOf2', 'DateValue', '����һ�����ڵ���������');
   2: _RetInfo(6, 'GetMax2', 'Value1, Value2', '��������ֵ�еĽϴ�ֵ');
   3: _RetInfo(6, 'RepeatStr2', 'Str, Count', '��ָ�����ַ����ظ�N�鲢����');
   4: _RetInfo(6, 'GetBySQL2', 'SQL', 'ִ��SQL��������һ��ֵ');
  end;
end;

end.
 
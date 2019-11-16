unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, AcReport_TLB, StdCtrls, AxCtrls, ActiveX;

type

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    fac: TAcRptEngine;
    procedure OnFunc(ASender: TObject; const RptEngine: IAcRptEngine; const FuncName: WideString; P1: OleVariant;
                                                       P2: OleVariant; P3: OleVariant;
                                                       var Value: OleVariant);
    procedure DoBeforePreview(ASender: TObject; const ARptEngine: IAcRptEngine);

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{$R XPStyle.RES}

procedure TForm1.FormCreate(Sender: TObject);
var
  sfile: string;
begin
  fac := TAcRptEngine.Create(nil);
  fac.OnFunction := OnFunc;
  fac.OnBeforePreview := DoBeforePreview;
  sfile := ExtractFilePath(ParamStr(0)) + 'test.apt';
  if FileExists(sfile) then
    fac.LoadFromFile(sfile); 
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  fac.Free;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  //演示加一个自定义表方法
  //ACRptUtils单元里提供了一个 AddCommonDatasetToAcReport 函数，
  //将一个Dataset加入ACReportEngine，也是基于CustDataBuilder对象实现的

 if not fac.CustDataBuilder.TableExist('table1') then
 begin
   fac.CustDataBuilder.NewTable('table1');
   fac.CustDataBuilder.AddStringField('table1', 'field1', 10);
   fac.CustDataBuilder.AddIntegerField('table1', 'int1');
   fac.CustDataBuilder.OpenTable('table1');
   fac.CustDataBuilder.AppendEmptyRow('table1');
   fac.CustDataBuilder.SetFieldValue('table1', 'field1', '123123123');
 end;
 caption := inttostr(fac.LinesCount);
 fac.ShowDesigner;
end;

procedure TForm1.OnFunc(ASender: TObject; const RptEngine: IAcRptEngine; const FuncName: WideString; P1,
  P2, P3: OleVariant; var Value: OleVariant);
begin
  if FuncName = 'SHOWMYFUN' then
  begin
    Value := fac.Calac(P1);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  ALine: IAcLine;
  ACell: IAcCell;
  APage: IAcRptPage;
begin
 fac.GetLineX(1).GetCell(2).BkColor := clYellow;
 fac.GetCellX(1, 2).CellText := 'shao jian';
 fac.GetCellX(1, 2).TextColor := clBlue;
 fac.GetCellX(1, 2).TextSize := 18;
 fac.GetCellX(1, 2).TextStyleBold := true;

 //子报表页面
 if fac.SubPageCount > 0 then
 begin
   APage := fac.GetSubPage(0);
   APage.GetCellX(1, 2).CellText := '子表单元格';
   APage.GetCellX(1, 2).TextSize := 20;
   APage._Release;
 end;

 fac.ShowDesigner;
 
end;

procedure TForm1.DoBeforePreview(ASender: TObject; const ARptEngine: IAcRptEngine);
begin

end;



end.

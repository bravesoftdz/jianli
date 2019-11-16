unit UFrmScheduledeparttime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh,
  NvDbgridEh, DB, DBClient, jsonClientDataSet,UDMPublic;

type
  TFrmScheduledeparttime = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    bbtnClose: TBitBtn;
    nvdbgrdhResult: TNvDbgridEh;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdhResult1: TNvDbgridEh;
    dsResult: TDataSource;
    jcdsResult: TjsonClientDataSet;
    intgrfldResultdistance: TIntegerField;
    fltfldResultruntime: TFloatField;
    wdstrngfldResultendstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultstarttime: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    jcdsReturnwayname: TjsonClientDataSet;
    btn1: TBitBtn;
    btn2: TBitBtn;
    procedure btn2Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduledeparttime: TFrmScheduledeparttime;

implementation

{$R *.dfm}

procedure TFrmScheduledeparttime.btn1Click(Sender: TObject);
begin
  nvdbgrdhResult.PrintPreview;
end;

procedure TFrmScheduledeparttime.btn2Click(Sender: TObject);
begin
   nvdbgrdhResult.ExpDbgrid;
end;

end.

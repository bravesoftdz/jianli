unit UFrmPackDepartinvoicesDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, DB, DBClient, jsonClientDataSet, GridsEh, DBGridEh,
  NvDbgridEh;

type
  TFrmPackDepartinvoicesDetail = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jcdsquerydepartdetail: TjsonClientDataSet;
    ds1: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    departinvoicesid:Int64;
  end;

var
  FrmPackDepartinvoicesDetail: TFrmPackDepartinvoicesDetail;

implementation

{$R *.dfm}

procedure TFrmPackDepartinvoicesDetail.FormShow(Sender: TObject);
begin
  inherited;
  with jcdsquerydepartdetail do
    begin
     Active:=false;
     begin
       Params.ParamValues['filter_EQL_pdd!packdepartinvoicesid'] := departinvoicesid;
     end;
     Active:=true;
    end;
end;

end.

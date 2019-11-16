unit UFrmVipTurnoverprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmVipTurnoverprint = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    nvhlpseller: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    turnoverid : Integer;
  end;

var
  FrmVipTurnoverprint: TFrmVipTurnoverprint;

implementation

uses Services, PubFn, UFrmVipturnoverEdit;
{$R *.dfm}

procedure TFrmVipTurnoverprint.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
end;

procedure TFrmVipTurnoverprint.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_v!turnoverdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime) + ' 00:00:00';
      Params.ParamValues['filter_LED_v!turnoverdate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime)+ ' 23:59:59';
      if Trim(nvhlpseller.Text) = '' then
        Params.ParamValues['filter_EQL_v!sellid'] := ''
      else
        Params.ParamValues['filter_EQL_v!sellid'] := nvhlpseller.Id;

    Active := True;
  end;
end;

procedure TFrmVipTurnoverprint.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  if not SysDialogs.Confirm('信息提示', '是否重打缴款单!') then
    exit;
  with FrmVipturnoverEdit do
  begin
    FrmVipturnoverEdit := TFrmVipturnoverEdit.Create(Self);
    turnoverid := jcdsResult.FieldByName('id').AsInteger;
    printVipcardturnover(turnoverid);

    ModalResult := mrOk;
    FrmVipTurnoverprint.Close;
  end;
end;

end.

unit UFrmVipsellticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, NovaComboBox;

type
  TFrmVipsellticket = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    nvcbbvipgrade: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVipsellticket: TFrmVipsellticket;

implementation

{$R *.dfm}

procedure TFrmVipsellticket.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvcbbvipgrade.Active := False;
  nvcbbvipgrade.Active := True;
end;

procedure TFrmVipsellticket.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_t!orgid'] := nvckbOrgid.GetSelectID;
      Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime);
      if trim(nvcbbvipgrade.Text) = '' then
        Params.ParamValues['filter_INS_v!vipgrade'] := ''
      else
        Params.ParamValues['filter_INS_v!vipgrade'] := nvcbbvipgrade.GetSelectID;
    Active := True;
  end;
end;

end.

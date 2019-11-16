unit UFrmQueryPackReceive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmQueryPackReceive = class(TSimpleCRUDForm)
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    jcdsResultshipprice: TFloatField;
    jcdsResulthandfee: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultORGID: TLargeintField;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    Label9: TLabel;
    nvhelpvehiclecode: TNovaHelp;
    jcdsResultorgname: TWideStringField;
    jcdsResultdepartdate: TWideStringField;
    jcdsResultpieces: TIntegerField;
    jcdsResultpackfee: TFloatField;
    jcdsResultgoodsprice: TFloatField;
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmQueryPackReceive: TFrmQueryPackReceive;

implementation

{$R *.dfm}

procedure TFrmQueryPackReceive.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmQueryPackReceive.FormCreate(Sender: TObject);
begin
  inherited;

  dtpstartdate.DateTime :=Now();
  dtpenddate.DateTime :=Now();

end;


procedure TFrmQueryPackReceive.FormShow(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := true;

end;

procedure TFrmQueryPackReceive.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
end;

procedure TFrmQueryPackReceive.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;


procedure TFrmQueryPackReceive.tbtnFilterClick(Sender: TObject);
begin
  inherited;
    nvcbborg.SetFocus;
  if (nvcbborg.CheckedCount = 0) then
  begin
    SysDialogs.ShowMessage('ÇëÑ¡Ôñ»ú¹¹£¡');
    nvcbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;

    Params.ParamValues['filter_INS_pk!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_pk!signdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_pk!signdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime+1);

    if nvhelpvehiclecode.Id<=0 then
      Params.ParamValues['filter_EQL_p!vehicleid'] := ''
    else
      Params.ParamValues['filter_EQL_p!vehicleid'] := nvhelpvehiclecode.Id;

    Active := true;


  end;
end;

end.

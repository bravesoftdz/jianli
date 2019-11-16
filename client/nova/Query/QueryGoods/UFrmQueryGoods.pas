unit UFrmQueryGoods;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NovaHelp, Services, UDMPublic, PubFn,
  NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox, NovaHComboBox;

type
  TFrmQueryGoods = class(TSimpleCRUDForm)
    ilsmalltools: TImageList;
    splmid: TSplitter;
    Label2: TLabel;
    jcdsResulttotalfee: TFloatField;
    jcdsResultORGID: TLargeintField;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl4: TLabel;
    nvcbborg: TNovaCheckedComboBox;
    jcdsResultorgname: TWideStringField;
    Label8: TLabel;
    nvhlpseller: TNovaHelp;
    chkgroup: TCheckBox;
    jcdsResultsellbyname: TWideStringField;
    jcdsResultdepositpieces: TLargeintField;
    jcdsResultdepositprice: TFloatField;
    jcdsResultrecaptionspieces: TLargeintField;
    jcdsResultrecaptionsprice: TFloatField;
    jcdsResultsellbytime: TWideStringField;
    procedure edtnameKeyPress(Sender: TObject; var Key: Char);
    procedure NvHpendstationKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure chkgroupClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);

  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmQueryGoods: TFrmQueryGoods;

implementation

{$R *.dfm}

procedure TFrmQueryGoods.chkgroupClick(Sender: TObject);
begin
  inherited;
    if chkgroup.Checked then
  begin
    nvhlpseller.Enabled := True;
    nvhlpseller.Visible := True;
    Label8.Visible := True;
  end
  else
  begin
    nvhlpseller.Enabled := False;
    nvhlpseller.Visible := False;
    Label8.Visible := False;
  end;
end;

procedure TFrmQueryGoods.edtnameKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;

procedure TFrmQueryGoods.FormCreate(Sender: TObject);
begin
  inherited;

  dtpstartdate.DateTime :=Now();
  dtpenddate.DateTime :=Now();

end;


procedure TFrmQueryGoods.FormShow(Sender: TObject);
begin
  inherited;
  nvcbborg.Active := true;

end;

procedure TFrmQueryGoods.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
end;

procedure TFrmQueryGoods.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if chkgroup.Checked then
      dbgrdhResult.Columns[2].Visible :=True
  else
     dbgrdhResult.Columns[2].Visible :=False;
end;

procedure TFrmQueryGoods.NvHpendstationKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if Key = #13 then
    tbtnFilterClick(Sender);
end;


procedure TFrmQueryGoods.tbtnFilterClick(Sender: TObject);
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

    Params.ParamValues['filter_INS_g!orgid'] := nvcbborg.GetSelectID;
    Params.ParamValues['filter_GED_g!startdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_g!enddate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);
    Params.ParamValues['filter_INS_g!status'] :='(0,1)';

    if chkgroup.Checked then
    begin
      params.ParamValues['isbysellgroup'] := True;
      if Trim(nvhlpseller.Text) = '' then
        params.ParamValues['filter_EQL_g!consignee'] := ''
      else if nvhlpseller.Id > 0 then
        params.ParamValues['filter_EQL_g!consignee'] := nvhlpseller.Id
      else
        params.ParamValues['filter_EQL_g!consignee'] := '';
    end else
    begin
        params.ParamValues['isbysellgroup'] := False;
        params.ParamValues['filter_EQL_g!consignee'] := '';
    end;

    Active := true;


  end;
end;

end.



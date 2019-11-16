unit UFrmRouteBalancePrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,UDMPublic,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp;

type
  TFrmRouteBalancePrice = class(TSimpleCRUDForm)
    lblroute: TLabel;
    Label2: TLabel;
    lblworkways: TLabel;
    nvhelpRoute: TNovaHelp;
    dtpstartdate: TDateTimePicker;
    nvcbbworkways: TNovaCheckedComboBox;
    Label10: TLabel;
    NovaChkSaleOrg: TNovaCheckedComboBox;
    Label1: TLabel;
    NovachkPorg: TNovaCheckedComboBox;
    Label3: TLabel;
    dtpenddate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovachkPorgCheckClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRouteBalancePrice: TFrmRouteBalancePrice;

implementation
 uses PubFn, Services;
{$R *.dfm}

procedure TFrmRouteBalancePrice.FormShow(Sender: TObject);
begin
  inherited;
  NovachkPorg.Active:= False;
  NovachkPorg.Active := True;
  NovachkPorg.OnCheckClick:=nil;
  NovachkPorg.CheckById(true,sysinfo.LoginUserInfo.POrgID);
  NovachkPorg.OnCheckClick:=NovachkPorgCheckClick;
  NovaChkSaleOrg.Active := False;
  NovaChkSaleOrg.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
  NovaChkSaleOrg.Active := True;
  NovaChkSaleOrg.CheckAll(true);
  nvcbbworkways.Active:=false;
  nvcbbworkways.Active:=true;
  nvcbbworkways.SelectAll;
  dtpstartdate.Date:=now;
  dtpenddate.Date:=now;
end;

procedure TFrmRouteBalancePrice.NovachkPorgCheckClick(Sender: TObject);
begin
  inherited;
  if NovachkPorg.GetSelectID<>'' then
  begin
    NovaChkSaleOrg.Active := False;
    NovaChkSaleOrg.Params.ParamValues['orgids']:=NovachkPorg.GetSelectID;
    NovaChkSaleOrg.Active := True;
    NovaChkSaleOrg.CheckAll(true);
  end;
end;

procedure TFrmRouteBalancePrice.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if NovaChkSaleOrg.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ����Ʊ������');
    exit;
  end;
  if nvcbbworkways.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ��Ӫ�˷�ʽ��');
    exit;
  end;
  if dtpstartdate.Date > dtpenddate.Date then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    Exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := NovaChkSaleOrg.GetSelectID;
    if nvhelpRoute.Id > 0 then
      Params.ParamValues['routeid'] := nvhelpRoute.Id
    else
      Params.ParamValues['routeid'] := 0;
    Params.ParamValues['startdate'] := formatdatetime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := formatdatetime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['workways'] :=nvcbbworkways.GetSelectID;
      Active := true;
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '�Ʊ������' + sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight := '�������ڣ�' + formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date) +'  ��'+ formatdatetime
      ('yyyy-mm-dd', dtpenddate.Date);
  end;
end;

end.

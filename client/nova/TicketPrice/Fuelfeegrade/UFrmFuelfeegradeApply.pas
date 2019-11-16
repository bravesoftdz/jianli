unit UFrmFuelfeegradeApply;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHComboBox, ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB,
  DBClient, jsonClientDataSet, NovaHelp;

type
  TFrmFuelfeegradeApply = class(TSimpleEditForm)
    Label1: TLabel;
    Label11: TLabel;
    NovaHCobOrg: TNovaHComboBox;
    Label2: TLabel;
    Label3: TLabel;
    DpFromDate: TDateTimePicker;
    NovaHCobGrade: TNovaHComboBox;
    dptoDate: TDateTimePicker;
    jscdSaveFuelfeegradeapply: TjsonClientDataSet;
    jscdQryRoutes: TjsonClientDataSet;
    DataSource1: TDataSource;
    GroupBox1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jscdQryRoutesselected: TBooleanField;
    jscdQryRoutesid: TLargeintField;
    jscdQryRoutesname: TWideStringField;
    jscdQryRoutesjianpin: TWideStringField;
    Label4: TLabel;
    NovaHRoute: TNovaHelp;
    Label5: TLabel;
    NovaVehicletype: TNovaHComboBox;
    Label9: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHCobOrgChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby,fuelfeegradeid: int64;
    createtime:string;
  end;

var
  FrmFuelfeegradeApply: TFrmFuelfeegradeApply;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmFuelfeegradeApply.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
  if NovaHCobOrg.ItemIndex < 0 then
  begin
    SysDialogs.Warning('��ѡ�������');
    NovaHCobOrg.SetFocus;
    exit;
  end;
  if NovaHCobGrade.ItemIndex < 0 then
  begin
    SysDialogs.Warning('��ѡ���ͼ۵��Σ�');
    NovaHCobGrade.SetFocus;
    exit;
  end;
  if (NovaHRoute.id = 0) or(NovaHRoute.Text='') then
  begin
    SysDialogs.Warning('������Ӧ�õ���·��');
    NovaHRoute.SetFocus;
    exit;
  end;
  if formatdatetime('yyyymmdd',DpFromDate.date)>formatdatetime('yyyymmdd',dptoDate.date) then
  begin
    SysDialogs.Warning('Ӧ�õĿ�ʼ���ڲ��ܴ��ڽ������ڣ�');
    DpFromDate.SetFocus;
    exit;
  end;
  try
    with jscdSaveFuelfeegradeapply do
    begin
      active := false;
      Params.ParamValues['fuelfeegradeapply.id'] := id;
      Params.ParamValues['fuelfeegradeapply.fuelfeegradeid'] :=NovaHCobGrade.HelpFieldValue['id'];
      Params.ParamValues['fuelfeegradeapply.fromdate'] :=formatdatetime('yyyy-mm-dd',DpFromDate.date);
      Params.ParamValues['fuelfeegradeapply.todate'] := formatdatetime('yyyy-mm-dd',dptoDate.date);
      Params.ParamValues['fuelfeegradeapply.routeid'] := NovaHRoute.Id;
      Params.ParamValues['fuelfeegradeapply.createby'] := createby;
      if NovaVehicletype.ItemIndex>=0  then
         Params.ParamValues['fuelfeegradeapply.vehicletype.id'] := NovaVehicletype.HelpFieldValue['id'];
      Params.ParamValues['fuelfeegradeapply.updateby'] := sysinfo.LoginUserInfo.UserID;
      if createtime<>'' then
        Params.ParamValues['fuelfeegradeapply.createtime'] := createtime;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          optype := '�޸�'
        else
          optype := '���';
        log := optype +'Ӧ��ȼ�͸��ӷ���Ϣ������='+NovaHCobOrg.Text
        +'��·����='+NovaHRoute.Text+'�ͼ۵���='
        +NovaHCobGrade.Text+',��ʼ����='+formatdatetime('yyyy-mm-dd',DpFromDate.date)+
        ',��������='+formatdatetime('yyyy-mm-dd',dptoDate.date);
        SysLog.WriteLog('Ʊ�۹���->ȼ�͸��ӷ�����',optype,log);
        id := Params.ParamByName('id').Value;
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        DpFromDate.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('����Ӧ��ȼ�͸��ӷ���Ϣ����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmFuelfeegradeApply.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCobOrg.Active := false;
  NovaHCobOrg.Active := true;
  NovaVehicletype.Active:=false;
  NovaVehicletype.Active:=true;
end;

procedure TFrmFuelfeegradeApply.FormShow(Sender: TObject);
begin
  inherited;
  NovaHCobOrg.SetItemIndexByField('id', sysinfo.LoginUserInfo.OrgID);
  if NovaHCobOrg.ItemIndex>=0 then
  begin
    NovaHRoute.Params.ParamValues['filter_EQL_t!orgid']:=NovaHCobOrg.HelpFieldValue['id'];
    NovaHCobGrade.Active := false;
    NovaHCobGrade.Params.ParamValues['orgid'] := NovaHCobOrg.HelpFieldValue['id'];
    NovaHCobGrade.Active := true;
    NovaHCobGrade.SetItemIndexByField('id',fuelfeegradeid);
  end;
  NovaHRoute.SetFocus;
end;

procedure TFrmFuelfeegradeApply.NovaHCobOrgChange(Sender: TObject);
begin
  inherited;
  if NovaHCobOrg.ItemIndex>=0 then
  BEGIN
    NovaHRoute.Params.ParamValues['filter_EQL_t!orgid']:=NovaHCobOrg.HelpFieldValue['id'];
    NovaHCobGrade.Active := false;
    NovaHCobGrade.Params.ParamValues['orgid'] := NovaHCobOrg.HelpFieldValue['id'];
    NovaHCobGrade.Active := true;
  END;
end;

end.

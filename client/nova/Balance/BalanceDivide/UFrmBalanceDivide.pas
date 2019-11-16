unit UFrmBalanceDivide;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmBalanceDivide = class(TSimpleCRUDForm)
    NovaCkbOrg: TNovaCheckedComboBox;
    Label1: TLabel;
    Label8: TLabel;
    NovaHelpVehicle: TNovaHelp;
    Label9: TLabel;
    NHelpRoute: TNovaHelp;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label2: TLabel;
    NovaHDivideUnit: TNovaHelp;
    jsonDelBalanceDivide: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBalanceDivide: TFrmBalanceDivide;

implementation
uses PubFn,Services,UDMPublic, UFrmBalanceDivideEdt;
{$R *.dfm}

procedure TFrmBalanceDivide.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCkbOrg.CheckById(true, sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmBalanceDivide.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult,log: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jsonDelBalanceDivide do
  try
    close;
    Params.ParamByName('balancedivide.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    log := 'ɾ������ֲ�Э����Ϣ��Ӫ����·='+jcdsResult.FieldByName('routename').AsString+
      ',Ӫ�˳���='+jcdsResult.FieldByName('vehicleno').AsString+',���㵥λ='+
      jcdsResult.FieldByName('balanceunit').AsString+ ',�ֲ����='+
      jcdsResult.FieldByName('divide').AsString;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('�������->����ֲ�Э��','ɾ��',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('����ֲ�Э��ɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmBalanceDivide.tbtnEditClick(Sender: TObject);
var
  curid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmBalanceDivideEdt := TFrmBalanceDivideEdt.Create(self);
  with FrmBalanceDivideEdt do
  begin
    Caption := '�޸Ľ���ֲ�Э��';
    edittype:=Tedittype.update;
    id := jcdsResult.FieldByName('id').AsLargeInt;
    NovaHCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt) ;
    NovaHCbbOrg.Enabled:=false;
    NHelpRoute.Id:=jcdsResult.FieldByName('routeid').AsLargeInt ;
    NHelpRoute.text:=jcdsResult.FieldByName('routename').AsString ;
    NovaHelpVehicle.Id:=jcdsResult.FieldByName('vehicleid').AsLargeInt ;
    NovaHelpVehicle.text:=jcdsResult.FieldByName('vehicleno').AsString ;
    NovaHelpUnit.Id:=jcdsResult.FieldByName('balanceunitid').AsLargeInt ;
    NovaHelpUnit.text:=jcdsResult.FieldByName('balanceunit').AsString ;
    NovaHDivideVehicle.Id:=jcdsResult.FieldByName('dividevehicleid').AsLargeInt ;
    NovaHDivideVehicle.text:=jcdsResult.FieldByName('dividevehicleno').AsString ;
    NovaEdtDivide.text:=jcdsResult.FieldByName('divide').AsString ;
    createtime:= jcdsResult.FieldByName('createtime').AsString ;
    createby:=jcdsResult.FieldByName('createby').AsLargeInt ;
    curid:=id ;
    if SysMainForm.showFormModal(FrmBalanceDivideEdt) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',curid,[]);
    end;
  end;
end;

procedure TFrmBalanceDivide.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if NovaCkbOrg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_t!orgid'] :=
        sysinfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_t!orgid'] := NovaCkbOrg.GetSelectID;
    if NHelpRoute.Id>0 then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.id
    else
       Params.ParamValues['filter_EQL_r!id'] :=null;
    if NovaHelpVehicle.Id>0 then
      Params.ParamValues['filter_EQL_t!vehicleid'] := NovaHelpVehicle.id
    else
       Params.ParamValues['filter_EQL_t!vehicleid'] :=null;
    if NovaHelpUnit.Id>0 then
      Params.ParamValues['filter_EQL_v!balanceunitid'] := NovaHelpUnit.id
    else
       Params.ParamValues['filter_EQL_v!balanceunitid'] :=null;
    if NovaHDivideUnit.Id>0 then
      Params.ParamValues['filter_EQL_t!divideunitid'] := NovaHDivideUnit.id
    else
       Params.ParamValues['filter_EQL_t!divideunitid'] :=null;
    Active := true;

  end;

end;

procedure TFrmBalanceDivide.tbtnInsertClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;
  FrmBalanceDivideEdt := TFrmBalanceDivideEdt.Create(self);
  try
    with FrmBalanceDivideEdt do
    begin
      Caption := '��ӽ���ֲ�Э��';
      if SysMainForm.showFormModal(FrmBalanceDivideEdt,false) = mrok then
      begin
         curid :=id;
         tbtnFilterClick(Sender);
         jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmBalanceDivideEdt);
  end;
end;

end.

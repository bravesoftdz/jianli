unit UFrmPrintItemSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHComboBox, NovaEdit, NovaHelp;

type
  TFrmPrintItemSet = class(TSimpleCRUDForm)
    lbl3: TLabel;
    NovaHelpVehiclenos: TNovaHelp;
    Label1: TLabel;
    NovaHCbbTypes: TNovaHComboBox;
    Label2: TLabel;
    NovaHCbbTypeItems: TNovaHComboBox;
    jscdDelItem: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaHCbbTypesChange(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }

  end;

var
  FrmPrintItemSet: TFrmPrintItemSet;

implementation

uses UFrmPrintItemSetEdt, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmPrintItemSet.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbTypes.Active:=false;
  NovaHCbbTypes.Active:=true;
end;

procedure TFrmPrintItemSet.NovaHCbbTypesChange(Sender: TObject);
begin
  inherited;
  if (NovaHCbbTypes.Active) and (NovaHCbbTypes.ItemIndex>=0) then
  begin
     NovaHCbbTypeItems.Active:=false;
     NovaHCbbTypeItems.Params.ParamValues['filter_EQL_t!printtemplatetype.id']:=NovaHCbbTypes.HelpFieldValue['id'];
     NovaHCbbTypeItems.Active:=true;
  end;
end;

procedure TFrmPrintItemSet.tbtnDeleteClick(Sender: TObject);
var
  sResult: string;
  nResult,scheduleid:integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;

  if SysDialogs.Confirm('删除操作','确认要删除该记录吗？') then
  with jscdDelItem do
  begin
    Active := false;
    Params.ParamValues['printtemplateitemset.id'] := jcdsResult.FieldByName('id').AsLargeInt;
    execute;
    sResult := Params.ParamByName('msg').Value;
    nResult := Params.ParamByName('flag').Value;
    if (nResult = 1) then
    begin
      log := '删除不打印项目设置：打印票据='+jcdsResult.FieldByName('templatename').AsString+
      ',打印项目='+jcdsResult.FieldByName('itemname').AsString+',车牌号码='+
      jcdsResult.FieldByName('vehicleno').AsString;
      SysLog.WriteLog('综合检票——>不打印项目设置','删除',log);
      SysDialogs.ShowMessage(sResult);
      tbtnFilterClick(sender);
    end
    else
      SysDialogs.Warning(sResult);
  end;

end;

procedure TFrmPrintItemSet.tbtnEditClick(Sender: TObject);
var
  curid:int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount<=0 then
     exit;

  FrmPrintItemSetEdt := TFrmPrintItemSetEdt.Create(self);
  try
    with FrmPrintItemSetEdt do
    begin
      Caption := '修改不打印项目信息';
      orgid    := SysInfo.LoginUserInfo.OrgID;
      curid:=  jcdsResult.FieldByName('id').AsLargeInt;
      id:=  jcdsResult.FieldByName('id').AsLargeInt;
      createtime:=  jcdsResult.FieldByName('createtime').AsString;
      createby :=  jcdsResult.FieldByName('createby').AsLargeInt;
      NovaHCbbType.SetItemIndexByField('id',jcdsResult.FieldByName('printtemplatetypeid').AsLargeInt);
      NovaHelpVehicleno.Text:= jcdsResult.FieldByName('vehicleno').AsString;
      NovaHelpVehicleno.id:= jcdsResult.FieldByName('vehicleid').AsLargeInt;
      edittype := Tedittype.update;
      NovaHCbbTypeChange(nil);
      NovaHCbbTypeItem.SetItemIndexByField('id',jcdsResult.FieldByName('printtemplatetypeitemid').AsLargeInt);
      if SysMainForm.showFormModal(FrmPrintItemSetEdt,false) = mrok then
      begin
         curid:=id;
         tbtnFilterClick(Sender);
         jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmPrintItemSetEdt);
  end;

end;

procedure TFrmPrintItemSet.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if NovaHCbbTypes.ItemIndex>0 then
      Params.ParamValues['filter_EQL_p!id'] := NovaHCbbTypes.HelpFieldValue['id']
    else
      Params.ParamValues['filter_EQL_p!id'] := null;


    if (NovaHCbbTypeItems.ItemIndex >= 0) then
      Params.ParamValues['filter_EQL_ps!printtemplatetypeitemid'] :=
        NovaHCbbTypeItems.HelpFieldValue['id']
    else
      Params.ParamValues['filter_EQL_ps!printtemplatetypeitemid'] := null;
    if (Trim(NovaHelpVehiclenos.Text)<>'') and (NovaHelpVehiclenos.Id>0)  then
      Params.ParamValues['filter_EQL_ps!vehicleid'] := NovaHelpVehiclenos.Id
    else
         Params.ParamValues['filter_EQL_ps!vehicleid'] := null;

    Active := true;
  end;
end;

procedure TFrmPrintItemSet.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  FrmPrintItemSetEdt := TFrmPrintItemSetEdt.Create(self);
  try
    with FrmPrintItemSetEdt do
    begin
      Caption := '添加不打印项目设置信息';
      createby := SysInfo.LoginUserInfo.UserID;
      orgid := SysInfo.LoginUserInfo.orgid;
      createtime:=FormatDateTime('yyyy-mm-dd hh:mm:ss',Now);
      edittype := add;
      if SysMainForm.showFormModal(FrmPrintItemSetEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmPrintItemSetEdt);
  end;

end;

end.

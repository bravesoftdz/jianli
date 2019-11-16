unit UFrmSchedulestationcontrol;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping, NovaComboBox, NovaHComboBox, NovaEdit,
  NovaHelp;

type
  TFrmSchedulestationcontrol = class(TSimpleCRUDForm)
    lbl2: TLabel;
    nvdbgrdh1: TNvDbgridEh;
    nvdbgrdh2: TNvDbgridEh;
    jcdsDel: TjsonClientDataSet;
    nvhlpRoute: TNovaHelp;
    lbl5: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    lblendstationname: TLabel;
    nvhlpendstation: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSchedulestationcontrol: TFrmSchedulestationcontrol;

implementation
  uses PubFn, Services,UFrmSchedulestationcontrolEdit,UDMPublic;
{$R *.dfm}

procedure TFrmSchedulestationcontrol.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := true;
end;


procedure TFrmSchedulestationcontrol.tbtnEditClick(Sender: TObject);
begin
  if jcdsResult.RecordCount<=0 then
  begin
    SysDialogs.Warning('没有选中的记录!');
    Exit;
  end;
  frmSchedulestationcontrolEdit := TfrmSchedulestationcontrolEdit.Create(self);
  try
    with frmSchedulestationcontrolEdit do
    begin
      edittype:=Tedittype.update;
      Caption := '修改班次站点售票控制';
      id := jcdsResult.FieldByName('id').AsInteger;
      orgname := jcdsResult.FieldByName('departorgname').AsString;
      nvhcbbOrg.SetItemIndexByField('name',
                        jcdsResult.FieldByName('departorgname').AsString);
      createby:=jcdsResult.FieldByName('createby').AsLargeInt;
      createtime:=jcdsResult.FieldByName('createtime').AsString;
      nvhlpRoute.Text := jcdsResult.FieldByName('routename').AsString;
      nvhlpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      nvhlpRoute.Enabled := false;
      nvhcbbOrg.Enabled := false;
      isupdate :='true';


      if SysMainForm.showFormModal(frmSchedulestationcontrolEdit, False) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('routeid', routeid, []);
      end;
    end;
  finally
    FreeAndNil(frmSchedulestationcontrolEdit);
  end;

end;

procedure TFrmSchedulestationcontrol.tbtnFilterClick(Sender: TObject);
begin
   if (NovaCkbOrg.CheckedCount=0) then
  begin
    SysDialogs.ShowMessage('请选择班次机构！');
    NovaCkbOrg.SetFocus;
    exit;
  end;

with jcdsResult do
  begin
   Active := False;
    Params.ParamByName('filter_INS_o!id').Value := NovaCkbOrg.GetSelectID;
    if nvhlpendstation.id <= 0 then
        Params.ParamValues['filter_EQL_sst!stationid'] := ''
    else
        Params.ParamValues['filter_EQL_sst!stationid'] := nvhlpendstation.id ;
    if nvhlpRoute.Id>0 then
    Params.ParamByName('filter_EQL_r!id').Value := nvhlpRoute.Id
    else
    Params.ParamByName('filter_EQL_r!id').Value := '';
    Active := True;
  end;
end;

procedure TFrmSchedulestationcontrol.tbtnInsertClick(Sender: TObject);

begin
  inherited;
  frmSchedulestationcontrolEdit := TfrmSchedulestationcontrolEdit.Create(self);
  try
    with frmSchedulestationcontrolEdit do
    begin
      Caption := '添加班次站点售票控制';
      isupdate :='false';
      edittype := add;
      createby:=SysInfo.LoginUserInfo.UserID;
      if SysMainForm.showFormModal(frmSchedulestationcontrolEdit, False) = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('routeid', routeid, []);
      end;
    end;
  finally
    FreeAndNil(frmSchedulestationcontrolEdit);
  end;

end;

procedure TFrmSchedulestationcontrol.ToolButton50Click(Sender: TObject);
var  nResult: integer;
  sResult,log: string;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该线路的所有站点控制吗!') then
    exit;

  with jcdsDel do
    try
      close;
       Params.ParamByName('orgid').Value :=
                jcdsResult.FieldByName('departorgid').AsString;
       Params.ParamByName('routeid').Value :=
                jcdsResult.FieldByName('routeid').AsString;
       Params.ParamByName('stationid').Value :='0';
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := ' 删除'+jcdsResult.FieldByName('departorgname').AsString
        +' 的 线路:'+jcdsResult.FieldByName('routename').AsString
        +' 的所有站点控制!';
        SysLog.WriteLog('业务管理->班次站点售票控制', '删除线路控制', log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('删除失败：' + E.Message);
      end;
    end;
end;


procedure TFrmSchedulestationcontrol.tbtnDeleteClick(Sender: TObject);
var  nResult: integer;
  sResult,log: string;
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该站点控制吗!') then
    exit;

  with jcdsDel do
    try
      close;
       Params.ParamByName('orgid').Value :=
                jcdsResult.FieldByName('departorgid').AsString;
       Params.ParamByName('routeid').Value :=
                jcdsResult.FieldByName('routeid').AsString;
       Params.ParamByName('stationid').Value :=
                jcdsResult.FieldByName('stationid').AsString;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        log := ' 删除'+jcdsResult.FieldByName('departorgname').AsString
        +' 的 线路:'+jcdsResult.FieldByName('routename').AsString
        +' 站点名称:'+jcdsResult.FieldByName('stationname').AsString;
        SysLog.WriteLog('业务管理->班次站点售票控制', '删除站点控制', log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('删除失败：' + E.Message);
      end;
    end;

end;
end.

unit UFrmFunctionManager;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls,UDMPublic;

type
  TFrmFunctionManager = class(TSimpleCRUDForm)
    jcdsFunctionDelete: TjsonClientDataSet;
    jcdsFunctionPermission: TjsonClientDataSet;
    dsFunctionPermission: TDataSource;
    jcdsFunctionPermissiondel: TjsonClientDataSet;
    pnlright: TPanel;
    ilsmalltools: TImageList;
    gbdetail: TGroupBox;
    nvdbgrdhdetail: TNvDbgridEh;
    tlbdetail: TToolBar;
    tbtn2: TToolButton;
    btnadddetail: TToolButton;
    tbtn7: TToolButton;
    btnUpdatedetail: TToolButton;
    tbtn8: TToolButton;
    btndeletedetail: TToolButton;
    lblname: TLabel;
    edtname: TEdit;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure btnadddetailClick(Sender: TObject);
    procedure btnUpdatedetailClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure btndeletedetailClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmFunctionManager: TFrmFunctionManager;

implementation

uses UFrmFunctionManagerEdit, UFrmFunctionPermissionEdit,services;

{$R *.dfm}

procedure TFrmFunctionManager.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with jcdsFunctionPermission do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_fm!functionregid']:=jcdsResult.FieldByName('id').AsString;
    Active:=true;
  end;
end;

procedure TFrmFunctionManager.btnadddetailClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  FrmFunctionPermissionEdit:=TFrmFunctionPermissionEdit.Create(self,self.functionItem);
  try
    with FrmFunctionPermissionEdit do
    begin
      functionregid:=self.jcdsResult.FieldByName('id').AsLargeInt;
      Caption:='添加可分配权限子功能';
      edittype:=Tedittype.add;
    end;
    if SysMainForm.showFormModal(FrmFunctionPermissionEdit,false)=mrOk then
    begin
      id := FrmFunctionPermissionEdit.operationid;
      jcdsResultAfterScroll(nil);
      jcdsFunctionPermission.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmFunctionPermissionEdit);
  end;
end;

procedure TFrmFunctionManager.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该功能吗？') then
    begin
      exit;
    end;
    with jcdsFunctionDelete do
    begin
      Params.ParamValues['functionreg.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        log := '删除功能管理：功能名='+jcdsResult.FieldByName('name').AsString+
        ',包名='+jcdsResult.FieldByName('packagename').AsString+',GUID='+
        jcdsResult.FieldByName('functionkey').AsString+',参数说明='+
        jcdsResult.FieldByName('parameterdescribe').AsString;
        SysLog.WriteLog('系统管理->功能管理','删除',log);
        tbtnFilter.Click;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;;
end;

procedure TFrmFunctionManager.btndeletedetailClick(Sender: TObject);
begin
  inherited;
  if (jcdsFunctionPermission.Active=True) and (jcdsFunctionPermission.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该子功能吗？') then
    begin
      exit;
    end;
    with jcdsFunctionPermissiondel do
    begin
      Params.ParamValues['functionpermissionreg.id']:=jcdsFunctionPermission.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        log := '删除功能管理可分配权限子功能：功能名='+
        jcdsFunctionPermission.FieldByName('permissionname').AsString+
        ',GUID='+jcdsFunctionPermission.FieldByName('permissionkey').AsString;
        SysLog.WriteLog('系统管理->功能管理','删除',log);
        jcdsResultAfterScroll(nil);
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;;
end;

procedure TFrmFunctionManager.tbtnEditClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmFunctionManagerEdit:=TFrmFunctionManagerEdit.Create(self,self.functionItem);
    try
      with FrmFunctionManagerEdit do
      begin
        Caption:='修改功能';
        edittype:=Tedittype.update;
        nvedtname.Text:=self.jcdsResult.FieldByName('NAME').AsString;
        nvedtkey.Text:=self.jcdsResult.FieldByName('functionkey').AsString;
        lblpackagename.Caption:=self.jcdsResult.FieldByName('packagename').AsString;
        mmodescribe.Text:=self.jcdsResult.FieldByName('functiondescribe').AsString;
        mmoParamdescribe.Text:=self.jcdsResult.FieldByName('parameterdescribe').AsString;
        operationid:=self.jcdsResult.FieldByName('id').AsLargeInt;
        createtime:=self.jcdsResult.FieldByName('createtime').AsString;
        createby:=self.jcdsResult.FieldByName('createby').AsString;
        updatetime:=self.jcdsResult.FieldByName('updatetime').AsString;
        updateby:=self.jcdsResult.FieldByName('updateby').AsString;
      end;
      if SysMainForm.showFormModal(FrmFunctionManagerEdit,false)=mrok then
      begin
        id := FrmFunctionManagerEdit.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmFunctionManagerEdit);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmFunctionManager.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_LIKES_f!name_OR_f!functiondescribe']:=trim(edtname.Text);
    jcdsResult.AfterScroll:=nil;
    try
      Active:=true;
      if recordcount>0 then
      begin
        jcdsResultAfterScroll(nil);
      end;
    finally
      jcdsResult.AfterScroll:=jcdsResultAfterScroll;
    end;
  end;
end;

procedure TFrmFunctionManager.tbtnInsertClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  FrmFunctionManagerEdit:=TFrmFunctionManagerEdit.Create(self,self.functionItem);
  try
    FrmFunctionManagerEdit.Caption:='添加功能';
    FrmFunctionManagerEdit.edittype:=Tedittype.add;
    if SysMainForm.showFormModal(FrmFunctionManagerEdit,false)=mrOk then
    begin
      id := FrmFunctionManagerEdit.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmFunctionManagerEdit);
  end;
end;

procedure TFrmFunctionManager.btnUpdatedetailClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmFunctionPermissionEdit:=TFrmFunctionPermissionEdit.Create(self,self.functionItem);
    try
      with FrmFunctionPermissionEdit do
      begin
        Caption:='修改可控权限子功能';
        edittype:=Tedittype.update;
        operationid:=self.jcdsFunctionPermission.FieldByName('id').AsLargeInt;
        functionregid:=self.jcdsResult.FieldByName('id').AsLargeInt;
        nvedtname.Text:=self.jcdsFunctionPermission.FieldByName('permissionname').AsString;
        nvedtkey.Text:=self.jcdsFunctionPermission.FieldByName('permissionkey').AsString;
        mmodescribe.Text:=self.jcdsFunctionPermission.FieldByName('permissiondescribe').AsString;
        createtime:=self.jcdsFunctionPermission.FieldByName('createtime').AsString;
        createby:=self.jcdsFunctionPermission.FieldByName('createby').AsString;
        updatetime:=self.jcdsFunctionPermission.FieldByName('updatetime').AsString;
        updateby:=self.jcdsFunctionPermission.FieldByName('updateby').AsString;
      end;
      if SysMainForm.showFormModal(FrmFunctionPermissionEdit,false)=mrok then
      begin
        id := FrmFunctionPermissionEdit.operationid;
        jcdsResultAfterScroll(nil);
        jcdsFunctionPermission.Locate('id',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmFunctionPermissionEdit);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmFunctionManager.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{5256AB43-41A0-4C90-B903-3269C5EB4FAB}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{B2056CBD-340B-4DBA-8B63-CDEB69B49E45}' then //修改
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{10843E10-F3FF-4A1F-BEB6-A04E37EB91BA}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{7DBA1E1A-DCD2-4010-90E1-41F360E8D262}' then //添加可分配权限
  begin
    btnadddetail.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{F46CFA90-ABC2-49A4-BDCA-3122908AFA3D}' then //修改可分配权限
  begin
    btnUpdatedetail.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{9D334AA3-58C8-4F4C-AD3A-B744807126F4}' then //删除可分配权限
  begin
    btndeletedetail.Enabled:=aEnable;
  end;
end;

end.

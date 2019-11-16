unit UFrmPermission;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  VirtualTrees, NvPrnDbgeh, NvDbgridEh, StdCtrls, NovaEdit,UDMPublic,activex,
  Buttons, NovaHComboBox, NovaHelp, NovaCheckedComboBox;

type
  PPermissionData = ^TPermissionData;
  TPermissionData = record
    permissiontype,
    grade:integer;
    roleid,
    menuid,
    parentid,
    functionpermissionregid:int64;
    orderno:single;
    name,
    parameter:String;
    haspermission:boolean;
    createtime:String;
    createbyname:String;
//    CheckState:TCheckState;//选择框状态
  end;
 TFrmPermission = class(TSimpleCRUDForm)
    lblname: TLabel;
    nvedtname: TNovaEdit;
    ilTree: TImageList;
    btnlocate: TBitBtn;
    GroupBox2: TGroupBox;
    vstreePermission: TVirtualStringTree;
    jcdsMenuPermissionQry: TjsonClientDataSet;
    ilsmalltools: TImageList;
    tlbstop: TToolBar;
    btnSaveOrgpermission: TToolButton;
    lblrole: TLabel;
    nvhelpcbbrole: TNovaHComboBox;
    jcdsOrgpermissionSave: TjsonClientDataSet;
    jcdsMenuPermissionSave: TjsonClientDataSet;
    spl1: TSplitter;
    Label3: TLabel;
    NovaCbbOrg: TNovaHComboBox;
    procedure vstreePermissionGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstreePermissionGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure FormCreate(Sender: TObject);
    procedure vstreePermissionInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstreePermissionFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure tbtnFilterClick(Sender: TObject);
    procedure btnlocateClick(Sender: TObject);
    procedure nvedtnameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure vstreePermissionChecked(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure btnSaveOrgpermissionClick(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure vstreePermissionChecking(Sender: TBaseVirtualTree;
      Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
    procedure NovaCbbOrgChange(Sender: TObject);
    procedure nvhelpcbbroleChange(Sender: TObject);
  private
    { Private declarations }
    procedure refreshMenupermission;
    procedure refreshOrgpermission;

    function AddTreeNode:PVirtualNode;overload;
    function AddTreeNode(_permissiontype,_grade:integer;
                        _roleid,_menuid,_parentid,_functionpermissionregid:int64;
                        _orderno:single;_name,_parameter:String;_haspermission:boolean;
                        _createtime:String;_createbyname:String):PVirtualNode;overload;
    function findNodeByid(id:int64):PVirtualNode;
    function locateLikeName(_name:String):PVirtualNode;overload;
    function locateLikeName(_name:String;_begin:PVirtualNode):PVirtualNode;overload;
    function recursionlocateLikeName(_name:String;_parent:PVirtualNode):PVirtualNode;

    procedure syncParentAndChildChecked(node:PVirtualNode);
    procedure syncChildChecked(node:PVirtualNode);
    function getCheckStateByChilds(node:PVirtualNode):TCheckState;
    procedure initChildChecked(node:PVirtualNode);
    procedure updateDSbyChecked(node:PVirtualNode);

    function getOrgPermissionCount:Integer;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmPermission: TFrmPermission;

implementation

uses services,PubFn;

{$R *.dfm}

function TFrmPermission.AddTreeNode(_permissiontype,_grade:integer;
                                    _roleid,_menuid,_parentid,_functionpermissionregid:int64;
                                    _orderno:single;_name,_parameter:String;_haspermission:boolean;
                                    _createtime:String;_createbyname:String): PVirtualNode;
var
  Permissiondata: PPermissionData;
begin
//        RootNode.CheckType := ctTriStateCheckBox; // ctCheckbox
//        RootNode.CheckState := csUncheckedNormal;
  result:=nil;
  with vstreePermission do
  begin
    result:=AddChild(findNodeByid(_parentid));
    Permissiondata := GetNodeData(result);
    with Permissiondata^ do
    begin
      permissiontype:=_permissiontype;
      grade:=_grade;
      roleid:=_roleid;
      menuid:=_menuid;
      parentid:=_parentid;
      functionpermissionregid:=_functionpermissionregid;
      orderno:=_orderno;
      name:=_name;
      parameter:=_parameter;
      haspermission:=_haspermission;
      createtime:=_createtime;
      createbyname:=_createbyname;
    end;
  end;
end;

function TFrmPermission.findNodeByid(id: int64): PVirtualNode;
var tmpnode:PVirtualNode;
    data:PPermissionData;
begin
  result:=nil;
  with vstreePermission do
  begin
    tmpnode:=GetFirst();
    while assigned(tmpnode) do
    begin
      data:=GetNodeData(tmpnode);
      if (data.menuid=id) and (data.permissiontype=0) then
      begin
        result:=tmpnode;
        exit;
      end;
      tmpnode:=vstreePermission.GetNext(tmpnode);
    end;
  end;
end;

procedure TFrmPermission.FormCreate(Sender: TObject);
begin
  inherited;
  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] :=SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] :='(1,2)'; //车站、配客点
    Active := True;
    if Items.Count>0 then
    begin
      ItemIndex:=0;
      NovaCbbOrgChange(NovaCbbOrg);
    end;
  end;
end;

function TFrmPermission.getCheckStateByChilds(node:PVirtualNode): TCheckState;
var i:integer;
  haschildselected,haschildnoselected:boolean;
  tmpchildnode:PVirtualNode;
  tmpdata:PPermissionData;
begin
  haschildselected:=false;
  haschildnoselected:=false;
  tmpchildnode:=node.FirstChild;
  while assigned(tmpchildnode) do
  begin
    tmpdata:=vstreePermission.GetNodeData(tmpchildnode);
    if tmpdata.permissiontype=1 then
    begin
      //子节点类型为可控制权限时，不影响上级节点的选中状态
      haschildselected:=false;
      haschildnoselected:=false;
      break;
    end;
    case tmpchildnode.CheckState of
      csUncheckedNormal,
      csUncheckedPressed:haschildnoselected:=true;
      csCheckedNormal,
      csCheckedPressed,
      csMixedNormal,
      csMixedPressed:haschildselected:=true;
    end;
    tmpchildnode:=tmpchildnode.NextSibling;
  end;
  if haschildselected and (not haschildnoselected) then
  begin
    result:=csCheckedNormal;
  end
  else if haschildselected and haschildnoselected then
  begin
    result:=csMixedNormal;
  end
  else if (not haschildselected) and haschildnoselected then
  begin
    result:=csUnCheckedNormal;
  end
  else if (not haschildselected) and (not haschildnoselected) then
  begin
    if ppermissiondata(vstreePermission.GetNodeData(node)).haspermission then
    begin
      result:=csCheckedNormal;
    end
    else
    begin
      result:=csUnCheckedNormal;
    end;
  end;
end;

procedure TFrmPermission.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{155F4701-48DE-46E8-B360-C785C57DEB52}' then //保存菜单权限
  begin
    tbtnSave.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{057C6B1A-A530-4F95-BC0C-D05819B26A2E}' then //保存机构权限
  begin
    btnSaveOrgpermission.Enabled:=aEnable;
  end;
end;

procedure TFrmPermission.initChildChecked(node:PVirtualNode);
var tmpchildnode:PVirtualNode;
    data:PPermissionData;
begin
  data:=vstreePermission.GetNodeData(node);
  if (data.permissiontype=0) and (node.ChildCount>0) then
  begin
    if node.ChildCount>1 then
      node.CheckType:=ctTriStateCheckBox
    else
      node.CheckType:=ctCheckBox;
    tmpchildnode:=node.FirstChild;
    while assigned(tmpchildnode) do
    begin
      initChildChecked(tmpchildnode);
      tmpchildnode:=tmpchildnode.NextSibling;
    end;
    node.CheckState:=getCheckStateByChilds(node);
  end
  else
  begin
    node.CheckType:=ctCheckBox;
    if data.haspermission then
    begin
      node.CheckState:=csCheckedNormal;
    end
    else
    begin
      node.CheckState:=csUncheckedNormal;
    end;
  end;
end;

function TFrmPermission.locateLikeName(_name: String;
  _begin: PVirtualNode): PVirtualNode;
var beginNode:PVirtualNode;
begin
  result:=nil;
  beginNode:=_begin;
  while assigned(beginNode) do
  begin
    result:=recursionlocateLikeName(_name,beginNode);
    if assigned(result) then
    begin
      //退出循环
      break;
    end;
    beginNode:=beginNode.NextSibling;
  end;
  if (not assigned(result)) and assigned(_begin.Parent) and (_begin.Parent<>vstreePermission.RootNode) then
  begin
    beginNode:=_begin.Parent;
    while (not Assigned(beginNode.NextSibling)) and (beginNode<>vstreePermission.RootNode) do
    begin
      beginNode:=beginNode.Parent;
    end;
    if assigned(beginNode.NextSibling) and (beginNode<>vstreePermission.RootNode) then
    begin
      //从父节点的下一个节点开始循环
      result:=locateLikeName(_name,beginNode.NextSibling);
    end;
  end;
end;

function TFrmPermission.locateLikeName(_name: String): PVirtualNode;
var beginNode:PVirtualNode;
begin
  result:=nil;
  beginNode:=vstreePermission.FocusedNode;
  if not Assigned(beginNode) then
  begin
    beginNode:=vstreePermission.GetFirst();
  end;
  result:=locateLikeName(_name,beginNode);
  if (not assigned(result)) and assigned(beginNode) then
  begin
    if (beginNode<>vstreePermission.GetFirst())  then
    begin
      if SysDialogs.Ask('提示','没有找到"'+nvedtname.Text+'",请问需要从头开始查找吗？') then
      begin
        result:=recursionlocateLikeName(_name,vstreePermission.GetFirst());
      end;
    end
    else
    begin
      SysDialogs.ShowInfo('没有找到"'+nvedtname.Text+'"');
    end;
  end;
end;

procedure TFrmPermission.NovaCbbOrgChange(Sender: TObject);
begin
  inherited;
  nvhelpcbbrole.Active:=false;
  nvhelpcbbrole.Params.ParamByName('filter_EQL_t!orgid').AsString:=NovaCbbOrg.HelpFieldValue['id'];//inttostr(sysinfo.LoginUserInfo.OrgID);
  nvhelpcbbrole.Active:=true;
  nvhelpcbbroleChange(nvhelpcbbrole);
end;

procedure TFrmPermission.nvedtnameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=VK_RETURN then
  begin
    btnlocateClick(nil);
  end;
end;

procedure TFrmPermission.nvhelpcbbroleChange(Sender: TObject);
begin
  inherited;
  if nvhelpcbbrole.ItemIndex>=0 then
  begin
    tbtnFilterClick(nil);
  end;
end;

function TFrmPermission.recursionlocateLikeName(_name:String;_parent: PVirtualNode): PVirtualNode;
var tmpdata:PPermissiondata;
    i:integer;
    tmpnode:PVirtualNode;
begin
  result:=nil;
  tmpdata:=PPermissiondata(vstreePermission.GetNodeData(_parent));
  if (pos(_name,tmpdata.name)>0) then
  begin
    result:=_parent;
    vstreePermission.Selected[result] := True;
    vstreePermission.FocusedNode := result;
    vstreePermission.FullyVisible[result] := True;
  end;
  tmpnode:=_parent.FirstChild;
  while assigned(tmpnode) do
  begin
    if tmpnode.ChildCount>0 then
    begin
      result:=recursionlocateLikeName(_name,tmpnode);
    end
    else
    begin  //退出递归
      tmpdata:=PPermissiondata(vstreePermission.GetNodeData(tmpnode));
      if (pos(_name,tmpdata.name)>0) then
      begin
        result:=tmpnode;
        vstreePermission.Selected[result] := True;
        vstreePermission.FocusedNode := result;
        vstreePermission.FullyVisible[result] := True;
      end;
    end;
    if assigned(result) then
    begin
      //退出循环
      break;
    end;
    tmpnode:=tmpnode.NextSibling;
  end;
end;

procedure TFrmPermission.refreshMenupermission;
var
  Data:PPermissionData;
  RootNode:PVirtualNode;
begin
  inherited;
  if NovaCbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择班次所属机构！');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  if nvhelpcbbrole.ItemIndex = -1 then
  begin
    SysDialogs.ShowInfo('请选择一个角色');
    nvhelpcbbrole.SetFocus;
    exit;
  end;

  vstreePermission.Clear;
//  vstreePermission.NodeDataSize := SizeOf(TPermissionData);
  //添加节点
  RootNode:= vstreePermission.AddChild(nil);
  Data:=vstreePermission.GetNodeData(RootNode);
  with Data^ do
  begin
    permissiontype:=0;
    grade:=0;
    roleid:=0;
    menuid:=0;
    parentid:=0;
    functionpermissionregid:=0;
    orderno:=0;
    name:='菜单';
    parameter:='';
    haspermission:=true;
  end;
  with jcdsMenuPermissionQry do
  begin
    Active:=false;
    Params.ParamByName('roleid').AsString:=nvhelpcbbrole.HelpFieldValue['id'];
    active:=true;
    first;
    while not eof do
    begin
      AddTreeNode;
      next;
    end;
  end;
  initChildChecked(RootNode);
  vstreePermission.Expanded[RootNode]:=True;
  btnlocateClick(nil);
end;

procedure TFrmPermission.refreshOrgpermission;
begin
  if nvhelpcbbrole.ItemIndex = -1 then
  begin
    SysDialogs.ShowInfo('请选择一个角色');
    nvhelpcbbrole.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active:=false;
    Params.ParamByName('roleid').AsString:=nvhelpcbbrole.HelpFieldValue['id'];
    active:=true;
  end;
end;

procedure TFrmPermission.syncChildChecked(node: PVirtualNode);
var tmpchildnode:PVirtualNode;
begin
  tmpchildnode:=node.FirstChild;
  while assigned(tmpchildnode) do
  begin
    tmpchildnode.CheckState:=node.CheckState;
    updateDSbyChecked(tmpchildnode);
    if tmpchildnode.ChildCount>0 then
    begin
      //递归
      syncChildChecked(tmpchildnode);
    end;
    tmpchildnode:=tmpchildnode.NextSibling;
  end;
end;

procedure TFrmPermission.syncParentAndChildChecked(node: PVirtualNode);
var
  Data,tmpdata: PPermissionData;
  tmpparentnode,tmpchildnode:PVirtualNode;
begin
  Data:=vstreePermission.GetNodeData(Node);
  //同步parent
  if (data.permissiontype=0) and (data.menuid<>0)  then
  begin
    tmpparentnode:=node.Parent;
    while assigned(tmpparentnode) do
    begin
      //检查所有直接子节点的状态
      tmpparentnode.CheckState:=getCheckStateByChilds(tmpparentnode);
      tmpdata:=vstreePermission.GetNodeData(tmpparentnode);
      if tmpdata.menuid=0 then
      begin
        tmpparentnode:=nil;
      end
      else
      begin
        updateDSbyChecked(tmpparentnode);
        tmpparentnode:=tmpparentnode.Parent;
      end;
    end;
  end;
  //同步childs
  if (Node.ChildCount>0) then
  begin
    syncChildChecked(Node);
  end;
end;

procedure TFrmPermission.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  refreshMenupermission;
  refreshOrgpermission;
end;

procedure TFrmPermission.tbtnSaveClick(Sender: TObject);
begin
  inherited;
  if getOrgPermissionCount<=0 then
  begin
    SysDialogs.Warning('请至少给角色一个机构权限');
    exit;
  end;
  with jcdsMenuPermissionSave do
  begin
    active:=false;
    active:=true;
    jcdsMenuPermissionQry.First;
    while not jcdsMenuPermissionQry.Eof do
    begin
      append;
      FieldByName('isselect').Value:=jcdsMenuPermissionQry.FieldByName('haspermission').Value;
      FieldByName('roleid').Value:=jcdsMenuPermissionQry.FieldByName('roleid').Value;
      FieldByName('type').Value:=jcdsMenuPermissionQry.FieldByName('type').Value;

      FieldByName('menuid').Value:=jcdsMenuPermissionQry.FieldByName('menuid').Value;
      FieldByName('functionpermissionregid').Value:=jcdsMenuPermissionQry.FieldByName('functionpermissionregid').Value;
      FieldByName('createby').Value:=0;
      FieldByName('createtime').Value:=now;
      post;
      jcdsMenuPermissionQry.Next;
    end;
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('保存菜单权限失败:未知错误！');
      end;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        refreshMenupermission;
      end;
    except on E: Exception do
      SysDialogs.Warning('保存菜单权限失败:'+e.Message);
    end;
  end;
  btnSaveOrgpermissionClick(btnSaveOrgpermission);
end;

procedure TFrmPermission.updateDSbyChecked(node: PVirtualNode);
var data:PPermissionData;
    _functionpermissionregid:variant;
begin
  inherited;
  if node=vstreePermission.RootNode then exit;
  data:=PPermissionData(vstreePermission.GetNodeData(node));
  if (data.menuid=0) then exit;
//  if data.functionpermissionregid=0 then
//    _functionpermissionregid:=null
//  else
    _functionpermissionregid:=data.functionpermissionregid;
  if jcdsMenuPermissionQry.Locate('menuid;functionpermissionregid',
                                VarArrayOf([data.menuid,_functionpermissionregid]),
                                []) then
  begin
    if (node.CheckState=csCheckedNormal) or (node.CheckState=csCheckedPressed)
        or (node.CheckState=csMixedNormal) or (node.CheckState=csMixedPressed) then
    begin
      if not jcdsMenuPermissionQry.fieldbyname('haspermission').asboolean then
      begin
        jcdsMenuPermissionQry.edit;
        jcdsMenuPermissionQry.fieldbyname('haspermission').asboolean:=true;
        jcdsMenuPermissionQry.post;
      end;
    end
    else
    begin
      if jcdsMenuPermissionQry.fieldbyname('haspermission').asboolean then
      begin
        jcdsMenuPermissionQry.edit;
        jcdsMenuPermissionQry.fieldbyname('haspermission').asboolean:=false;
        jcdsMenuPermissionQry.post;
      end;
    end;
  end
  else
  begin
    SysDialogs.ShowError('错误 ，找不到数据源');
  end;
end;

procedure TFrmPermission.vstreePermissionChecked(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
begin
  inherited;
  updateDSbyChecked(node);
  syncParentAndChildChecked(node);
  vstreePermission.Repaint;
end;

procedure TFrmPermission.vstreePermissionChecking(Sender: TBaseVirtualTree;
  Node: PVirtualNode; var NewState: TCheckState; var Allowed: Boolean);
begin
  inherited;
//  SysDialogs.ShowMessage(PPermissionData(Sender.GetNodeData(node)).name+' checking');
  //
end;

procedure TFrmPermission.vstreePermissionFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
Data:PPermissionData;
begin
  inherited;
  Data:=Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFrmPermission.vstreePermissionGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;
  NodeDataSize := SizeOf(TPermissionData);
end;

procedure TFrmPermission.vstreePermissionGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  Data: PPermissionData;
begin
  inherited;
  Data := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := Data.name;
    1:begin
        if data.permissiontype=0 then
          CellText := '菜单'
        else
          CellText := '可控权限';
    end;
    2:
      CellText := Data.parameter;
    3:
      CellText := Data.createtime;
    4:
      CellText := Data.createbyname;
  end;
end;

procedure TFrmPermission.vstreePermissionInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PPermissionData;
begin
  inherited;
//  Data:=Sender.GetNodeData(Node);
//  if (data.permissiontype=0) and (node.ChildCount>1) then
//  begin
//    node.CheckType:=ctTriStateCheckBox;
//    if data.haspermission then
//    begin
//      { TODO : 取状态 }
//      Node.CheckState:=csCheckedNormal;
////      csCheckedPressed,   // checked and pressed
////      csMixedNormal,      // 3-state check box and not pressed
////      csMixedPressed      // 3-state check box and pressed
//    end
//    else
//    begin
//      Node.CheckState:=csUncheckedNormal;  //    csUncheckedPressed
//    end;
//  end
//  else
//  begin
//    node.CheckType:=ctCheckBox;
//    if data.haspermission then
//    begin
//      Node.CheckState:=csCheckedNormal;
//    end
//    else
//    begin
//      Node.CheckState:=csUncheckedNormal;
//    end;
//  end;
end;

function TFrmPermission.AddTreeNode:PVirtualNode;
var _createtime:string;
begin
  with jcdsMenuPermissionQry do
  begin
    if FieldByName('createtime').IsNull then
    begin
      _createtime:='';
    end
    else
    begin
      _createtime:=formatdatetime('yyyy-mm-dd hh:nn:ss',FieldByName('createtime').AsDateTime);
    end;
    result:=AddTreeNode(FieldByName('type').Value,FieldByName('grade').Value,
                        FieldByName('roleid').Value,FieldByName('menuid').Value,
                        FieldByName('parentid').Value,
                        nvl(FieldByName('functionpermissionregid').Value,0),FieldByName('orderno').Value,
                        FieldByName('name').Value,nvl(FieldByName('PARAMETER').Value,''),
                        FieldByName('haspermission').AsBoolean,
                        formatdatetime('yyyy-mm-dd hh:nn:ss',FieldByName('createtime').AsDateTime),
                        FieldByName('createbyname').AsString);
  end;
end;

procedure TFrmPermission.btnlocateClick(Sender: TObject);
begin
  inherited;
  if (trim(nvedtname.Text)<>'') then
  begin
    locateLikeName(trim(nvedtname.Text));
  end;
end;

procedure TFrmPermission.btnSaveOrgpermissionClick(Sender: TObject);
var _bookmark:TBookmark;
begin
  inherited;
  with jcdsOrgpermissionSave do
  begin
    active:=false;
    active:=true;
    _bookmark:=jcdsResult.GetBookmark;
    jcdsResult.DisableControls;
    try
      jcdsResult.First;
      while not jcdsResult.Eof do
      begin
        append;
        FieldByName('isselect').Value:=jcdsResult.FieldByName('haspermission').Value;
        FieldByName('roleid').Value:=jcdsResult.FieldByName('roleid').Value;
        FieldByName('orgid').Value:=jcdsResult.FieldByName('orgid').Value;
        FieldByName('createby').Value:=0;
        FieldByName('createtime').Value:=now;
        post;
        jcdsResult.Next;
      end;
      try
        if (ApplyUpdates(-1) <> 0) then
        begin
          SysDialogs.Warning('保存机构权限失败:未知错误！');
        end;
        if Params.ParamValues['msg']<>'' then
        begin
          SysDialogs.ShowMessage(Params.ParamValues['msg']);
        end;
        if Params.ParamValues['flag']=1 then
        begin
          refreshOrgpermission;
        end;
      except on E: Exception do
        SysDialogs.Warning('保存机构权限失败:'+e.Message);
      end;
    finally
      jcdsResult.GotoBookmark(_bookmark);
      jcdsResult.EnableControls;

    end;
  end;
end;

function TFrmPermission.getOrgPermissionCount: Integer;
var _bookmark:TBookmark;
begin
  inherited;
  result:=0;
  _bookmark:=jcdsResult.GetBookmark;
  jcdsResult.DisableControls;
  jcdsResult.First;
  while not jcdsResult.Eof do
  begin
    if jcdsResult.FieldByName('haspermission').Value then
    begin
    Inc(Result);
    end;
    jcdsResult.Next;
  end;
  jcdsResult.GotoBookmark(_bookmark);
  jcdsResult.EnableControls;
end;

end.

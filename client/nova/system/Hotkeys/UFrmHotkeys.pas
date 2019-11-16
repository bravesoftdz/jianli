unit UFrmHotkeys;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, VirtualTrees, StdCtrls,
  NovaHComboBox, Buttons, NovaEdit, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, ComCtrls, ToolWin, ExtCtrls,Menus;

const
  WM_STARTEDITING = WM_USER + 778;

type
  PHotkeysData = ^THotkeysData;
  THotkeysData = record
    id,
    parentid,
    functionregid:int64;
    grade:integer;
    orderno:Single;
    createbyname,
    updatebyname,
    createtime,
    updatetime,
    Hotkey,
    name,
    PARAMETER,
    functionname,
    functiondescribe,
    parameterdescribe: String;
  end;
  TFrmHotkeys = class(TSimpleCRUDForm)
    lblname: TLabel;
    lblrole: TLabel;
    lbl1: TLabel;
    nvedtname: TNovaEdit;
    btnlocate: TBitBtn;
    nvhelpcbbrole: TNovaHComboBox;
    NovaCbbOrg: TNovaHComboBox;
    jcdsHotkeysSave: TjsonClientDataSet;
    ilTree: TImageList;
    vstreeHotkeys: TVirtualStringTree;
    procedure vstreeHotkeysChange(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vstreeHotkeysCreateEditor(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    procedure vstreeHotkeysEditing(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstreeHotkeysFreeNode(Sender: TBaseVirtualTree;
      Node: PVirtualNode);
    procedure vstreeHotkeysGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure NovaCbbOrgChange(Sender: TObject);
    procedure nvhelpcbbroleChange(Sender: TObject);
    procedure nvedtnameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnlocateClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure tbtnFilterClick(Sender: TObject);
    procedure vstreeHotkeysGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstreeHotkeysGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure tbtnSaveClick(Sender: TObject);
  private
    function AddTreeNode:PVirtualNode;overload;
    function AddTreeNode(_id,_parentid,_functionregid:int64;
                          _name,_PARAMETER,_functionname,_functiondescribe,_parameterdescribe: String;
                          _grade:integer;_orderno:single;
                          _createtime,_createbyname,_updatetime,_updatebyname,_Hotkey:String):PVirtualNode;overload;
    function findNodeByid(id:int64):PVirtualNode;
    function locateLikeName(_name:String):PVirtualNode;overload;
    function locateLikeName(_name:String;_begin:PVirtualNode):PVirtualNode;overload;
    function recursionlocateLikeName(_name:String;_parent:PVirtualNode):PVirtualNode;

    procedure WMStartEditing(var Message: TMessage); message WM_STARTEDITING;

  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

  TPropertyEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit: THotKey;        // One of the property editor classes.
    FTree: TVirtualStringTree; // A back reference to the tree calling.
    FNode: PVirtualNode;       // The node being edited.
    FColumn: Integer;          // The column of the node being edited.
  protected
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    destructor Destroy; override;

    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;
  end;

var
  FrmHotkeys: TFrmHotkeys;

implementation
uses services,PubFn;

{$R *.dfm}

{ TPropertyEditLink }

function TPropertyEditLink.BeginEdit: Boolean;
begin
  Result := True;
  FEdit.Show;
  FEdit.SetFocus;
end;

function TPropertyEditLink.CancelEdit: Boolean;
begin
  Result := True;
  FEdit.Hide;
end;

destructor TPropertyEditLink.Destroy;
begin
  FEdit.Free;
  inherited;
end;

procedure TPropertyEditLink.EditKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_ESCAPE:
      begin
        FTree.CancelEditNode;
        Key := 0;
      end;
    VK_RETURN:
      begin
        FTree.EndEditNode;
        Key := 0;
      end;
  end;
end;

function TPropertyEditLink.EndEdit: Boolean;
var
  Data: PHotkeysData;
  edittext:String;

  tmpnode:PVirtualNode;
begin
  Result := True;
  Data := FTree.GetNodeData(FNode);
  edittext:=ShortCutToText(Fedit.HotKey);
  if edittext <> Data.Hotkey then
  begin
//    Data.Hotkey := edittext;
    if edittext<>'' then
    begin
      with FTree do
      begin
        tmpnode:=GetFirst();
        while assigned(tmpnode) do
        begin
          data:=GetNodeData(tmpnode);
          if data.Hotkey=edittext then
          begin
            data.Hotkey:='';
            break;
          end;
          tmpnode:=GetNext(tmpnode);
        end;
      end;
    end;
    Data := FTree.GetNodeData(FNode);
    Data.Hotkey := edittext;

    FTree.InvalidateNode(FNode);
  end;
  try
    FEdit.Hide;
  except on E: Exception do
  end;
  FTree.SetFocus;
end;

function TPropertyEditLink.GetBounds: TRect;
begin
  Result := FEdit.BoundsRect;
end;

function TPropertyEditLink.PrepareEdit(Tree: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  Data: PHotkeysData;
begin
  Result := True;
  FTree := Tree as TVirtualStringTree;
  FNode := Node;
  FColumn := Column;
  Data := FTree.GetNodeData(Node);
  if data.functionregid=0 then
  begin
    result:=false;
    exit;
  end;
//  FEdit.Free;
//  FEdit := nil;
  if not assigned(Fedit) then
  begin
    Fedit:=THotKey.Create(nil);
  end;
  with Fedit do
  begin
    Visible := False;
    Parent := Tree;
    Fedit.InvalidKeys:=[hcNone,hcShift,hcAlt];
    Fedit.Modifiers:=[hkCtrl];
    HotKey:= TextToShortCut(data.Hotkey);
//    OnKeyDown := EditKeyDown;
  end;
end;

procedure TPropertyEditLink.ProcessMessage(var Message: TMessage);
begin
  FEdit.WindowProc(Message);
end;

procedure TPropertyEditLink.SetBounds(R: TRect);
var
  Dummy: Integer;
begin
  // Since we don't want to activate grid extensions in the tree (this would influence how the selection is drawn)
  // we have to set the edit's width explicitly to the width of the column.
  FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  FEdit.BoundsRect := R;
end;

{ TFrmHotkeys }

function TFrmHotkeys.AddTreeNode(_id, _parentid, _functionregid: int64; _name,
  _PARAMETER, _functionname, _functiondescribe, _parameterdescribe: String;
  _grade: integer; _orderno: single; _createtime, _createbyname,
  _updatetime, _updatebyname, _Hotkey: String): PVirtualNode;
var
  Hotkeysdata: PHotkeysData;
  _Data:THotkeysData;
begin
  result:=nil;
  with vstreeHotkeys do
  begin
    result:=AddChild(findNodeByid(_parentid));
    Hotkeysdata := GetNodeData(result);
    with Hotkeysdata^ do
    begin
      id:=_id;
      parentid:=_parentid;
      functionregid:=_functionregid;
      name:=_name;
      PARAMETER:=_PARAMETER;
      functionname:=_functionname;
      functiondescribe:=_functiondescribe;
      parameterdescribe:=_parameterdescribe;
      grade:=_grade;
      orderno:=_orderno;
      createtime:=_createtime;
      createbyname:=_createbyname;
      updatebyname:=_updatebyname;
      updatetime:=_updatetime;
      Hotkey:=_Hotkey;
    end;
//    Hotkeysdata:=@_Data;
//    result:=AddChild(findNodeByid(_parentid),Hotkeysdata);
//    Hotkeysdata := GetNodeData(result);
  end;
end;

function TFrmHotkeys.AddTreeNode: PVirtualNode;
begin
  with jcdsResult do
  result:=AddTreeNode(FieldByName('id').Value,FieldByName('parentid').Value,
                      nvl(FieldByName('functionregid').Value,0),
                      FieldByName('name').Value,nvl(FieldByName('PARAMETER').Value,''),
                      nvl(FieldByName('functionname').Value,''),
                      nvl(FieldByName('functiondescribe').Value,''),
                      nvl(FieldByName('parameterdescribe').Value,''),
                      FieldByName('grade').Value,FieldByName('orderno').Value,
                      nvl(FieldByName('createtime').AsString,''),nvl(FieldByName('createbyname').AsString,''),
                      nvl(FieldByName('updatetime').AsString,''),nvl(FieldByName('updatebyname').AsString,''),
                      nvl(FieldByName('hotkey').AsString,''));
end;

procedure TFrmHotkeys.btnlocateClick(Sender: TObject);
begin
  inherited;
  if (trim(nvedtname.Text)<>'') then
  begin
    locateLikeName(trim(nvedtname.Text));
  end;
end;

function TFrmHotkeys.findNodeByid(id: int64): PVirtualNode;
var tmpnode:PVirtualNode;
    data:PHotkeysData;
begin
  result:=nil;
  with vstreeHotkeys do
  begin
    tmpnode:=GetFirst();
    while assigned(tmpnode) do
    begin
      data:=GetNodeData(tmpnode);
      if data.id=id then
      begin
        result:=tmpnode;
        exit;
      end;
      tmpnode:=vstreeHotkeys.GetNext(tmpnode);
    end;
  end;
end;

procedure TFrmHotkeys.FormCreate(Sender: TObject);
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

procedure TFrmHotkeys.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  key:=0;
end;

procedure TFrmHotkeys.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{86033F5B-8E87-46AC-B5D5-D32D7912C2C6}' then //保存快捷键
  begin
    tbtnSave.Enabled:=aEnable;
  end;
end;

function TFrmHotkeys.locateLikeName(_name: String): PVirtualNode;
var beginNode:PVirtualNode;
begin
  result:=nil;
  beginNode:=vstreeHotkeys.FocusedNode;
  if not Assigned(beginNode) then
  begin
    beginNode:=vstreeHotkeys.GetFirst();
  end;
  result:=locateLikeName(_name,beginNode);
  if (not assigned(result)) and assigned(beginNode) then
  begin
    if (beginNode<>vstreeHotkeys.GetFirst())  then
    begin
      if SysDialogs.Ask('提示','没有找到"'+nvedtname.Text+'",请问需要从头开始查找吗？') then
      begin
        result:=recursionlocateLikeName(_name,vstreeHotkeys.GetFirst());
      end;
    end
    else
    begin
      SysDialogs.ShowInfo('没有找到"'+nvedtname.Text+'"');
    end;
  end;
end;

function TFrmHotkeys.locateLikeName(_name: String;
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
  if (not assigned(result)) and assigned(_begin.Parent) and (_begin.Parent<>vstreeHotkeys.RootNode) then
  begin
    beginNode:=_begin.Parent;
    while (not Assigned(beginNode.NextSibling)) and (beginNode<>vstreeHotkeys.RootNode) do
    begin
      beginNode:=beginNode.Parent;
    end;
    if assigned(beginNode.NextSibling) and (beginNode<>vstreeHotkeys.RootNode) then
    begin
      //从父节点的下一个节点开始循环
      result:=locateLikeName(_name,beginNode.NextSibling);
    end;
  end;
end;

procedure TFrmHotkeys.NovaCbbOrgChange(Sender: TObject);
begin
  inherited;
  nvhelpcbbrole.Active:=false;
  nvhelpcbbrole.Params.ParamByName('filter_EQL_t!orgid').AsString:=NovaCbbOrg.HelpFieldValue['id'];//inttostr(sysinfo.LoginUserInfo.OrgID);
  nvhelpcbbrole.Active:=true;
  nvhelpcbbroleChange(nvhelpcbbrole);
end;

procedure TFrmHotkeys.nvedtnameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=VK_RETURN then
  begin
    btnlocateClick(nil);
  end;
end;

procedure TFrmHotkeys.nvhelpcbbroleChange(Sender: TObject);
begin
  inherited;
  if nvhelpcbbrole.ItemIndex>=0 then
  begin
    tbtnFilterClick(nil);
  end;
end;

function TFrmHotkeys.recursionlocateLikeName(_name: String;
  _parent: PVirtualNode): PVirtualNode;
var tmpdata:PHotkeysdata;
    i:integer;
    tmpnode:PVirtualNode;
begin
  result:=nil;
  tmpdata:=PHotkeysdata(vstreeHotkeys.GetNodeData(_parent));
  if (pos(_name,tmpdata.name)>0) or (pos(_name,tmpdata.functionname)>0) or (pos(_name,tmpdata.functiondescribe)>0) then
  begin
    result:=_parent;
    vstreeHotkeys.Selected[result] := True;
    vstreeHotkeys.FocusedNode := result;
    vstreeHotkeys.FullyVisible[result] := True;
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
      tmpdata:=PHotkeysdata(vstreeHotkeys.GetNodeData(tmpnode));
      if (pos(_name,tmpdata.name)>0) or (pos(_name,tmpdata.functionname)>0) or (pos(_name,tmpdata.functiondescribe)>0) then
      begin
        result:=tmpnode;
        vstreeHotkeys.Selected[result] := True;
        vstreeHotkeys.FocusedNode := result;
        vstreeHotkeys.FullyVisible[result] := True;
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

procedure TFrmHotkeys.tbtnFilterClick(Sender: TObject);
var
  Data:PHotkeysData;
  RootNode:PVirtualNode;
  _Data:THotkeysData;
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
  vstreeHotkeys.Clear;
  vstreeHotkeys.NodeDataSize := SizeOf(THotkeysData);
  //添加节点
  RootNode:= vstreeHotkeys.AddChild(nil);
  Data:=vstreeHotkeys.GetNodeData(RootNode);
  with Data^ do
  begin
    id:=0;
    parentid:=0;
    functionregid:=0;
    name:='菜单';
    PARAMETER:='';
    functionname:='';
    functiondescribe:='';
    parameterdescribe:='';
    grade:=0;
    orderno:=0;
    createtime:='';
    createbyname:='';
    updatebyname:='';
    updatetime:='';
    Hotkey:='';
  end;
//  Data:=@_Data;
//  RootNode:= vstreeHotkeys.AddChild(nil,data);
  vstreeHotkeys.Expanded[RootNode]:=True;
  with jcdsResult do
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
  vstreeHotkeys.Expanded[RootNode]:=True;
  btnlocateClick(nil);
end;

procedure TFrmHotkeys.tbtnSaveClick(Sender: TObject);
var node:PVirtualNode;
    nodedata:PHotkeysData;
begin
  inherited;
  with jcdsHotkeysSave do
  begin
    active:=false;
    active:=true;
    jcdsResult.First;
    while not jcdsResult.Eof do
    begin
      append;
      if (not jcdsResult.FieldByName('functionregid').IsNull)
        and (jcdsResult.FieldByName('functionregid').AsLargeInt>0) then
      begin
        node:=findNodeByid(jcdsResult.FieldByName('id').AsLargeInt);
        nodedata:=vstreeHotkeys.GetNodeData(node);
        FieldByName('hotkey').Value:=nodedata.hotkey; //jcdsResult.FieldByName('hotkey').Value;
      end
      else
      begin
        FieldByName('hotkey').Value:=null;
      end;
      FieldByName('roleid').Value:=jcdsResult.FieldByName('roleid').Value;
      FieldByName('menuid').Value:=jcdsResult.FieldByName('id').Value;
//      FieldByName('createby').Value:=0;
//      FieldByName('createtime').Value:=now;
      post;
      jcdsResult.Next;
    end;
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('保存快捷键设置失败:未知错误！');
      end;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        tbtnFilterClick(nil);
      end;
    except on E: Exception do
      SysDialogs.Warning('保存快捷键设置失败:'+e.Message);
    end;
  end;
end;

procedure TFrmHotkeys.vstreeHotkeysChange(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data: PHotkeysData;
begin
  inherited;
  with Sender do
  begin
    // Start immediate editing as soon as another node gets focused.
    if Assigned(Node) then
    begin
      Data := Sender.GetNodeData(Node);
      if data.functionregid>0 then
      begin
        // We want to start editing the currently selected node. However it might well happen that this change event
        // here is caused by the node editor if another node is currently being edited. It causes trouble
        // to start a new edit operation if the last one is still in progress. So we post us a special message and
        // in the message handler we then can start editing the new node. This works because the posted message
        // is first executed *after* this event and the message, which triggered it is finished.
        PostMessage(Self.Handle, WM_STARTEDITING, Integer(Node), 0);
      end;
    end;
  end;
end;

procedure TFrmHotkeys.vstreeHotkeysCreateEditor(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  inherited;
  EditLink := TPropertyEditLink.Create;
end;

procedure TFrmHotkeys.vstreeHotkeysEditing(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var
  Data: PHotkeysData;
begin
  inherited;
  with Sender do
  begin
    Data := GetNodeData(Node);
    Allowed := (Node.Parent <> RootNode) and (Column = 1) and (Data.functionregid>0);
  end;
end;

procedure TFrmHotkeys.vstreeHotkeysFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  Data:PHotkeysData;
begin
  inherited;
  Data:=Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFrmHotkeys.vstreeHotkeysGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PHotkeysData;
begin
  inherited;
  Data := Sender.GetNodeData(Node);
  case Column of
    0:
      if Data.functionregid=0 then
      begin
        ImageIndex:=0;
      end
      else
      begin
        ImageIndex:=2;
      end;
    else
      ImageIndex:=-1;
  end;
end;

procedure TFrmHotkeys.vstreeHotkeysGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;
  NodeDataSize := SizeOf(THotkeysData);
end;

procedure TFrmHotkeys.vstreeHotkeysGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  Data: PHotkeysData;
begin
  inherited;
  Data := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := Data.name;
    1:
      CellText := Data.Hotkey;
    2:
      CellText := Data.functionname;
    3:
      CellText := Data.PARAMETER;
    4:
      CellText := Data.createbyname;
    5:
      CellText := Data.createtime;
    6:
      CellText := Data.updatebyname;
    7:
      CellText := Data.updatetime;
  end;
end;

procedure TFrmHotkeys.WMStartEditing(var Message: TMessage);
var
  Node: PVirtualNode;
begin
  Node := Pointer(Message.WParam);
  // Note: the test whether a node can really be edited is done in the OnEditing event.
  vstreehotkeys.EditNode(Node, 1);
end;

end.

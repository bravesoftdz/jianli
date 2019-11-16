unit UFrmMenus;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, VirtualTrees, Buttons, NovaEdit, UDMPublic, activex;

type
  PMenuData = ^TMenuData;

  TMenuData = record
    id, parentid, functionregid: int64;
    grade: integer;
    orderno: Single;
    name, PARAMETER, functionname, functiondescribe, parameterdescribe: String;
    createtime, createby: String;
  end;

type
  TFrmMenus = class(TSimpleCRUDForm)
    lblname: TLabel;
    nvedtname: TNovaEdit;
    btnlocate: TBitBtn;
    vstreeMenu: TVirtualStringTree;
    jcdsMenuDelete: TjsonClientDataSet;
    jcdsMenuSave: TjsonClientDataSet;
    ilTree: TImageList;
    procedure tbtnFilterClick(Sender: TObject);
    procedure btnlocateClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure vstreeMenuDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex;
      var Allowed: Boolean);
    procedure vstreeMenuDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: integer; Mode: TDropMode);
    procedure vstreeMenuDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: integer; var Accept: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure vstreeMenuFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstreeMenuGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: integer);
    procedure vstreeMenuGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: integer);
    procedure vstreeMenuGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure vstreeMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
    procedure vstreeMenuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: integer);
  private
    { Private declarations }
    function AddTreeNode: PVirtualNode; overload;
    function AddTreeNode(_id, _parentid, _functionregid: int64;
      _name, _PARAMETER, _functionname, _functiondescribe,
      _parameterdescribe: String; _grade: integer; _orderno: Single;
      _createtime, _createby: String): PVirtualNode; overload;
    function findNodeByid(id: int64): PVirtualNode;
    function locateLikeName(_name: String): PVirtualNode; overload;
    function locateLikeName(_name: String; _begin: PVirtualNode): PVirtualNode;
      overload;
    function recursionlocateLikeName(_name: String;
      _parent: PVirtualNode): PVirtualNode;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmMenus: TFrmMenus;

implementation

uses UFrmMenuAdd, services, PubFn;
{$R *.dfm}

function TFrmMenus.AddTreeNode(_id, _parentid, _functionregid: int64;
  _name, _PARAMETER, _functionname, _functiondescribe,
  _parameterdescribe: String; _grade: integer; _orderno: Single;
  _createtime, _createby: String): PVirtualNode;

var
  menudata: PMenuData;
begin
  // RootNode.CheckType := ctTriStateCheckBox; // ctCheckbox
  // RootNode.CheckState := csUncheckedNormal;
  result := nil;
  with vstreeMenu do
  begin
    result := AddChild(findNodeByid(_parentid));
    menudata := GetNodeData(result);
    with menudata^ do
    begin
      id := _id;
      parentid := _parentid;
      functionregid := _functionregid;
      name := _name;
      PARAMETER := _PARAMETER;
      functionname := _functionname;
      functiondescribe := _functiondescribe;
      parameterdescribe := _parameterdescribe;
      grade := _grade;
      orderno := _orderno;
      createtime := _createtime;
      createby := _createby;
    end;
  end;
end;

function TFrmMenus.AddTreeNode: PVirtualNode;
begin
  with jcdsResult do
    result := AddTreeNode(FieldByName('id').Value,
      FieldByName('parentid').Value,
      nvl(FieldByName('functionregid').Value, 0),
      FieldByName('name').Value, nvl(FieldByName('PARAMETER').Value, ''),
      nvl(FieldByName('functionname').Value, ''),
      nvl(FieldByName('functiondescribe').Value, ''),
      nvl(FieldByName('parameterdescribe').Value, ''),
      FieldByName('grade').Value, FieldByName('orderno').Value,
      FieldByName('createtime').AsString, FieldByName('createby').AsString);
end;

procedure TFrmMenus.btnlocateClick(Sender: TObject);
begin
  inherited;
  if (trim(nvedtname.Text) <> '') then
  begin
    locateLikeName(trim(nvedtname.Text));
  end;
end;

function TFrmMenus.findNodeByid(id: int64): PVirtualNode;
var
  tmpnode: PVirtualNode;
  data: PMenuData;
begin
  result := nil;
  with vstreeMenu do
  begin
    tmpnode := GetFirst();
    while assigned(tmpnode) do
    begin
      data := GetNodeData(tmpnode);
      if data.id = id then
      begin
        result := tmpnode;
        exit;
      end;
      tmpnode := vstreeMenu.GetNext(tmpnode);
    end;
  end;
end;

procedure TFrmMenus.FormCreate(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(nil);
end;

procedure TFrmMenus.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(Key) = '{533CAEED-0E42-4417-A5C8-160A64D36F00}' then // 添加
  begin
    tbtnInsert.Enabled := aEnable;
  end
  else if GUIDToString(Key) = '{59755A6E-4726-4754-A35D-DF517446D43D}' then
  // 修改
  begin
    tbtnEdit.Enabled := aEnable;
  end
  else if GUIDToString(Key) = '{B5E313BF-69BE-4621-82B3-C69E3AC1F06D}' then
  // 删除
  begin
    tbtnDelete.Enabled := aEnable;
  end
  else if GUIDToString(Key) = '{12183242-6817-4AB3-8024-D2911BDEE10B}' then
  // 保存
  begin
    tbtnSave.Enabled := aEnable;
  end;
end;

function TFrmMenus.locateLikeName(_name: String): PVirtualNode;
var
  beginNode: PVirtualNode;
begin
  result := nil;
  beginNode := vstreeMenu.FocusedNode;
  if not assigned(beginNode) then
  begin
    beginNode := vstreeMenu.GetFirst();
  end;
  result := locateLikeName(_name, beginNode);
  if (not assigned(result)) and assigned(beginNode) then
  begin
    if (beginNode <> vstreeMenu.GetFirst()) then
    begin
      if SysDialogs.Ask('提示', '没有找到"' + nvedtname.Text + '",请问需要从头开始查找吗？') then
      begin
        result := recursionlocateLikeName(_name, vstreeMenu.GetFirst());
      end;
    end
    else
    begin
      SysDialogs.ShowInfo('没有找到"' + nvedtname.Text + '"');
    end;
  end;

end;

function TFrmMenus.locateLikeName(_name: String;
  _begin: PVirtualNode): PVirtualNode;
var
  beginNode: PVirtualNode;
begin
  result := nil;
  beginNode := _begin;
  while assigned(beginNode) do
  begin
    result := recursionlocateLikeName(_name, beginNode);
    if assigned(result) then
    begin
      // 退出循环
      break;
    end;
    beginNode := beginNode.NextSibling;
  end;
  if (not assigned(result)) and assigned(_begin.Parent) and
    (_begin.Parent <> vstreeMenu.RootNode) then
  begin
    beginNode := _begin.Parent;
    while (not assigned(beginNode.NextSibling)) and
      (beginNode <> vstreeMenu.RootNode) do
    begin
      beginNode := beginNode.Parent;
    end;
    if assigned(beginNode.NextSibling) and (beginNode <> vstreeMenu.RootNode)
      then
    begin
      // 从父节点的下一个节点开始循环
      result := locateLikeName(_name, beginNode.NextSibling);
    end;
  end;

end;

function TFrmMenus.recursionlocateLikeName(_name: String;
  _parent: PVirtualNode): PVirtualNode;
var
  tmpdata: PMenuData;
  i: integer;
  tmpnode: PVirtualNode;
begin
  result := nil;
  tmpdata := PMenuData(vstreeMenu.GetNodeData(_parent));
  if (pos(_name, tmpdata.name) > 0) or (pos(_name, tmpdata.functionname) > 0)
    or (pos(_name, tmpdata.functiondescribe) > 0) then
  begin
    result := _parent;
    vstreeMenu.Selected[result] := True;
    vstreeMenu.FocusedNode := result;
    vstreeMenu.FullyVisible[result] := True;
  end;
  tmpnode := _parent.FirstChild;
  while assigned(tmpnode) do
  begin
    if tmpnode.ChildCount > 0 then
    begin
      result := recursionlocateLikeName(_name, tmpnode);
    end
    else
    begin // 退出递归
      tmpdata := PMenuData(vstreeMenu.GetNodeData(tmpnode));
      if (pos(_name, tmpdata.name) > 0) or
        (pos(_name, tmpdata.functionname) > 0) or
        (pos(_name, tmpdata.functiondescribe) > 0) then
      begin
        result := tmpnode;
        vstreeMenu.Selected[result] := True;
        vstreeMenu.FocusedNode := result;
        vstreeMenu.FullyVisible[result] := True;
      end;
    end;
    if assigned(result) then
    begin
      // 退出循环
      break;
    end;
    tmpnode := tmpnode.NextSibling;
  end;

end;

procedure TFrmMenus.tbtnDeleteClick(Sender: TObject);
var
  selectrow: PVirtualNode;
begin
  inherited;
  selectrow := vstreeMenu.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.ShowInfo('请先选择要删除菜单！');
    exit;
  end
  else if selectrow.ChildCount > 0 then
  begin
    SysDialogs.ShowInfo('该菜单拥有子菜单，请先删除子菜单！');
    exit;
  end;
  if not SysDialogs.Confirm('提示', '确定要删除该菜单吗？') then
  begin
    exit;
  end;
  with jcdsMenuDelete do
  begin
    Params.ParamValues['menu.id'] := PMenuData
      (vstreeMenu.GetNodeData(selectrow))^.id;
    Execute;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      vstreeMenu.DeleteNode(selectrow);
    end;
  end;
end;

procedure TFrmMenus.tbtnEditClick(Sender: TObject);
var
  id: integer;
  selectrow: PVirtualNode;
  menudata: PMenuData;
begin
  inherited;
  selectrow := vstreeMenu.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.ShowInfo('请先选择要修改菜单！');
    exit;
  end
  else if PMenuData(vstreeMenu.GetNodeData(selectrow))^.id = 0 then
  begin
    SysDialogs.ShowInfo('顶级菜单不能修改！');
    exit;
  end;

  FrmMenuAdd := TFrmMenuAdd.Create(self, self.functionItem);
  try
    with FrmMenuAdd, jcdsResult do
    begin
      Caption := '修改菜单';
      edittype := Tedittype.update;
      menudata := vstreeMenu.GetNodeData(selectrow);
      operationid := menudata.id;
      createtime := menudata.createtime;
      createby := menudata.createby;
      parentid := menudata.parentid;
      lblparentmenu.Caption := PMenuData
        (vstreeMenu.GetNodeData(selectrow.Parent))^.name;
      grade := menudata.grade;
      orderno := menudata.orderno;
      nvedtname.Text := menudata.name;
      nvhelpfunction.Text := menudata.functionname;
      nvhelpfunction.id := menudata.functionregid;
      nvedtparam.Text := menudata.PARAMETER;
      mmofunctiondescribe.Text := menudata.functiondescribe;
      mmoparameterdescribe.Text := menudata.parameterdescribe;
      if menudata.functionregid > 0 then
      begin
        rbfunction.Checked := True;
      end
      else
      begin
        rbfolder.Checked := True;
        if selectrow.ChildCount > 0 then
        begin
          rbfunction.Enabled := false;
        end;
      end;
    end;
    if SysMainForm.showFormModal(FrmMenuAdd, false) = mrok then
    begin
      with FrmMenuAdd, menudata^ do
      begin
        name := nvedtname.Text;
        PARAMETER := nvedtparam.Text;
        if rbfunction.Checked then
        begin
          functionregid := nvhelpfunction.id;
          functionname := nvhelpfunction.Text;
          functiondescribe := mmofunctiondescribe.Text;
          parameterdescribe := mmoparameterdescribe.Text;
        end
        else
        begin
          functionregid := 0;
          functionname := '';
          functiondescribe := '';
          parameterdescribe := '';
        end;
      end;
      vstreeMenu.Repaint;
    end;
  finally
    FreeAndNil(FrmMenuAdd);
  end;

end;

procedure TFrmMenus.tbtnFilterClick(Sender: TObject);
var
  data: PMenuData;
  RootNode: PVirtualNode;
begin
  inherited;
  vstreeMenu.Clear;
  // vstreeMenu.NodeDataSize := SizeOf(TMenuData);
  // 添加节点
  RootNode := vstreeMenu.AddChild(nil);
  data := vstreeMenu.GetNodeData(RootNode);
  with data^ do
  begin
    id := 0;
    parentid := 0;
    functionregid := 0;
    name := '菜单';
    PARAMETER := '';
    functionname := '';
    functiondescribe := '';
    parameterdescribe := '';
    grade := 0;
    orderno := 0;
    createtime := '';
    createby := '';
  end;
  vstreeMenu.Expanded[RootNode] := True;
  with jcdsResult do
  begin
    Active := false;
    Active := True;
    first;
    while not eof do
    begin
      AddTreeNode;
      next;
    end;
  end;
  vstreeMenu.Expanded[RootNode] := True;
  btnlocateClick(nil);
end;

procedure TFrmMenus.tbtnInsertClick(Sender: TObject);
var
  id: integer;
  selectrow: PVirtualNode;
  menudata: PMenuData;
begin
  inherited;
  selectrow := vstreeMenu.GetFirstSelected;
  if (not assigned(selectrow)) or (PMenuData(vstreeMenu.GetNodeData(selectrow))
      ^.functionregid > 0) then
  begin
    SysDialogs.ShowInfo('请先选择父菜单！');
    exit;
  end;
  menudata := vstreeMenu.GetNodeData(selectrow);
  FrmMenuAdd := TFrmMenuAdd.Create(self, self.functionItem);
  try
    with FrmMenuAdd do
    begin
      Caption := '添加菜单';
      edittype := Tedittype.add;
      parentid := menudata.id;
      lblparentmenu.Caption := menudata.name;
      grade := menudata.grade + 1;
      if selectrow.ChildCount > 0 then
      begin
        orderno := PMenuData(vstreeMenu.GetNodeData(selectrow.LastChild))
          ^.orderno + 1;
      end
      else
      begin
        orderno := 1;
      end;
      nvhelpfunction.Text := '';
      nvhelpfunction.id := 0;
      mmofunctiondescribe.Clear;
      mmoparameterdescribe.Clear;
    end;
    if SysMainForm.showFormModal(FrmMenuAdd, false) = mrok then
    begin
      with FrmMenuAdd do
      begin
        if rbfunction.Checked then
        begin
          AddTreeNode(operationid, parentid, nvhelpfunction.id,
            trim(nvedtname.Text), nvedtparam.Text, nvhelpfunction.Text,
            mmofunctiondescribe.Text, mmoparameterdescribe.Text, grade,
            orderno, createtime, createby);
        end
        else
        begin
          AddTreeNode(operationid, parentid, 0, trim(nvedtname.Text),
            nvedtparam.Text, '', '', '', grade, orderno, createtime,
            createby);
        end;
      end;
    end;
  finally
    FreeAndNil(FrmMenuAdd);
  end;

end;

procedure TFrmMenus.vstreeMenuDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  inherited;
  if assigned(Node) and (PMenuData(Sender.GetNodeData(Node))^.id > 0) then
  begin
    Allowed := True;
  end
  else
  begin
    Allowed := false;
  end;
end;

procedure TFrmMenus.vstreeMenuDragDrop(Sender: TBaseVirtualTree;
  Source: TObject; DataObject: IDataObject; Formats: TFormatArray;
  Shift: TShiftState; Pt: TPoint; var Effect: integer; Mode: TDropMode);
var
  sourcevstree: TBaseVirtualTree;
  sourceNode: PVirtualNode;
  sourcedata, destdata, tmpdata: PMenuData;
begin
  inherited;
  if not SysDialogs.Ask('确认移动', '是否移动菜单位置？') then
  begin
    exit;
  end;
  sourcevstree := TBaseVirtualTree(Source);
  sourceNode := sourcevstree.FocusedNode;
  sourcedata := sourcevstree.GetNodeData(sourceNode);
  destdata := Sender.GetNodeData(Sender.DropTargetNode);

  with jcdsMenuSave do
  begin
    Params.ParamValues['menu.id'] := sourcedata^.id;
    Params.ParamValues['menu.createtime'] := sourcedata^.createtime;
    Params.ParamValues['menu.createby'] := sourcedata^.createby;
    if sourcedata^.functionregid > 0 then
    begin
      Params.ParamValues['menu.functionregid'] := sourcedata^.functionregid;
    end
    else
    begin
      Params.ParamValues['menu.functionregid'] := null;
    end;
    Params.ParamValues['menu.name'] := sourcedata^.name;
    Params.ParamValues['menu.parameter'] := sourcedata^.PARAMETER;
    case Mode of
      dmAbove:
        begin
          Params.ParamValues['menu.parentid'] := destdata^.parentid;
          Params.ParamValues['menu.grade'] := destdata^.grade;
          if assigned(Sender.DropTargetNode.PrevSibling) then
          begin
            tmpdata := PMenuData
              (Sender.GetNodeData(Sender.DropTargetNode.PrevSibling));
            // if tmpdata^.grade=destdata^.grade then
            Params.ParamValues['menu.orderno'] :=
              (destdata^.orderno + tmpdata^.orderno) / 2
            // else
            // Params.ParamValues['menu.orderno']:=destdata^.orderno/2;
          end
          else
            Params.ParamValues['menu.orderno'] := destdata^.orderno / 2;
        end;
      dmBelow:
        begin
          Params.ParamValues['menu.parentid'] := destdata^.parentid;
          Params.ParamValues['menu.grade'] := destdata^.grade;
          if assigned(Sender.DropTargetNode.NextSibling) then
          begin
            tmpdata := PMenuData
              (Sender.GetNodeData(Sender.DropTargetNode.NextSibling));
            // if tmpdata^.grade=destdata^.grade then
            Params.ParamValues['menu.orderno'] :=
              (destdata^.orderno + tmpdata^.orderno) / 2
            // else
            // Params.ParamValues['menu.orderno']:=destdata^.orderno+1;
          end
          else
            Params.ParamValues['menu.orderno'] := destdata^.orderno + 1;
        end;
      dmOnNode:
        begin
          if PMenuData(Sender.GetNodeData(Sender.DropTargetNode))
            ^.functionregid <= 0 then
          begin
            Sender.MoveTo(sourceNode, Sender.DropTargetNode, amAddChildLast,
              false);
            Params.ParamValues['menu.parentid'] := destdata^.id;
            Params.ParamValues['menu.grade'] := destdata^.grade + 1;
            if Sender.DropTargetNode.ChildCount = 0 then
              Params.ParamValues['menu.orderno'] := 1
            else
              Params.ParamValues['menu.orderno'] := PMenuData
                (Sender.GetNodeData(Sender.DropTargetNode.LastChild))
                ^.orderno + 1;
          end
          else
          begin
            SysDialogs.ShowInfo('不允许移动，程序逻辑不应该出现此问题！');
          end;
        end;
      dmNowhere:
        begin
        end;
    else
    end;
    Execute;
    if Params.ParamValues['msg'] <> '' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      case Mode of
        dmAbove:
          begin
            Sender.MoveTo(sourceNode, Sender.DropTargetNode, amInsertBefore,
              false);
          end;
        dmBelow:
          begin
            Sender.MoveTo(sourceNode, Sender.DropTargetNode, amInsertAfter,
              false);
          end;
        dmOnNode:
          begin
            if PMenuData(Sender.GetNodeData(Sender.DropTargetNode))
              ^.functionregid = 0 then
            begin
              Sender.MoveTo(sourceNode, Sender.DropTargetNode, amAddChildLast,
                false);
            end
            else
            begin
              SysDialogs.ShowError('不允许移动，程序逻辑不应该出现此问题！');
            end;
          end;
        dmNowhere:
          begin
          end;
      else
      end;
      sourcedata^.parentid := Params.ParamValues['menu.parentid'];
      sourcedata^.grade := Params.ParamValues['menu.grade'];
      sourcedata^.orderno := Params.ParamValues['menu.orderno'];
    end;
  end;
end;

procedure TFrmMenus.vstreeMenuDragOver(Sender: TBaseVirtualTree;
  Source: TObject; Shift: TShiftState; State: TDragState; Pt: TPoint;
  Mode: TDropMode; var Effect: integer; var Accept: Boolean);

  function IsAncestor(vnDescendant, vnAncestor: PVirtualNode): Boolean;
  var
    p: PVirtualNode;
  begin
    result := false;
    p := vnDescendant;
    // vnDescendant.Parent;
    while p <> nil do
    begin
      if p = vnAncestor then
      begin
        // HintBar.Panels[0].Text := '不能移动到自己的子节点或子子节点';
        result := True;
        exit;
      end;
      p := p.Parent;
    end;
  end;

begin
  inherited;
  TVirtualStringTree(Sender).TreeOptions.SelectionOptions := TVirtualStringTree
    (Sender).TreeOptions.SelectionOptions - [toFullRowSelect];
  if (Source = Sender) and assigned(Sender.DropTargetNode) and
    (not IsAncestor(Sender.DropTargetNode,
      TBaseVirtualTree(Source).FocusedNode)) and
    ((Mode <> dmOnNode) or (TBaseVirtualTree(Source)
        .FocusedNode.Parent <> Sender.DropTargetNode)) and
    ((Mode <> dmOnNode) or (PMenuData(Sender.GetNodeData(Sender.DropTargetNode)
        )^.functionregid <= 0)) and
    ((Mode = dmOnNode) or (PMenuData(Sender.GetNodeData(Sender.DropTargetNode))
        ^.id > 0)) // 目标是顶层节点时，只能成为其子节点
    then
  begin
    Accept := True;
  end
  else
  begin
    Accept := false;
  end;
end;

procedure TFrmMenus.vstreeMenuFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data: PMenuData;
begin
  inherited;
  data := Sender.GetNodeData(Node);
  Finalize(data^);
end;

procedure TFrmMenus.vstreeMenuGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: integer);
var
  data: PMenuData;
begin
  inherited;
  data := Sender.GetNodeData(Node);
  case Column of
    0:
      if data.functionregid = 0 then
      begin
        ImageIndex := 0;
      end
      else
      begin
        ImageIndex := 2;
      end;
  else
    ImageIndex := -1;
  end;
end;

procedure TFrmMenus.vstreeMenuGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: integer);
begin
  inherited;
  NodeDataSize := SizeOf(TMenuData);
end;

procedure TFrmMenus.vstreeMenuGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: PMenuData;
begin
  inherited;
  data := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := data.name;
    1:
      CellText := data.PARAMETER;
    2:
      CellText := data.functionname;
    3:
      CellText := data.functiondescribe;
    4:
      CellText := data.parameterdescribe;
  end;
end;

procedure TFrmMenus.vstreeMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  inherited;
  TVirtualStringTree(Sender).TreeOptions.SelectionOptions := TVirtualStringTree
    (Sender).TreeOptions.SelectionOptions + [toFullRowSelect];
end;

procedure TFrmMenus.vstreeMenuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
begin
  inherited;
  TVirtualStringTree(Sender).TreeOptions.SelectionOptions := TVirtualStringTree
    (Sender).TreeOptions.SelectionOptions + [toFullRowSelect];
end;


end.

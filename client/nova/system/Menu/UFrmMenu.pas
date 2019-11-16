unit UFrmMenu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls,
  VirtualTrees, NvPrnDbgeh, NvDbgridEh, StdCtrls, NovaEdit,UDMPublic,activex,
  Buttons;

type
  PMenuData = ^TMenuData;
  TMenuData = record
    id,
    parentid,
    functionregid:int64;
    grade:integer;
    orderno:Single;
    name,
    PARAMETER,
    functionname,
    functiondescribe,
    parameterdescribe: String;
    createtime,createby:String;
  end;
 TFrmMenu = class(TSimpleCRUDForm)
    vstreeMenu: TVirtualStringTree;
    lblname: TLabel;
    nvedtname: TNovaEdit;
    jcdsMenuDelete: TjsonClientDataSet;
    ilTree: TImageList;
    jcdsMenuSave: TjsonClientDataSet;
    btnlocate: TBitBtn;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure vstreeMenuGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstreeMenuGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
    procedure FormCreate(Sender: TObject);
    procedure vstreeMenuInitNode(Sender: TBaseVirtualTree; ParentNode,
      Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
    procedure vstreeMenuFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);
    procedure vstreeMenuGetImageIndex(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var ImageIndex: Integer);
    procedure tbtnFilterClick(Sender: TObject);
    procedure vstreeMenuDragOver(Sender: TBaseVirtualTree; Source: TObject;
      Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
      var Effect: Integer; var Accept: Boolean);
    procedure vstreeMenuDragAllowed(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    procedure vstreeMenuDragDrop(Sender: TBaseVirtualTree; Source: TObject;
      DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
      Pt: TPoint; var Effect: Integer; Mode: TDropMode);
    procedure vstreeMenuMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure vstreeMenuMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnlocateClick(Sender: TObject);
    procedure nvedtnameKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function AddTreeNode:PVirtualNode;overload;
    function AddTreeNode(_id,_parentid,_functionregid:int64;
                          _name,_PARAMETER,_functionname,_functiondescribe,_parameterdescribe: String;
                          _grade:integer;_orderno:single;
                          _createtime,_createby:String):PVirtualNode;overload;
    function findNodeByid(id:int64):PVirtualNode;
    function locateLikeName(_name:String):PVirtualNode;overload;
    function locateLikeName(_name:String;_begin:PVirtualNode):PVirtualNode;overload;
    function recursionlocateLikeName(_name:String;_parent:PVirtualNode):PVirtualNode;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmMenu: TFrmMenu;

implementation

uses UFrmMenuAdd,services,PubFn;

{$R *.dfm}

function TFrmMenu.AddTreeNode(_id,_parentid,_functionregid:int64;
                              _name,_PARAMETER,_functionname,_functiondescribe,_parameterdescribe: String;
                              _grade:integer;_orderno:single;
                              _createtime,_createby:String): PVirtualNode;
var
  menudata: PMenuData;
begin
//        RootNode.CheckType := ctTriStateCheckBox; // ctCheckbox
//        RootNode.CheckState := csUncheckedNormal;
  result:=nil;
  with vstreemenu do
  begin
    result:=AddChild(findNodeByid(_parentid));
    menudata := GetNodeData(result);
    with menudata^ do
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
      createby:=_createby;
    end;
  end;
end;

function TFrmMenu.findNodeByid(id: int64): PVirtualNode;
var tmpnode:PVirtualNode;
    data:PMenuData;
begin
  result:=nil;
  with vstreeMenu do
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
      tmpnode:=vstreeMenu.GetNext(tmpnode);
    end;
  end;
end;

procedure TFrmMenu.FormCreate(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(nil);
end;

procedure TFrmMenu.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{533CAEED-0E42-4417-A5C8-160A64D36F00}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{59755A6E-4726-4754-A35D-DF517446D43D}' then //修改
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{B5E313BF-69BE-4621-82B3-C69E3AC1F06D}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{12183242-6817-4AB3-8024-D2911BDEE10B}' then //保存
  begin
    tbtnSave.Enabled:=aEnable;
  end;
end;

function TFrmMenu.locateLikeName(_name: String;
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
  if (not assigned(result)) and assigned(_begin.Parent) and (_begin.Parent<>vstreeMenu.RootNode) then
  begin
    beginNode:=_begin.Parent;
    while (not Assigned(beginNode.NextSibling)) and (beginNode<>vstreeMenu.RootNode) do
    begin
      beginNode:=beginNode.Parent;
    end;
    if assigned(beginNode.NextSibling) and (beginNode<>vstreeMenu.RootNode) then
    begin
      //从父节点的下一个节点开始循环
      result:=locateLikeName(_name,beginNode.NextSibling);
    end;
  end;
end;

function TFrmMenu.locateLikeName(_name: String): PVirtualNode;
var beginNode:PVirtualNode;
begin
  result:=nil;
  beginNode:=vstreeMenu.FocusedNode;
  if not Assigned(beginNode) then
  begin
    beginNode:=vstreeMenu.GetFirst();
  end;
  result:=locateLikeName(_name,beginNode);
  if (not assigned(result)) and assigned(beginNode) then
  begin
    if (beginNode<>vstreeMenu.GetFirst())  then
    begin
      if SysDialogs.Ask('提示','没有找到"'+nvedtname.Text+'",请问需要从头开始查找吗？') then
      begin
        result:=recursionlocateLikeName(_name,vstreeMenu.GetFirst());
      end;
    end
    else
    begin
      SysDialogs.ShowInfo('没有找到"'+nvedtname.Text+'"');
    end;
  end;
end;

procedure TFrmMenu.nvedtnameKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=VK_RETURN then
  begin
    btnlocateClick(nil);
  end;
end;

function TFrmMenu.recursionlocateLikeName(_name:String;_parent: PVirtualNode): PVirtualNode;
var tmpdata:PMenudata;
    i:integer;
    tmpnode:PVirtualNode;
begin
  result:=nil;
  tmpdata:=PMenudata(vstreeMenu.GetNodeData(_parent));
  if (pos(_name,tmpdata.name)>0) or (pos(_name,tmpdata.functionname)>0) or (pos(_name,tmpdata.functiondescribe)>0) then
  begin
    result:=_parent;
    vstreeMenu.Selected[result] := True;
    vstreeMenu.FocusedNode := result;
    vstreeMenu.FullyVisible[result] := True;
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
      tmpdata:=PMenudata(vstreeMenu.GetNodeData(tmpnode));
      if (pos(_name,tmpdata.name)>0) or (pos(_name,tmpdata.functionname)>0) or (pos(_name,tmpdata.functiondescribe)>0) then
      begin
        result:=tmpnode;
        vstreeMenu.Selected[result] := True;
        vstreeMenu.FocusedNode := result;
        vstreeMenu.FullyVisible[result] := True;
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

procedure TFrmMenu.tbtnDeleteClick(Sender: TObject);
var selectrow:PVirtualNode;
begin
  inherited;
  selectrow:=vstreeMenu.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.ShowInfo('请先选择要删除菜单！');
    exit;
  end
  else if selectrow.ChildCount>0 then
  begin
    SysDialogs.ShowInfo('该菜单拥有子菜单，请先删除子菜单！');
    exit;
  end;
  if not SysDialogs.Confirm('提示','确定要删除该菜单吗？') then
  begin
    exit;
  end;
  with jcdsMenuDelete do
  begin
    Params.ParamValues['menu.id']:=PMenudata(vstreeMenu.GetNodeData(selectrow))^.id;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      vstreeMenu.DeleteNode(selectrow);
    end;
  end;
end;

procedure TFrmMenu.tbtnEditClick(Sender: TObject);
var id:Integer;
    selectrow:PVirtualNode;
    menudata:PMenuData;
begin
  inherited;
  selectrow:=vstreeMenu.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.ShowInfo('请先选择要修改菜单！');
    exit;
  end
  else if PMenuData(vstreeMenu.GetNodeData(selectrow))^.id=0 then
  begin
    SysDialogs.ShowInfo('顶级菜单不能修改！');
    exit;
  end;

  FrmMenuAdd:=TFrmMenuAdd.Create(self,self.functionItem);
  try
    with FrmMenuAdd,jcdsResult do
    begin
      Caption:='修改菜单';
      edittype:=Tedittype.update;
      menudata:=vstreeMenu.GetNodeData(selectrow);
      operationid:=menudata.id;
      createtime:=menudata.createtime;
      createby:=menudata.createby;
      parentid:=menudata.parentid;
      lblparentmenu.Caption:=PMenuData(vstreeMenu.GetNodeData(selectrow.Parent))^.name;
      grade:=menudata.grade;
      orderno:=menudata.orderno;
      nvedtname.Text:=menudata.name;
      nvhelpfunction.text:=menudata.functionname;
      nvhelpfunction.id:=menudata.functionregid;
      nvedtparam.Text:=menudata.PARAMETER;
      mmofunctiondescribe.text:=menudata.functiondescribe;
      mmoparameterdescribe.Text:=menudata.parameterdescribe;
      if menudata.functionregid>0 then
      begin
        rbfunction.Checked:=true;
      end
      else
      begin
        rbfolder.Checked:=true;
        if selectrow.ChildCount>0 then
        begin
          rbfunction.Enabled:=false;
        end;
      end;
    end;
    if SysMainForm.showFormModal(FrmMenuAdd,false)=mrok then
    begin
      with FrmMenuAdd,menudata^ do
      begin
        name:=nvedtname.Text;
        PARAMETER:=nvedtparam.Text;
        if rbfunction.Checked then
        begin
          functionregid:=nvhelpfunction.id;
          functionname:=nvhelpfunction.Text;
          functiondescribe:=mmofunctiondescribe.Text;
          parameterdescribe:=mmoparameterdescribe.Text;
        end
        else
        begin
          functionregid:=0;
          functionname:='';
          functiondescribe:='';
          parameterdescribe:='';
        end;
      end;
      vstreeMenu.Repaint;
    end;
  finally
    FreeAndNil(FrmMenuAdd);
  end;
end;

procedure TFrmMenu.tbtnFilterClick(Sender: TObject);
var
  Data:PMenuData;
  RootNode:PVirtualNode;
begin
  inherited;
  vstreeMenu.Clear;
//  vstreeMenu.NodeDataSize := SizeOf(TMenuData);
  //添加节点
  RootNode:= vstreeMenu.AddChild(nil);
  Data:=vstreeMenu.GetNodeData(RootNode);
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
    createby:='';
  end;
  vstreeMenu.Expanded[RootNode]:=True;
  with jcdsResult do
  begin
    Active:=false;
    active:=true;
    first;
    while not eof do
    begin
      AddTreeNode;
      next;
    end;
  end;
  vstreeMenu.Expanded[RootNode]:=True;
  btnlocateClick(nil);
end;

procedure TFrmMenu.tbtnInsertClick(Sender: TObject);
var id:Integer;
    selectrow:PVirtualNode;
    menudata:PMenuData;
begin
  inherited;
  selectrow:=vstreeMenu.GetFirstSelected;
  if (not assigned(selectrow)) or (PMenuData(vstreeMenu.GetNodeData(selectrow))^.functionregid>0) then
  begin
    SysDialogs.ShowInfo('请先选择父菜单！');
    exit;
  end;
  menudata:=vstreeMenu.GetNodeData(selectrow);
  FrmMenuAdd:=TFrmMenuAdd.Create(self,self.functionItem);
  try
    with FrmMenuAdd do
    begin
      Caption:='添加菜单';
      edittype:=Tedittype.add;
      parentid:=menudata.id;
      lblparentmenu.Caption:=menudata.name;
      grade:=menudata.grade+1;
      if selectrow.ChildCount>0 then
      begin
        orderno:=PMenuData(vstreeMenu.GetNodeData(selectrow.LastChild))^.orderno+1;
      end
      else
      begin
        orderno:=1;
      end;
      nvhelpfunction.text:='';
      nvhelpfunction.id:=0;
      mmofunctiondescribe.Clear;
      mmoparameterdescribe.Clear;
    end;
    if SysMainForm.showFormModal(FrmMenuAdd,false)=mrOk then
    begin
      with FrmMenuAdd do
      begin
        if rbfunction.Checked then
        begin
          AddTreeNode(operationid,parentid,
                      nvhelpfunction.id,
                      Trim(nvedtname.Text),nvedtparam.Text,
                      nvhelpfunction.Text,
                      mmofunctiondescribe.Text,
                      mmoparameterdescribe.Text,
                      grade,orderno,
                      createtime,createby);
        end
        else
        begin
          AddTreeNode(operationid,parentid,
                      0,
                      Trim(nvedtname.Text),nvedtparam.Text,
                      '','','',
                      grade,orderno,
                      createtime,createby);
        end;
      end;
    end;
  finally
    FreeAndNil(FrmMenuAdd);
  end;
end;

procedure TFrmMenu.vstreeMenuDragAllowed(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
begin
  inherited;
  if assigned(Node)
  and (PMenudata(Sender.GetNodeData(Node))^.id>0) then
  begin
    Allowed:=true;
  end
  else
  begin
    Allowed:=false;
  end;
end;

procedure TFrmMenu.vstreeMenuDragDrop(Sender: TBaseVirtualTree; Source: TObject;
  DataObject: IDataObject; Formats: TFormatArray; Shift: TShiftState;
  Pt: TPoint; var Effect: Integer; Mode: TDropMode);
var sourcevstree:TBaseVirtualTree;
    sourceNode:PVirtualNode;
    sourcedata,destdata,tmpdata:Pmenudata;
begin
  inherited;
  if not SysDialogs.Ask('确认移动','是否移动菜单位置？') then
  begin
    exit;
  end;
  sourcevstree:=TBaseVirtualTree(Source);
  sourceNode:=sourcevstree.FocusedNode;
  sourcedata:=sourcevstree.GetNodeData(sourcenode);
  destdata:=Sender.GetNodeData(Sender.DropTargetNode);

  with FrmMenu.jcdsMenuSave do
  begin
    Params.ParamValues['menu.id']:=sourcedata^.id;
    Params.ParamValues['menu.createtime']:=sourcedata^.createtime;
    Params.ParamValues['menu.createby']:=sourcedata^.createby;
    if sourcedata^.functionregid>0 then
    begin
      Params.ParamValues['menu.functionregid']:=sourcedata^.functionregid;
    end
    else
    begin
      Params.ParamValues['menu.functionregid']:=null;
    end;
    Params.ParamValues['menu.name']:=sourcedata^.name;
    Params.ParamValues['menu.parameter']:=sourcedata^.PARAMETER;
    case Mode of
      dmAbove:
        begin
          Params.ParamValues['menu.parentid']:=destdata^.parentid;
          Params.ParamValues['menu.grade']:=destdata^.grade;
          if assigned(sender.DropTargetNode.PrevSibling) then
          begin
            tmpdata:=PMenudata(sender.GetNodeData(sender.DropTargetNode.PrevSibling));
//            if tmpdata^.grade=destdata^.grade then
              Params.ParamValues['menu.orderno']:=(destdata^.orderno+tmpdata^.orderno)/2
//            else
//              Params.ParamValues['menu.orderno']:=destdata^.orderno/2;
          end
          else
            Params.ParamValues['menu.orderno']:=destdata^.orderno/2;
        end;
      dmBelow:
        begin
          Params.ParamValues['menu.parentid']:=destdata^.parentid;
          Params.ParamValues['menu.grade']:=destdata^.grade;
          if assigned(sender.DropTargetNode.NextSibling) then
          begin
            tmpdata:=PMenudata(sender.GetNodeData(sender.DropTargetNode.NextSibling));
//            if tmpdata^.grade=destdata^.grade then
              Params.ParamValues['menu.orderno']:=(destdata^.orderno+tmpdata^.orderno)/2
//            else
//              Params.ParamValues['menu.orderno']:=destdata^.orderno+1;
          end
          else
            Params.ParamValues['menu.orderno']:=destdata^.orderno+1;
        end;
      dmOnNode:
        begin
          if PMenudata(Sender.GetNodeData(Sender.DropTargetNode))^.functionregid<=0 then
          begin
            Sender.MoveTo(sourceNode, Sender.DropTargetNode, amAddChildLast, False);
            Params.ParamValues['menu.parentid']:=destdata^.id;
            Params.ParamValues['menu.grade']:=destdata^.grade+1;
            if Sender.DropTargetNode.ChildCount=0 then
              Params.ParamValues['menu.orderno']:=1
            else
              Params.ParamValues['menu.orderno']:=PMenudata(sender.GetNodeData(Sender.DropTargetNode.LastChild))^.orderno+1;
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
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      case Mode of
        dmAbove:
          begin
            Sender.MoveTo(sourceNode, Sender.DropTargetNode, amInsertBefore, False);
          end;
        dmBelow:
          begin
              Sender.MoveTo(sourceNode, Sender.DropTargetNode, amInsertAfter, False);
    //        for i := 0 to High(selectedList) do
    //        begin
    //          srcNode := selectedList[i];
    //        end;
    //        VirtualStringTree1.Sort(dstNode, 0, sdAscending, False);
          end;
        dmOnNode:
          begin
            if PMenudata(Sender.GetNodeData(Sender.DropTargetNode))^.functionregid=0 then
            begin
              Sender.MoveTo(sourceNode, Sender.DropTargetNode, amAddChildLast, False);
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
      sourcedata^.parentid:=Params.ParamValues['menu.parentid'];
      sourcedata^.grade:=Params.ParamValues['menu.grade'];
      sourcedata^.orderno:=Params.ParamValues['menu.orderno'];
    end;
  end;
end;

procedure TFrmMenu.vstreeMenuDragOver(Sender: TBaseVirtualTree; Source: TObject;
  Shift: TShiftState; State: TDragState; Pt: TPoint; Mode: TDropMode;
  var Effect: Integer; var Accept: Boolean);
  function IsAncestor(vnDescendant, vnAncestor: PVirtualNode): Boolean;
  var
    p: PVirtualNode;
  begin
    Result := False;
    p := vnDescendant;//vnDescendant.Parent;
    while p <> nil do
    begin
      if p = vnAncestor then
      begin
//        HintBar.Panels[0].Text := '不能移动到自己的子节点或子子节点';
        Result := True;
        Exit;
      end;
      p := p.Parent;
    end;
  end;
begin
  inherited;
  TVirtualStringTree(sender).TreeOptions.SelectionOptions:=TVirtualStringTree(sender).TreeOptions.SelectionOptions-[toFullRowSelect];
  if (source=sender) and Assigned(sender.DropTargetNode)
    and (not IsAncestor(sender.DropTargetNode, TBaseVirtualTree(Source).FocusedNode))
    and ((mode<>dmOnNode) or (TBaseVirtualTree(Source).FocusedNode.Parent<>sender.DropTargetNode))
    and ((mode<>dmOnNode) or (Pmenudata(sender.GetNodeData(sender.DropTargetNode))^.functionregid<=0))
    and ((mode=dmOnNode) or (Pmenudata(sender.GetNodeData(sender.DropTargetNode))^.id>0)) //目标是顶层节点时，只能成为其子节点
  then
  begin
    Accept:=true;
  end
  else
  begin
    accept:=false;
  end;
end;

procedure TFrmMenu.vstreeMenuFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
Data:PMenuData;
begin
  inherited;
  Data:=Sender.GetNodeData(Node);
  Finalize(Data^);
end;

procedure TFrmMenu.vstreeMenuGetImageIndex(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var ImageIndex: Integer);
var
  Data: PMenuData;
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

procedure TFrmMenu.vstreeMenuGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;
  NodeDataSize := SizeOf(TMenuData);
end;

procedure TFrmMenu.vstreeMenuGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  Data: PMenuData;
begin
  inherited;
  Data := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := Data.name;
    1:
      CellText := Data.PARAMETER;
    2:
      CellText := Data.functionname;
    3:
      CellText := Data.functiondescribe;
    4:
      CellText := Data.parameterdescribe;
  end;
end;

procedure TFrmMenu.vstreeMenuInitNode(Sender: TBaseVirtualTree; ParentNode,
  Node: PVirtualNode; var InitialStates: TVirtualNodeInitStates);
var
  Data: PMenuData;
begin
  inherited;
//  Data := Sender.GetNodeData(Node);
////  Node.CheckType:=Data^.CheckType;
////  Node.CheckState:=Data^.CheckState;
//  if ParentNode = nil then
//  begin
//    with Data^ do
//    begin
//    end;
//    InitialStates := InitialStates + [ivsHasChildren, ivsExpanded];
//  end
//  else
//  begin
//    with Data^ do
//    begin
//    end;
//  end;
end;

procedure TFrmMenu.vstreeMenuMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TVirtualStringTree(sender).TreeOptions.SelectionOptions:=TVirtualStringTree(sender).TreeOptions.SelectionOptions+[toFullRowSelect];
end;

procedure TFrmMenu.vstreeMenuMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  TVirtualStringTree(sender).TreeOptions.SelectionOptions:=TVirtualStringTree(sender).TreeOptions.SelectionOptions+[toFullRowSelect];
end;

function TFrmMenu.AddTreeNode:PVirtualNode;
begin
  with jcdsResult do
  result:=AddTreeNode(FieldByName('id').Value,FieldByName('parentid').Value,
                      nvl(FieldByName('functionregid').Value,0),
                      FieldByName('name').Value,nvl(FieldByName('PARAMETER').Value,''),
                      nvl(FieldByName('functionname').Value,''),
                      nvl(FieldByName('functiondescribe').Value,''),
                      nvl(FieldByName('parameterdescribe').Value,''),
                      FieldByName('grade').Value,FieldByName('orderno').Value,
                      FieldByName('createtime').AsString,FieldByName('createby').AsString);
end;

procedure TFrmMenu.btnlocateClick(Sender: TObject);
begin
  inherited;
  if (trim(nvedtname.Text)<>'') then
  begin
    locateLikeName(trim(nvedtname.Text));
  end;
end;

end.

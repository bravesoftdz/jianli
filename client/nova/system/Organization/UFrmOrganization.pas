unit UFrmOrganization;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, PrnDbgeh, StdCtrls, NovaHComboBox,
  NvPrnDbgeh, DB, DBClient, jsonClientDataSet, ImgList, GridsEh, DBGridEh,
  NvDbgridEh, ComCtrls, ToolWin, ExtCtrls, NovaEdit,
  NovaComboBox, VirtualTrees, Buttons,Generics.Collections;

type

  POrgData = ^TOrgData;
  TOrgData = record
    id: Int64;
    parentid: Int64;
    districtid: Int64;
    unitid: Int64;
    stationid: Int64;
    createby: Int64;
    updateby: Int64;
    code, name, orgtype, describe, serversaddress, ticketserversaddress,
      address, contactperson, contactphone, createtime, updatetime,synccode,
      unitname, stationname, parentname, districtname, updatename, username,
      typename: String;
    isactive, islocal: Boolean;
  end;

  TFrmOrganization = class(TSimpleCRUDForm)
    lbl2: TLabel;
    edtname: TNovaEdit;
    DBGridEh1: TNvDBGridEh;
    jsonCDSDelOrg: TjsonClientDataSet;
    jcdstypename: TjsonClientDataSet;
    GroupBox2: TGroupBox;
    dbgrdh1: TNvDBGridEh;
    mmo: TMemo;
    dataSource: TDataSource;
    jcdsQryDepment: TjsonClientDataSet;
    jsonCDSDelDep: TjsonClientDataSet;
    prntdbgrdh1: TNvPrintDBGridEh;
    ToolBar1: TToolBar;
    btnInsertDep: TToolButton;
    btnUpdateDep: TToolButton;
    ToolButton5: TToolButton;
    btndelDep: TToolButton;
    jcdsResultcode: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultcontactperson: TWideStringField;
    jcdsResultcontactphone: TWideStringField;
    jcdsResultaddress: TWideStringField;
    jcdsResultparentname: TWideStringField;
    jcdsResultdescribe: TWideStringField;
    jcdsResultserversaddress: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdsResultticketserversaddress: TWideStringField;
    jcdsResultstationid: TLargeintField;
    jcdsResultunitid: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResulttypename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultstationname: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultusername: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    lrgntfldResultid: TLargeintField;
    jcdsResultorganid: TLargeintField;
    jcdsResultisactive: TBooleanField;
    jcdsResultislocal: TBooleanField;
    btnlocate: TBitBtn;
    jcdsResultsynccode: TWideStringField;
    vstreeOrg: TVirtualStringTree;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure btnInsertDepClick(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure btndelDepClick(Sender: TObject);
    procedure vstreeOrgGetNodeDataSize(Sender: TBaseVirtualTree;
      var NodeDataSize: Integer);
    procedure vstreeOrgFreeNode(Sender: TBaseVirtualTree; Node: PVirtualNode);

    procedure vstreeOrgClick(Sender: TObject);
    procedure btnlocateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure vstreeOrgGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
  private
    { Private declarations }
    curid:Int64;
    islast:Boolean;
    orgidlist:TList<Int64>;
    function AddTreeNode: PVirtualNode; overload;
    function AddTreeNode(orgdata: TOrgData): PVirtualNode; overload;
    function findNodeByid(id: Int64): PVirtualNode;
    procedure VSTIterateProc(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
    procedure qryDeparment(parentid:Int64);

  public
    { Public declarations }
  end;

var
  FrmOrganization: TFrmOrganization;

implementation

uses PubFn, Services, UDMPublic, UFrmOrgEdit, UFrmDepEdit;
{$R *.dfm}

var
  orgid: string;

function TFrmOrganization.findNodeByid(id: Int64): PVirtualNode;
var
  tmpnode: PVirtualNode;
  data: POrgData;
begin
  result := nil;
  with vstreeOrg do
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
      tmpnode := vstreeOrg.GetNext(tmpnode);
    end;
  end;
end;

procedure TFrmOrganization.FormShow(Sender: TObject);
begin
  inherited;
  orgidlist:=TList<Int64>.Create;
end;

function TFrmOrganization.AddTreeNode(orgdata: TOrgData): PVirtualNode;
var
  menudata: POrgData;
  virtualNode: PVirtualNode;
  data: POrgData;
  tempNode: PVirtualNode;
begin
  result := nil;
  with vstreeOrg do
  begin
    virtualNode := findNodeByid(orgdata.parentid);
    if virtualNode = nil then
    begin
      // 添加节点
      tempNode := vstreeOrg.AddChild(nil);
      data := vstreeOrg.GetNodeData(tempNode);
      with data^ do
      begin
        id := orgdata.id;
        parentid := orgdata.parentid;
        districtid := orgdata.districtid;
        unitid := orgdata.unitid;
        stationid := orgdata.stationid;
        updateby := orgdata.updateby;
        code := orgdata.code;
        name := orgdata.name;
        orgtype := orgdata.orgtype;
        describe := orgdata.describe;
        serversaddress := orgdata.serversaddress;
        ticketserversaddress := orgdata.ticketserversaddress;
        address := orgdata.address;
        contactperson := orgdata.contactperson;
        contactphone := orgdata.contactphone;
        createtime := orgdata.createtime;
        updatetime := orgdata.updatetime;
        stationname := orgdata.stationname;
        parentname := orgdata.parentname;
        districtname := orgdata.districtname;
        updatename := orgdata.updatename;
        username := orgdata.username;
        isactive := orgdata.isactive;
        islocal := orgdata.islocal;
        typename := orgdata.typename;
        unitname := orgdata.unitname;
        synccode := orgdata.synccode;
      end;
      vstreeOrg.Expanded[RootNode] := true;
    end
    else
    begin
      result := AddChild(virtualNode);
      menudata := GetNodeData(result);
      with menudata^ do
      begin
        id := orgdata.id;
        parentid := orgdata.parentid;
        districtid := orgdata.districtid;
        unitid := orgdata.unitid;
        stationid := orgdata.stationid;
        updateby := orgdata.updateby;
        code := orgdata.code;
        name := orgdata.name;
        orgtype := orgdata.orgtype;
        describe := orgdata.describe;
        serversaddress := orgdata.serversaddress;
        ticketserversaddress := orgdata.ticketserversaddress;
        address := orgdata.address;
        contactperson := orgdata.contactperson;
        contactphone := orgdata.contactphone;
        createtime := orgdata.createtime;
        updatetime := orgdata.updatetime;
        stationname := orgdata.stationname;
        parentname := orgdata.parentname;
        districtname := orgdata.districtname;
        updatename := orgdata.updatename;
        username := orgdata.username;
        isactive := orgdata.isactive;
        islocal := orgdata.islocal;
        typename := orgdata.typename;
        unitname := orgdata.unitname;
        synccode := orgdata.synccode;
      end;
    end;
  end;
end;

function TFrmOrganization.AddTreeNode: PVirtualNode;
var
  orgdata: TOrgData;
begin
  with jcdsResult do
  begin
    orgdata.id := nvl(FieldByName('id').Value, 0);
    orgdata.parentid := nvl(FieldByName('parentid').Value, 0);
    orgdata.districtid := nvl(FieldByName('districtid').Value,0);
    orgdata.unitid := nvl(FieldByName('unitid').Value, 0);
    orgdata.stationid := nvl(FieldByName('stationid').Value, 0);
    orgdata.updateby := FieldByName('updateby').Value;
    orgdata.code := FieldByName('code').Value;
    orgdata.name := FieldByName('name').Value;
    orgdata.orgtype := FieldByName('type').Value;
    orgdata.describe := FieldByName('describe').AsString;
    orgdata.serversaddress := FieldByName('serversaddress').AsString;
    orgdata.ticketserversaddress := FieldByName('ticketserversaddress')
      .AsString;
    orgdata.address := FieldByName('address').AsString;
    orgdata.contactperson := FieldByName('contactperson').AsString;
    orgdata.contactphone := FieldByName('contactphone').AsString;
    orgdata.createtime := FieldByName('createtime').AsString;
    orgdata.updatetime := FieldByName('updatetime').AsString;
    orgdata.stationname := FieldByName('stationname').AsString;
    orgdata.parentname := FieldByName('parentname').AsString;
    orgdata.districtname := FieldByName('districtname').AsString;
    orgdata.updatename := FieldByName('updatename').AsString;
    orgdata.username := FieldByName('username').AsString;
    orgdata.isactive := FieldByName('isactive').AsBoolean;
    orgdata.islocal := FieldByName('islocal').AsBoolean;
    orgdata.typename := FieldByName('typename').AsString;
    orgdata.unitname := FieldByName('unitname').AsString;
    orgdata.synccode:= FieldByName('synccode').AsString;
  end;
  result := AddTreeNode(orgdata);
end;

procedure TFrmOrganization.tbtnFilterClick(Sender: TObject);
begin
  inherited;

  with jcdsResult do
  begin
    Active := false;
   { Params.ParamValues['filter_LIKES_t!name'] := edtname.Text;
    if Trim(cbbtype.Text) = '' then
    begin
      Params.ParamValues['filter_LIKES_t!type'] := null;
    end
    else
    begin
      Params.ParamValues['filter_LIKES_t!type'] := TCommInfo
        (cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
    if cbbparent.ItemIndex >= 0 then
    begin
      orgid := cbbparent.HelpFieldValue['id'];
      Params.ParamValues['filter_EQL_t!parentid'] := orgid;
    end
    else
    begin
      Params.ParamValues['filter_EQL_t!parentid'] := null;
    end; }
    Active := true;
  end;

  vstreeOrg.Clear;

  with jcdsResult do
  begin
    first;
    while not eof do
    begin
      AddTreeNode;
      next;
    end;
  end;
  vstreeOrg.IterateSubtree(nil,VSTIterateProc,nil,[]);
  orgidlist.Clear;
end;

procedure TFrmOrganization.btndelDepClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
  parentid:Int64;
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;
  parentid:=jcdsQryDepment.FieldByName('parentid').AsInteger;
  with jsonCDSDelDep do
    try
      close;
      Params.ParamByName('department.id').Value := jcdsQryDepment.FieldByName('id')
        .AsInteger;
      Params.ParamByName('parentid').Value := parentid;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
         SysDialogs.ShowMessage(sResult);
         QryDeparment(parentid);
      end
      else
      begin
        SysDialogs.ShowError(sResult);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('部门信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmOrganization.btnInsertDepClick(Sender: TObject);
var
  id: Integer;
  selectrow: PVirtualNode;
  orgdata: POrgData;
begin
  inherited;
  selectrow:=vstreeOrg.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.Warning('请先选择要添加部门的机构！');
    exit;
  end;
  orgdata := vstreeOrg.GetNodeData(selectrow);
  with FrmDepEdit do
  begin
    FrmDepEdit := TFrmDepEdit.Create(self);
    Caption := '添加部门信息';
    flag := true;
    parentid := orgdata.id;
    NovaEdtOrg.Text:=orgdata.name;
    ShowModal;
    if ModalResult = mrok then
    begin
      qryDeparment(parentid);
    end;
  end;
end;
{procedure TFrmOrganization.VirtualStringTree1GetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: POrgData;
begin
  inherited;
  data := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := data.name;
    1:
      CellText := data.code;
    2:
      CellText := data.typename;
    3:
      CellText := data.parentname;
    4:
      CellText := data.stationname;
    5:
      CellText := data.unitname;
    6:
      CellText := data.districtname;
    7:
      CellText := data.serversaddress;
    8:
      CellText := data.ticketserversaddress;
    9:
      CellText := data.contactperson;
    10:
      CellText := data.contactphone;
    11:
      CellText := data.address;
    12:
      CellText := data.describe;
    13:
      CellText := data.username;
    14:
      CellText := data.createtime;
    15:
      CellText := data.updatename;
    16:
      CellText := data.updatetime;
  end;

end;  }

procedure TFrmOrganization.VSTIterateProc(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Data: Pointer; var Abort: Boolean);
var
  _pNodeData:POrgData;
begin
  _pNodeData := Sender.GetNodeData(Node);
  if Assigned(_pNodeData) then
  begin
    if  (orgidlist<>nil) and  (orgidlist.Contains(_pNodeData.id)) then
      exit;
    vstreeOrg.Expanded[Node] := true;
    if (Pos(edtname.Text,_pNodeData.name)>0)
       or (curid=_pNodeData.id)
    then
    begin
      vstreeOrg.FocusedNode:=node;
      vstreeOrg.Selected[node] := True;
      vstreeOrg.FullyVisible[node] := True;
      if not orgidlist.Contains(_pNodeData.id) then
        orgidlist.Add(_pNodeData.id);
      islast:=true;
      Abort:=true;
      Exit;
    end;
  end;
end;
procedure TFrmOrganization.btnlocateClick(Sender: TObject);
var
 PVN:PVirtualNode;
begin
  inherited;
  islast:=false;
  PVN:=vstreeOrg.IterateSubtree(nil,VSTIterateProc,nil,[]);
  if (not islast) then
  begin
    if SysDialogs.Ask('查找','已经查找到最后一个，是否重头开始查找！') then
    begin
        orgidlist.Clear;
        vstreeOrg.IterateSubtree(nil,VSTIterateProc,nil,[]);
    end;
  end;

end;

procedure TFrmOrganization.btnUpdateDepClick(Sender: TObject);
var
  id: Integer;
begin
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  with FrmDepEdit do
  begin
    FrmDepEdit := TFrmDepEdit.Create(self);
    Caption := '修改部门信息';
    flag := false;
    id := jcdsQryDepment.FieldByName('id').AsLargeInt;
    edtname.Text := jcdsQryDepment.FieldByName('name').AsString;
    edtCode.Text := jcdsQryDepment.FieldByName('code').AsString;
    createby := jcdsQryDepment.FieldByName('createby').AsString;
    createtime := jcdsQryDepment.FieldByName('createtime').AsString;
    mmodescribe.Text := jcdsQryDepment.FieldByName('describe').AsString;
    edtphone.Text := jcdsQryDepment.FieldByName('contactphone').AsString;
    edtContactPerson.Text := jcdsQryDepment.FieldByName('contactperson').AsString;
    parentid := jcdsQryDepment.FieldByName('parentid').AsLargeInt;
    NovaEdtOrg.Text:= jcdsQryDepment.FieldByName('orgname').AsString;
    nvhlpsupervisorid.Id:=jcdsQryDepment.FieldByName('supervisorid').AsLargeInt;
    nvhlpsupervisorid.text:=jcdsQryDepment.FieldByName('supervisor').AsString;

    ShowModal;
    if ModalResult = mrok then
    begin
       QryDeparment(parentid);
       jcdsQryDepment.Locate('id', id, []);
    end;
  end;
end;


procedure TFrmOrganization.qryDeparment(parentid: Int64);
begin
  with jcdsQryDepment do
  begin
    Active := false;
    Params.ParamByName('parentid').Value := parentid;
    Active := true;
  end;
end;

procedure TFrmOrganization.tbtnDeleteClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
  id: Integer;
  selectrow: PVirtualNode;
  orgdata: POrgData;
begin
  inherited;
  selectrow:=vstreeOrg.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.ShowError('请先选择要删除记录！');
    exit;
  end;
  orgdata := vstreeOrg.GetNodeData(selectrow);
  if not orgdata.islocal then
  begin
    SysDialogs.ShowMessage('不能删除非本地机构');
    exit;
  end
  else if orgdata.id=SysInfo.LoginUserInfo.OrgID then
  begin
    SysDialogs.ShowMessage('不能删本地默认机构');
    exit;
  end;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
  begin
    exit;
  end;
  id := orgdata.id;
  with jsonCDSDelOrg do
    try
      close;
      Params.ParamByName('organization.id').Value :=id;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('机构信息删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmOrganization.tbtnEditClick(Sender: TObject);
var
  id: Integer;
  selectrow: PVirtualNode;
  orgdata: POrgData;
begin
  inherited;
  selectrow:=vstreeOrg.GetFirstSelected;
  if not assigned(selectrow) then
  begin
    SysDialogs.ShowMessage('请先选择要修改记录！');
    exit;
  end;
  orgdata := vstreeOrg.GetNodeData(selectrow);
  if not orgdata.islocal then
  begin
    SysDialogs.ShowMessage('不能修改非本地机构');
    exit;
  end;
  with FrmOrgEdit do
  begin
    FrmOrgEdit := TFrmOrgEdit.Create(self);
    Caption := '修改组织机构信息';
    flag := false;

    edittype := Tedittype.update;
    id := orgdata.id;
    curid:=orgdata.id;

    createtime := orgdata.createtime;
    createby := orgdata.createby;
    parentid := orgdata.parentid;
    NovaHelpObjectID.OnIdChange:=nil;
    //cbbCobOrgTypeChange(nil);
    cbbComboxParentOrg.SetItemIndexByField('id', parentid);
    cbbCobOrgType.SetItemIndexByCode(orgdata.orgtype);
    edtname.Text :=orgdata.name;
    edtname.id := orgdata.id;
    edtCode.Text := orgdata.code;
    edtServiceAddress.Text := orgdata.serversaddress;
    if ((orgdata.orgtype = '1') or (orgdata.orgtype = '2')) then
    begin
      NovaHelpObjectID.id := orgdata.stationid;
      lbl14.Caption := '对应站点';
      NovaHelpObjectID.Text := orgdata.stationname;
      edtSaleAddress.Enabled:=false;
      NovaHelpObjectID.HelpOptions.HelpType := 'StationDHelp';
    end
    else if (orgdata.orgtype = '3') then
    begin
      NovaHelpObjectID.id := orgdata.unitid;
      NovaHelpObjectID.Text := orgdata.unitname;
      edtSaleAddress.Enabled:=false;
      NovaHelpObjectID.HelpOptions.HelpType := 'UnitDHelp';
      lbl14.Caption := '对应车属单位';
    end
    else
    begin
      NovaHelpObjectID.Enabled:=false;
      edtSaleAddress.Text := orgdata.ticketserversaddress;
    end;
    edtdistrict.id := orgdata.districtid;
    edtdistrict.Text := orgdata.districtname;
    edtContactPerson.Text := orgdata.contactperson;
    edtphone.Text := orgdata.contactphone;
    edtaddress.Text := orgdata.address;
    mmodescribe.Text := orgdata.describe;
    NovaHelpObjectID.OnIdChange:=NovaHelpObjectIDIdChange;
    cursynccode:=orgdata.synccode;
    cbbComboxParentOrg.Enabled:=false;
    edtCode.Enabled:=false;
    edtname.Enabled:=false;
    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      btnlocateClick(Sender);
    end;
  end;
end;

procedure TFrmOrganization.tbtnInsertClick(Sender: TObject);
var
  curid: Int64;
  selectrow: PVirtualNode;
  orgdata: POrgData;
begin
  inherited;
  FrmOrgEdit := TFrmOrgEdit.Create(self);
  try
    with FrmOrgEdit do
    begin
      Caption := '添加组织机构信息';
      edittype := add;
      selectrow:=vstreeOrg.GetFirstSelected;
      if assigned(selectrow) then
      begin
        orgdata := vstreeOrg.GetNodeData(selectrow);
        parentid := orgdata.id;
        //cbbCobOrgType.ItemIndex:=StrToInt(orgdata.orgtype)-1;
      end;

      cbbComboxParentOrg.SetItemIndexByField('id',parentid) ;
      if SysMainForm.showFormModal(FrmOrgEdit, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(Sender);
        //jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmOrgEdit);
  end;
end;


procedure TFrmOrganization.vstreeOrgClick(Sender: TObject);
var
  id: Integer;
  selectrow: PVirtualNode;
  orgdata: POrgData;
begin
 inherited;
  selectrow:=vstreeOrg.GetFirstSelected;
  if assigned(selectrow) then
  begin
    orgdata := vstreeOrg.GetNodeData(selectrow);
    curid:=orgdata.id;
    id := orgdata.id;
    qryDeparment(id);
  end;
end;

procedure TFrmOrganization.vstreeOrgFreeNode(Sender: TBaseVirtualTree;
  Node: PVirtualNode);
var
  data: POrgData;
begin
  inherited;
  data := Sender.GetNodeData(Node);
  Finalize(data^);
end;

procedure TFrmOrganization.vstreeOrgGetNodeDataSize(Sender: TBaseVirtualTree;
  var NodeDataSize: Integer);
begin
  inherited;
  NodeDataSize := SizeOf(TOrgData);
end;



procedure TFrmOrganization.vstreeOrgGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: string);
var
  data: POrgData;
begin
  inherited;
  data := Sender.GetNodeData(Node);
  case Column of
    0:
      CellText := data.name;
    1:
      CellText := data.code;
    2:
      CellText := data.typename;
    3:
      CellText := data.parentname;
    4:
      CellText := data.stationname;
    5:
      CellText := data.unitname;
    6:
      CellText := data.districtname;
    7:
      CellText := data.serversaddress;
    8:
      CellText := data.ticketserversaddress;
    9:
      CellText := data.contactperson;
    10:
      CellText := data.contactphone;
    11:
      CellText := data.address;
    12:
      CellText := data.describe;
    13:
      CellText := data.username;
    14:
      CellText := data.createtime;
    15:
      CellText := data.updatename;
    16:
      CellText := data.updatetime;
  end;


end;

end.

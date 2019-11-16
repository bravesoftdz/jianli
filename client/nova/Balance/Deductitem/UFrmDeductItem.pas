unit UFrmDeductItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaComboBox, Menus, NovaCheckedComboBox,
  NovaHComboBox;

type

  TFrmDeductItem = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    TreeVItem: TTreeView;
    jscdCreatetree: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultdeductmoney: TFloatField;
    jcdsResultdeducttype: TWideStringField;
    jcdsResultdescription: TWideStringField;
    jcdsResultisaudited: TBooleanField;
    jcdsResultisauditpass: TBooleanField;
    jcdsResultisdeductbeforebalance: TBooleanField;
    jcdsResultname: TWideStringField;
    jcdsResultparentid: TLargeintField;
    jcdsResultorgid: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultorgname: TWideStringField;
    Label2: TLabel;
    Label6: TLabel;
    NovaCobType: TNovaComboBox;
    NovaEdtName: TNovaEdit;
    ChbIsPrintDeduct: TCheckBox;
    jcdsQryDeducttype: TjsonClientDataSet;
    jcdsResultdeducttypename: TWideStringField;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    jscdDelItem: TjsonClientDataSet;
    GroupBox3: TGroupBox;
    jcdsQryItemDetail: TjsonClientDataSet;
    DBGridEhDetail: TDBGridEh;
    DataSource1: TDataSource;
    ImageList1: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    TbtnAdd: TToolButton;
    ToolButton3: TToolButton;
    TbtnUpdate: TToolButton;
    ToolButton5: TToolButton;
    TbtnDel: TToolButton;
    jcdsDelAboutDistance: TjsonClientDataSet;
    jcdsDelaboutPrice: TjsonClientDataSet;
    Splitter1: TSplitter;
    jcdsResultisticketpriceitem: TBooleanField;
    Label1: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsResultcode: TWideStringField;
    jcdsResultformula: TWideStringField;
    jcdsResultisexpress: TBooleanField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure TreeVItemClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure TbtnAddClick(Sender: TObject);
    procedure TbtnUpdateClick(Sender: TObject);
    procedure TbtnDelClick(Sender: TObject);
    procedure NovaHCbbOrgChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
    isfirst: boolean;
    procedure qryitemdetail(balanceid: int64);
    procedure additem(parentid: int64);
    procedure delitem(id: int64);
    procedure delItemaboutdistance(id: int64);
    procedure delItemaboutprice(id: int64);
    procedure qryitem(parentid, curid: int64);
    procedure createtree();
  public
    { Public declarations }
  end;

var
  FrmDeductItem: TFrmDeductItem;

implementation

uses PubFn, Services, TreeUnit,UFrmbalanceAbout, UFrmDeductItemEdt, UDMPublic;
{$R *.dfm}

procedure TFrmDeductItem.additem(parentid: int64);
var
  curid: int64;
begin
  inherited;
  try
    FrmDeductItemEdt := TFrmDeductItemEdt.Create(self);
    with FrmDeductItemEdt do
    begin
      caption := '添加结算固定扣费项目';
      orgid:=NovaHCbbOrg.HelpFieldValue['id'];
      NovaHCobParent.SetItemIndexByField('id', parentid);
      if SysMainForm.showFormModal(FrmDeductItemEdt, False) = mrok then
      begin
        curid := balancedeductitemid;

        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
        createtree;
      end;
    end;
  finally
    FreeAndNil(FrmDeductItemEdt);
  end;
end;

procedure TFrmDeductItem.createtree;
var
   orgid:int64;
begin
   if NovaHCbbOrg.GetCount=0 then
     orgid:=sysinfo.LoginUserInfo.OrgID
   else
     orgid:=NovaHCbbOrg.HelpFieldValue['id'];
  jscdCreatetree.Active := False;
  jscdCreatetree.Params.ParamValues['orgid']:= orgid;
  jscdCreatetree.Active := True;
  if jscdCreatetree.RecordCount > 0 then
  begin
    TreeVItem.Items.Clear;
    BuildIDXTree(jscdCreatetree, TreeVItem, True);
  end
  else
    TreeVItem.Items.Clear;
end;

procedure TFrmDeductItem.delitem(id: int64);
var
  sResult: string;
  nResult: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount <= 0 then
    Exit;

  if SysDialogs.Confirm('删除操作', '确认要删除该扣费信息吗？') then
    try
      with jscdDelItem do
      begin
        Active := False;
        Params.ParamValues['balancedeductitem.id'] := id;
        Params.ParamValues['balancedeductitem.updateby'] :=
          SysInfo.LoginUserInfo.UserID;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          log := '删除结算固定扣费项目：扣费项目='+jcdsResult.FieldByName('name').AsString+
          ',扣费类型='+jcdsResult.FieldByName('deducttypename').AsString+',扣费金额='+
          jcdsResult.FieldByName('deductmoney').AsString+',发班打单时扣='+
          jcdsResult.FieldByName('isdeductbeforebalance').AsString+',是否票价组成荐='+
          jcdsResult.FieldByName('isticketpriceitem').AsString;
          SysLog.WriteLog('结算管理—>结算固定扣费项目','删除',log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
          createtree;
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('删除结算扣费项目操作失败：' + e.Message);
      end;
    end;
end;

procedure TFrmDeductItem.delItemaboutdistance(id: int64);
var
  nResult: Integer;
  sResult: String;
begin
  if SysDialogs.Confirm('删除操作', '确认要删除该扣费信息吗？') then
    try
      with jcdsDelAboutDistance do
      begin
        Active := False;
        Params.ParamValues['balancedeductitemdistance.id'] := id;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          SysDialogs.ShowMessage(sResult);
          qryitemdetail(jcdsResult.fieldbyname('id').AsLargeInt);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('删除结算里程相关扣费项目操作失败：' + e.Message);
      end;
    end;
end;

procedure TFrmDeductItem.delItemaboutprice(id: int64);
var
  nResult: Integer;
  sResult: String;
begin
  if SysDialogs.Confirm('删除操作', '确认要删除该扣费信息吗？') then
    try
      with jcdsDelaboutPrice do
      begin
        Active := False;
        Params.ParamValues['balancedeductitemprice.id'] := id;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          SysDialogs.ShowMessage(sResult);
          qryitemdetail(jcdsResult.fieldbyname('id').AsLargeInt);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('删除结算票价相关扣费项目操作失败：' + e.Message);
      end;
    end;
end;

procedure TFrmDeductItem.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active:=false;
  NovaHCbbOrg.Active:=true;
  NovaCobType.Active := False;
  NovaCobType.Active := True;
  jcdsQryDeducttype.Active := False;
  jcdsQryDeducttype.Active := True;
  createtree();
end;

procedure TFrmDeductItem.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;


  qryitemdetail(jcdsResult.fieldbyname('id').AsLargeInt);
end;

procedure TFrmDeductItem.N1Click(Sender: TObject);
begin
  additem(strtoint(PIDXRec(TreeVItem.Selected.Data).id));
end;

procedure TFrmDeductItem.N2Click(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  curid := strtoint(PIDXRec(TreeVItem.Selected.Data).id);
  if curid = 0 then
    Exit;
  jcdsResult.Locate('id', curid, []);
  tbtnEditClick(nil);
end;

procedure TFrmDeductItem.N3Click(Sender: TObject);
var
  id: int64;
begin
  inherited;
  id := strtoint(PIDXRec(TreeVItem.Selected.Data).id);
  if id > 0 then
    delitem(id);
end;

procedure TFrmDeductItem.NovaHCbbOrgChange(Sender: TObject);
begin
  inherited;
   createtree;
  qryitem(0, 0);
end;

procedure TFrmDeductItem.qryitem(parentid, curid: int64);
begin
  inherited;
  jcdsResult.AfterScroll := nil;

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['filter_EQL_b!orgid'] := self.NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['filter_LIKES_b!name'] := Trim(NovaEdtName.Text);
    if NovaCobType.ItemIndex >= 0 then
      Params.ParamValues['filter_EQS_b!deducttype'] := NovaCobType.GetSelectCode
    else
      Params.ParamValues['filter_EQS_b!deducttype'] := null;
    if ChbIsPrintDeduct.Checked then
      Params.ParamValues['filter_EQB_b!isdeductbeforebalance'] := True
    else
      Params.ParamValues['filter_EQB_b!isdeductbeforebalance'] := null;
    Params.ParamValues['balancedeductitemid'] := parentid;
    Active := True;
    if (RecordCount > 0) then
    begin
      jcdsResult.Locate('id', curid, []);
       qryitemdetail(jcdsResult.fieldbyname('id').AsLargeInt);
    end
    else
    begin
      jcdsQryItemDetail.Close;
   end;
  end;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmDeductItem.qryitemdetail(balanceid: int64);
begin
  with jcdsQryItemDetail do
  begin
    Active := False;
    Params.ParamValues['balancedeductitemid'] := balanceid;
    Active := True;
    if RecordCount > 0 then
    begin
      TbtnUpdate.Enabled:=true;
      TbtnDel.Enabled:=true;
      if fieldbyname('abouttype').AsInteger = 1 then
      begin
        DBGridEhDetail.Columns.Clear;
        DBGridEhDetail.Columns.Add;
        DBGridEhDetail.Columns[0].FieldName := 'startvalue';
        DBGridEhDetail.Columns[0].Width := 70;
        DBGridEhDetail.Columns[0].Title.caption := '开始票价';
        DBGridEhDetail.Columns.Add;
        DBGridEhDetail.Columns[1].FieldName := 'endvalue';
        DBGridEhDetail.Columns[1].Width := 70;
        DBGridEhDetail.Columns[1].Title.caption := '结束票价';
        DBGridEhDetail.Columns.Add;
        DBGridEhDetail.Columns[2].FieldName := 'deductmoney';
        DBGridEhDetail.Columns[2].Width := 70;
        DBGridEhDetail.Columns[2].Title.caption := '扣费金额';
      end
      else if fieldbyname('abouttype').AsInteger = 0 then
      begin
        DBGridEhDetail.Columns.Clear;
        DBGridEhDetail.Columns.Add;
        DBGridEhDetail.Columns[0].FieldName := 'startvalue';
        DBGridEhDetail.Columns[0].Width := 70;
        DBGridEhDetail.Columns[0].Title.caption := '开始里程';
        DBGridEhDetail.Columns.Add;
        DBGridEhDetail.Columns[1].FieldName := 'endvalue';
        DBGridEhDetail.Columns[1].Width := 70;
        DBGridEhDetail.Columns[1].Title.caption := '结束里程';
        DBGridEhDetail.Columns.Add;
        DBGridEhDetail.Columns[2].FieldName := 'deductmoney';
        DBGridEhDetail.Columns[2].Width := 70;
        DBGridEhDetail.Columns[2].Title.caption := '扣费金额';
      end
    end
    else
    begin
      DBGridEhDetail.Columns.Clear;
      DBGridEhDetail.Columns.Add;
      DBGridEhDetail.Columns[0].FieldName := 'id';
      DBGridEhDetail.Columns[0].Width := 0;
      DBGridEhDetail.Columns[0].Title.caption := '';
      TbtnUpdate.Enabled:=false;
      TbtnDel.Enabled:=false;
    end;
  end;
end;

procedure TFrmDeductItem.TbtnAddClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount <= 0 then
    Exit;
  try
    FrmbalanceAbout := TFrmbalanceAbout.Create(self);
    with FrmbalanceAbout do
    begin
      caption := '添加结算固定相关扣费项目';
      NovaEdtName.Text := jcdsResult.fieldbyname('name').AsString;
      NovaEdtName.Enabled := False;
      balanceid := jcdsResult.fieldbyname('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmbalanceAbout, False) = mrok then
      begin
        curid := id;
        qryitemdetail(balanceid);
        jcdsQryItemDetail.Locate('aboutid', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmbalanceAbout);
  end;
end;

procedure TFrmDeductItem.TbtnDelClick(Sender: TObject);
begin
  inherited;
  if not jcdsQryItemDetail.Active then
    Exit;
  if jcdsQryItemDetail.RecordCount <= 0 then
    Exit;
  if jcdsQryItemDetail.fieldbyname('abouttype').AsString = '0' then
    delItemaboutdistance(jcdsQryItemDetail.fieldbyname('aboutid').AsLargeInt)
  else
    delItemaboutprice(jcdsQryItemDetail.fieldbyname('aboutid').AsLargeInt);
end;

procedure TFrmDeductItem.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  delitem(jcdsResult.fieldbyname('id').AsLargeInt);
end;

procedure TFrmDeductItem.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount <= 0 then
    Exit;
  if (jcdsResult.FieldByName('isticketpriceitem').AsBoolean)
  and (jcdsResult.FieldByName('parentid').AsInteger=0) then
  begin
    SysDialogs.ShowMessage('票价组成项扣费不允许修改！');
    Exit;
  end;
  try
    FrmDeductItemEdt := TFrmDeductItemEdt.Create(self);
    with FrmDeductItemEdt do
    begin
      caption := '修改结算固定扣费项目';
      balancedeductitemid := jcdsResult.fieldbyname('id').AsLargeInt;
      createtime := jcdsResult.fieldbyname('createtime').AsString;
      //NovaEdtFormula.Text := jcdsResult.fieldbyname('code').AsString;
      NovaEdtFormula.Enabled:=false;
      NovaEdtdeductmoney.Text := jcdsResult.fieldbyname('deductmoney').AsString;
      orgid := jcdsResult.fieldbyname('orgid').AsLargeInt;
      //NovaCobType.GetSelectID
      NovaCobType.SetItemIndexByCode(jcdsResult.fieldbyname('deducttype')
          .AsString);
      parentid := jcdsResult.fieldbyname('parentid').AsLargeInt;
      ChbIsPrintDeduct.Checked := jcdsResult.fieldbyname
        ('isdeductbeforebalance').AsBoolean;
      if jcdsResult.fieldbyname('isaudited').AsBoolean then
         NovaEdtName.Enabled:=false;
      NovaEdtName.Text := jcdsResult.fieldbyname('name').AsString;
      NovaHCobParent.SetItemIndexByField('id',
        jcdsResult.fieldbyname('parentid').AsString);
      isaudited := jcdsResult.fieldbyname('isaudited').AsBoolean;
      isauditpass := jcdsResult.fieldbyname('isauditpass').AsBoolean;
      code := jcdsResult.fieldbyname('code').AsString;
      if jcdsResult.fieldbyname('ISEXPRESS').AsBoolean then
      begin
        ChkForma.Checked:=true;
        NovaEdtFormula.Text:=jcdsResult.fieldbyname('formula').AsString;
      end;
      curid := balancedeductitemid;
      if SysMainForm.showFormModal(FrmDeductItemEdt, False) = mrok then
      begin
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
        createtree;
      end;
    end;
  finally
    FreeAndNil(FrmDeductItemEdt);
  end;
end;

procedure TFrmDeductItem.tbtnFilterClick(Sender: TObject);
begin
  qryitem(0, 0);
end;

procedure TFrmDeductItem.tbtnInsertClick(Sender: TObject);
begin
  additem(0);
  TreeVItem.Items.Clear;
  createtree();
end;

procedure TFrmDeductItem.TbtnUpdateClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsQryItemDetail.Active then
    Exit;
  if jcdsQryItemDetail.RecordCount <= 0 then
    Exit;
  try
    FrmbalanceAbout := TFrmbalanceAbout.Create(self);
    with FrmbalanceAbout do
    begin
      caption := '修改结算固定相关扣费项目';
      NovaEdtName.Text := jcdsResult.fieldbyname('name').AsString;
      balanceid := jcdsResult.fieldbyname('id').AsLargeInt;
      NovaEdtName.Enabled := False;
      if jcdsQryItemDetail.fieldbyname('abouttype').AsString = '0' then
        RbAboutDistance.Checked := True
      else
        RbAboutPrice.Checked := True;
      id := jcdsQryItemDetail.fieldbyname('aboutid').AsLargeInt;
      createby := jcdsQryItemDetail.fieldbyname('createby').AsLargeInt;
      createtime := jcdsQryItemDetail.fieldbyname('createtime').AsString;
      NovaEdtFrom.Text := jcdsQryItemDetail.fieldbyname('startvalue').AsString;
      NovaEdtEnd.Text := jcdsQryItemDetail.fieldbyname('endvalue').AsString;
      NovaEdtValue.Text := jcdsQryItemDetail.fieldbyname('deductmoney')
        .AsString;
      if SysMainForm.showFormModal(FrmbalanceAbout, False) = mrok then
      begin
        curid := id;
        qryitemdetail(balanceid);
        jcdsQryItemDetail.Locate('aboutid', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmbalanceAbout);
  end;

end;

procedure TFrmDeductItem.TreeVItemClick(Sender: TObject);
begin
  inherited;
  qryitem(strtoint(PIDXRec(TreeVItem.Selected.Data).id), 0);
end;

end.

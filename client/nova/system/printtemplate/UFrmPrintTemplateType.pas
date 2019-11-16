unit UFrmPrintTemplateType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmPrintTemplateTypeAdd, UFrmPrintTemplateTypeItemAdd,
  Services,UDMPublic, NovaEdit, DBGridEhGrouping;

type
  TFrmPrintTemplateType = class(TSimpleCRUDForm)
    pnlright: TPanel;
    gbSingleValue: TGroupBox;
    dbgrdhSingleValue: TDBGridEh;
    tlbSingleValue: TToolBar;
    tbtn2: TToolButton;
    tbtnaddsignitem: TToolButton;
    tbtn7: TToolButton;
    tbtnUpdatesignitem: TToolButton;
    tbtn8: TToolButton;
    tbtndelsignitem: TToolButton;
    gbMultipleValue: TGroupBox;
    dbgrdhMultipleValue: TDBGridEh;
    tlbMultipleValue: TToolBar;
    tbtn9: TToolButton;
    tbtnaddmultipleitem: TToolButton;
    tbtn11: TToolButton;
    tbtnupdatemultipleitem: TToolButton;
    tbtn13: TToolButton;
    tbtndelmultipleitem: TToolButton;
    ilsmalltools: TImageList;
    jcdsSingleValue: TjsonClientDataSet;
    dsSingleValue: TDataSource;
    jcdsDeleteprinttemplatetypeitem: TjsonClientDataSet;
    jcdsMultipleValue: TjsonClientDataSet;
    dsMultipleValue: TDataSource;
    jcdsDeletePrinttemplatetype: TjsonClientDataSet;
    lblname: TLabel;
    nvedtname: TNovaEdit;
    jcdsitemtype: TjsonClientDataSet;
    lrgntfldSingleValueid: TLargeintField;
    lrgntfldSingleValuePRINTTEMPLATETYPEID: TLargeintField;
    strngfldSingleValueITEMNAME: TWideStringField;
    strngfldSingleValueITEMTYPE: TWideStringField;
    strngfldSingleValueITEMCODE: TWideStringField;
    blnfldSingleValueISLIST: TBooleanField;
    strngfldSingleValueitemtypevalue: TWideStringField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtndelsignitemClick(Sender: TObject);
    procedure tbtndelmultipleitemClick(Sender: TObject);
    procedure tbtnaddsignitemClick(Sender: TObject);
    procedure tbtnaddmultipleitemClick(Sender: TObject);
    procedure tbtnUpdatesignitemClick(Sender: TObject);
    procedure tbtnupdatemultipleitemClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure deleteprinttemplatetypeitem(cds:TjsonClientDataSet);
    procedure addprinttemplatetypeitem(cds:TjsonClientDataSet);
    procedure udpateprinttemplatetypeitem(cds:TjsonClientDataSet);
  public
    { Public declarations }
    ischilelist:Boolean;
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;

  end;

var
  FrmPrintTemplateType: TFrmPrintTemplateType;

implementation

{$R *.dfm}

procedure TFrmPrintTemplateType.addprinttemplatetypeitem(
  cds: TjsonClientDataSet);
begin
  FrmPrintTemplateTypeItemAdd:=TFrmPrintTemplateTypeItemAdd.Create(self);
  with FrmPrintTemplateTypeItemAdd do
  begin
    try
      Caption:='添加打印模板类型项目';
      printtemplatetypeid:=jcdsResult.FieldByName('id').AsString;
      edittype:=TEditType.add;
      if cds=jcdsMultipleValue then
        islist:='True'
      else
        islist:='false';
      if SysMainForm.showFormModal(FrmPrintTemplateTypeItemAdd,False)=mrOk then
      begin
        jcdsResultAfterScroll(jcdsResult);
        cds.Locate('id',operationid,[]);
      end;
    finally
      FreeAndNil(FrmPrintTemplateTypeItemAdd);
    end;
  end;
end;

procedure TFrmPrintTemplateType.deleteprinttemplatetypeitem(
  cds: TjsonClientDataSet);
begin
  if (cds.Active=True) and (cds.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该打印模板类型明细吗？') then
    begin
      exit;
    end;
    with jcdsDeleteprinttemplatetypeitem do
    begin
      Params.ParamValues['printtemplatetypeitem.id']:=cds.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        jcdsResultAfterScroll(jcdsResult);
      end;
    end;
  end;
end;

procedure TFrmPrintTemplateType.FormCreate(Sender: TObject);
begin
  inherited;
  jcdsitemtype.Active:=true;
end;

procedure TFrmPrintTemplateType.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{508615BC-D298-43D9-83A2-8E3982FA6DD0}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{8DF25BE1-EA3B-4B11-BF6E-26D3A88B7842}' then //修改
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{CDF511EB-5BB8-4761-AAB5-63A24F5367D3}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{0F5DC44E-E6FD-48A4-A0E9-089D595BEE20}' then //添加单个变量
  begin
    tbtndelsignitem.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{8BD54B61-FEEA-45A0-9462-163E5B6DFE87}' then //修改单个变量
  begin
    tbtnUpdatesignitem.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{F4A14743-5EB0-4B1C-A57C-91094B584ABD}' then //删除单个变量
  begin
    tbtnaddsignitem.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{29E60E23-135E-4C91-8FC2-00206FE51832}' then //添加数据集变量
  begin
    tbtnaddmultipleitem.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{BE813D6D-59C0-4EDF-BF6B-0BB817AEC7FF}' then //修改数据集变量
  begin
    tbtnupdatemultipleitem.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{7D7EA844-A0A2-4F89-BA91-465108B7BCBD}' then //删除数据集变量
  begin
    tbtndelmultipleitem.Enabled:=aEnable;
  end;
end;

procedure TFrmPrintTemplateType.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with jcdsMultipleValue do
  begin
    Active:=false;
    Params.ParamValues['printtemplatetypeitem.printtemplatetype.id']:=jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['printtemplatetypeitem.islist']:='true';
    active:=true;
    if RecNo>0 then
      ischilelist := True   //存在子记录，将提示不能删除
    else
      ischilelist := false;
  end;
  with jcdsSingleValue do
  begin
    Active:=false;
    Params.ParamValues['printtemplatetypeitem.printtemplatetype.id']:=jcdsResult.FieldByName('id').AsString;
    Params.ParamValues['printtemplatetypeitem.islist']:='false';
    active:=true;
     if RecNo>0 then
      ischilelist := True     //存在子记录，将提示不能删除
    else
      ischilelist := false;
  end;
end;

procedure TFrmPrintTemplateType.tbtnaddmultipleitemClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    addprinttemplatetypeitem(jcdsMultipleValue);
  end;
end;

procedure TFrmPrintTemplateType.tbtnaddsignitemClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    addprinttemplatetypeitem(jcdsSingleValue);
  end;
end;

procedure TFrmPrintTemplateType.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if ischilelist then
    begin
       SysDialogs.ShowMessage('该打印模板类型存在子记录或已被使用!');
       Exit;
    end;

    if not SysDialogs.Confirm('提示','确定要删除该打印模板类型吗？') then
    begin
      exit;
    end;
    with jcdsDeletePrinttemplatetype do
    begin
      Params.ParamValues['printtemplatetype.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        tbtnFilter.Click;
      end;
    end;
  end;
end;

procedure TFrmPrintTemplateType.tbtndelmultipleitemClick(Sender: TObject);
begin
  inherited;
  deleteprinttemplatetypeitem(jcdsMultipleValue);
end;

procedure TFrmPrintTemplateType.tbtndelsignitemClick(Sender: TObject);
begin
  inherited;
  deleteprinttemplatetypeitem(jcdsSingleValue);
end;

procedure TFrmPrintTemplateType.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmPrintTemplateTypeAdd:=TFrmPrintTemplateTypeAdd.Create(self);
    with FrmPrintTemplateTypeAdd do
    begin
      try
        Caption:='修改打印模板类型';
        edittype:=TEditType.update;
        nvedtname.Text:=self.jcdsResult.FieldByName('name').AsString;
        id:=self.jcdsResult.FieldByName('id').AsString;
        if SysMainForm.showFormModal(FrmPrintTemplateTypeAdd,False)=mrOk then
        begin
          self.tbtnFilter.Click;
          self.jcdsResult.Locate('id',operationid,[]);
        end;
      finally
        FreeAndNil(FrmPrintTemplateTypeAdd);
      end;
    end;
  end;
end;

procedure TFrmPrintTemplateType.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=false;
    Params.ParamValues['filter_LIKES_t!name']:=Trim(nvedtname.Text);
    Active:=true;
  end;
end;

procedure TFrmPrintTemplateType.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmPrintTemplateTypeAdd:=TFrmPrintTemplateTypeAdd.Create(self);
  with FrmPrintTemplateTypeAdd do
  begin
    try
      Caption:='添加打印模板类型';
      edittype:=TEditType.add;
      if SysMainForm.showFormModal(FrmPrintTemplateTypeAdd,False)=mrOk then
      begin
        self.tbtnFilter.Click;
        self.jcdsResult.Locate('id',operationid,[]);
      end;
    finally
      FreeAndNil(FrmPrintTemplateTypeAdd);
    end;
  end;
end;

procedure TFrmPrintTemplateType.tbtnupdatemultipleitemClick(Sender: TObject);
begin
  inherited;
  udpateprinttemplatetypeitem(jcdsMultipleValue);
end;

procedure TFrmPrintTemplateType.tbtnUpdatesignitemClick(Sender: TObject);
begin
  inherited;
  udpateprinttemplatetypeitem(jcdsSingleValue);
end;

procedure TFrmPrintTemplateType.udpateprinttemplatetypeitem(
  cds: TjsonClientDataSet);
begin
  if (cds.Active=True) and (cds.RecNo>0) then
  begin
    FrmPrintTemplateTypeItemAdd:=TFrmPrintTemplateTypeItemAdd.Create(self);
    with FrmPrintTemplateTypeItemAdd do
    begin
      try
        Caption:='修改打印模板类型项目';
        id:=cds.FieldByName('id').AsString;
        islist:=cds.FieldByName('islist').AsString;
        printtemplatetypeid:=jcdsResult.FieldByName('id').AsString;
        nvedtitemname.Text:=cds.FieldByName('itemname').AsString;
        nvedtitemcode.Text:=cds.FieldByName('itemcode').AsString;
        nvedtitemcode.Enabled:=false;
        nvcbbitemtype.SetItemIndexByCode(cds.FieldByName('itemtype').AsString);
        edittype:=TEditType.update;
        if SysMainForm.showFormModal(FrmPrintTemplateTypeItemAdd,False)=mrOk then
        begin
          jcdsResultAfterScroll(jcdsResult);
          cds.Locate('id',operationid,[]);
        end;
      finally
        FreeAndNil(FrmPrintTemplateTypeItemAdd);
      end;
    end;
  end;
end;

end.

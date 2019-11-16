unit UFrmBalanceformula;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaCheckedComboBox, NovaComboBox;

type
  TFrmBalanceformula = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    DBGridEh1: TNvDbgridEh;
    Splitter1: TSplitter;
    jcdsqryBalanceItem: TjsonClientDataSet;
    DsBalanceitem: TDataSource;
    Label4: TLabel;
    NovaCobBTypes: TNovaComboBox;
    NovaCkbOrg: TNovaCheckedComboBox;
    Label1: TLabel;
    Label2: TLabel;
    NovaEditNames: TNovaEdit;
    jcdsQryFormulaType: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultdescription: TWideStringField;
    jcdsResultformula: TWideStringField;
    jcdsResultformulaname: TWideStringField;
    jcdsResultformulatype: TWideStringField;
    jcdsResultformulatypename: TWideStringField;
    jcdsResultisaudited: TBooleanField;
    jcdsResultisauditpass: TBooleanField;
    jcdsResultisdefault: TBooleanField;
    jcdsResultorgid: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsDelformula: TjsonClientDataSet;
    jcdsResultparentid: TLargeintField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
  end;

var
  FrmBalanceformula: TFrmBalanceformula;

implementation

uses UFrmBalanceformulaEdt, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmBalanceformula.FormCreate(Sender: TObject);
begin
  inherited;
  jcdsqryBalanceItem.Active := false;
  jcdsqryBalanceItem.Active := true;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
  NovaCobBTypes.Active := false;
  NovaCobBTypes.Active := true;
  jcdsQryFormulaType.Active := false;
  jcdsQryFormulaType.Active := true;
end;

procedure TFrmBalanceformula.tbtnDeleteClick(Sender: TObject);
var
  nResult: Integer;
  sResult: String;
begin
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('isaudited').AsBoolean then
  begin
    SysDialogs.Warning('�������Ѿ���˲���ɾ����');
    exit;
  end;
  if SysDialogs.Confirm('ɾ������', 'ȷ��Ҫɾ���ý��㹫ʽ��') then
    try
      with jcdsDelformula do
      begin
        active := false;
        Params.ParamValues['balanceformula.id'] := jcdsResult.FieldByName
          ('id').AsLargeInt;
        Params.ParamValues['balanceformula.updateby'] := Sysinfo.LoginUserInfo.UserID;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          log := 'ɾ�����㹫ʽ�����㹫ʽ����='+jcdsResult.FieldByName('formulatypename').AsString+
          ',��ʽ����='+jcdsResult.FieldByName('formulaname').AsString
          +',���㹫ʽ='+jcdsResult.FieldByName('formula').AsString
          +',��������='+jcdsResult.FieldByName('orgname').AsString
          +',Ĭ�Ϲ�ʽ='+jcdsResult.FieldByName('isdefault').AsString;
          SysLog.WriteLog('�������->���㹫ʽ����','ɾ��',log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('ɾ�����㹫ʽ����ʧ�ܣ�' + e.Message);
      end;
    end;


end;

procedure TFrmBalanceformula.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  try
    FrmBalanceformulaEdt := TFrmBalanceformulaEdt.Create(self);
    with FrmBalanceformulaEdt do
    begin
      caption := '�޸Ľ��㹫ʽ';
      id := jcdsResult.FieldByName('id').AsLargeInt;
      NovaHCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
      NovaHCbbOrg.Enabled:=false;
      NovaEdtFormula.Text := jcdsResult.FieldByName('formula').AsString;
      NovaEditName.Text := jcdsResult.FieldByName('formulaname').AsString;
      if jcdsResult.fieldbyname('isaudited').AsBoolean then
         NovaEditName.Enabled:=false;
      NovaCobBType.SetItemIndexByCode(jcdsResult.FieldByName('formulatype').AsString);
      MeRemark.Text := jcdsResult.FieldByName('description').AsString;
      isdefault := jcdsResult.FieldByName('isdefault').AsBoolean;
      createby := jcdsResult.FieldByName('createby').AsLargeInt;
      createtime := jcdsResult.FieldByName('createtime').AsString;
      isaudited := jcdsResult.FieldByName('isaudited').AsBoolean;
      NovaHCobParent.SetItemIndexByField('id',
        jcdsResult.fieldbyname('parentid').AsString);
      isauditpass := jcdsResult.FieldByName('isauditpass').AsBoolean;
      if SysMainForm.showFormModal(FrmBalanceformulaEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmBalanceformulaEdt);
  end;
end;

procedure TFrmBalanceformula.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if NovaCkbOrg.ItemIndex >= 0 then
      Params.ParamValues['filter_INS_b!orgid'] := NovaCkbOrg.GetSelectID
    else
      Params.ParamValues['filter_INS_b!orgid'] := SysInfo.LoginUserInfo.OrgIDs;
    if NovaCobBTypes.ItemIndex >= 0 then
      Params.ParamValues['filter_EQS_b!formulatype'] :=
        NovaCobBTypes.GetSelectCode
    else
      Params.ParamValues['filter_EQS_b!formulatype'] := null;
    if trim(NovaEditNames.Text) <> '' then
      Params.ParamValues['filter_EQS_b!formulaname'] := trim
        (NovaEditNames.Text);
    Active := true;
  end;
end;

procedure TFrmBalanceformula.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  try
    FrmBalanceformulaEdt := TFrmBalanceformulaEdt.Create(self);
    with FrmBalanceformulaEdt do
    begin
      caption := '��ӽ��㹫ʽ';
      if SysMainForm.showFormModal(FrmBalanceformulaEdt, false) = mrok then
      begin
        curid := id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmBalanceformulaEdt);
  end;

end;

end.

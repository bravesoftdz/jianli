unit UFrmCarryControl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, Buttons, NovaComboBox,Services,UDMPublic,PubFn,
  NovaHComboBox;

type
  TFrmCarryControl = class(TSimpleCRUDForm)
    lbl: TLabel;
    Nvcbbdescribe: TNovaHComboBox;
    jcdsReultmodulecode: TWideStringField;
    jcdsReultdescribe: TWideStringField;
    jcdsReultformula: TWideStringField;
    jcdsReultid: TLargeintField;
    jcdsCarryControlDel: TjsonClientDataSet;
    jcdsCarryControlDelid: TLargeintField;
    jcdsCarryControlDelmodulecode: TWideStringField;
    jcdsCarryControlDeldescribe: TWideStringField;
    jcdsCarryControlDelformula: TWideStringField;
    jcdsReultname: TWideStringField;
    jcdsResultupdatetime: TDateTimeField;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCarryControl: TFrmCarryControl;

implementation

uses UFrmCarryControlAdd;

{$R *.dfm}

procedure TFrmCarryControl.FormCreate(Sender: TObject);
begin
  inherited;
//  Nvcbbdescribe.Items.Clear;
//  Nvcbbdescribe.Items.Add('ȫ��');

  Nvcbbdescribe.Active:=False;
  Nvcbbdescribe.Active:=True;
  Nvcbbdescribe.Items.Add(' ');
end;

procedure TFrmCarryControl.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jcdsCarryControlDel do
  try
    close;
    Params.ParamByName('carrycontrol.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;

    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      //������������������������Լ�¼������ϸ���������
      SysLog.WriteLog('��λ�������','ɾ��','modulecode='+Trim(jcdsResult.FieldByName('modulecode').Value)+',describe='+Trim(jcdsResult.FieldByName('describe').Value));
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('��λ������Ϣɾ��ʧ�ܣ�' + E.Message);
    end;
  end;
  //���³�ʼ����ʾ�б�
  Nvcbbdescribe.Active:=False;
  Nvcbbdescribe.Active:=True;
  Nvcbbdescribe.Items.Add(' ');
end;

procedure TFrmCarryControl.tbtnEditClick(Sender: TObject);
var
  id:integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmCarryControlAdd:=TFrmCarryControlAdd.Create(Self);
  FrmCarryControlAdd.Caption:='�޸Ľ�λ������Ϣ';
  FrmCarryControlAdd.flag:=False;
  id :=  jcdsResult.FieldByName('id').AsInteger;
  FrmCarryControlAdd.id := id;
  with FrmCarryControlAdd do
  begin
    nvedtmodulecode.Enabled:=False;
    nvedtmodulecode.Text := jcdsResult.FieldByName('modulecode').AsString;
    nvedtdescribe.Text := jcdsResult.FieldByName('describe').AsString;
    nvedtformula.Text:= jcdsResult.FieldByName('formula').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
  //���³�ʼ����ʾ�б�
  Nvcbbdescribe.Active:=False;
  Nvcbbdescribe.Active:=True;
  Nvcbbdescribe.Items.Add(' ');
end;

procedure TFrmCarryControl.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamByName('carrycontrol.describe').Value :=Trim(Nvcbbdescribe.Text);
    Active := true;
  end;
end;

procedure TFrmCarryControl.tbtnInsertClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  FrmCarryControlAdd:=TFrmCarryControlAdd.Create(self,self.functionItem);
  try
    FrmCarryControlAdd.Caption:='��ӽ�λ����';
    FrmCarryControlAdd.edittype:=Tedittype.add;
    if SysMainForm.showFormModal(FrmCarryControlAdd,false)=mrOk then
    begin
      id := FrmCarryControlAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmCarryControlAdd);
  end;
  //���³�ʼ����ʾ�б�
  Nvcbbdescribe.Active:=False;
  Nvcbbdescribe.Active:=True;
  Nvcbbdescribe.Items.Add(' ');
end;

end.

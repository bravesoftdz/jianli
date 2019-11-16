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
//  Nvcbbdescribe.Items.Add('全部');

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
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
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
      //第三个参数视情况而定，可以记录更加详细的添加内容
      SysLog.WriteLog('进位规则管理','删除','modulecode='+Trim(jcdsResult.FieldByName('modulecode').Value)+',describe='+Trim(jcdsResult.FieldByName('describe').Value));
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('进位规则信息删除失败：' + E.Message);
    end;
  end;
  //重新初始化显示列表
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
  FrmCarryControlAdd.Caption:='修改进位规则信息';
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
  //重新初始化显示列表
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
    FrmCarryControlAdd.Caption:='添加进位规则';
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
  //重新初始化显示列表
  Nvcbbdescribe.Active:=False;
  Nvcbbdescribe.Active:=True;
  Nvcbbdescribe.Items.Add(' ');
end;

end.

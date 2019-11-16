unit UFrmCarryControlAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet,UDMPublic,Services, NovaComboBox, NovaHComboBox,PubFn,LogIntf,
  Designer;

type
  TFrmCarryControlAdd = class(TSimpleEditForm)
    lbldistricttype: TLabel;
    lbl2: TLabel;
    lblstartstation: TLabel;
    lbl1: TLabel;
    nvedtmodulecode: TNovaEdit;
    lblname: TLabel;
    nvedtformula: TNovaEdit;
    lbl3: TLabel;
    jcdscarrycontrol: TjsonClientDataSet;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    nvedtdescribe: TNovaEdit;
    bbtntrim: TBitBtn;
    bbtngetp: TBitBtn;
    bbtngetd: TBitBtn;
    bbtnRound: TBitBtn;
    procedure bbtnSaveClick(Sender: TObject);
    procedure bbtntrimClick(Sender: TObject);
    procedure bbtngetdClick(Sender: TObject);
    procedure bbtngetpClick(Sender: TObject);
    procedure bbtnRoundClick(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;

    function checkFormula(Sstr:string):Boolean;
  public
    { Public declarations }
    id:Integer;
    modulecode:string;
    describe:string;
    formula:string;
    flag, isactive:boolean;
    property operationid:Integer read Foperationid;
  end;

var
  FrmCarryControlAdd: TFrmCarryControlAdd;

implementation

{$R *.dfm}



{  ���ܣ�����ָ����ʽ�Ƿ���ڷ�������
   ������       Sstr:string  ������ַ���
   ����ֵ   true/false  �߼�ֵ
}
function TFrmCarryControlAdd.checkFormula(Sstr:string):Boolean;
begin
  //1.����ָ����ʽ�ַ���()�Ƿ����
  if (getSubStrNum('(',trim(Sstr)) <> getSubStrNum(')',trim(Sstr))) then
  begin
    Result:=False;
    Exit;
  end;
  //2.����ָ���ĺ����Ƿ�����:Trime(E) E�����Ǵ�д

end;

procedure TFrmCarryControlAdd.bbtngetdClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getD(m,n)';
end;

procedure TFrmCarryControlAdd.bbtngetpClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getP(m,n)';
end;

procedure TFrmCarryControlAdd.bbtnRoundClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getRound(m,n)';
end;

procedure TFrmCarryControlAdd.bbtnSaveClick(Sender: TObject);
var
  OperFlag:string;
begin
  inherited;
  OperFlag:='��ӽ�λ����';
  //���鿪ʼ
  if Trim(nvedtmodulecode.Text)='' then
  begin
    SysDialogs.ShowMessage('������벻��Ϊ��!');
    nvedtmodulecode.SetFocus;
    exit;
  end;
  if Trim(nvedtdescribe.Text)='' then
  begin
    SysDialogs.ShowMessage('�������Ʋ���Ϊ��!');
    nvedtdescribe.SetFocus;
    exit;
  end;
  if Trim(nvedtformula.Text)='' then
  begin
    SysDialogs.ShowMessage('����ʽ����Ϊ��!');
    nvedtformula.SetFocus;
    exit;
  end;
  //�������ʽ �磺��ʽ�������Ƿ���Եȡ�
   if not checkFormula(trim(nvedtformula.Text)) then
   begin
     SysDialogs.ShowMessage('������Ĺ���ʽ�д��ڲ��Ϸ�,��˶ԣ�');
     nvedtformula.SetFocus;
     Exit;
   end;
  //�������
  with jcdscarrycontrol do
  begin
    //��̨Action�ж����Id�ǿ�Ϊ���� ��Ϊ�����޸�
    Params.ParamValues['carrycontrol.id']:=id;
    Params.ParamValues['carrycontrol.modulecode']:=Trim(nvedtmodulecode.Text);
    Params.ParamValues['carrycontrol.describe']:= Trim(nvedtdescribe.Text);
    Params.ParamValues['carrycontrol.formula']:= Trim(nvedtformula.Text);
    Execute;

    if Pos('�޸�',trim(Params.ParamValues['msg']))>0 then
    begin
      OperFlag:='�޸Ľ�λ����';
    end;
    //������������������������Լ�¼������ϸ���������
    SysLog.WriteLog('��λ�������',trim(OperFlag),'modulecode='+Trim(nvedtmodulecode.Text)+',describe='+Trim(nvedtdescribe.Text));
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      self.ModalResult:=mrOk;
    end;

  end;
end;

procedure TFrmCarryControlAdd.bbtntrimClick(Sender: TObject);
begin
  inherited;
  nvedtformula.Text:=nvedtformula.Text+'getInt(E)';

end;

end.

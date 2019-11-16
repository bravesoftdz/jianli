unit UFrmBillinventory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,NovaEdit,NovaComboBox,USimpleEditForm,
  NovaHelp, DB, DBClient, Services,jsonClientDataSet, NovaHComboBox, ImgList;

type
  TFrmBillinventory = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    edtstartno: TNovaEdit;
    edtreendno: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edtrestartno: TNovaEdit;
    edtendno: TNovaEdit;
    lbl8: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    jsonBillinventorySave: TjsonClientDataSet;
    lbl9: TLabel;
    lbl10: TLabel;
    edtbatchno: TNovaEdit;
    novahcbbstorage: TNovaHComboBox;
    novahcbbtype: TNovaHComboBox;
    lblparvalue: TLabel;
    edtparvalue: TNovaEdit;
    Label4: TLabel;
    qryValue: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure novahcbbtypeChange(Sender: TObject);
    procedure novahcbbtypeSelect(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
      public
      id,maxlength:Int64;
      isactive:Boolean;
  end;

var
  FrmBillinventory: TFrmBillinventory;

implementation

{$R *.dfm}

procedure TFrmBillinventory.bbtnSaveClick(Sender: TObject);
  var nResult: integer;
  sResult,temp,log:string;
begin
  inherited;
  if edtbatchno.Text='' then
  begin
    SysDialogs.ShowMessage('���������κŲ���Ϊ��');
    edtbatchno.SetFocus;
    exit;
  end;
  if novahcbbstorage.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ��Ʊ��');
    novahcbbstorage.SetFocus;
    exit;
  end;
   if novahcbbtype.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ��Ʊ������');
    novahcbbtype.SetFocus;
    exit;
  end;
  if edtparvalue.Text='' then
    begin
      SysDialogs.ShowMessage('Ʊ���ֵ����Ϊ��');
      edtparvalue.SetFocus;
       exit;
    end;
  if edtstartno.Text='' then
  begin
    SysDialogs.ShowMessage('��ʼ���벻��Ϊ��');
    edtstartno.SetFocus;
    exit;
  end
  else
  begin
    if edtstartno.Text<> edtrestartno.Text  then
    begin
      SysDialogs.ShowMessage('��������ͬ����ʼ����');
      edtrestartno.SetFocus;
      exit;
    end;
  end;
  if edtendno.Text='' then
  begin
    SysDialogs.ShowMessage('�������벻��Ϊ��');
    edtendno.SetFocus;
    exit;
  end
  else
  begin
    if edtendno.Text<> edtreendno.Text  then
    begin
      SysDialogs.ShowMessage('��������ͬ�Ľ�������');
      edtreendno.SetFocus;
      exit;
    end;
  end;
  if StrToInt64(edtstartno.Text) = 0 then
  begin
    SysDialogs.ShowMessage('��ʼƱ�Ų���Ϊ0�����������룡');
    Exit;
  end;
  if strtoInt64(edtstartno.Text)>=strtoInt64(edtendno.Text) then
  begin
    SysDialogs.ShowMessage('��ʼ���벻�ܴ��ڻ���ڽ�������');
    edtstartno.SetFocus;
    exit;
  end;
  with jsonBillinventorySave do
  begin
    Params.ParamByName('billinventory.id').Value :=id ;
    Params.ParamByName('billinventory.batchno').Value :=edtbatchno.Text ;
    log := log +'[���������κ�]:'+  edtbatchno.Text;
    Params.ParamByName('billinventory.storageid').Value :=novahcbbstorage.HelpFieldValue['id'] ;
    log := log +',[Ʊ������]:'+  novahcbbstorage.Text;
    Params.ParamByName('billinventory.billtypeid').Value :=novahcbbtype.HelpFieldValue['id'];
    log := log +',[Ʊ������]:'+  novahcbbtype.Text;
    Params.ParamByName('billinventory.parvalue').Value :=edtparvalue.Text;
    log := log +',[Ʊ���ֵ]:'+  edtparvalue.Text;
    Params.ParamByName('billinventory.putinstartno').Value :=edtstartno.Text ;
    log := log +',[��ʼ����]:'+  edtstartno.Text;
    Params.ParamByName('billinventory.putinendno').Value :=edtendno.Text;
    log := log +',[��������]:'+  edtendno.Text;
    Params.ParamByName('billinventory.isactive').Value :=  isactive;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtbatchno.SetFocus;
        log :='';
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
        SysLog.WriteLog('Ʊ�ݹ���-Ʊ�����','���Ʊ�����',log);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ʊ����������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmBillinventory.FormCreate(Sender: TObject);
begin
  inherited;
  isactive:=True;
  novahcbbtype.Active:=false;
  novahcbbtype.Active:=true;
  novahcbbstorage.Active:=false;
  novahcbbstorage.Active:=true;
end;



procedure TFrmBillinventory.novahcbbtypeChange(Sender: TObject);
var i:Integer;
begin
  inherited;
  edtstartno.Text:= '';
  edtendno.Text:='';
  edtrestartno.Text:='';
  edtreendno.Text:='';
  edtstartno.MaxLength := StrToInt64(novahcbbtype.HelpFieldValue['ticketnolength']) ;
  edtendno.MaxLength := StrToInt64(novahcbbtype.HelpFieldValue['ticketnolength'] );
  edtrestartno.MaxLength := StrToInt64(novahcbbtype.HelpFieldValue['ticketnolength']) ;
  edtreendno.MaxLength := StrToInt64(novahcbbtype.HelpFieldValue['ticketnolength']) ;
end;

procedure TFrmBillinventory.novahcbbtypeSelect(Sender: TObject);
begin
  inherited;
    with qryValue do
  begin
    Active := false;
    Params.ParamByName('name').Value := novahcbbtype.text;
    Active := true;
  end;
  edtparvalue.text := qryValue.FieldByName('parvalue').AsString;
end;

end.

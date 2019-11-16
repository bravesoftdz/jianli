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
    SysDialogs.ShowMessage('入库操作批次号不能为空');
    edtbatchno.SetFocus;
    exit;
  end;
  if novahcbbstorage.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择票库');
    novahcbbstorage.SetFocus;
    exit;
  end;
   if novahcbbtype.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择票据类型');
    novahcbbtype.SetFocus;
    exit;
  end;
  if edtparvalue.Text='' then
    begin
      SysDialogs.ShowMessage('票面价值不能为空');
      edtparvalue.SetFocus;
       exit;
    end;
  if edtstartno.Text='' then
  begin
    SysDialogs.ShowMessage('起始号码不能为空');
    edtstartno.SetFocus;
    exit;
  end
  else
  begin
    if edtstartno.Text<> edtrestartno.Text  then
    begin
      SysDialogs.ShowMessage('请输入相同的起始号码');
      edtrestartno.SetFocus;
      exit;
    end;
  end;
  if edtendno.Text='' then
  begin
    SysDialogs.ShowMessage('结束号码不能为空');
    edtendno.SetFocus;
    exit;
  end
  else
  begin
    if edtendno.Text<> edtreendno.Text  then
    begin
      SysDialogs.ShowMessage('请输入相同的结束号码');
      edtreendno.SetFocus;
      exit;
    end;
  end;
  if StrToInt64(edtstartno.Text) = 0 then
  begin
    SysDialogs.ShowMessage('起始票号不能为0，请重新输入！');
    Exit;
  end;
  if strtoInt64(edtstartno.Text)>=strtoInt64(edtendno.Text) then
  begin
    SysDialogs.ShowMessage('起始号码不能大于或等于结束号码');
    edtstartno.SetFocus;
    exit;
  end;
  with jsonBillinventorySave do
  begin
    Params.ParamByName('billinventory.id').Value :=id ;
    Params.ParamByName('billinventory.batchno').Value :=edtbatchno.Text ;
    log := log +'[入库操作批次号]:'+  edtbatchno.Text;
    Params.ParamByName('billinventory.storageid').Value :=novahcbbstorage.HelpFieldValue['id'] ;
    log := log +',[票库名称]:'+  novahcbbstorage.Text;
    Params.ParamByName('billinventory.billtypeid').Value :=novahcbbtype.HelpFieldValue['id'];
    log := log +',[票据类型]:'+  novahcbbtype.Text;
    Params.ParamByName('billinventory.parvalue').Value :=edtparvalue.Text;
    log := log +',[票面价值]:'+  edtparvalue.Text;
    Params.ParamByName('billinventory.putinstartno').Value :=edtstartno.Text ;
    log := log +',[起始号码]:'+  edtstartno.Text;
    Params.ParamByName('billinventory.putinendno').Value :=edtendno.Text;
    log := log +',[结束号码]:'+  edtendno.Text;
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
        SysLog.WriteLog('票据管理-票据入库','添加票据入库',log);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据类型增加失败：' + E.Message);
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

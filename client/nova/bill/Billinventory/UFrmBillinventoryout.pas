unit UFrmBillinventoryout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,NovaEdit,NovaComboBox,USimpleEditForm,
  NovaHelp, DB, DBClient, Services,jsonClientDataSet, NovaHComboBox, ImgList;


type
  TFrmBillinventoryout = class(TSimpleEditForm)
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    edtbillstorage: TNovaEdit;
    edtbilltypename: TNovaEdit;
    lbl1: TLabel;
    lbl3: TLabel;
    jsonBillinventoryOut: TjsonClientDataSet;
    lbl5: TLabel;
    edtstartnum: TNovaEdit;
    edtendnum: TNovaEdit;
    edtstartno: TNovaEdit;
    edtticketcount: TNovaEdit;
    edtendno: TNovaEdit;
    Label1: TLabel;
    edtavailablecount: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtstartnoChange(Sender: TObject);
    procedure edtticketcountChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   id,storageid,billtypeid,availablestartno,availableenno:Int64;
  end;

var
  FrmBillinventoryout: TFrmBillinventoryout;

implementation

{$R *.dfm}

procedure TFrmBillinventoryout.bbtnSaveClick(Sender: TObject);
 var nResult: integer;
  sResult,log:string;
begin
  inherited;
  if StrToInt(edtticketcount.Text) = 0then
  begin
    SysDialogs.ShowMessage('������������С��1�����������룡');
    edtticketcount.SetFocus;
    Exit;
  end;
  if edtstartno.Text='' then
  begin
    SysDialogs.ShowMessage('���⿪ʼ�Ų���Ϊ��');
    edtstartno.SetFocus;
    exit;
  end;
  if StrToInt64(edtstartno.Text)<availablestartno  then
  begin
    SysDialogs.ShowMessage('������ʼ�Ų���С�ڿ�����ʼ��');
    edtstartno.SetFocus;
    exit;
  end;
  if  StrToInt64(edtstartno.Text)>availableenno then
  begin
    SysDialogs.ShowMessage('������ʼ�Ų��ܴ��ڿ��ý�����');
    edtstartno.SetFocus;
    exit;
  end;
  if edtendno.Text='' then
  begin
    SysDialogs.ShowMessage('��������Ų���Ϊ��');
    edtstartno.SetFocus;
     exit;
  end;
  if StrToInt64(edtendno.Text)<StrToInt64(edtstartno.Text)  then
  begin
    SysDialogs.ShowMessage('��������Ų���С����ʼ��');
    edtendno.SetFocus     ;
    exit;
  end;
  if  StrToInt64(edtendno.Text)>availableenno then
  begin
    SysDialogs.ShowMessage('��������Ų��ܴ��ڿ��ý�����,��������������Ʊ��');
    edtticketcount.SetFocus;
    exit;
  end;
  if StrToInt(edtticketcount.Text)<1   then
  begin
    SysDialogs.ShowMessage('Ʊ������С��1');
    edtticketcount.SetFocus;
    exit;
  end;
  with jsonBillinventoryOut do
  begin
    Params.ParamByName('billinventory.id').Value :=id ;
    Params.ParamByName('outstartno').Value :=edtstartno.Text ;
    Params.ParamByName('outendno').Value :=edtendno.Text ;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
       SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtstartno.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
        log:='[Ʊ������]:'+ edtbillstorage.Text+',[Ʊ������]:'+edtbilltypename.Text
        +',[������ʼ����]:'+edtstartno.Text+'[��������]:'+edtendno.Text
        +',[����Ʊ��]:'+edtticketcount.Text ;
        SysLog.WriteLog('Ʊ�ݹ���-Ʊ�ݳ���','����',log);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ʊ�ݳ���ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmBillinventoryout.edtstartnoChange(Sender: TObject);
begin
  inherited;
    edtendno.Text:= IntToStr(StrToInt64(edtticketcount.Text)+StrToInt64(edtstartno.Text)-1);
end;

procedure TFrmBillinventoryout.edtticketcountChange(Sender: TObject);
begin
  inherited;
  edtendno.Text:= IntToStr(StrToInt64(edtticketcount.Text)+StrToInt64(edtstartno.Text)-1) ;
end;

end.

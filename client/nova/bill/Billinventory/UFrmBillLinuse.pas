unit UFrmBillLinuse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,NovaEdit,NovaComboBox,USimpleEditForm,
  NovaHelp, DB, DBClient, Services,jsonClientDataSet, NovaHComboBox, ImgList,
  NovaPrint, Generics.Collections;


type
  TFrmBillLinuse = class(TSimpleEditForm)
    lbl12: TLabel;
    lbl13: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    jsonBillinuesSave: TjsonClientDataSet;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl11: TLabel;
    edtbillstorage: TNovaEdit;
    edtbilltypename: TNovaEdit;
    edtstartnum: TNovaEdit;
    edtendnum: TNovaEdit;
    edtstartno: TNovaEdit;
    edtcount: TNovaEdit;
    edtendno: TNovaEdit;
    nvhlprecipients: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtcountChange(Sender: TObject);
    procedure edtstartnoChange(Sender: TObject);
    procedure edtcountExit(Sender: TObject);

    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    isprint:boolean;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
  public
    { Public declarations }
   id, inventoryid,storageid,billtypeid,availablestartno,
   availableenno,availablecount:Int64;
   receiveorg,parvalue:String;
   numperbox:string;
  end;

var
  FrmBillinuse: TFrmBillLinuse;

implementation
uses PubFn,  UDMPublic;
{$R *.dfm}

procedure TFrmBillLinuse.bbtnSaveClick(Sender: TObject);
 var nResult: integer;
  sResult,log:string;
begin
  inherited;
    if Trim(nvhlprecipients.Text) = '' then
    begin
      SysDialogs.ShowMessage('�����˲���Ϊ��');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if nvhlprecipients.Id<0 then
    begin
      SysDialogs.ShowMessage('�����˲���Ϊ��');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if nvhlprecipients.Id=0 then
    begin
      SysDialogs.ShowMessage('�����˲�����');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if edtstartno.Text='' then
    begin
      SysDialogs.ShowMessage('���ÿ�ʼ�Ų���Ϊ��');
      edtstartno.SetFocus;
      exit;
    end
    else
    begin
      if StrToInt64(edtstartno.Text)<availablestartno  then
      begin
        SysDialogs.ShowMessage('������ʼ�Ų���С�ڿ�����ʼ��');
        edtstartno.SetFocus;
        exit;
      end;
      if  StrToInt64(edtstartno.Text)>availableenno then
      begin
        SysDialogs.ShowMessage('���ý����Ų��ܴ��ڿ��ý�����');
        edtstartno.SetFocus;
        exit;
      end;
    end;
    if edtendno.Text='' then
    begin
      SysDialogs.ShowMessage('���ý����Ų���Ϊ��');
      edtstartno.SetFocus;
      exit;
    end
    else
    begin
      if StrToInt64(edtendno.Text)<StrToInt64(edtstartno.Text)  then
      begin
        SysDialogs.ShowMessage('���ý����Ų���С����ʼ��');
        edtstartno.SetFocus;
        exit;
      end;
      if  StrToInt64(edtendno.Text)>availableenno then
      begin
         SysDialogs.ShowMessage('���ý����Ų��ܴ��ڿ��ý�����');
         edtstartno.SetFocus;
         exit;
      end;
    end;
    if StrToInt64(edtcount.Text)<1   then
    begin
      SysDialogs.ShowMessage('Ʊ������С��1');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if StrToInt64(edtcount.Text) > availablecount then
    begin
      SysDialogs.ShowMessage('����Ʊ�����ܴ��ڿ���Ʊ��������Ʊ��Ϊ:' + inttostr(availablecount));
      nvhlprecipients.SetFocus;
      exit;
    end;
    with jsonBillinuesSave do
    begin

      Params.ParamByName('billinuse.startno').Value :=edtstartno.Text;
      Params.ParamByName('billinuse.endno').Value :=edtendno.Text ;
      Params.ParamByName('billinuse.billtypeid').Value :=billtypeid;
      Params.ParamByName('billinuse.billinventoryid').Value :=inventoryid;
      Params.ParamByName('billinuse.recipients').Value :=  nvhlprecipients.Id ;

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
          id := Params.ParamByName('id').Value;
          if isprint then
          begin
            if not Assigned(printValue) then
              printValue := TDictionary<String, String>.Create
            else
              printValue.Clear;
            printValue.Add('receiveorg', receiveorg);
            printValue.Add('receivedate', formatdatetime('yyyy-mm-dd',now));
            printValue.Add('receiver', nvhlprecipients.Text);
            printValue.Add('billtype', edtbilltypename.Text);
            printValue.Add('startbillno',edtstartno.Text);
            printValue.Add('endbillno', edtendno.Text);
            printValue.Add('parvalue', parvalue);
            printValue.Add('receiverbills', edtcount.Text);
            printValue.Add('numperbox', numperbox);
            printValue.Add('sender', sysinfo.LoginUserInfo.UserName);
            billPrint.SingleValue := printValue;
            billPrint.Print;
          end;
          ModalResult := mrok;
          log:='[Ʊ������]:'+ edtbillstorage.Text+',[Ʊ������]:'+edtbilltypename.Text
            +',[������ʼ����]:'+edtstartno.Text+'[��������]:'+edtendno.Text
            +',[����Ʊ��]:'+edtcount.Text +',[������]:'+nvhlprecipients.Text;
          SysLog.WriteLog('Ʊ�ݹ���-Ʊ������','Ʊ������',log);
        end;
      except
          on E: Exception do
        begin
          SysLog.WriteErr('Ʊ������ʧ�ܣ�' + E.Message);
        end;
      end;
    end;

end;

procedure TFrmBillLinuse.edtcountChange(Sender: TObject);
begin
  inherited;
    edtendno.Text:= IntToStr(StrToInt64(edtcount.Text)+StrToInt64(edtstartno.Text)-1) ;

end;

procedure TFrmBillLinuse.edtcountExit(Sender: TObject);
begin
  inherited;
  if StrToInt(edtcount.Text) = 0then
  begin
    SysDialogs.ShowMessage('���õ���������С��1�����������룡');
    edtcount.SetFocus;
    Exit;
  end;
end;

procedure TFrmBillLinuse.edtstartnoChange(Sender: TObject);
begin
  inherited;
  edtcount.Text := '1';
    edtendno.Text:= IntToStr(StrToInt64(edtcount.Text)+StrToInt64(edtstartno.Text)-1) ;

end;

procedure TFrmBillLinuse.FormShow(Sender: TObject);
begin
  inherited;
  if getParametervalue('0018', Sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    isprint := true;
    billPrint := TNovaPrint.Create(Self,
            TNovaPrint.GetTicketModelName('Ʊ֤��Ʊ��', 'Ʊ֤��Ʊ��'));
  end
  else
    isprint:= false;
end;

end.

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
    printValue: TDictionary<String, String>; // 输出单变量
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
      SysDialogs.ShowMessage('领用人不能为空');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if nvhlprecipients.Id<0 then
    begin
      SysDialogs.ShowMessage('领用人不能为空');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if nvhlprecipients.Id=0 then
    begin
      SysDialogs.ShowMessage('领用人不存在');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if edtstartno.Text='' then
    begin
      SysDialogs.ShowMessage('领用开始号不能为空');
      edtstartno.SetFocus;
      exit;
    end
    else
    begin
      if StrToInt64(edtstartno.Text)<availablestartno  then
      begin
        SysDialogs.ShowMessage('领用起始号不能小于可用起始号');
        edtstartno.SetFocus;
        exit;
      end;
      if  StrToInt64(edtstartno.Text)>availableenno then
      begin
        SysDialogs.ShowMessage('领用结束号不能大于可用结束号');
        edtstartno.SetFocus;
        exit;
      end;
    end;
    if edtendno.Text='' then
    begin
      SysDialogs.ShowMessage('领用结束号不能为空');
      edtstartno.SetFocus;
      exit;
    end
    else
    begin
      if StrToInt64(edtendno.Text)<StrToInt64(edtstartno.Text)  then
      begin
        SysDialogs.ShowMessage('领用结束号不能小于起始号');
        edtstartno.SetFocus;
        exit;
      end;
      if  StrToInt64(edtendno.Text)>availableenno then
      begin
         SysDialogs.ShowMessage('领用结束号不能大于可用结束号');
         edtstartno.SetFocus;
         exit;
      end;
    end;
    if StrToInt64(edtcount.Text)<1   then
    begin
      SysDialogs.ShowMessage('票数不能小于1');
      nvhlprecipients.SetFocus;
      exit;
    end;
    if StrToInt64(edtcount.Text) > availablecount then
    begin
      SysDialogs.ShowMessage('领用票数不能大于可用票数，可用票数为:' + inttostr(availablecount));
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
          log:='[票库名称]:'+ edtbillstorage.Text+',[票据类型]:'+edtbilltypename.Text
            +',[领用起始号码]:'+edtstartno.Text+'[结束号码]:'+edtendno.Text
            +',[领用票数]:'+edtcount.Text +',[领用人]:'+nvhlprecipients.Text;
          SysLog.WriteLog('票据管理-票据领用','票据领用',log);
        end;
      except
          on E: Exception do
        begin
          SysLog.WriteErr('票据领用失败：' + E.Message);
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
    SysDialogs.ShowMessage('领用的数量不能小于1，请重新输入！');
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
            TNovaPrint.GetTicketModelName('票证领票单', '票证领票单'));
  end
  else
    isprint:= false;
end;

end.

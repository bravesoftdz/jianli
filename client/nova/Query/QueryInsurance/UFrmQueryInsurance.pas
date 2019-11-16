unit UFrmQueryInsurance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  ExtDlgs;

type
  TFrmQueryInsurance = class(TSimpleCRUDForm)
    lbl1: TLabel;
    sellOrgid: TNovaCheckedComboBox;
    Label1: TLabel;
    nvhlpschedule: TNovaHelp;
    Label2: TLabel;
    nvhelpRoute: TNovaHelp;
    lbl9: TLabel;
    nvhelpendstation: TNovaHelp;
    lbl2: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl7: TLabel;
    lbl14: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    lbl17: TLabel;
    edtpolnumber: TNovaEdit;
    Label3: TLabel;
    edtinsuranceno: TNovaEdit;
    lbl13: TLabel;
    nvcbbstatus: TNovaComboBox;
    Label4: TLabel;
    lbl5: TLabel;
    nvedtPhone: TNovaEdit;
    Label5: TLabel;
    edtcertificateno: TNovaEdit;
    jcdsstatus: TjsonClientDataSet;
    jcdspaymethod: TjsonClientDataSet;
    jcdssellway: TjsonClientDataSet;
    wdstrngfldResultticketname: TWideStringField;
    wdstrngfldResultticketno: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    wdstrngfldResultcode: TWideStringField;
    wdstrngfldResultdeparttime: TWideStringField;
    wdstrngfldResultendname: TWideStringField;
    wdstrngfldResultinsuranceno: TWideStringField;
    wdstrngfldResultcustomername: TWideStringField;
    wdstrngfldResultmobilephone: TWideStringField;
    wdstrngfldResultcertificateno: TWideStringField;
    wdstrngfldResultinsurername: TWideStringField;
    wdstrngfldResulttypename: TWideStringField;
    wdstrngfldResultinsurancestatus: TWideStringField;
    wdstrngfldResultinsurancestatusname: TWideStringField;
    wdstrngfldResultsellname: TWideStringField;
    wdstrngfldResultselltime: TWideStringField;
    wdstrngfldResultpaymethod: TWideStringField;
    wdstrngfldResultpaymethodname: TWideStringField;
    wdstrngfldResultsellway: TWideStringField;
    wdstrngfldResultsellwayname: TWideStringField;
    wdstrngfldResultpolnumber: TWideStringField;
    nvhlpname: TNovaHelp;
    dtfldResultdepartdate: TDateField;
    fltfldResultpremium: TFloatField;
    fltfldResultinsureamount: TFloatField;
    jcdsResultsellip: TWideStringField;
    fltfldResultywmoney: TFloatField;
    fltfldResultshmoney: TFloatField;
    fltfldResultemoney: TFloatField;
    fltfldResultemmoney: TFloatField;
    wdstrngfldResultreprintnum: TWideStringField;
    wdstrngfldResultoutletsaddress: TWideStringField;
    wdstrngfldResultreturnorcancelby: TWideStringField;
    wdstrngfldResultreturnorcanceltime: TWideStringField;
    wdstrngfldResultinsurersbankcode: TWideStringField;
    wdstrngfldResultstartname: TWideStringField;
    wdstrngfldResultinsuretypecode: TWideStringField;
    wdstrngfldResultinsuranceprintdatetime: TWideStringField;
    dlg1: TSaveTextFileDialog;
    blnfldResultislinework: TBooleanField;
    wdstrngfldResultseatno: TWideStringField;
    wdstrngfldResultsellby: TWideStringField;
    wdstrngfldResultorgcode: TWideStringField;
    jcdscertificatetypename: TjsonClientDataSet;
    wdstrngfldResultcertificatetype: TWideStringField;
    wdstrngfldResultcertificatetypename: TWideStringField;
    Label6: TLabel;
    cbb1: TNovaCheckedComboBox;
    Label7: TLabel;
    cbbNovachkPorg: TNovaCheckedComboBox;
    Label8: TLabel;
    cbb2: TNovaCheckedComboBox;
    Label9: TLabel;
    cbb3: TNovaCheckedComboBox;
    Label10: TLabel;
    edt1: TNovaEdit;
    lbl10: TLabel;
    lbl12: TLabel;
    cbbSellway: TNovaComboBox;
    cbbPaymethod: TNovaComboBox;
    jcdsResultsellorg: TWideStringField;
    jcdsResulthtsellorg: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpBselldateChange(Sender: TObject);
    procedure dtpEselldateChange(Sender: TObject);
    procedure tbtn5Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryInsurance: TFrmQueryInsurance;
function getPolnumber(typename,insuranceno:string):string;
implementation

uses Services, PubFn,strUtils;
{$R *.dfm}

procedure TFrmQueryInsurance.dtpBselldateChange(Sender: TObject);
begin
  inherited;
  if dtpBselldate.Checked = True then
  begin
    dtpEselldate.Checked := True;
  end;
  if dtpBselldate.Checked =False then
  begin
    dtpEselldate.Checked := False;
  end;
end;

procedure TFrmQueryInsurance.dtpenddateChange(Sender: TObject);
begin
  inherited;
  if dtpenddate.Checked = True  then
  begin
     dtpstartdate.Checked := True;
  end;
 if  dtpenddate.Checked =False then
  begin
     dtpstartdate.Checked := False;
  end;
end;

procedure TFrmQueryInsurance.dtpEselldateChange(Sender: TObject);
begin
  inherited;
  if dtpEselldate.Checked = True  then
  begin
     dtpBselldate.Checked := True;
  end;
 if  dtpEselldate.Checked =False then
  begin
     dtpBselldate.Checked := False;
  end;
end;

procedure TFrmQueryInsurance.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  if dtpstartdate.Checked = True  then
  begin
     dtpenddate.Checked := True;
  end;
 if  dtpstartdate.Checked =False then
  begin
     dtpenddate.Checked := False;
  end;
end;

procedure TFrmQueryInsurance.FormCreate(Sender: TObject);
begin
  inherited;
   dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmQueryInsurance.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  dtpstartdate.Checked := False;
  dtpenddate.Checked := False;
  dtpBselldate.DateTime := Now;
  dtpEselldate.DateTime := Now;
  nvcbbstatus.Active := False;
  nvcbbstatus.Active := True;
  nvcbbstatus.ItemIndex :=0;
  sellOrgid.Active := False;
  sellOrgid.Active := True;
  cbb3.Active := False;
  cbb3.Active := True;
  cbbNovachkPorg.Active := False;
  cbbNovachkPorg.Active := True;
  cbb2.Active := False;
  cbb2.Active := True;
  cbb1.Active := False;
  cbb1.Active := True;
  cbbsellway.active :=False;
  cbbsellway.active :=True;
  cbbsellway.ItemIndex :=0;
  cbbpaymethod.active :=False;
  cbbpaymethod.active :=True;
  cbbpaymethod.ItemIndex :=0;
end;

procedure TFrmQueryInsurance.tbtn5Click(Sender: TObject);
var
  filetxt:tstrings;
  sbuf:string;
  polNumber:string;
begin
  inherited;
  filetxt:=TStringList.Create;
  with jcdsResult do
  begin;
    First;
    begin
      while not Eof do
      begin
        sbuf := Concat(  sbuf,  FieldByName('ticketno').AsString+','  );
        if FieldByName('islinework').AsString='0' then
        begin
          sbuf := Concat(  sbuf,  '*,'  );   //流水班次
        end
        else
        begin
          sbuf := Concat(  sbuf,  FieldByName('seatno').AsString+','  );
        end;
        sbuf := Concat(  sbuf,  FieldByName('selltime').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('insuranceprintdatetime').AsString+','  );
        if FieldByName('islinework').AsString='0' then
        begin
          sbuf := Concat(  sbuf,  FieldByName('departdate').AsString+' '
                                +'*    ,'  );     //流水班次
        end
        else
        begin
          sbuf := Concat(  sbuf,  FieldByName('departdate').AsString+' '
                                +FieldByName('departtime').AsString+','  );
        end;
        sbuf := Concat(  sbuf,  FieldByName('endname').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('premium').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('ywmoney').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('shmoney').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('emoney').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('emmoney').AsString+','  );
        sbuf := Concat(  sbuf,  '0'+','  ); //重打次数为0
        sbuf := Concat(  sbuf,  FieldByName('sellby').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('outletsaddress').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('insurancestatus').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('returnorcancelby').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('returnorcanceltime').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('insuranceno').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('ticketno').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('insurersbankcode').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('insurername').AsString+','  );//保险公司名称可为空
        sbuf := Concat(  sbuf,  FieldByName('certificatetypename').AsString+','  );
        sbuf := Concat(  sbuf,  FieldByName('certificateno').AsString+','  );//证件号码可为空
        sbuf := Concat(  sbuf,  FieldByName('customername').AsString+','  );//受益人可为空
        sbuf := Concat(  sbuf,  FieldByName('orgcode').AsString+','  );
        //保险产品代码，十堰，字段意思看以下代码
        if (FieldByName('premium').AsString='1') and (FieldByName('ywmoney').AsString='0.3') then
        begin

          sbuf := Concat(  sbuf,  '2307990012000322'+','  );
        end
        else if (FieldByName('premium').AsString='2') and (FieldByName('ywmoney').AsString='0.5') then
        begin
          sbuf := Concat(  sbuf,  '2307990012000399'+','  );
        end
        else
        begin
          sbuf := Concat(  sbuf,  '未知保险产品代码'+','  );
        end;
        sbuf := Concat(  sbuf,  FieldByName('insuretypecode').AsString+','  );
        polNumber := getPolnumber( FieldByName('typename').AsString,
                                    FieldByName('insuranceno').AsString );
        sbuf := Concat(  sbuf,  polNumber  );
        filetxt.Add(sbuf);
        sbuf:='';
        Next;
      end;
    end;
  end;
  dlg1.FileName:='保险销售记录('
                      + FormatDateTime('yyyymmdd--',dtpstartdate.DateTime)
                      + FormatDateTime('yyyymmdd',dtpenddate.DateTime)
                      +')';
  if dlg1.Execute then
  begin
    filetxt.SaveToFile(dlg1.FileName);
  end;
  filetxt.Free;
end;
function getPolnumber(typename,insuranceno:string):string;
const
  prestr:string='AWUHA59';
var
  beforeNo:string;
  midNo:string;
  afterNo:string;
begin
  try
    beforeNo := LeftStr(insuranceno,2);
    midNo := MidStr(insuranceno,3,2);
    midNo := Char( 65+strtoint(midNo) );
    afterNo := RightStr( insuranceno, Length(insuranceno)-4 );
    result := prestr + typename + beforeNo + midNo + afterNo + midNo;
  except
    on E:exception do
    begin
      SysLog.WriteErr('导出TXT生成最后一项(打印号)失败：' + E.Message);
    end;
  end;
end;

procedure TFrmQueryInsurance.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if dtpstartdate.checked then
  begin
     if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  end;
  if dtpBselldate.checked then
  begin
     if FormatDateTime('yyyymmdd', dtpBselldate.Date) > FormatDateTime('yyyymmdd',
    dtpEselldate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpEselldate.Date-dtpBselldate.Date)
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;

  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;

  if dtpBselldate.Checked or dtpstartdate.checked then
  begin
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_i!orgid'] := sellOrgid.GetSelectID;
      Params.ParamValues['filter_INS_o!id'] := cbb1.GetSelectID;
      Params.ParamValues['filter_EQS_i!sellway'] := cbbSellway.GetSelectCode;
      Params.ParamValues['filter_EQS_i!paymethod'] := cbbPaymethod.GetSelectCode;
      if dtpstartdate.checked then
      begin
        Params.ParamValues['filter_GED_t!selltime'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date) + ' 00:00:01';
        Params.ParamValues['filter_LED_t!selltime'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date) + ' 23:59:59';
      end else
      begin
        Params.ParamValues['filter_GED_t!selltime'] := '';
        Params.ParamValues['filter_LED_t!selltime'] := '';
      end;

      if dtpBselldate.Checked then
      begin
        Params.ParamValues['filter_GED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpBselldate.Date);
        Params.ParamValues['filter_LED_t!departdate'] := FormatDateTime('yyyy-mm-dd',dtpEselldate.Date);
      end else
      begin
        Params.ParamValues['filter_GED_t!departdate'] := '';
        Params.ParamValues['filter_LED_t!departdate'] := '';
      end;
      if Trim(edtpolnumber.Text) = '' then
        Params.ParamValues['filter_LIKES_i!polnumber'] := ''
      else
        Params.ParamValues['filter_LIKES_i!polnumber'] := edtpolnumber.Text;
      if Trim(edtinsuranceno.Text) = '' then
        Params.ParamValues['filter_LIKES_i!insuranceno'] := ''
      else
        Params.ParamValues['filter_LIKES_i!insuranceno'] := edtinsuranceno.Text;
      if Trim(nvhelpendstation.Text) = '' then
        Params.ParamValues['filter_EQL_st!id'] := ''
      else
        Params.ParamValues['filter_EQL_st!id'] := nvhelpendstation.Id;
      if nvcbbstatus.ItemIndex > 0 then
        Params.ParamValues['filter_EQS_i!insurancestatus'] :=
        TCommInfo(nvcbbstatus.Items.Objects[nvcbbstatus.ItemIndex]).Value
      else
        Params.ParamValues['filter_EQS_i!insurancestatus'] := '';
      if Trim(nvhlpname.Text) = '' then
        Params.ParamValues['filter_EQL_i!customerid'] := ''
      else
        Params.ParamValues['filter_EQL_i!customerid'] := nvhlpname.Id;
      if Trim(nvedtPhone.Text) = '' then
        Params.ParamValues['filter_LIKES_c!mobilephone'] := ''
      else
        Params.ParamValues['filter_LIKES_c!mobilephone'] := nvedtPhone.Text;
      if Trim(cbb3.Text) = '' then
        Params.ParamValues['filter_INS_ise!id'] := ''
      else
        Params.ParamValues['filter_INS_ise!id'] := cbb3.GetSelectID;
      if Trim(edtcertificateno.Text) = '' then
        Params.ParamValues['filter_LIKES_c!certificateno'] := ''
      else
        Params.ParamValues['filter_LIKES_c!certificateno'] := edtcertificateno.Text;
      if Trim(nvhelpRoute.Text) = '' then
        Params.ParamValues['routeid'] := ''
      else
        Params.ParamValues['routeid'] := nvhelpRoute.Id;
      if Trim(nvhlpschedule.Text) = '' then
        Params.ParamValues['scheduleid'] := ''
      else
        Params.ParamValues['scheduleid'] := nvhlpschedule.Id;
      if Trim(edt1.Text) = '' then
        Params.ParamValues['orderno'] := ''
      else
        Params.ParamValues['orderno'] := edt1.Text;

    Active := True;
  end;
  end else
  begin
      SysDialogs.Warning('请选择售票日期或发车日期！');
    exit;
  end;
end;

end.

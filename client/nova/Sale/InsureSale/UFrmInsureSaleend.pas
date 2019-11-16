unit UFrmInsureSaleend;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleEditForm, ComCtrls, StdCtrls, NovaEdit, NovaComboBox, ExtCtrls,
  GridsEh, DBGridEh, NvDbgridEh, Buttons,
  uBaseForm, DB, DBClient, jsonClientDataSet,UDMPublic, DBCtrls, Mask, dblookup,
  Services, DBGridEhGrouping,NovaPrint, ImgList;

type
  TFrmInsureSaleend = class(TSimpleEditForm)
    gbadvanced: TGroupBox;
    gbstandard: TGroupBox;
    lbl6: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl5: TLabel;
    lbl10: TLabel;
    nvdbgrdhCustomer: TNvDbgridEh;
    jsoncdsEducation: TjsonClientDataSet;
    jsoncdsCustom: TjsonClientDataSet;
    dbedtMOBILEPHONE: TDBEdit;
    dbedtFamilyPhone: TDBEdit;
    dbedtAdress: TDBEdit;
    dbmmoRemark: TDBMemo;
    dsInsuranceBuffer: TDataSource;
    dsEducation: TDataSource;
    jsoncdsquerycustomer: TjsonClientDataSet;
    dblkcbbEDUCATION: TDBLookupComboBox;
    pnlinsurereceipt: TPanel;
    lblinsurenum_: TLabel;
    lblinsurenum: TLabel;
    lblinsurereceivablenum_: TLabel;
    lblinsurereceivablenum: TLabel;
    bvlrr: TBevel;
    lbl1: TLabel;
    pnlrr: TPanel;
    Bevel2: TBevel;
    lblpayment: TLabel;
    lblchange: TLabel;
    lblchange_: TLabel;
    nvedtreceipt: TNovaEdit;
    nvcbbpayment: TNovaComboBox;
    lblreceipt: TLabel;
    jcdsquerycustomerbyid: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure dsInsuranceBufferDataChange(Sender: TObject; Field: TField);
    procedure nvdbgrdhCustomerExit(Sender: TObject);
    procedure nvedtreceiptChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure setsexinputenable(isIDCard:boolean);
    function getTotalInsureBufferReceivablenum: Currency;
    function printinsure: boolean;
    function sellInsure(): boolean;
    function SaveCustomer(): boolean;
  public
    { Public declarations }
    cdsinsuretype:TjsonClientDataSet;
    FinsurePrint:TNovaPrint;
    setDefaultCustomerOnSellinsure:Boolean;
    defaultCustomerID:int64;
  end;

var
  FrmInsureSaleend: TFrmInsureSaleend;

implementation
uses PubFn;

{$R *.dfm}

procedure TFrmInsureSaleend.bbtnSaveClick(Sender: TObject);
begin
 if(StrToInt(lblinsurereceivablenum.Caption)>StrToInt(nvedtreceipt.Text)) then
  begin
    SysDialogs.ShowMessage('ʵ�ս��Ӧ���ڱ��ս�');
    EXIT;
    nvedtreceipt.SetFocus;
  end;
  if SaveCustomer then
  begin
    if sellInsure then
    begin
      self.ModalResult:=mrok;
    end;
  end;
end;

procedure TFrmInsureSaleend.dsInsuranceBufferDataChange(Sender: TObject;
  Field: TField);
var exist:boolean;
    oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  exist:=false;
  if (Field=nil) then exit;
  if (Field.FieldName='certificatetype') or (Field.FieldName='certificateno') then
  begin
    if (not Field.DataSet.FieldByName('certificatetype').IsNull)
      and (not Field.DataSet.FieldByName('certificateno').IsNull) then
    begin
      with jsoncdsquerycustomer do
      begin
        Active:=false;
        Params.ParamValues['filter_EQS_c!certificatetype']:=Field.DataSet.FieldValues['certificatetype'];
        Params.ParamValues['filter_EQS_c!certificateno']:=Field.DataSet.FieldValues['certificateno'];
        active:=true;
        if RecordCount=1 then
        begin
          exist:=true;
          oldOnDataChange:=(sender as TDataSource).OnDataChange;
          (sender as TDataSource).OnDataChange:=nil;
          Field.DataSet.edit;
          Field.DataSet.FieldValues['customerid']:=FieldValues['id'];
          Field.DataSet.FieldValues['education']:=FieldValues['education'];
          Field.DataSet.FieldValues['familyaddress']:=FieldValues['familyaddress'];
          Field.DataSet.FieldValues['familyphone']:=FieldValues['familyphone'];
          Field.DataSet.FieldValues['mobilephone']:=FieldValues['mobilephone'];
          Field.DataSet.FieldValues['customername']:=FieldValues['name'];
          Field.DataSet.FieldValues['customerremarks']:=FieldValues['remarks'];
//          Field.DataSet.post;
          (sender as TDataSource).OnDataChange:=oldOnDataChange;
        end;
      end;
      if (not exist) and (not Field.DataSet.FieldByName('customerid').IsNull) and (Field.DataSet.FieldByName('customerid').AsLargeInt>0) then
      begin
        oldOnDataChange:=(sender as TDataSource).OnDataChange;
        (sender as TDataSource).OnDataChange:=nil;
        Field.DataSet.edit;
        Field.DataSet.FieldValues['customerid']:=0;
        Field.DataSet.FieldValues['education']:=null;
        Field.DataSet.FieldValues['familyaddress']:=null;
        Field.DataSet.FieldValues['familyphone']:=null;
        Field.DataSet.FieldValues['mobilephone']:=null;
        Field.DataSet.FieldValues['customername']:=null;
        Field.DataSet.FieldValues['customerremarks']:=null;
//        Field.DataSet.post;
        (sender as TDataSource).OnDataChange:=oldOnDataChange;
      end;
    end;
    dbedtMOBILEPHONE.Enabled:=not exist;
    dbedtFamilyPhone.Enabled:=not exist;
    dbedtAdress.Enabled:=not exist;
    dblkcbbEDUCATION.Enabled:=not exist;
    dbmmoRemark.Enabled:=not exist;
    if (Field.FieldName='certificatetype') then
    begin
      setsexinputenable((not Field.DataSet.FieldByName('certificatetype').IsNull)
                        and (Field.DataSet.FieldValues['certificatetype']='0')
                        );
    end;
  end
  else if (Field.FieldName='insuretypeid') then  //(Field.FieldName='issell') or
  begin
    if field.DataSet.FieldByName('issell').AsBoolean then
    begin
      if not Field.DataSet.FieldByName('premium').IsNull then
      begin
        lblinsurereceivablenum.Caption:=CurrToStr(StrToCurrDef(lblinsurereceivablenum.Caption,0)-Field.DataSet.FieldValues['premium']);
      end;
    end;
    if cdsinsuretype.Locate('id',VarArrayOf([Field.DataSet.FieldValues['insuretypeid']]),[]) then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      Field.DataSet.edit;
      Field.DataSet.FieldValues['premium']:=cdsinsuretype.FieldValues['premium'];
      Field.DataSet.FieldValues['insureamount']:=cdsinsuretype.FieldValues['MAXINSUREAMOUNT'];
      Field.DataSet.FieldValues['insurersid']:=cdsinsuretype.FieldValues['insurersid'];
//      Field.DataSet.FieldValues['emoney']:=cdsinsuretype.FieldValues['emoney']; //�����˺����ս��
//      Field.DataSet.FieldValues['emmoney']:=cdsinsuretype.FieldValues['emmoney'];    //�����˺�ҽ�Ʊ��ս��
//      Field.DataSet.FieldValues['reprintdatetime']:=cdsinsuretype.FieldValues['reprintdatetime'];  //���ճ�Ʊʱ��
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end;
    if field.DataSet.FieldByName('issell').AsBoolean then
    begin
      if not Field.DataSet.FieldByName('premium').IsNull then
      begin
        lblinsurereceivablenum.Caption:=CurrToStr(StrToCurrDef(lblinsurereceivablenum.Caption,0)+Field.DataSet.FieldValues['premium']);
      end;
    end;
    nvedtreceiptChange(nil);
  end
  else if (Field.FieldName='issell') then
  begin
    if field.AsBoolean then
    begin
      lblinsurenum.Caption:=inttostr(strtoint(lblinsurenum.Caption)+1);
      if not Field.DataSet.FieldByName('premium').IsNull then
      begin
        lblinsurereceivablenum.Caption:=CurrToStr(StrToCurrDef(lblinsurereceivablenum.Caption,0)+Field.DataSet.FieldValues['premium']);
      end;
    end
    else
    begin
      lblinsurenum.Caption:=inttostr(strtoint(lblinsurenum.Caption)-1);
      if not Field.DataSet.FieldByName('premium').IsNull then
      begin
        lblinsurereceivablenum.Caption:=CurrToStr(StrToCurrDef(lblinsurereceivablenum.Caption,0)-Field.DataSet.FieldValues['premium']);
      end;
    end;
    nvedtreceiptChange(nil);
  end;
end;

procedure TFrmInsureSaleend.FormCreate(Sender: TObject);
begin
  inherited;
  nvedtreceipt.Text:='';
  jsoncdsEducation.Active:=true;
  nvcbbpayment.Active:=true;
  nvcbbpayment.ItemIndex:=0;
end;

procedure TFrmInsureSaleend.FormShow(Sender: TObject);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  nvdbgrdhCustomerExit(nil);
  if setDefaultCustomerOnSellinsure then
  begin
    jcdsquerycustomerbyid.Active:=false;
    jcdsquerycustomerbyid.Params.ParamValues['filter_EQL_c!id']:=defaultCustomerID;
    jcdsquerycustomerbyid.active:=true;
    if jcdsquerycustomerbyid.RecordCount=1 then
    begin
      oldOnDataChange:=dsInsuranceBuffer.OnDataChange;
      dsInsuranceBuffer.OnDataChange:=nil;
      with dsInsuranceBuffer.DataSet do
      begin
        First;
        while not eof do
        begin
          edit;
          FieldValues['customerid']:=jcdsquerycustomerbyid.FieldValues['id'];
          FieldValues['certificatetype']:=jcdsquerycustomerbyid.FieldValues['certificatetype'];
          FieldValues['certificateno']:=jcdsquerycustomerbyid.FieldValues['certificateno'];
          FieldValues['education']:=jcdsquerycustomerbyid.FieldValues['education'];
          FieldValues['familyaddress']:=jcdsquerycustomerbyid.FieldValues['familyaddress'];
          FieldValues['familyphone']:=jcdsquerycustomerbyid.FieldValues['familyphone'];
          FieldValues['mobilephone']:=jcdsquerycustomerbyid.FieldValues['mobilephone'];
          FieldValues['customername']:=jcdsquerycustomerbyid.FieldValues['name'];
          FieldValues['customerremarks']:=jcdsquerycustomerbyid.FieldValues['remarks'];
          next;
        end;
      end;
      dsInsuranceBuffer.OnDataChange:=oldOnDataChange;
    end;
  end;
  nvedtreceipt.SetFocus;
  nvedtreceipt.SelectAll;
  nvedtreceipt.Text:=lblinsurereceivablenum.Caption;
end;

procedure TFrmInsureSaleend.setsexinputenable(isIDCard: boolean);
begin
//  rbMan.Enabled:=not isIDCard;
//  rbGrile.Enabled:=not isIDCard;
//  dbehdtedtbirthday.Enabled:=not isIDCard;
end;

function TFrmInsureSaleend.sellInsure(): boolean;
begin
  result:=false;
  with TjsonClientDataSet(dsInsuranceBuffer.DataSet) do
  begin
    Params.ParamValues['insuranceOrder.seller']:= SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['insuranceOrder.orgid']:= SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['insuranceOrder.startTicketNO']:=SysInfo.LoginUserInfo.curBillNo.Items['Insure'];
    Params.ParamValues['insuranceOrder.totalmoney']:=CurrToStr(getTotalInsureBufferReceivablenum);
    Params.ParamValues['insuranceOrder.ip']:=SysInfo.LocalHostAddress;
    Params.ParamValues['insuranceOrder.ticketoutletsid']:=SysInfo.LoginUserInfo.ticketoutletsid;
    //0	��Ʊ  1	��Ʊ  2	��Ȩ��Ʊ   3	����Ʊ  4	��Ʊ   5	�ֹ�Ʊ  6	��Ʊ����  7	������Ʊ  8	��Ʊ  9	�����۱���
    Params.ParamValues['insuranceOrder.sellway']:='9';
    DisableControls;
    try
      first;
      while not eof do
      begin
        edit;
        FieldByName('paymethod').AsString:=nvcbbpayment.GetSelectCode;
        post;
        next;
      end;
    finally
      EnableControls;
    end;
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('�۱��յ�ʧ��:δ֪����');
      end;
      if Params.ParamValues['flag']=1 then
      begin
        //���浽��������
        with sysinfo.LoginUserInfo do
        begin
          curBillNo.AddOrSetValue('Insure',zerofill(IntToStr(strtoint64(curBillNo.Items['Insure'])+RecordCount),
                                                    length(curBillNo.Items['Insure'])));
          curBillNum.AddOrSetValue('Insure',curBillNum.Items['Insure']-RecordCount);
        end;
        try
          printinsure;
        except on E: Exception do
          SysDialogs.ShowError(e.Message);
        end;
        if Params.ParamByName('msg').IsNull or (trim(Params.ParamByName('msg').AsString)='')
          or (trim(Params.ParamByName('msg').AsString)='null') then
          SysDialogs.ShowMessage('�۱��ճɹ���')
        else
          SysDialogs.ShowMessage(Params.ParamValues['msg']);
        result:=true;
      end
      else
      begin
        if Params.ParamByName('msg').IsNull then
          SysDialogs.Warning('�۱��յ�ʧ��:δ֪����')
        else
          SysDialogs.Warning(Params.ParamValues['msg']);
      end;
    except on E: Exception do
      SysDialogs.Warning('�۱��յ�ʧ��:'+e.Message);
    end;
  end;
end;

function TFrmInsureSaleend.getTotalInsureBufferReceivablenum: Currency;
begin
  result:=0;
  //ͳ�ƻ�����еĽ��
  if (dsInsuranceBuffer.DataSet<>nil) and dsInsuranceBuffer.DataSet.Active then
  begin
    with dsInsuranceBuffer.DataSet do
    begin
      DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('issell').AsBoolean then
        begin
          result:=result+FieldByName('premium').AsCurrency;
        end;
        next;
      end;
      EnableControls;
    end;
  end;
end;

procedure TFrmInsureSaleend.nvdbgrdhCustomerExit(Sender: TObject);
var sellnum:integer;
    sellmoney:Currency;
begin
  inherited;
  sellnum:=0;
  sellmoney:=0;
  //ȡӦ�ɿ�
  with dsInsuranceBuffer.DataSet do
  begin
    DisableControls;
    try
      first;
      while not eof do
      begin
        edit;
        if cdsinsuretype.Locate('id',VarArrayOf([FieldValues['insuretypeid']]),[]) then
        begin
          FieldValues['premium']:=cdsinsuretype.FieldValues['premium'];
          FieldValues['insureamount']:=cdsinsuretype.FieldValues['MAXINSUREAMOUNT'];
          FieldValues['insurersid']:=cdsinsuretype.FieldValues['insurersid'];
//          FieldValues['emoney']:=cdsinsuretype.FieldValues['emoney']; //�����˺����ս��
//          FieldValues['emmoney']:=cdsinsuretype.FieldValues['emmoney'];    //�����˺�ҽ�Ʊ��ս��
//          FieldValues['reprintdatetime']:=cdsinsuretype.FieldValues['reprintdatetime'];  //���ճ�Ʊʱ��
        end;
        if FieldByName('issell').AsBoolean then
        begin
          inc(sellnum);
          sellmoney:=sellmoney+FieldByName('premium').AsCurrency;
        end;
        next;
      end;
    finally
      EnableControls;
    end;
  end;
  lblinsurenum.Caption:=inttostr(sellnum);
  lblinsurereceivablenum.Caption:=CurrToStr(sellmoney);
  nvedtreceiptChange(nil);
end;

procedure TFrmInsureSaleend.nvedtreceiptChange(Sender: TObject);
begin
  inherited;
  lblchange.Caption:=CurrToStr(StrToCurrDef(nvedtreceipt.Text,0)-StrToCurrDef(lblinsurereceivablenum.Caption,0))
end;

function TFrmInsureSaleend.printinsure: boolean;
begin
  with FinsurePrint.SingleValue,TjsonClientDataSet(dsInsuranceBuffer.DataSet) do
  begin
    first;
    while not eof do
    begin
      if not FieldByName('issell').AsBoolean then
      begin
        next;
        Continue;
      end;

      AddOrSetValue('certificatetypename',FieldByName('certificatetypename').AsString);
      AddOrSetValue('selltime',FieldByName('selltime').AsString);
      AddOrSetValue('ticketoutletsname', FieldByName('ticketoutletsname').AsString);

      AddOrSetValue('certificateno', FieldByName('certificateno').AsString);
      AddOrSetValue('customername', FieldByName('customername').AsString);
      AddOrSetValue('familyaddress', FieldByName('familyaddress').AsString);
      AddOrSetValue('familyphone', FieldByName('familyphone').AsString);
      AddOrSetValue('mobilephone', FieldByName('mobilephone').AsString);
      AddOrSetValue('insuranceno', FieldByName('insuranceno').AsString);

      AddOrSetValue('departdate', FieldByName('departdate').AsString);
      AddOrSetValue('schedulecode', FieldByName('schedulecode').AsString);
      AddOrSetValue('departstationname', FieldByName('departstationname').AsString);
      AddOrSetValue('reachstationname', FieldByName('reachstationname').AsString);
      AddOrSetValue('reachstationsecondname', FieldByName('reachstationsecondname').AsString);
      AddOrSetValue('tickettypeprintname',FieldByName('tickettypeprintname').AsString);
      AddOrSetValue('ticketno', FieldByName('ticketno').AsString);
      if FieldByName('carrychildnum').AsInteger<1 then
        AddOrSetValue('carrychildnum', '')
      else
        AddOrSetValue('carrychildnum', FieldByName('carrychildnum').AsString);
      AddOrSetValue('premium', FieldByName('premium').AsString);
      AddOrSetValue('insureamount', FieldByName('insureamount').AsString);

      if FieldByName('islinework').AsBoolean then
      begin
        AddOrSetValue('islinework', '��ˮ��');
        AddOrSetValue('seatno', '���̶�');
        AddOrSetValue('departtime', FieldByName('departtime').AsString+'ǰ�ϳ���Ч');
      end
      else
      begin
        AddOrSetValue('islinework', '');
        AddOrSetValue('seatno', FieldByName('seatno').AsString);
        AddOrSetValue('departtime', FieldByName('departtime').AsString);
      end;
      AddOrSetValue('sellbycode', SysInfo.LoginUserInfo.UserCode);
      AddOrSetValue('sellbyname', SysInfo.LoginUserInfo.UserName);
      AddOrSetValue('polnumber', FieldByName('polnumber').AsString);
      AddOrSetValue('emoney', FieldByName('emoney').AsString);    //�����˺����ս��
      AddOrSetValue('emmoney', FieldByName('emmoney').AsString);  //�����˺�ҽ�Ʊ��ս��
      AddOrSetValue('reprintdatetime', FieldByName('reprintdatetime').AsString); //����Ʊ��Ʊʱ��
      FinsurePrint.Print;
      next;
    end;
  end;
end;



function TFrmInsureSaleend.SaveCustomer: boolean;
var certificateno:String;
    sellnum:integer;
    PIDErrMsg:String;
begin
  inherited;
  result:=false;
  sellnum:=0;
  jsoncdsCustom.Active:=false;
  jsoncdsCustom.Active:=true;
  //������������
  with dsInsuranceBuffer.DataSet do //jsoncdsInsurance
  begin
    DisableControls;
    first;
    while not eof do
    begin
      if FieldByName('issell').AsBoolean then
      begin
        if FieldByName('insuretypeid').IsNull or FieldByName('customername').IsNull or FieldByName('certificatetype').IsNull or FieldByName('certificateno').IsNull then
        begin
          SysDialogs.ShowInfo('�۱��ձ���������д������Ϣ!');
          if not (State in [dsEdit,dsInsert]) then
          begin
            edit;
          end;
          EnableControls;
          exit;
        end;
        edit;
        if cdsinsuretype.Locate('id',VarArrayOf([FieldValues['insuretypeid']]),[]) then
        begin
          FieldValues['premium']:=cdsinsuretype.FieldValues['premium'];
          FieldValues['insureamount']:=cdsinsuretype.FieldValues['MAXINSUREAMOUNT'];
          FieldValues['insurersid']:=cdsinsuretype.FieldValues['insurersid'];
//          FieldValues['emoney']:=cdsinsuretype.FieldValues['emoney']; //�����˺����ս��
//          FieldValues['emmoney']:=cdsinsuretype.FieldValues['emmoney'];    //�����˺�ҽ�Ʊ��ս��
//          FieldValues['reprintdatetime']:=cdsinsuretype.FieldValues['reprintdatetime'];  //���ճ�Ʊʱ��
        end;
        post;
        if (not FieldByName('customerid').IsNull) and (FieldByName('customerid').AsLargeInt>0) then
        begin
          inc(sellnum);
          next;
          Continue;
        end;

        jsoncdsCustom.Append;
        jsoncdsCustom.FieldByName('id').Value:=0;
        jsoncdsCustom.FieldByName('name').Value:=FieldValues['customername'];

        if (FieldValues['certificatetype']='0') then  //���֤
        begin
          certificateno:=FieldValues['certificateno'];
          PIDErrMsg:=ValidatePID(certificateno);
          if trim(PIDErrMsg)='' then
          begin
            if length(certificateno)=15 then
            begin
              jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint('19'+copy(certificateno,7,2)),
                                                                      strtoint(copy(certificateno,9,2)),
                                                                      strtoint(copy(certificateno,11,2)));
              if odd(strtoint(copy(certificateno,15,1))) then
                jsoncdsCustom.FieldByName('sex').Value:='��'
              else
                jsoncdsCustom.FieldByName('sex').Value:='Ů';
            end
            else if length(certificateno)=18 then
            begin
              jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint(copy(certificateno,7,4)),
                                                                      strtoint(copy(certificateno,11,2)),
                                                                      strtoint(copy(certificateno,13,2)));
              if odd(strtoint(copy(certificateno,17,1))) then
                jsoncdsCustom.FieldByName('sex').Value:='��'
              else
                jsoncdsCustom.FieldByName('sex').Value:='Ů';
            end;
          end
          else
          begin
            SysDialogs.ShowInfo('"'+FieldValues['customername']+'"'+PIDErrMsg);
            if not (State in [dsEdit,dsInsert]) then
            begin
              edit;
            end;
            EnableControls;
            nvdbgrdhCustomer.SetFocus;
            exit;
          end;
//          try
//            if length(certificateno)=15 then
//            begin
//              jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint('19'+copy(certificateno,7,2)),
//                                                                      strtoint(copy(certificateno,9,2)),
//                                                                      strtoint(copy(certificateno,11,2)));
//              if odd(strtoint(copy(certificateno,15,1))) then
//                jsoncdsCustom.FieldByName('sex').Value:='��'
//              else
//                jsoncdsCustom.FieldByName('sex').Value:='Ů';
//            end
//            else if length(certificateno)=18 then
//            begin
//              jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint(copy(certificateno,7,4)),
//                                                                      strtoint(copy(certificateno,11,2)),
//                                                                      strtoint(copy(certificateno,13,2)));
//              if odd(strtoint(copy(certificateno,17,1))) then
//                jsoncdsCustom.FieldByName('sex').Value:='��'
//              else
//                jsoncdsCustom.FieldByName('sex').Value:='Ů';
//            end
//            else
//            begin
//              SysDialogs.ShowError(FieldValues['customername']+'���֤�Ÿ�ʽ����');
//              if not (State in [dsEdit,dsInsert]) then
//              begin
//                edit;
//              end;
//              EnableControls;
//              exit;
//            end;
//          except on E: Exception do
//            begin
//              SysDialogs.ShowError(FieldValues['customername']+'���֤�Ÿ�ʽ����');
//              if not (State in [dsEdit,dsInsert]) then
//              begin
//                edit;
//              end;
//              EnableControls;
//              exit;
//            end;
//          end;
        end
        else
        begin
          jsoncdsCustom.FieldByName('sex').Value:='��';
          jsoncdsCustom.FieldByName('birthday').Value:=null;
        end;

        jsoncdsCustom.FieldByName('certificatetype').Value:=FieldValues['certificatetype'];
        jsoncdsCustom.FieldByName('certificateno').Value:=FieldValues['certificateno'];
        jsoncdsCustom.FieldByName('education').Value:=FieldValues['education'];
        jsoncdsCustom.FieldByName('familyaddress').Value:=FieldValues['familyaddress'];
        jsoncdsCustom.FieldByName('familyphone').Value:=FieldValues['familyphone'];
        jsoncdsCustom.FieldByName('mobilephone').Value:=FieldValues['mobilephone'];
        jsoncdsCustom.FieldByName('orgid').Value:=SysInfo.LoginUserInfo.OrgID; // jsoncdsInsurance.FieldValues['orgid'];
        jsoncdsCustom.FieldByName('ticketoutletsid').Value:=100301;  //jsoncdsInsurance.FieldValues['ticketoutletsid'];
        jsoncdsCustom.FieldByName('inputway').Value:='0';
        jsoncdsCustom.FieldByName('lastbuytickettime').Value:=now;
        jsoncdsCustom.FieldByName('remarks').Value:=FieldValues['customerremarks'];
        jsoncdsCustom.post;
      end;

      next;
    end;
    EnableControls;
  end;
  if (jsoncdsCustom.Active) and (jsoncdsCustom.RecordCount>0) then
  begin
    with jsoncdsCustom do
    begin
      try
        if (ApplyUpdates(-1) <> 0) then
        begin
          SysDialogs.Warning('����ͻ���Ϣʧ��:δ֪����');
          if not (dsInsuranceBuffer.DataSet.State in [dsEdit,dsInsert]) then
          begin
            dsInsuranceBuffer.DataSet.edit;
          end;
          exit;
        end;
      except on E: Exception do
        begin
          SysDialogs.Warning('����ͻ���Ϣʧ��:'+e.Message);
          if not (dsInsuranceBuffer.DataSet.State in [dsEdit,dsInsert]) then
          begin
            dsInsuranceBuffer.DataSet.edit;
          end;
          exit;
        end;
      end;
      if Params.ParamValues['flag']=1 then
      begin
        //����customerid
        first;
        while not eof do
        begin
          dsInsuranceBuffer.DataSet.DisableControls;
          if (dsInsuranceBuffer.DataSet.Locate('certificatetype;certificateno',
                                  VarArrayOf([FieldValues['certificatetype'],FieldValues['certificateno']]),
                                  [])) then
          begin
            dsInsuranceBuffer.DataSet.edit;
            dsInsuranceBuffer.DataSet.FieldValues['customerid']:=FieldValues['id'];
            dsInsuranceBuffer.DataSet.post;
          end
          else
          begin
            ;
          end;
          result:=true;
          dsInsuranceBuffer.DataSet.EnableControls;
          next;
        end;
      end
      else
      begin
        if Params.ParamByName('msg').IsNull then
        begin
          SysDialogs.Warning('����ͻ���Ϣʧ��:δ֪����');
        end
        else
        begin
          SysDialogs.Warning(Params.ParamValues['msg']);
        end;
        if not (dsInsuranceBuffer.DataSet.State in [dsEdit,dsInsert]) then
        begin
          dsInsuranceBuffer.DataSet.edit;
        end;
        exit;
      end;
    end;
  end
  else if sellnum>0 then
  begin
    result:=true;
  end;
end;

end.

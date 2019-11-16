unit UFrmCustomerAdd;

interface

uses
  Windows, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ComCtrls, StdCtrls, NovaEdit, NovaComboBox,
  ExtCtrls,
  GridsEh, DBGridEh, NvDbgridEh, Buttons,
  uBaseForm, DB, DBClient, jsonClientDataSet, UDMPublic, DBCtrls, Mask,
  dblookup,
  Services, DBGridEhGrouping, ImgList, UIDCardReader;

type
  TFrmCustomerAdd = class(TSimpleEditForm, IIDCardfound)
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
    jcdsquerycustomerbyid: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure dsInsuranceBufferDataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure nvdbgrdhCustomerKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    cansave: boolean;
    { Private declarations }
    procedure setsexinputenable(isIDCard: boolean);
  public
    { Public declarations }
    cdsinsuretype: TjsonClientDataSet;
    setDefaultCustomerOnSellinsure: boolean;
    setDefaultCustomerOnRealsellticket: boolean;
    defaultCustomerID: int64;
    canrealticketsell: boolean;
    canrealticketsell_route  : boolean;
    procedure cardfound(idcard: TIDCard);
  end;

var
  FrmCustomerAdd: TFrmCustomerAdd;

implementation

uses SellTicket, PubFn;
{$R *.dfm}

procedure TFrmCustomerAdd.bbtnSaveClick(Sender: TObject);
var
  certificateno: String;
  firstcustomername, firstcertificateno: String;
  firstdepartdate: String;
  firstschedulecode,firstcertificatetype: String;
  pass: boolean;
  PIDErrMsg: String;
  i, j, k: Integer;
begin
  inherited;
  pass := true;
  jsoncdsCustom.Active := false;
  jsoncdsCustom.Active := true;

  // --begin--一个身份证在同一天只能购买同一班次的一张车票
  if dsInsuranceBuffer.DataSet.RecordCount > 1 then
  begin
    for i := 1 to dsInsuranceBuffer.DataSet.RecordCount - 1 do
    begin
      dsInsuranceBuffer.DataSet.first;
      {
        for k := 1 to i do
        begin
        dsInsuranceBuffer.DataSet.Next;
        end;
        dsInsuranceBuffer.DataSet.Prior; }
      for k := 1 to i - 1 do
      begin
        dsInsuranceBuffer.DataSet.Next;
      end;
      if (dsInsuranceBuffer.DataSet.FieldByName('issell').AsBoolean) and
        ((not canrealticketsell) and (not canrealticketsell_route)) then // 售保险但不实名制售票
      begin
        Break;
      end;
      { if (dsInsuranceBuffer.DataSet.FieldByName('customername').IsNull) or
        (dsInsuranceBuffer.DataSet.FieldByName('certificateno').IsNull) then
        begin
        SysDialogs.ShowInfo('乘客姓名和证件号不能为空!');
        if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
        begin
        dsInsuranceBuffer.DataSet.edit;
        end;
        nvdbgrdhCustomer.SetFocus;
        exit;
        end; }

      if dsInsuranceBuffer.DataSet.FieldByName('certificateno').IsNull or (dsInsuranceBuffer.DataSet.FieldByName('certificateno').AsString='') then
      begin
        SysDialogs.ShowInfo('实名制售票时乘客证件号不能为空!');
        if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
        begin
          dsInsuranceBuffer.DataSet.edit;
        end;
        nvdbgrdhCustomer.SetFocus;
        exit;
      end;

      if getParametervalue('9797', SysInfo.LoginUserInfo.OrgID) = '1' then
      // 实名制售票是否必须输入乘客姓名：0否，1是
      begin
        if dsInsuranceBuffer.DataSet.FieldByName('customername').IsNull  or (dsInsuranceBuffer.DataSet.FieldByName('customername').AsString='') then
        begin
          SysDialogs.ShowInfo('实名制售票时乘客姓名不能为空!');
          if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
          begin
            dsInsuranceBuffer.DataSet.edit;
          end;
          nvdbgrdhCustomer.SetFocus;
          exit;
        end;
      end;
      {
      if dsInsuranceBuffer.DataSet.FieldByName('customername').IsNull then
      begin
         dsInsuranceBuffer.DataSet.FieldValues['customername'] := '旅客';
      end;
      firstcustomername := dsInsuranceBuffer.DataSet.FieldValues
        ['customername']; }
      firstcertificateno := dsInsuranceBuffer.DataSet.FieldValues
        ['certificateno'];
      firstdepartdate := dsInsuranceBuffer.DataSet.FieldValues['departdate'];
      firstschedulecode := dsInsuranceBuffer.DataSet.FieldValues
        ['schedulecode'];
      firstcertificatetype := dsInsuranceBuffer.DataSet.FieldValues
        ['certificatetype'];
      for j := i + 1 to dsInsuranceBuffer.DataSet.RecordCount do
      begin
        dsInsuranceBuffer.DataSet.Next;
        if dsInsuranceBuffer.DataSet.FieldByName('certificateno').IsNull or (dsInsuranceBuffer.DataSet.FieldByName('certificateno').AsString='') then
        begin
          SysDialogs.ShowInfo('实名制售票时乘客证件号不能为空!');
          if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
          begin
            dsInsuranceBuffer.DataSet.edit;
          end;
          nvdbgrdhCustomer.SetFocus;
          exit;
        end;
        if getParametervalue('9797', SysInfo.LoginUserInfo.OrgID) = '1' then
        // 实名制售票是否必须输入乘客姓名：0否，1是
        begin
           if dsInsuranceBuffer.DataSet.FieldByName('customername').IsNull  or (dsInsuranceBuffer.DataSet.FieldByName('customername').AsString='') then
           begin
               SysDialogs.ShowInfo('实名制售票时乘客姓名不能为空!');
               if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
               begin
                  dsInsuranceBuffer.DataSet.edit;
               end;
               nvdbgrdhCustomer.SetFocus;
               exit;
           end;
        end;
        {
        if dsInsuranceBuffer.DataSet.FieldByName('customername').IsNull then
        begin
           dsInsuranceBuffer.DataSet.FieldValues['customername'] := '旅客';
        end; }
        if (firstcertificateno = dsInsuranceBuffer.DataSet.FieldValues
            ['certificateno']) and
          (firstdepartdate = dsInsuranceBuffer.DataSet.FieldValues
            ['departdate']) and
          (firstschedulecode = dsInsuranceBuffer.DataSet.FieldValues
            ['schedulecode']) and
          (firstcertificatetype = dsInsuranceBuffer.DataSet.FieldValues
            ['certificatetype']) then
        begin
          SysDialogs.Warning('同一证件类型相同证件号在同一天只能购买同一班次的一张车票!');
          if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
          begin
            dsInsuranceBuffer.DataSet.edit;
          end;
          nvdbgrdhCustomer.SetFocus;
          exit;
        end;

      end;
      dsInsuranceBuffer.DataSet.Next;
    end;
  end
  else
  begin
   if (canrealticketsell) and (canrealticketsell_route) then // 实名制售票
   begin
    if dsInsuranceBuffer.DataSet.FieldByName('certificateno').IsNull or (dsInsuranceBuffer.DataSet.FieldByName('certificateno').AsString='') then
    begin
      SysDialogs.ShowInfo('实名制售票时乘客证件号不能为空!');
      if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
      begin
        dsInsuranceBuffer.DataSet.edit;
      end;
      nvdbgrdhCustomer.SetFocus;
      exit;
    end;

    if getParametervalue('9797', SysInfo.LoginUserInfo.OrgID) = '1' then
    // 实名制售票是否必须输入乘客姓名：0否，1是
    begin
      if dsInsuranceBuffer.DataSet.FieldByName('customername').IsNull or (dsInsuranceBuffer.DataSet.FieldByName('customername').AsString='') then
      begin
        SysDialogs.ShowInfo('实名制售票时乘客姓名不能为空!');
        if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
        begin
          dsInsuranceBuffer.DataSet.edit;
        end;
        nvdbgrdhCustomer.SetFocus;
        exit;
      end;
    end;
   end;
  end;
  // --end--一个身份证在同一天只能购买同一班次的一张车票

  // 调用批量保存
  with dsInsuranceBuffer.DataSet do // jsoncdsInsurance
  begin
    DisableControls;
    first;
    while not eof do
    begin
      if FieldByName('issell').AsBoolean then // 售保险
      begin
        if getParametervalue('9797', SysInfo.LoginUserInfo.OrgID) = '1' then
       // 售保险时是否必须输入乘客姓名：0否，1是
        begin
          if FieldByName('customername').IsNull or (FieldByName('customername').AsString='') then
          begin
            SysDialogs.ShowInfo('售保险时时乘客姓名不能为空!');
            if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
            begin
              dsInsuranceBuffer.DataSet.edit;
            end;
            EnableControls;
            nvdbgrdhCustomer.SetFocus;
            exit;
          end;
        end;

        if FieldByName('insuretypeid').IsNull  or FieldByName('certificatetype').IsNull or FieldByName('certificateno').IsNull then
        begin
          pass := false;
          SysDialogs.ShowInfo('售保险必需完整填写基础信息!');
          if not(State in [dsEdit, dsInsert]) then
          begin
            edit;
          end;
          EnableControls;
          nvdbgrdhCustomer.SetFocus;
          exit;
        end;
        edit;
        if cdsinsuretype.Locate('id',
          VarArrayOf([FieldValues['insuretypeid']]), []) then
        begin
          FieldValues['premium'] := cdsinsuretype.FieldValues['premium'];
          FieldValues['insureamount'] := cdsinsuretype.FieldValues
            ['MAXINSUREAMOUNT'];
          FieldValues['insurersid'] := cdsinsuretype.FieldValues['insurersid'];
        end;
        post;
      end;
      {if (not FieldByName('customerid').IsNull) and
        (FieldByName('customerid').AsLargeInt > 0) then
      begin // 如果库中已存在该乘客，就不需要再保存
        Next;
        Continue;
      end;}

      jsoncdsCustom.Append;
      jsoncdsCustom.FieldByName('id').Value := 0;
      if FieldByName('customername').IsNull or (FieldByName('customername').AsString='') then //实名制售票时售票员不填写乘客姓名，并且根据身份证号又查不到姓名时
      begin
         jsoncdsCustom.FieldByName('name').Value := '旅客';
      end
      else
      begin
          jsoncdsCustom.FieldByName('name').Value := FieldValues['customername'];
      end;
      if (FieldValues['certificatetype'] = '0') then // 身份证
      begin
          certificateno := FieldValues['certificateno'];
          PIDErrMsg := ValidatePID(certificateno);
          if trim(PIDErrMsg) = '' then
          begin
            if length(certificateno) = 15 then
            begin
              jsoncdsCustom.FieldByName('birthday').Value := EncodeDate
                (strtoint('19' + copy(certificateno, 7, 2)),
                strtoint(copy(certificateno, 9, 2)),
                strtoint(copy(certificateno, 11, 2)));
              if odd(strtoint(copy(certificateno, 15, 1))) then
                jsoncdsCustom.FieldByName('sex').Value := '男'
              else
                jsoncdsCustom.FieldByName('sex').Value := '女';
            end
            else if length(certificateno) = 18 then
            begin
              jsoncdsCustom.FieldByName('birthday').Value := EncodeDate
                (strtoint(copy(certificateno, 7, 4)),
                strtoint(copy(certificateno, 11, 2)),
                strtoint(copy(certificateno, 13, 2)));
              if odd(strtoint(copy(certificateno, 17, 1))) then
                jsoncdsCustom.FieldByName('sex').Value := '男'
              else
                jsoncdsCustom.FieldByName('sex').Value := '女';
            end;
          end
          else
          begin
            if FieldByName('customername').IsNull then
            begin
            SysDialogs.ShowInfo
              ('"' + '旅客' + '"' + PIDErrMsg);
            end
            else
            begin
               SysDialogs.ShowInfo
              ('"' + FieldValues['customername'] + '"' + PIDErrMsg);
            end;
            if not(State in [dsEdit, dsInsert]) then
            begin
              edit;
            end;
            EnableControls;
            nvdbgrdhCustomer.SetFocus;
            exit;
          end;

        // try
        // if length(certificateno)=15 then
        // begin
        // jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint('19'+copy(certificateno,7,2)),
        // strtoint(copy(certificateno,9,2)),
        // strtoint(copy(certificateno,11,2)));
        // if odd(strtoint(copy(certificateno,15,1))) then
        // jsoncdsCustom.FieldByName('sex').Value:='男'
        // else
        // jsoncdsCustom.FieldByName('sex').Value:='女';
        // end
        // else if length(certificateno)=18 then
        // begin
        // jsoncdsCustom.FieldByName('birthday').Value:=EncodeDate(strtoint(copy(certificateno,7,4)),
        // strtoint(copy(certificateno,11,2)),
        // strtoint(copy(certificateno,13,2)));
        // if odd(strtoint(copy(certificateno,17,1))) then
        // jsoncdsCustom.FieldByName('sex').Value:='男'
        // else
        // jsoncdsCustom.FieldByName('sex').Value:='女';
        // end
        // else
        // begin
        // SysDialogs.ShowError('"'+FieldValues['customername']+'"身份证号格式错误');
        // if not (State in [dsEdit,dsInsert]) then
        // begin
        // edit;
        // end;
        // EnableControls;
        // exit;
        // end;
        // except on E: Exception do
        // begin
        // SysDialogs.ShowError('"'+FieldValues['customername']+'"身份证号格式错误');
        // if not (State in [dsEdit,dsInsert]) then
        // begin
        // edit;
        // end;
        // EnableControls;
        // exit;
        // end;
        // end;
      end
      else
      begin
        jsoncdsCustom.FieldByName('sex').Value := '男';
        jsoncdsCustom.FieldByName('birthday').Value := null;
      end;

      jsoncdsCustom.FieldByName('certificatetype').Value := FieldValues
        ['certificatetype'];

      jsoncdsCustom.FieldByName('certificateno').Value := FieldValues['certificateno'];

      jsoncdsCustom.FieldByName('education').Value := FieldValues['education'];
      jsoncdsCustom.FieldByName('familyaddress').Value := FieldValues
        ['familyaddress'];
      jsoncdsCustom.FieldByName('familyphone').Value := FieldValues
        ['familyphone'];
      jsoncdsCustom.FieldByName('mobilephone').Value := FieldValues
        ['mobilephone'];
      jsoncdsCustom.FieldByName('orgid').Value := SysInfo.LoginUserInfo.OrgID;
      jsoncdsCustom.FieldByName('ticketoutletsid').Value :=
        SysInfo.LoginUserInfo.ticketoutletsid;
      jsoncdsCustom.FieldByName('inputway').Value := '0';
      jsoncdsCustom.FieldByName('lastbuytickettime').Value := now;
      jsoncdsCustom.FieldByName('remarks').Value := FieldValues
        ['customerremarks'];
      jsoncdsCustom.post;

      Next;
    end;
    EnableControls;
  end;
  if (not jsoncdsCustom.Active) or (jsoncdsCustom.RecordCount = 0) then
  begin
    self.ModalResult := mrok;
    exit;
  end;

  with jsoncdsCustom do
  begin
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('保存客户信息失败:未知错误！');
        if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
        begin
          dsInsuranceBuffer.DataSet.edit;
        end;
        exit;
      end;
    except
      on E: Exception do
      begin
        SysDialogs.Warning('保存客户信息失败:' + E.Message);
        if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
        begin
          dsInsuranceBuffer.DataSet.edit;
        end;
        exit;
      end;
    end;
    if Params.ParamValues['flag'] = 1 then
    begin
      // 保存customerid
      first;
      while not eof do
      begin
        dsInsuranceBuffer.DataSet.DisableControls;
        if (dsInsuranceBuffer.DataSet.Locate('certificatetype;certificateno',
            VarArrayOf([FieldValues['certificatetype'],
              FieldValues['certificateno']]), [])) then
        begin
          dsInsuranceBuffer.DataSet.edit;
          dsInsuranceBuffer.DataSet.FieldValues['customerid'] := FieldValues
            ['id'];
          dsInsuranceBuffer.DataSet.post;
        end
        else
        begin ;
        end;
        dsInsuranceBuffer.DataSet.EnableControls;
        Next;
      end;
      self.ModalResult := mrok;
    end
    else
    begin
      if Params.ParamByName('msg').IsNull then
      begin
        SysDialogs.Warning('保存客户信息失败:未知错误！');
        if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
        begin
          dsInsuranceBuffer.DataSet.edit;
        end;
        exit;
      end
      else
        SysDialogs.Warning(Params.ParamValues['msg']);
      if not(dsInsuranceBuffer.DataSet.State in [dsEdit, dsInsert]) then
      begin
        dsInsuranceBuffer.DataSet.edit;
      end;
      nvdbgrdhCustomer.SetFocus;
      exit;
    end;
  end;
end;

procedure TFrmCustomerAdd.cardfound(idcard: TIDCard);
var
  curidcard: TIDCard;
  oldOnDataChange: TDataChangeEvent;
begin
  curidcard := idcard;
  if (curidcard <> nil) and Assigned(dsInsuranceBuffer.DataSet)
    and dsInsuranceBuffer.DataSet.Active and
    (dsInsuranceBuffer.DataSet.RecordCount > 0) then
  begin
    // oldOnDataChange:=dsInsuranceBuffer.OnDataChange;
    // dsInsuranceBuffer.OnDataChange:=nil;
    with dsInsuranceBuffer.DataSet do
    begin
      edit;
      FieldValues['certificatetype'] := '0';
      FieldValues['certificateno'] := curidcard.ID;
      FieldValues['familyaddress'] := curidcard.Addr;
      FieldValues['customername'] := curidcard.Name;
      Next;
      if eof then
        first;
    end;
    // dsInsuranceBuffer.OnDataChange:=oldOnDataChange;
  end;
end;

procedure TFrmCustomerAdd.dsInsuranceBufferDataChange(Sender: TObject;
  Field: TField);
var
  exist: boolean;
  oldOnDataChange: TDataChangeEvent;
  check: string;
  count: Integer;
begin
  inherited;
  //注释掉，全部提交到服务端处理
 { exist := false;
  if (Field = nil) then
    exit;
  if (Field.FieldName = 'certificatetype') or
    (Field.FieldName = 'certificateno') then
  begin
    if (not Field.DataSet.FieldByName('certificatetype').IsNull) and
      (not Field.DataSet.FieldByName('certificateno').IsNull) then
    begin
      with jsoncdsquerycustomer do
      begin
        Active := false;
        Params.ParamValues['filter_EQS_c!certificatetype'] :=
          Field.DataSet.FieldValues['certificatetype'];
        Params.ParamValues['filter_EQS_c!certificateno'] :=
          Field.DataSet.FieldValues['certificateno'];
        Active := true;
        if RecordCount = 1 then
        begin
          exist := true;
          oldOnDataChange := (Sender as TDataSource).OnDataChange;
(Sender as TDataSource)
          .OnDataChange := nil;
          Field.DataSet.edit;
          Field.DataSet.FieldValues['customerid'] := FieldValues['id'];
          Field.DataSet.FieldValues['education'] := FieldValues['education'];
          Field.DataSet.FieldValues['familyaddress'] := FieldValues
            ['familyaddress'];
          Field.DataSet.FieldValues['familyphone'] := FieldValues
            ['familyphone'];
          Field.DataSet.FieldValues['mobilephone'] := FieldValues
            ['mobilephone'];
          Field.DataSet.FieldValues['customername'] := FieldValues['name'];
          Field.DataSet.FieldValues['customerremarks'] := FieldValues
            ['remarks'];
          // Field.DataSet.post;
(Sender as TDataSource)
          .OnDataChange := oldOnDataChange;
        end
        else
        begin
          Field.DataSet.edit;
          Field.DataSet.FieldValues['customerid'] := 0;
        end;
      end;
    if (Field.FieldName = 'certificatetype') then
    begin
      setsexinputenable((not Field.DataSet.FieldByName('certificatetype')
            .IsNull) and (Field.DataSet.FieldValues['certificatetype']
            = '0'));
    end;
  end; }
end;

procedure TFrmCustomerAdd.FormCreate(Sender: TObject);
begin
  inherited;
  jsoncdsEducation.Active := true;
  TIDCardReader.GetInstance.addObserver(self, false, true);
end;

procedure TFrmCustomerAdd.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TIDCardReader.GetInstance.removeObserver(self);
  except
  end;
end;

procedure TFrmCustomerAdd.FormShow(Sender: TObject);
var
  oldOnDataChange: TDataChangeEvent;
begin
  inherited;
  if setDefaultCustomerOnSellinsure or setDefaultCustomerOnRealsellticket then
  begin
    jcdsquerycustomerbyid.Active := false;
    jcdsquerycustomerbyid.Params.ParamValues['filter_EQL_c!id'] :=
      defaultCustomerID;
    jcdsquerycustomerbyid.Active := true;
    if jcdsquerycustomerbyid.RecordCount = 1 then
    begin
      oldOnDataChange := dsInsuranceBuffer.OnDataChange;
      dsInsuranceBuffer.OnDataChange := nil;
      with dsInsuranceBuffer.DataSet do
      begin
        first;
        while not eof do
        begin
          edit;
          FieldValues['customerid'] := jcdsquerycustomerbyid.FieldValues['id'];
          FieldValues['certificatetype'] := jcdsquerycustomerbyid.FieldValues
            ['certificatetype'];
          FieldValues['certificateno'] := jcdsquerycustomerbyid.FieldValues
            ['certificateno'];
          FieldValues['education'] := jcdsquerycustomerbyid.FieldValues
            ['education'];
          FieldValues['familyaddress'] := jcdsquerycustomerbyid.FieldValues
            ['familyaddress'];
          FieldValues['familyphone'] := jcdsquerycustomerbyid.FieldValues
            ['familyphone'];
          FieldValues['mobilephone'] := jcdsquerycustomerbyid.FieldValues
            ['mobilephone'];
          FieldValues['customername'] := jcdsquerycustomerbyid.FieldValues
            ['name'];
          FieldValues['customerremarks'] := jcdsquerycustomerbyid.FieldValues
            ['remarks'];
          Next;
        end;
        first;
      end;
      bbtnSave.SetFocus;
      dsInsuranceBuffer.OnDataChange := oldOnDataChange;
    end;
  end;
  // cansave := True;
end;

procedure TFrmCustomerAdd.nvdbgrdhCustomerKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = 13 then
  begin
    bbtnSave.SetFocus;
  end;
end;

procedure TFrmCustomerAdd.setsexinputenable(isIDCard: boolean);
begin
  // rbMan.Enabled:=not isIDCard;
  // rbGrile.Enabled:=not isIDCard;
  // dbehdtedtbirthday.Enabled:=not isIDCard;
end;

end.

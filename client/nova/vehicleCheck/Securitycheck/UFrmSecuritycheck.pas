unit UFrmSecuritycheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NvPrnDbgeh, NvDbgridEh, NovaComboBox, UFrmSecuritycheckEdit, NovaEdit,
  NovaHelp, NovaPrint, Generics.Collections, UICcardRW, NovaCheckedComboBox,
  NovaHComboBox;

type

  TFrmSecurity = class(TSimpleCRUDForm, IBaseCardfound)
    jcdstypename: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResulttype: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultorgname: TWideStringField;
    nn: TWideStringField;
    jcdsResultresult: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultcheckby: TLargeintField;
    jcdsResultorgid: TLargeintField;
    jcdsResulttypename: TWideStringField;
    Label1: TLabel;
    jsonCDSVehInit: TjsonClientDataSet;
    Label2: TLabel;
    Label3: TLabel;
    nvhelpcheckname: TNovaHelp;
    Label4: TLabel;
    jsonCDSUnitInit: TjsonClientDataSet;
    jsonCDSVehicletypeid: TjsonClientDataSet;
    Label8: TLabel;
    Label9: TLabel;
    startdate: TDateTimePicker;
    enddate: TDateTimePicker;
    nvhelpcardno: TNovaHelp;
    jcdsResultlight: TWideStringField;
    jcdsResultmirror: TWideStringField;
    jcdsResultdrive: TWideStringField;
    jcdsResultbrake: TWideStringField;
    jcdsResultturn: TWideStringField;
    jcdsResultwheel: TWideStringField;
    jcdsResulthang: TWideStringField;
    jcdsResultleak: TWideStringField;
    jcdsResultwindow: TWideStringField;
    jcdsResultsafety: TWideStringField;
    nvhelpunitname: TNovaHelp;
    nvhelpvehicleno: TNovaHelp;
    jcdsResultname: TjsonClientDataSet;
    jcdsResultresultname: TWideStringField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultchecktime: TDateTimeField;
    jcdsChickinfo: TjsonClientDataSet;
    Label10: TLabel;
    lbltype: TLabel;
    cbbChecktype: TNovaCheckedComboBox;
    jcdsResultremarks: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    nvcbbResult: TNovaCheckedComboBox;
    jscdAutoCheck: TjsonClientDataSet;
    chkAutoCheck: TCheckBox;
    chkPrint: TCheckBox;
    LabResult: TLabel;
    chkIsCheck: TCheckBox;
    jcdsDeletChecked: TjsonClientDataSet;
    CheckPrintTitle: TCheckBox;
    wdstrngfldResultcamera: TWideStringField;
    wdstrngfldResultreturncheck: TWideStringField;
    jsonShowValidate: TjsonClientDataSet;
    Label5: TLabel;
    EdtNotenum: TEdit;
    jcdsResultnotenum: TWideStringField;
    jcdsResultvehicletypename: TWideStringField;
    jcdsVehicledistance: TjsonClientDataSet;
    jsonVehicleResult: TjsonClientDataSet;
    jsonVehicleResultid: TLargeintField;
    jsonVehicleResultunitname: TWideStringField;
    jsonVehicleResultvehicletypename: TWideStringField;
    wdstrngfldVehicleResultcardno: TWideStringField;
    wdstrngfldVehicleResultvehicleno: TWideStringField;
    cbborg: TNovaHComboBox;
    jcdsResultdrivername: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    // procedure tbtnPrinterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhelpcardnoChange(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure startdateChange(Sender: TObject);
  private
    { Private declarations }
    sysday: Integer;
    distancemessage: string;
    checkprint: TNovaPrint;
    checktitle: TNovaPrint;
    printValue: TDictionary<String, String>; // �������
    titleValue: TDictionary<String, String>; // ���������
    procedure qrySecureitycheck(id: int64);
    procedure iccardfound(icCard: TBaseCard);
  public
    { Public declarations }
    curid: int64;
    procedure printCheckinfo(id: int64);
    procedure HandleAuthority(const Key: TGUID; aEnable: boolean); override;
  end;

var
  FrmSecurity: TFrmSecurity;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmSecurity.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;

  // ��ʾ�û���ǰ��¼�Ŀ�
  cbborg.SetItemIndexByField('id', sysinfo.LoginUserInfo.OrgID);
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;
  setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,
    sysinfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, sysinfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    sysinfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, sysinfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, sysinfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    sysinfo.curBillLength.Items['Unit']);
end;

procedure TFrmSecurity.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmSecurity.FormShow(Sender: TObject);
begin
  inherited;
  startdate.Date := Now;
  enddate.Date := Now;

  // cbbvehicletypeid.Active:= false;
  // cbbvehicletypeid.Active:= true;

  cbbChecktype.Active := False;
  cbbChecktype.Active := True;
  nvcbbResult.Active := False;
  nvcbbResult.Active := True;
  // 6013�Ƿ�Ĭ�ϴ�ӡ����֪ͨ����0����ӡ��1��ӡ֪ͨ��
  if getParametervalue('6013', sysinfo.LoginUserInfo.OrgID) = '1' then
  begin
    chkPrint.Checked := True;
  end;
  sysday := StrToInt(getParametervalue('0006', sysinfo.LoginUserInfo.OrgID));
  // cbbChecktype.SetCheck(0,true);
  // cbbChecktype.SetCheck(1,true);
  // cbbChecktype.SetCheck(2,true);
  // cbbChecktype.SetCheck(3,true);
end;

procedure TFrmSecurity.HandleAuthority(const Key: TGUID; aEnable: boolean);
begin
  inherited;
  if GUIDToString(Key) = '{4A8E7A91-1BA2-469A-AAFB-9D966264AABB}' then
  begin
    chkAutoCheck.Enabled := aEnable;
  end;
end;

procedure TFrmSecurity.iccardfound(icCard: TBaseCard);
begin
  nvhelpcardno.SetFocus;
  if Integer(icCard.cardtype) <> 0 then
  begin
    ShowMessage('�ÿ����Ǳ��������������ڰ��죡');
  end
  else
    nvhelpcardno.Text := icCard.cardNo;
end;

procedure TFrmSecurity.nvhelpcardnoChange(Sender: TObject);
var
  flag, nResult, temp: Integer;
  msg, cardnos, sResult, maintenance: string;
  vehicleid: int64;
begin
  inherited;
  // ���࿨��������ϣ���ʹ�ÿ��Ž��а��죬����ֻ����ѯ����
  if chkIsCheck.Checked then
  begin
    if length(nvhelpcardno.Text) = sysinfo.curBillLength.Items['Vehicle'] then
    begin
      // �Զ����氲���¼
      if chkAutoCheck.Checked then
      begin
        // ��������ʱ�ж���ʻ֤�����յĽ�ֹ���ڣ�0����1����
        if getParametervalue('6002', sysinfo.LoginUserInfo.OrgID) = '1' then
        begin
          //
          with jsonShowValidate do
          begin
            Close;
            Params.ParamValues['cardno'] := nvhelpcardno.Text;
            Params.ParamValues['orgid'] := sysinfo.LoginUserInfo.OrgID;
            Execute;
            flag := Params.ParamByName('flag').Value;
            if flag < 0 then
            begin
              msg := Params.ParamByName('msg').Value;
              SysDialogs.Warning(msg);
            end;
          end;
        end;
        with jsonVehicleResult do
        begin
          Active := False;
          Params.ParamByName('filter_EQS_v!cardno').Value := nvhelpcardno.Text;
          Active := True;
        end;
        if (not jsonVehicleResult.Active) and
          (jsonVehicleResult.RecordCount = 0) then
        begin
          SysDialogs.Warning('�����ڸÿ��Ŷ�Ӧ�ĳ�����Ϣ��');
          Exit;
        end
        else
        begin
          vehicleid := jsonVehicleResult.FieldByName('id').AsInteger;
        end;
        distancemessage := '';
        // �Ƿ��������������
        if getParametervalue('0143', sysinfo.LoginUserInfo.OrgID) = '1' then
        begin
          // ��ѯ������̼������ȡ����������������Ƶ������
          with jcdsVehicledistance do
          begin
            Close;
            Params.ParamValues['vehicleid'] := vehicleid;
            Params.ParamValues['iscomparedate'] := 'false';
            Execute;
            nResult := Params.ParamByName('flag').Value;
            if (nResult <= 0) then
            begin
              sResult := Params.ParamByName('msg').Value;
              //
              temp := Pos('�ó�������', sResult);
              if temp > 0 then
                distancemessage := sResult
              else
              begin
                SysDialogs.Warning(sResult);
                Exit;
              end;
            end;
          end;
        end;
        // �Ƿ�����������ά����Ч��
        if getParametervalue('6006', sysinfo.LoginUserInfo.OrgID) = '1' then
        begin
          // ��ѯ������̼������ȡ����ά��Ч��
          with jcdsVehicledistance do
          begin
            Close;
            Params.ParamValues['vehicleid'] := vehicleid;
            Params.ParamValues['iscomparedate'] := 'true';
            Execute;
            nResult := Params.ParamByName('flag').Value;
            if (nResult <= 0) then
            begin
              sResult := Params.ParamByName('msg').Value;
              temp := Pos('�ó�������', sResult);
              if temp > 0 then
              begin
                if distancemessage <> '' then
                begin
                  sResult := Copy(sResult, 4);
                  distancemessage := distancemessage + ',' + sResult;
                end
                else
                  distancemessage := sResult;
              end
              else
              begin
                SysDialogs.Warning(sResult);
                Exit;
              end;
            end;

          end;
        end;
        if distancemessage <> '' then
        begin
          LabResult.Caption := distancemessage + ',�ﵽ��ά���ޣ�';
          LabResult.Refresh;
        end;
        // SysDialogs.ShowInfo(distancemessage + ',�ﵽ��ά���ޣ�');

        maintenance := maintenance + distancemessage + #13;

        // �Ƿ����֤���ж�
        if getParametervalue('6002', sysinfo.LoginUserInfo.OrgID) = '1' then
        begin
          //
          with jsonShowValidate do
          begin
            Close;
            Params.ParamValues['vehicleid'] := vehicleid;
            Params.ParamValues['orgid'] := sysinfo.LoginUserInfo.OrgID;
            Execute;
            nResult := Params.ParamByName('flag').Value;
            if nResult < 0 then
            begin
              sResult := Params.ParamByName('msg').Value;
              SysDialogs.Warning(sResult);
              maintenance := maintenance + sResult + #13;
            end;
          end;
        end;

        with jscdAutoCheck do
        begin
          Active := False;
          Params.ParamValues['cardno'] := nvhelpcardno.Text;
          Params.ParamValues['isautosave'] := True;
          Execute;
          flag := Params.ParamValues['flag'];
          msg := Params.ParamValues['msg'];
          Self.LabResult.Caption := msg;
          if flag = 1 then
          begin
            curid := Params.ParamValues['checkid'];
            if chkPrint.Checked then
            begin
              // ��ӡ
              printCheckinfo(curid);
            end;
            nvhelpcardno.Clear;
            qrySecureitycheck(curid);
            Self.jcdsResult.Locate('id', curid, []);
          end
          else
          begin
            nvhelpcardno.SetFocus;
          end;
        end;
      end
      else
      begin
        with jscdAutoCheck do
        begin
          Active := False;
          Params.ParamValues['cardno'] := nvhelpcardno.Text;
          Params.ParamValues['isautosave'] := False;
          Execute;
          flag := Params.ParamValues['flag'];
          msg := Params.ParamValues['msg'];
          Self.LabResult.Caption := msg;
          cardnos := nvhelpcardno.Text;
          nvhelpcardno.Clear;
          if flag = 1 then
          begin
            LabResult.Caption := '';
            FrmSecuritycheckEdit := TFrmSecuritycheckEdit.Create(Self);
            try
              with FrmSecuritycheckEdit do
              begin
                Caption := '��ӳ���������Ϣ';
                // edtcard.Text := cardnos;
                vehicleid := jscdAutoCheck.Params.ParamValues['checkid'];
                if chkAutoCheck.Checked then
                begin
                  nvhelpcheckname.Text := sysinfo.LoginUserInfo.UserName;
                  nvhelpcheckname.id := sysinfo.LoginUserInfo.UserID;
                end;
                isprintcheck := chkPrint.Checked;
                isprinttitle := CheckPrintTitle.Checked;
                // isSelfWrite := True;
                if SysMainForm.showFormModal(FrmSecuritycheckEdit, False)
                  = mrok then
                begin
                  // tbtnFilterClick(Sender);
                  qrySecureitycheck(id);
                  // jcdsResult.Locate('id', id, []);
                end;

              end;
            finally
              FreeAndNil(FrmSecuritycheckEdit);
            end;
          end
          else
          begin
            LabResult.Caption := msg;
            nvhelpcardno.SetFocus;
          end;
        end;
      end;
    end;
  end;
end;

procedure TFrmSecurity.printCheckinfo(id: int64);
begin
  with jcdsChickinfo do
  begin
    Active := False;
    Params.ParamByName('checkid').Value := id;
    Active := True;
    if RecordCount > 0 then
    begin
      if chkPrint.Checked then
      begin
        if not Assigned(checkprint) then
          checkprint := TNovaPrint.Create(Self,
            TNovaPrint.GetTicketModelName('����ϸ�֪ͨ��', '����ϸ�֪ͨ��'));
        if not Assigned(printValue) then
          printValue := TDictionary<String, String>.Create
        else
          printValue.Clear;
        printValue.Add('checkorg', FieldByName('checkorg').AsString);
        printValue.Add('checker', FieldByName('checker').AsString);
        printValue.Add('checkercode', FieldByName('checkercode').AsString);
        printValue.Add('checktime', FieldByName('checktime').AsString);
        printValue.Add('vehicleno', FieldByName('vehicleno').AsString);
        printValue.Add('color', FieldByName('color').AsString);
        printValue.Add('notenum', FieldByName('notenum').AsString);
        printValue.Add('idcard', FieldByName('idcard').AsString);
        printValue.Add('routename', FieldByName('routename').AsString);
        printValue.Add('vehicletypename', FieldByName('vehicletypename').Value);
        if distancemessage <> '' then
          printValue.Add('maintainmessage', distancemessage + '�ﵽ��ά���ޣ�');
        checkprint.SingleValue := printValue;
        checkprint.Print;
      end;
      if CheckPrintTitle.Checked then
      begin
        if not Assigned(checktitle) then
          checktitle := TNovaPrint.Create(Self,
            TNovaPrint.GetTicketModelName('����ϸ��ǩ', '����ϸ��ǩ'));
        if not Assigned(titleValue) then
          titleValue := TDictionary<String, String>.Create
        else
          titleValue.Clear;
        titleValue.Add('checkorg', FieldByName('checkorg').AsString);
        titleValue.Add('checker', FieldByName('checker').AsString);
        titleValue.Add('checkercode', FieldByName('checkercode').AsString);
        titleValue.Add('checktime', FieldByName('checktime').AsString);
        titleValue.Add('vehicleno', FieldByName('vehicleno').AsString);
        titleValue.Add('color', FieldByName('color').AsString);
        titleValue.Add('idcard', FieldByName('idcard').AsString);
        titleValue.Add('notenum', FieldByName('notenum').AsString);
        titleValue.Add('routename', FieldByName('routename').AsString);
        checktitle.SingleValue := titleValue;
        checktitle.Print;
      end;

    end;
  end;
end;

procedure TFrmSecurity.qrySecureitycheck(id: int64);
var
  inter: Integer;
begin
  inter := Trunc(enddate.Date - startdate.Date);
  if (sysday < inter) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    Exit;
  end;
  if (Trim(nvhelpvehicleno.Text) = '') and (Trim(EdtNotenum.Text) = '') then
  begin
    // if formatdatetime('yyyy-mm-dd', startdate.DateTime) <> formatdatetime
    // ('yyyy-mm-dd', enddate.DateTime) then
    if (enddate.DateTime - startdate.DateTime) > 31 then
    begin
      SysDialogs.ShowMessage('��û�����복�ƺŻ򰲼쵥�ŵ�����£���ֻ�ܲ�ѯһ������ݣ�');
      Exit;
    end;
  end;
  if enddate.DateTime < startdate.DateTime then
  begin
    SysDialogs.ShowMessage('�������ڲ���С�ڿ�ʼ���ڣ�');
    Exit;
  end;

  with jcdsResult do
  begin
    Active := False;
    if id > 0 then
      Params.ParamValues['filter_EQL_t!id'] := id
    else
      Params.ParamValues['filter_EQL_t!id'] := null;
    if (Trim(nvhelpvehicleno.Text) = '') then
    begin
      Params.ParamValues['filter_LIKES_v!vehicleno'] := '';
    end
    else
    begin
      Params.ParamValues['filter_LIKES_v!vehicleno'] := Trim
        (nvhelpvehicleno.Text);
    end;
    if Trim(nvcbbResult.Text) = '' then
    begin
      Params.ParamValues['filter_INS_t!result'] := null;
    end
    else
    begin
      Params.ParamValues['filter_INS_t!result'] := nvcbbResult.GetSelectID;
    end;
    if Trim(nvhelpunitname.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_v!unitid'] := nvhelpunitname.id;
    end;
    if (Trim(nvhelpcheckname.Text) = '') then
    begin
      Params.ParamValues['filter_EQL_t!checkby'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_t!checkby'] := nvhelpcheckname.id;
    end;
    if cbborg.ItemIndex >= 0 then
      Params.ParamValues['filter_EQS_us!orgid'] := cbborg.HelpFieldValue['id']
    else
      Params.ParamValues['filter_EQS_us!orgid'] := sysinfo.LoginUserInfo.OrgID;
    if Trim(cbbChecktype.Text) = '' then
      Params.ParamByName('filter_INS_v!type').Value := null
    else
      Params.ParamByName('filter_INS_v!type').Value := cbbChecktype.GetSelectID;

    // Params.ParamValues['filter_LIKES_t!notenum'] := trim(nvhelpnotenum.Text);
    Params.ParamValues['filter_LIKES_v!cardno'] := Trim(nvhelpcardno.Text);
    if Trim(EdtNotenum.Text) <> '' then
      Params.ParamValues['filter_LIKES_t!notenum'] := Trim(EdtNotenum.Text)
    else
      Params.ParamValues['filter_LIKES_t!notenum'] := '';

    Params.ParamValues['filter_GED_t!checktime'] := formatdatetime
      ('yyyy-mm-dd', startdate.DateTime) + ' 00:00:00';
    Params.ParamValues['filter_LED_t!checktime'] := formatdatetime
      ('yyyy-mm-dd', enddate.DateTime) + ' 23:59:59';
    Active := True;
  end;
end;

procedure TFrmSecurity.startdateChange(Sender: TObject);
begin
  inherited;
  if Trunc(startdate.Date) > Trunc(enddate.Date) then
  begin
    enddate.Date := startdate.Date;
  end;

end;

procedure TFrmSecurity.tbtnDeleteClick(Sender: TObject);
var
  log, sResult, nResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;

  if getParametervalue('6001', SysInfo.LoginUserInfo.OrgID) = '0' then
  begin
    SysDialogs.ShowMessage('����6001����Ϊ0��������ע����');
    exit;
  end;

  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫע���ð��쵥��?') then
    Exit;
  with jcdsDeletChecked do
    try
      Close;
      log := 'ע������������Ϣ������ʱ��' + jcdsResult.FieldByName('checktime')
        .AsString + ',������' + jcdsResult.FieldByName('resultname')
        .AsString + ',���ƺ�=' + jcdsResult.FieldByName('vehicleno')
        .AsString + ',������λ=' + jcdsResult.FieldByName('unitname')
        .AsString + ',��·=' + jcdsResult.FieldByName('routename')
        .AsString + ',����Ա=' + jcdsResult.FieldByName('checkname')
        .AsString + ',���쳵վ=' + jcdsResult.FieldByName('orgname').AsString;
      Params.ParamByName('checkid').Value := jcdsResult.FieldByName('id')
        .AsInteger;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = '1') then
      begin
        SysLog.WriteLog('ע������������Ϣ', 'ע��', log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('ע������������Ϣʧ�ܣ�' + E.Message);
      end;
    end;
end;

procedure TFrmSecurity.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  curid := 0;
  qrySecureitycheck(0);

end;

procedure TFrmSecurity.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  try
    with FrmSecuritycheckEdit do
    begin
      FrmSecuritycheckEdit := TFrmSecuritycheckEdit.Create(Self);
      Caption := '��ӳ���������Ϣ';
      if chkAutoCheck.Checked then
      begin
        nvhelpcheckname.Text := sysinfo.LoginUserInfo.UserName;
        nvhelpcheckname.id := sysinfo.LoginUserInfo.UserID;
      end;
      isprintcheck := chkPrint.Checked;
      isprinttitle := CheckPrintTitle.Checked;
      // createby := jcdsResult.FieldByName('createby').AsInteger;
      // createtime := jcdsResult.FieldByName('createtime').AsDateTime;
      // sign:=true;
      // isSelfWrite := False;//�򿪰��촰�ڣ����ﲻ���Զ�д�뱨����
      ShowModal;
      if ModalResult = mrok then
      begin
        qrySecureitycheck(0);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  except
      on E: Exception do
      begin
        SysLog.WriteErr('����������Ϣʧ�ܣ�' + E.Message);
      end;
  end;

end;

// procedure TFrmSecurity.tbtnPrinterClick(Sender: TObject);
// var checktime : string;
// begin
// inherited;
// if not dsResult.DataSet.Active then
// Exit;
// if dsResult.DataSet.RecordCount < 0 then
// Exit;
// printCheckinfo(jcdsResult.fieldbyname('id').AsLargeInt);
//
// end;

end.

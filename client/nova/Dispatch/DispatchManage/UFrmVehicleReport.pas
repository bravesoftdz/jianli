unit UFrmVehicleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh,
  ComCtrls, StdCtrls, NovaHComboBox, NovaHelp, NovaEdit, Mask, DBCtrlsEh,
  Buttons, ExtCtrls, DB, DBClient, jsonClientDataSet, DateUtils, ImgList,
  UICcardRW,Dispatch, OleCtrls, ZKFPEngXControl_TLB;

type
  TFrmVehicleReport = class(TSimpleEditForm, IBaseCardfound)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl12: TLabel;
    nvedtbdcard: TNovaEdit;
    chktempvehicle: TCheckBox;
    pgc1: TPageControl;
    tstpbcbd: TTabSheet;
    grp3: TGroupBox;
    nvdbgrdhregisterrecord: TNvDbgridEh;
    tsdistpbcbd: TTabSheet;
    grp5: TGroupBox;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    lbl20: TLabel;
    NvEdtRoute: TNovaEdit;
    nvedtcode: TNovaEdit;
    nvedttickettype: TNovaEdit;
    nvedDeparttime: TNovaEdit;
    nvedtSeatnum: TNovaEdit;
    nvedtSoldeatnum: TNovaEdit;
    nvedtylNum: TNovaEdit;
    nvedtyzNum: TNovaEdit;
    DpDepartDate: TDateTimePicker;
    NovaHReprotSchedule: TNovaHelp;
    NovaHelpVehicleno: TNovaHelp;
    NovaHUnit: TNovaHelp;
    RgReprotResult: TRadioGroup;
    jcdsQryDriver: TjsonClientDataSet;
    BitBtn1: TBitBtn;
    NovaHelpVehicletype: TNovaHelp;
    Label1: TLabel;
    jcdsQryvehiclepeopleplans: TjsonClientDataSet;
    DsVehiclepeople: TDataSource;
    jscdIsLater: TjsonClientDataSet;
    grp4: TGroupBox;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl10: TLabel;
    nvhlpdriver: TNovaHelp;
    NovaHelpcopilot1: TNovaHelp;
    NovaHelpsteward: TNovaHelp;
    jcsdQryVehiclecheck: TjsonClientDataSet;
    cbbCheckResult: TComboBox;
    lbl21: TLabel;
    mmoCheckResult: TMemo;
    Label2: TLabel;
    NovaHelpBalanceUnit: TNovaHelp;
    jsonShowValidate: TjsonClientDataSet;
    jcdsqryDriverbycardno: TjsonClientDataSet;
    bbtnAddtempVehi: TBitBtn;
    jcsdQryTempVehi: TjsonClientDataSet;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    Edtliabilityinsureenddate: TEdit;
    Label4: TLabel;
    Edtlicenseenddate: TEdit;
    Label5: TLabel;
    Edtworkenddate: TEdit;
    Label6: TLabel;
    Edtworkno: TEdit;
    LabInfo: TLabel;
    Label9: TLabel;
    Editqualificationenddate: TEdit;
    Label12: TLabel;
    Edit1: TEdit;
    Label7: TLabel;
    Edtdrivinglicenseenddate: TEdit;
    Label11: TLabel;
    Editqualificationenddate1: TEdit;
    Label13: TLabel;
    Edtworkenddate1: TEdit;
    Label10: TLabel;
    Edtdrivinglicenseenddate1: TEdit;
    NovaHelpcopilot2: TNovaHelp;
    Chkdqualificationres: TCheckBox;
    Chkdworknores: TCheckBox;
    Chkddrivinglicenseres: TCheckBox;
    chkdqualificationres2: TCheckBox;
    Chkdworknores2: TCheckBox;
    Chkddrivinglicenseres2: TCheckBox;
    nvedtSeatnumhid: TNovaEdit;
    Scheduleplanidhid: TNovaEdit;
    jcdsVehicleDriver: TjsonClientDataSet;
    lbl8: TLabel;
    lbl9: TLabel;
    NovaHelpcopilot3: TNovaHelp;
    lbl11: TLabel;
    edtcompulsoryinsureenddate: TEdit;
    jsonShowValidatecardName: TWideStringField;
    jsonShowValidatecardNo: TWideStringField;
    jsonShowValidateendate: TDateField;
    jsonShowValidatedays: TLargeintField;

    jscdSpcQry: TjsonClientDataSet;
    jsnclQrydriverByDriverid: TjsonClientDataSet;
    jsncQryStewardName: TjsonClientDataSet;
    jscdExamineCheck: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpVehiclenoIdChange(Sender: TObject);
    procedure pnlOperationResize(Sender: TObject);
    procedure NovaHReprotScheduleIdChange(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure nvdbgrdhregisterrecordDblClick(Sender: TObject);
    procedure chktempvehicleClick(Sender: TObject);
    procedure DpDepartDateExit(Sender: TObject);
    procedure DpDepartDateChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure NovaHReprotScheduleKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtbdcardChange(Sender: TObject);
    procedure NovaHelpVehicletypeIdChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure nvhlpdriverIdChange(Sender: TObject);
    procedure bbtnAddtempVehiClick(Sender: TObject);
    procedure NovaHelpcopilot1IdChange(Sender: TObject);
//    procedure nvedtylNumChange(Sender: TObject);
    procedure nvedtylNumKeyPress(Sender: TObject; var Key: Char);
    procedure nvedtylNumExit(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure jcdsQryvehiclepeopleplansAfterScroll(DataSet: TDataSet);
    procedure zkfpngxReportCapture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);

  private
    { Private declarations }
    zkfpngxReport: TZKFPEngX;
    isVehicleEmployee: boolean; // �����Ƿ����һ��Ҫ��ʻԱ
    ischangebyVehicle: boolean;
    msg: string;
    orderno:string;
    fpcHandle: Integer;
    initsuccess:boolean;
    isNovaHelpVehiclenoKeyPress: boolean;
    ischangebyschedule: boolean;
    ischangebyDepartdate: boolean;
    seatnum: integer; // ������λ��
    function checkReportInfo(): boolean;
    procedure clearReprotinfo();
    procedure qryScheduleplanInfo();
    procedure vehiclereport(flag: integer); // 0:����,1:��������
    procedure clearNotScheduleplan();

    procedure iccardfound(icCard: TBaseCard);
    procedure finddriverbycardno(cardno: string);
  public
    { Public declarations }
    //curQryFingerInfo:TjsonClientDataSet;
    scheduleEmployees: integer; // ��μ�ʻԱ����
    scheduleplanid, createby, reportorgid, curstationid, routedistance: Int64;
    isMustCheck: boolean; // �Ƿ���밲��
    distancemessage: string;
    curisfinger:boolean;
    temp: integer;
    planvehicleid : Integer; //�ƻ�����id
    isTempVehicle:boolean;
    // ��ȡ����������Ϣ
    function checkVehicles(vehicleid: Int64; departdate: string): boolean;
  end;

var
  FrmVehicleReport: TFrmVehicleReport;

implementation

uses PubFn, Services, UFrmVehicleLater, UDMPublic, UFrmAddTempVehi,
  UFrmCardValidate;
{$R *.dfm}

procedure TFrmVehicleReport.bbtnAddtempVehiClick(Sender: TObject);
begin
  inherited;
  try
    FrmAddTempVehi := TFrmAddTempVehi.Create(self);
    with FrmAddTempVehi do
    begin
      Caption := '�����ʱ������Ϣ';
      if SysMainForm.showFormModal(FrmAddTempVehi, false) = mrok then
      begin
        with jcsdQryTempVehi do
        begin
          Active := false;
          Params.ParamValues['vehicleid'] := FrmAddTempVehi.tempvehicleid;
          Active := True;
          NovaHelpVehicleno.Text := FieldByName('name').AsString;
          NovaHelpVehicleno.HelpFieldValue['unitname'] := FieldByName
            ('unitname').AsString;
          NovaHelpVehicleno.HelpFieldValue['unitid'] := FieldByName('unitid')
            .AsInteger;
          NovaHelpVehicleno.HelpFieldValue['vehicletypename'] := FieldByName
            ('vehicletypename').AsString;
          NovaHelpVehicleno.HelpFieldValue['vehicletypeid'] := FieldByName
            ('vehicletypeid').AsInteger;
          NovaHelpVehicleno.HelpFieldValue['seatnum'] := FieldByName('seatnum')
            .AsInteger;
          NovaHelpVehicleno.HelpFieldValue['balancename'] := FieldByName
            ('balancename').AsString;
          NovaHelpVehicleno.HelpFieldValue['balanceunitid'] := FieldByName
            ('balanceunitid').AsInteger;
          NovaHelpVehicleno.HelpFieldValue['isneedfinger'] := FieldByName
            ('isneedfinger').AsBoolean;
          NovaHelpVehicleno.HelpFieldValue['brandid'] := FieldByName('brandid')
            .AsInteger;
          NovaHelpVehicleno.HelpFieldValue['brandname'] := FieldByName
            ('brandname').AsString;
          NovaHelpVehicleno.Id := FrmAddTempVehi.tempvehicleid;

          isTempVehicle:=true;
        end;

      end;
    end;
  finally
    FreeAndNil(FrmAddTempVehi);
  end;
end;

procedure TFrmVehicleReport.bbtnSaveClick(Sender: TObject);
begin
  vehiclereport(0);
end;

procedure TFrmVehicleReport.vehiclereport(flag: integer);
var
  maintainvaliddate: TDate;
  nResult, curseats, busseats, limitdistance, departdistance, messagedistance,
    messagedate, driverid, driver1id, driver2id, driver3id,
    controdistance: integer;
  sResult, reason, log, showmessage, isGPScheck, validatetype: string;
  checkresult: boolean;
begin
  inherited;
  if (nvhlpdriver.Id > 0) and (NovaHelpcopilot1.Id=nvhlpdriver.Id) then
  begin
    SysDialogs.ShowMessage('������ʻԱ������ͬһ����!');
    NovaHelpcopilot1.SetFocus;
    Exit;
  end;
  if checkReportInfo then
  begin
    SysDialogs.Warning(msg);
    exit;
  end;

  // checkresult := checkVehicle(NovaHelpVehicleno.Id,
  // FormatDateTime('yyyy-mm-dd', DpDepartDate.Date));
  if (isMustCheck) and (not isTempVehicle) then //��ʱ�������ж�
  begin
    if (cbbCheckResult.ItemIndex = -1) or (cbbCheckResult.ItemIndex = 0) then
    begin
      SysDialogs.Warning('�ó�����δ���а��죬����������');
      NovaHelpVehicleno.SetFocus;
      exit;
    end
    else if cbbCheckResult.ItemIndex = 2 then
    begin
      SysDialogs.Warning('�ó������첻�ϸ񣬲���������');
      NovaHelpVehicleno.SetFocus;
      exit;
    end
  end;


  // �Ƿ����֤���˲��ж�  ���ֶ�����
  if vehReport.p0030 = '1' then
  begin
     with jscdExamineCheck do
     begin
        Close;
        Params.ParamValues['vehicleid'] := NovaHelpVehicleno.Id;
        if nvhlpdriver.Id>0 then
          params.ParamValues['driverid'] := nvhlpdriver.Id
        else
        begin
          SysDialogs.ShowMessage('��¼������ʻ��');
          exit;
        end;
        if NovaHelpcopilot1.Id>=0 then
          params.ParamValues['driver1id']:=NovaHelpcopilot1.Id
        else
          params.ParamValues['driver1id']:='';
        if NovaHelpsteward.Id>0 then
          params.ParamValues['stewardid']:=NovaHelpsteward.Id
        else
        begin
          SysDialogs.ShowMessage('��¼�����Ա��');
          exit;
        end;
        params.ParamValues['departdate']:=FormatDateTime
                              ('yyyy-mm-dd', DpDepartDate.DateTime);
        Params.ParamValues['orgid'] := sysInfo.LoginUserInfo.OrgID;
        try
          Execute;
          nResult := Params.ParamByName('flag').Value;
          sResult := Params.ParamByName('msg').Value;
          if (nResult <= 0) then
          begin
            SysDialogs.ShowMessage(sResult);
            exit;
          end;
        except on e:Exception do
          SysDialogs.ShowMessage(e.Message);
        end;
     end;
  end;


  // �Ƿ����֤���ж�
  if vehReport.p6002 = '1' then
  begin
    //
    with jsonShowValidate do
    begin
      Close;
      Params.ParamValues['vehicleid'] := NovaHelpVehicleno.Id;
      params.ParamValues['driverid'] := nvhlpdriver.Id;
      params.ParamValues['driverid1']:=NovaHelpcopilot1.Id;
      Params.ParamValues['orgid'] := sysInfo.LoginUserInfo.OrgID;
      try
          active:=True;
          if jsonShowValidate.RecordCount>1 then
          begin
              FrmCardValidate:=TFrmCardValidate.Create(self);
              with FrmCardValidate do
              begin
                jcdsCercate.Close;
                jcdsCercate.CreateDataSet;
                jcdsCercate.Open;
                jsonShowValidate.First;
                jsonShowValidate.Next;
                while not jsonShowValidate.Eof do
                begin
                    try
                      jcdsCercate.Append;
                      jcdsCercate.FieldValues['cardName']:=jsonShowValidate.FieldValues['cardName'];
                      jcdsCercate.FieldValues['cardNo']:=jsonShowValidate.FieldValues['cardNo'];
                      jcdsCercate.FieldValues['endate']:=jsonShowValidate.FieldValues['endate'];
                      jcdsCercate.FieldValues['days']:=jsonShowValidate.FieldValues['days'];
                      jcdsCercate.Post;
                      jsonShowValidate.Next;
                    except on e:Exception do
                      SysDialogs.ShowMessage(e.Message);
                    end;
                end;
                ShowModal;
              end;
          end;
      except on e:Exception do
          SysDialogs.ShowMessage(e.Message);
      end;
    end;
  end;
  // 2026:�Ƿ���������ʻԱ���ܱ���
  if (isVehicleEmployee) or (scheduleEmployees > 0) then
  begin
    SysDialogs.Warning('�ð���Ѱ󶨼�ʻԱ��Ϣ,��ʹ��ָ�Ʊ���ϵͳ���б��࣡');
    NovaHReprotSchedule.SetFocus;
    exit;
  end
  else if (vehReport.p2026 = '1') then
  begin

    // 2023:����˾������·��̶���
    controdistance := strtoint(vehReport.p2023);
    if routedistance >= controdistance then
    begin
      if (nvhlpdriver.Id <= 0) and (trim(nvhlpdriver.Text) = '') then
      begin
        SysDialogs.Warning('����������ʻ��Ϣ��');
        nvhlpdriver.SetFocus;
        exit;
      end;
      if (NovaHelpcopilot1.Id <= 0) and (trim(NovaHelpcopilot1.Text) = '') then
      begin
        SysDialogs.Warning('����·��̳�������2023���õ�'+inttostr(controdistance)+
        '����,���뱨��������ʻԱ,�����븱��ʻ1����Ϣ!');
        NovaHelpcopilot1.SetFocus;
        exit;
      end;
      if nvhlpdriver.Id = NovaHelpcopilot1.Id then
      begin
        SysDialogs.Warning('������ʻԱ������ͬһ��');
        NovaHelpcopilot1.SetFocus;
        exit;
      end;
    end
    else
    begin
      if (nvhlpdriver.Id <= 0) or (trim(nvhlpdriver.Text) = '') then
      begin
        SysDialogs.Warning('�������ʻԱ��Ϣ��');
        nvhlpdriver.SetFocus;
        exit;
      end;
    end;
  end;

  if FormatDateTime('yyyymmdd', DpDepartDate.DateTime) <> FormatDateTime
    ('yyyymmdd', now) then
  begin
    if not SysDialogs.Confirm('������ʾ',
      '�ó������ķ���������' + FormatDateTime('yyyy-mm-dd',
        DpDepartDate.DateTime) + '�İ�Σ��Ƿ������') then
    begin
      exit;
    end;
  end;

  if pgc1.ActivePageIndex = 0 then
  begin
    if (NovaHelpVehicleno.Id > 0) then
    begin
      curseats := strtoint(nvedtSeatnum.Text);
      busseats := NovaHelpVehicleno.HelpFieldValue['seatnum'];
      if busseats <> curseats then
      begin
        if busseats > curseats then
        begin
          if not SysDialogs.Confirm('������ʾ',
            '��ǰ����������λ��(' + inttostr(busseats) + ')���ڸð�μƻ���λ�����Ƿ����������') then
          begin
            exit;
          end;
        end
        else if busseats < curseats then
       //---begin����2011 ������������λ��С�ڰ����λ�����Ƿ���������0������1����Ĭ��Ϊ0
        if (vehReport.p2011='0') then
        begin
             SysDialogs.showmessage('��ǰ����������λ��(' + inttostr(busseats) + ')С�ڸð�μƻ���λ�����������࣡');
             exit;
        end
        else
        begin
          if not SysDialogs.Confirm('������ʾ',
            '��ǰ����������λ��(' + inttostr(busseats) + ')С�ڸð�μƻ���λ�����Ƿ����������') then
         begin
            exit;
          end;
        end;
       //--- end ����2011

      end;
    end;
  end;

  with jscdIsLater do
  begin
    Active := false;
    Params.ParamValues['departstationid'] := curstationid;
    Params.ParamValues['vehiclereport.scheduleid'] := NovaHReprotSchedule.Id;
    Params.ParamValues['vehiclereport.departdate'] := FormatDateTime
      ('yyyy-mm-dd', DpDepartDate.DateTime);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult > 0) then
      begin
        SysDialogs.Warning(sResult);
        FrmVehicleLater := TFrmVehicleLater.Create(self);
        try
          with FrmVehicleLater do
          begin
            NvEditScheduleCodeL.Text := NovaHReprotSchedule.Text;
            NvedtDeparttimeL.Text := nvedDeparttime.Text;
            NovaHelpVehiclenoL.Text := NovaHelpVehicleno.Text;
            NovaEdtLaterMinutes.Text := inttostr(nResult);
            if SysMainForm.showFormModal(FrmVehicleLater, false) = mrok then
            begin
              if CobLaterReason.ItemIndex=3 then
              begin
                 reason := CobLaterReason.Text+':'+nvedtotherreason.Text;
              end
              else
              begin
                  reason := CobLaterReason.Text;
              end;

              RgReprotResult.ItemIndex := 1;
            end
            else
            begin
              RgReprotResult.ItemIndex := 0;
              SysDialogs.Warning('�ó����Ѿ���㣬��������㴦��');
              exit;
            end;
          end;
        finally
          FreeAndNil(FrmVehicleLater);
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�������ж�ʧ�ܣ�' + E.Message);
        exit;
      end;
    end;
  end;

  repAskCondition.departstationid:=curstationid;
  repAskCondition.departdate:=DpDepartDate.DateTime;
  repAskCondition.createby:=createby;
  repAskCondition.scheduleplanid:=scheduleplanid;
  repAskCondition.driver1id := nvhlpdriver.Id;
  repAskCondition.driver2id := NovaHelpcopilot1.Id;
  repAskCondition.driver3id := NovaHelpcopilot2.Id;
  repAskCondition.driver4id := NovaHelpcopilot3.Id;
  repAskCondition.driver4id := NovaHelpcopilot3.Id;
   repAskCondition.steward1id := NovaHelpsteward.Id;
  // repAskCondition.steward2id := NovaHelpsteward.Id;
  repAskCondition.reportorgid := reportorgid;
  repAskCondition.scheduleid := NovaHReprotSchedule.Id;
  repAskCondition.vehicleid := NovaHelpVehicleno.Id;
  repAskCondition.isTempVehicle:=isTempVehicle;
  repAskCondition.vehicleno:=NovaHelpVehicleno.Text;
  repAskCondition.unitid:=NovaHUnit.Id;
  repAskCondition.reason:= reason;
  repAskCondition.balanceunitid:=NovaHelpBalanceUnit.Id;
  if orderno='' then
  begin
    orderno:='-1';
  end;
  repAskCondition.orderno:=orderno;

  if Edtworkno.Text <> '' then    //��·��ʶ��
     repAskCondition.vroadnores:='�ϸ�'
  else
     repAskCondition.vroadnores:='���ϸ�' ;

 if (Edtlicenseenddate.Text >= DateToStr(now)) or
        (Edtlicenseenddate.Text = '') then  //��ʻ֤
    repAskCondition.vdriverlicenseres:='�ϸ�'
    else
    repAskCondition.vdriverlicenseres:='���ϸ�';

 if (Edtliabilityinsureenddate.Text >= DateToStr(now)) or
      (Edtliabilityinsureenddate.Text='') then  // ��·����֤
       repAskCondition.vworknores :='�ϸ�'
    else
      repAskCondition.vworknores :='���ϸ�';
     if cbbCheckResult.ItemIndex=1 then                     //����ϸ�֪ͨ������������
       repAskCondition.vnotenum := '�ϸ�'
    else
        repAskCondition.vnotenum:= '���ϸ�';

   repAskCondition.drivername:= nvhlpdriver.Text;

    if Chkdqualificationres.Checked then
       repAskCondition.dqualificationres :='�ϸ�'
    else
       repAskCondition.dqualificationres :='���ϸ�';

 if Chkddrivinglicenseres.Checked then
        repAskCondition.ddrivinglicenseres:='�ϸ�'
    else
        repAskCondition.ddrivinglicenseres :='���ϸ�';

    if Chkdworknores.Checked then
        repAskCondition.dworknores :='�ϸ�'
    else
        repAskCondition.dworknores :='���ϸ�';

    repAskCondition.driversign := nvhlpdriver.Text;
    //�ڶ�����ʻԱ
    repAskCondition.drivername2 := NovaHelpcopilot1.Text;
    if Chkddrivinglicenseres2.Checked then
        repAskCondition.ddrivinglicenseres2 :='�ϸ�'
    else
        repAskCondition.ddrivinglicenseres2 :='���ϸ�';

    if Chkdworknores2.Checked then
        repAskCondition.dworknores2 :='�ϸ�'
    else
        repAskCondition.dworknores2 :='���ϸ�';

    if chkdqualificationres2.Checked then
        repAskCondition.dqualificationres2 := '�ϸ�'
    else
        repAskCondition.dqualificationres2 := '���ϸ�';

    repAskCondition.driversign2 := NovaHelpcopilot1.Text;


    repAskCondition.classmember := Sysinfo.LoginUserInfo.UserName;
    repAskCondition.dispatcher := Sysinfo.LoginUserInfo.UserName;
    repAskCondition.stewardname := NovaHelpsteward.Text;

    repAskCondition.vehicleno:=NovaHelpVehicleno.Text;
    repAskCondition.vehicleunit:=NovaHUnit.Text;
    //;  //��ʾѡ�е�Ϊ��ˮ��
    if   pgc1.ActivePageIndex= 0 then
    begin
      repAskCondition.departtime:=nvedDeparttime.Text;
      repAskCondition.reachstation:=NvEdtRoute.Text;
    end
    else
    begin
      repAskCondition.departtime:=FormatDateTime('HH:MM',now);
      if DsVehiclepeople.DataSet.Active and (DsVehiclepeople.DataSet.RecordCount>0)
      then
      begin
        repAskCondition.reachstation:=DsVehiclepeople.DataSet.FieldByName('endstation').AsString;
      end;
    end;
    repAskCondition.schedulecode:=NovaHReprotSchedule.Text;
    repAskCondition.seatno:=IntToStr(busseats);


      vehReport.report(repAskCondition);
      nResult :=vehReport.res.flag;
      sResult := vehReport.res.msg;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        if Pos('����', sResult) > 0 then
          NovaHelpVehicleno.SetFocus
        else
          NovaHReprotSchedule.SetFocus;
      end
      else
      begin
        SysDialogs.showmessage(sResult);
        if RgReprotResult.ItemIndex = 0 then
          reason := '����'
        else
          reason := '���';
        log := '������վ:' + sysInfo.LoginUserInfo.OrgName + ',������Σ�' +
          NovaHReprotSchedule.Text + ',��������:' + NovaHelpVehicleno.Text +
          ',������λ:' + NovaHUnit.Text + ',��������:' + NovaHelpVehicletype.Text +
          ',����ʻ:' + nvhlpdriver.Text + ',�������:' + reason;
        SysLog.WriteLog('�ۺϵ���', '��������', log);
        if flag = 0 then
          ModalResult := mrok
        else
          clearReprotinfo;
      end;


end;

procedure TFrmVehicleReport.zkfpngxReportCapture(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
var
  ID: Integer;
  isexist:boolean;
begin
    ID:= ATemplate[0];
    if ID = -1 then
    begin
       LabInfo.Caption :=  '�밴ָ��ʶ��������';
    end
    else
    begin
       with self.jscdSpcQry do
       begin
         if Active and (recordcount>0) then
         begin
            isexist:=false;
            first;
            while not eof do
            begin
              if FieldByName('id').AsLargeInt = ID then
              begin
                if ActiveControl=nvhlpdriver then
                begin
                  with jsnclQrydriverByDriverid do
                  begin
                      Active:=False;
                      Params.ParamByName('driverid').Value := ID;
                      Active:=True;
                      if RecordCount > 0 then
                      begin
                        if jsnclQrydriverByDriverid.FieldByName('id').AsInteger>0 then
                        begin
                          nvhlpdriver.Text :=jsnclQrydriverByDriverid.FieldByName('name').AsString;
                          nvhlpdriver.Id:=jsnclQrydriverByDriverid.FieldByName('id').AsInteger;
                          keybd_event(VK_RETURN,0,0,0); //ģ�ⰴ��������enter��
                          keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //������
                        end;
                      end
                      else
                      begin
                        LabInfo.Caption := 'û�ҵ��ü�ʻԱ��Ӧ��ָ����Ϣ��';
                      end;
                  end;
                end;

                if ActiveControl=NovaHelpcopilot1 then
                begin
                  with jsnclQrydriverByDriverid do
                  begin
                      Active:=False;
                      Params.ParamByName('driverid').Value := ID;
                      Active:=True;
                      if RecordCount > 0 then
                      begin
                        if jsnclQrydriverByDriverid.FieldByName('id').AsInteger>0 then
                        begin
                          NovaHelpcopilot1.Text :=jsnclQrydriverByDriverid.FieldByName('name').AsString;
                          NovaHelpcopilot1.Id:=jsnclQrydriverByDriverid.FieldByName('id').AsInteger;
                          keybd_event(VK_RETURN,0,0,0); //ģ�ⰴ��������enter��
                          keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //������
                        end;
                      end
                      else
                      begin
                        LabInfo.Caption :=  'û�ҵ��ü�ʻԱ��Ӧ��ָ����Ϣ��';
                      end;
                  end;
                end;
                //����Ա
                if ActiveControl=NovaHelpsteward then
                begin
                  with jsncQryStewardName do
                  begin
                      Active:=False;
                      Params.ParamByName('stewardid').Value := ID;
                      Active:=True;
                      if RecordCount > 0 then
                      begin
                        if jsncQryStewardName.FieldByName('id').AsInteger>0 then
                        begin
                          NovaHelpsteward.Text :=jsncQryStewardName.FieldByName('name').AsString;
                          NovaHelpsteward.Id:=jsncQryStewardName.FieldByName('id').AsInteger;
                          keybd_event(VK_RETURN,0,0,0); //ģ�ⰴ��������enter��
                          keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //������
                        end;
                      end
                      else
                      begin
                        LabInfo.Caption :=  'û�ҵ��ü�ʻԱ��Ӧ��ָ����Ϣ��';
                      end;
                  end;


                end;
                isexist:=true;
                exit;
              end;
              next;
            end;
            if not isexist then
            begin
              LabInfo.Caption :=  'û�и�ָ����Ϣ����';
            end;
         end;
       end;
    end;
end;

procedure TFrmVehicleReport.BitBtn1Click(Sender: TObject);
begin
  vehiclereport(1);
end;

function TFrmVehicleReport.checkReportInfo: boolean;
begin
  result := True;
  if (NovaHReprotSchedule.Id = 0) or (trim(NovaHReprotSchedule.Text) = '') then
  begin
    msg := '��ѡ��Ҫ�����İ�Σ�';
    NovaHReprotSchedule.SetFocus;
    exit;
  end;

  if (NovaHelpVehicleno.Id = 0) or (trim(NovaHelpVehicleno.Text) = '') then
  begin
    msg := '��ѡ��Ҫ�����ĳ�����';
    NovaHelpVehicleno.SetFocus;
    exit;
  end;
  result := false;
end;

function TFrmVehicleReport.checkVehicles(vehicleid: Int64;
  departdate: string): boolean;
var
  nResult: integer;
  sResult, ischeckwithout: string;
begin
  with jcsdQryVehiclecheck do
  begin
    Active := false;
    Params.ParamValues['vehiclereport.vehicleid'] := vehicleid;
    Params.ParamValues['vehiclereport.departdate'] := FormatDateTime('yyyy-mm-dd',DpDepartDate.date)+ ' 23:59:59';
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      mmoCheckResult.Text := sResult;
      ischeckwithout := vehReport.p6008;
      // -1δ�� 1�ϸ� 0���ϸ� 2���ް���ƻ�����У�鰲�� 3:24Сʱ�ڰ���ϸ�
      // - 2,�ѷ�����̴���������Ҫ�ظ�������̣���ʾ��Ҫ�ٴΰ���
      if (isMustCheck) then
      begin
        cbbCheckResult.Enabled := false;
        if (nResult = -1) then // �ó������ջ�û���죡
        begin
          if ischeckwithout = '1' then
          begin
            cbbCheckResult.ItemIndex := 0;
            result := false;
            exit;
          end
          else
          begin
            cbbCheckResult.ItemIndex := 0;
            result := True;
            cbbCheckResult.Enabled := True;
            exit;
          end;
        end
        else if (nResult = 1) then // �ó�����������ϸ�!
        begin
          if sResult = '�ó�����û���죡' then
          begin
            cbbCheckResult.ItemIndex := 0;
            cbbCheckResult.Enabled := True;
          end
          else
            cbbCheckResult.ItemIndex := 1;

          result := True;
          exit;
        end
        else if (nResult = 2) then // ��ǰ�����ް���ƻ�!
        begin
          // �Ƿ���Ҫ����ϸ��������
          if isMustCheck then
          begin
            if ischeckwithout = '1' then
            begin
              sResult := '����ϸ����������';
              cbbCheckResult.ItemIndex := 0;
              mmoCheckResult.Text := sResult;
              result := false;
              exit;
            end
            else
            begin
              cbbCheckResult.Enabled := True;
              cbbCheckResult.ItemIndex := 0;
              mmoCheckResult.Text := sResult;
              result := True; ;
              // exit;
            end;
          end
          else
          begin
            cbbCheckResult.ItemIndex := 1;
            result := True;
            exit;
          end;
        end
        else if (nResult = 3) then // �ó���24Сʱ������ϸ�!
        begin
          cbbCheckResult.ItemIndex := 1;
          result := True;
          exit;
        end
        else if (nResult = 0) then // �ó����������첻�ϸ�
        begin
          cbbCheckResult.ItemIndex := 2;
          result := false;
          exit;
        end
        else if (nResult = -2) or (nResult = -3) then // ��ʾ��Ҫ�ٴΰ���
        begin
          cbbCheckResult.ItemIndex := 0;
          result := false;
          exit;
        end
        else
        begin
          cbbCheckResult.Enabled := True;
          cbbCheckResult.ItemIndex := 0;
          result := True;
        end;
      end
      else
      begin
        mmoCheckResult.Text := 'ϵͳδ���ó�����Ҫ���죡';
        cbbCheckResult.Enabled := True;
        cbbCheckResult.ItemIndex := 1;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��ȡ����������Ϣʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehicleReport.chktempvehicleClick(Sender: TObject);
begin
  inherited;
  if chktempvehicle.Checked then
  begin
    NovaHUnit.Enabled := True;
    NovaHelpVehicletype.Enabled := True;
    NovaHelpBalanceUnit.Enabled := True;
  end
  else
  begin
    NovaHUnit.Enabled := false;
    NovaHelpVehicletype.Enabled := false;
    NovaHelpBalanceUnit.Enabled := false;
  end;
end;

procedure TFrmVehicleReport.clearNotScheduleplan;
begin
  NvEdtRoute.Clear;
  nvedttickettype.Clear;
  nvedtcode.Clear;
  nvedDeparttime.Clear;
  nvedtSeatnum.Clear;
  nvedtSoldeatnum.Clear;
  nvedtylNum.Clear;
  nvedtyzNum.Clear;
  nvhlpdriver.Clear;
  NovaHelpcopilot1.Clear;
  NovaHelpcopilot2.Clear;
  NovaHelpcopilot3.Clear;
  NovaHelpsteward.Clear;
  NovaHelpVehicleno.Clear;
  NovaHelpVehicleno.Id := 0;
  NovaHUnit.Clear;
  NovaHUnit.Id := 0;
  NovaHelpVehicletype.Clear;
  NovaHelpVehicletype.Id := 0;
end;

procedure TFrmVehicleReport.clearReprotinfo;
begin
  NovaHReprotSchedule.Id := 0;
  NovaHReprotSchedule.Clear;
  nvedtbdcard.Clear;
  chktempvehicle.Checked := false;
  NovaHelpVehicleno.Clear;
  NovaHelpVehicleno.Id := 0;
  NovaHUnit.Clear;
  NovaHUnit.Id := 0;
  NovaHelpVehicletype.Clear;
  NovaHelpVehicletype.Id := 0;
  cbbCheckResult.ItemIndex := -1;
  RgReprotResult.ItemIndex := 0;
  NvEdtRoute.Clear;
  nvedttickettype.Clear;
  nvedtcode.Clear;
  nvedDeparttime.Clear;
  nvedtSeatnum.Clear;
  nvedtSoldeatnum.Clear;
  nvedtylNum.Clear;
  nvedtyzNum.Clear;
  nvhlpdriver.Clear;
  NovaHelpcopilot1.Clear;
  NovaHelpcopilot2.Clear;
  NovaHelpcopilot3.Clear;
  NovaHelpsteward.Clear;
  //Image1.Picture.Bitmap := nil;
end;

procedure TFrmVehicleReport.DpDepartDateChange(Sender: TObject);
begin
  inherited;
  ischangebyDepartdate := True;
end;

procedure TFrmVehicleReport.DpDepartDateExit(Sender: TObject);
begin
  inherited;
  if ischangebyDepartdate then
  begin
    qryScheduleplanInfo();
    ischangebyDepartdate := false;
  end;
end;

procedure TFrmVehicleReport.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.addObserver(self);
  except
    TBaseCardRW.GetInstance.addObserver(self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡ���ܿ�');
  end;
  setCardTypeNOLength(Tcardtypes.vehiclereport,
    sysInfo.curBillLength.Items['Vehicle']);
  setCardTypeNOLength(Tcardtypes.DRIVER, sysInfo.curBillLength.Items['Driver']);
  setCardTypeNOLength(Tcardtypes.STEWARD,
    sysInfo.curBillLength.Items['Steward']);
  setCardTypeNOLength(Tcardtypes.VIP, sysInfo.curBillLength.Items['Vip']);
  setCardTypeNOLength(Tcardtypes.USER, sysInfo.curBillLength.Items['Userinfo']);
  setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,
    sysInfo.curBillLength.Items['Unit']);

  if vehReport.p2033='1' then
  begin
      zkfpngxReport:=TZKFPEngX.Create(Self);
      fpcHandle := zkfpngxReport.CreateFPCacheDB;
  end;
end;

procedure TFrmVehicleReport.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(self);
    if self.initsuccess then
     begin
       if fpcHandle<=0 then exit;
        zkfpngxReport.FreeFPCacheDB(fpcHandle);
        zkfpngxReport.Free;
     end;
  except
  end;
end;

procedure TFrmVehicleReport.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if isNovaHelpVehiclenoKeyPress then
  begin
    Key := 0;
    NovaHelpVehicleno.SetFocus;
    isNovaHelpVehiclenoKeyPress := false;
  end;
end;

procedure TFrmVehicleReport.FormShow(Sender: TObject);
var
  sTemp: WideString;
  id,  pid:Integer;
begin
  inherited;
  if pgc1.TabIndex = 1 then
    qryScheduleplanInfo();
  if NovaHelpVehicleno.Id > 0 then
  begin
    ischangebyVehicle := True ;
    nvedtbdcard.SetFocus ;
  end
  else
  begin
    NovaHelpVehicleno.SetFocus;
  end;
  if vehReport.p2033='1' then
   begin
       jscdSpcQry.Active:=False;
       jscdSpcQry.Active:=True;
      if zkfpngxReport.InitEngine = 0 then
      begin
        LabInfo.Visible:=True;
        LabInfo.Caption := 'ָ���豸��ʼ���ɹ���';
        initsuccess:=true;
        with jscdSpcQry do
        begin
           if active then
           begin
             first;
             while(not eof) do
             begin
               sTemp:= FieldByName('fingerstr').AsString;
               SysLog.WriteErr('sTemp='+sTemp);
               id:=FieldByName('id').AsInteger;
               try
                  zkfpngxReport.AddRegTemplateStrToFPCacheDB(fpcHandle,id,sTemp);
               except
                  SysLog.WriteErr('id='+inttostr(id)+'ָ��ע��ʧ�ܣ�');
               end;
               next;
             end;
           end;
        end ;
        zkfpngxReport.BeginCapture;
        zkfpngxReport.EnrollCount:=1;
        //ZKFPEngX1.BeginEnroll;
        if zkfpngxReport.IsRegister then zkfpngxReport.CancelEnroll;
        zkfpngxReport.SetAutoIdentifyPara(true, fpcHandle, 8);
      end
      else
      begin
         LabInfo.Caption := 'ָ���豸��ʼ��ʧ�ܣ�';
         initsuccess:=false;
      end;
   end;
end;

procedure TFrmVehicleReport.iccardfound(icCard: TBaseCard);
begin
  // if Integer(icCard.cardtype) <> 0 then
  // begin
  // ShowMessage('�ÿ����Ǳ��������������ڱ�����');
  // end
  // else
  if integer(icCard.cardtype) = 0 then
    nvedtbdcard.Text := icCard.cardno
  else if integer(icCard.cardtype) = 1 then
  begin
    finddriverbycardno(icCard.cardno);
  end
  else
    showmessage('�ÿ����Ǳ�������Ҳ���Ǽ�ʻԱ�����������ڱ�����');

  // if Integer(icCard.cardtype) = 2 then
  // begin
  // NovaHelpsteward.Text := icCard.cardNo;
  // end;

end;

procedure TFrmVehicleReport.jcdsQryvehiclepeopleplansAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
  if not jcdsQryvehiclepeopleplans.Active then
    exit;
  if jcdsQryvehiclepeopleplans.RecordCount = 0 then
    exit;
    //ֻ��˫��ʱ ����
//  orderno:=jcdsQryvehiclepeopleplans.FieldByName('orderno').AsString;
end;

procedure TFrmVehicleReport.NovaHelpcopilot1IdChange(Sender: TObject);
begin
  inherited;
  if NovaHelpcopilot1.Id > 0 then
  begin
    with jcdsQryDriver do
    begin
      active := false;
      Params.ParamValues['driverid'] := NovaHelpcopilot1.Id;
      active := true;
      if RecordCount > 0 then
      begin

        if(fieldbyname('drivinglicenseenddate').IsNull) then
        begin
           Edtdrivinglicenseenddate1.Text:='δ¼��';
        end
        else
        begin
          Edtdrivinglicenseenddate1.Text :=FormatDateTime('yyyy-mm-dd',
              fieldbyname('drivinglicenseenddate').AsDateTime);
          if fieldbyname('drivinglicenseenddate').AsDateTime>=now  then
          begin
             Chkddrivinglicenseres2.Checked:=true;
          end
          else
          begin
             Chkddrivinglicenseres2.Checked:=false;
          end;

        end;

        if(fieldbyname('qualificationenddate').IsNull) then
        begin
           Editqualificationenddate1.Text:='δ¼��';
        end
        else
        begin
          Editqualificationenddate1.Text :=FormatDateTime('yyyy-mm-dd',
              fieldbyname('qualificationenddate').AsDateTime);
          if fieldbyname('qualificationenddate').AsDateTime>=now  then
          begin
             chkdqualificationres2.Checked:=true;
          end
          else
          begin
             chkdqualificationres2.Checked:=false;
          end;
        end;

        if(fieldbyname('workenddate').IsNull) then
        begin
           Edtworkenddate1.Text:='δ¼��';
        end
        else
        begin
          Edtworkenddate1.Text :=FormatDateTime('yyyy-mm-dd',
              fieldbyname('workenddate').AsDateTime);
          if fieldbyname('workenddate').AsDateTime>=now  then
          begin
             Chkdworknores2.Checked:=true;
          end
          else
          begin
             Chkdworknores2.Checked:=false;
          end;
        end;
       { HexStr := FieldByName('picture').AsString;
        if HexStr = '' then
          Image1.Picture.Bitmap := nil
        else
          Image1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));  }
      end;
    end;
    //if NovaHelpcopilot2.Visible and NovaHelpcopilot2.Enabled then
    //    NovaHelpcopilot2.SetFocus;
  end
  else
  begin
    Edtdrivinglicenseenddate1.Text:='';
    Editqualificationenddate1.Text:='';
    Edtworkenddate1.Text:='';
  end;
end;


procedure TFrmVehicleReport.NovaHelpVehiclenoIdChange(Sender: TObject);
begin
    Edtliabilityinsureenddate.Clear;
    Edtlicenseenddate.Clear;
    Edtworkenddate.Clear;
    Edtworkno.Clear;
    edtcompulsoryinsureenddate.Clear;

  if (NovaHelpVehicleno.isactive) and (NovaHelpVehicleno.Id > 0) and
    (trim(NovaHelpVehicleno.Text) <> '') then
  begin
    vehReport.vehicleid:=NovaHelpVehicleno.Id ;
    vehReport.vehicleno:=NovaHelpVehicleno.Text;
    vehReport.QryVehicleById(NovaHelpVehicleno.Id);
    if vehReport.jcsdQryVehicle.Active
        and  (vehReport.jcsdQryVehicle.RecordCount>0) then
    with  vehReport.jcsdQryVehicle do
    begin
      NovaHUnit.Text :=FieldByName('unitname').AsString;
      NovaHUnit.Id := FieldByName('unitid').AsLargeInt;
      NovaHelpVehicletype.Text :=FieldByName('vehicletypename').AsString;
      NovaHelpVehicletype.Id := FieldByName('vehicletypeid').AsLargeInt;
      seatnum :=FieldByName('seatnum').AsInteger;
      NovaHelpBalanceUnit.Text :=FieldByName('balancename').AsString;
      NovaHelpBalanceUnit.Id :=FieldByName('balanceunitid').AsLargeInt;
      isVehicleEmployee :=FieldByName('isneedfinger').AsBoolean;
      //NvHcbbVehiclebrandmodel.SetItemIndexByField('Id',
      //  NovaHelpVehicleno.HelpFieldValue['brandid']);
      if not FieldByName('liabilityinsureenddate').IsNull then
         Edtliabilityinsureenddate.Text:=FormatDateTime('yyyy-mm-dd',FieldByName('liabilityinsureenddate').AsDateTime) ;
      if not FieldByName('licenseenddate').IsNull then
         Edtlicenseenddate.Text:=FormatDateTime('yyyy-mm-dd',FieldByName('licenseenddate').AsDateTime) ;
      if not FieldByName('workenddate').IsNull  then
         Edtworkenddate.Text:=FormatDateTime('yyyy-mm-dd',FieldByName('workenddate').AsDateTime) ;

      Edtworkno.Text:=FieldByName('roadno').AsString;
      if not FieldByName('compulsoryinsureenddate').IsNull then
         edtcompulsoryinsureenddate.text:= FormatDateTime('yyyy-mm-dd',FieldByName('compulsoryinsureenddate').AsDateTime) ;
    end;
    {**********************���ݱ����������������ʻԱ**************************}
    {****����2038****IC������ʱ�Ƿ�����ͨ�����ƺŻ�ȡ��ʻԱ����Ϣ��0��1��****}
    if(getParametervalue('2038', sysInfo.LoginUserInfo.OrgID)='1') then
    begin
    //����ʻԱ������ʻԱ�뱨����������
      nvhlpdriver.Clear;
      NovaHelpcopilot1.Clear;
      NovaHelpcopilot2.Clear;
      NovaHelpcopilot3.Clear;
      NovaHelpsteward.Clear;
      with jcdsVehicleDriver do
      begin
        Active:=False;
        Params.ParamValues['vehicleid']:=NovaHelpVehicleno.id;
        Params.ParamValues['departdate']:=FormatDateTime('yyyy-mm-dd', DpDepartDate.DateTime);
        if (NovaHReprotSchedule.Id>0) and (Trim(NovaHReprotSchedule.Text) <> '')  then
           begin
             Params.ParamValues['scheduleid']:=NovaHReprotSchedule.Id;
           end
        else
        begin
           Params.ParamValues['scheduleid']:='';
        end;
        active:=True;
        if RecordCount > 0 then
        begin
          if FieldByName('driverid').AsInteger>0 then
          begin
            nvhlpdriver.Text:=FieldByName('drivername').AsString;
            nvhlpdriver.Id:=FieldByName('driverid').AsInteger;
            nvhlpdriver.OnIdChange:=nvhlpdriverIdChange;
          end;
          if FieldByName('drivercopilot1id').AsInteger>0 then
          begin
            NovaHelpcopilot1.Text:=FieldByName('drivercopilot1name').AsString;
            NovaHelpcopilot1.Id:=FieldByName('drivercopilot1id').AsInteger;
            NovaHelpcopilot1.OnIdChange:=NovaHelpcopilot1IdChange;
          end;
          if FieldByName('drivercopilot2id').AsInteger>0 then
          begin
            NovaHelpcopilot2.Text:=FieldByName('drivercopilot2name').AsString;
            NovaHelpcopilot2.Id:=FieldByName('drivercopilot2id').AsInteger;
          end;
          if FieldByName('drivercopilot3id').AsInteger>0 then
          begin
            NovaHelpcopilot3.Text:=FieldByName('drivercopilot3name').AsString;
            NovaHelpcopilot3.Id:=FieldByName('drivercopilot3id').AsInteger;
          end;
        end;
      end;
    end;
    // ischangebyVehicle := true;
    checkVehicles(NovaHelpVehicleno.Id, FormatDateTime('yyyy-mm-dd',
        DpDepartDate.DateTime));
    //nvhlpdriver.SetFocus;
  end;
end;

procedure TFrmVehicleReport.NovaHelpVehicletypeIdChange(Sender: TObject);
begin
  inherited;
 { if NovaHelpVehicletype.Id > 0 then
  begin
    NvHcbbVehiclebrandmodel.Active := false;
    NvHcbbVehiclebrandmodel.Params.ParamValues['filter_EQL_t!vehicletypeid'] :=
      NovaHelpVehicletype.Id;
    NvHcbbVehiclebrandmodel.Active := True;
  end;  }
end;

procedure TFrmVehicleReport.NovaHReprotScheduleIdChange(Sender: TObject);
begin
  inherited;
  // ischangebyschedule := true;
  if NovaHReprotSchedule.isactive and (NovaHReprotSchedule.Id > 0) then
  begin
    qryScheduleplanInfo();
  end;
  // ischangebyschedule := false;
end;

procedure TFrmVehicleReport.NovaHReprotScheduleKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  { if (Key = #13) then
    begin
    if ischangebyschedule and (NovaHReprotSchedule.Id > 0) then
    begin
    qryScheduleplanInfo();
    ischangebyschedule := false;
    end;
    end; }
end;

procedure TFrmVehicleReport.nvdbgrdhregisterrecordDblClick(Sender: TObject);
begin
  inherited;
  if not jcdsQryvehiclepeopleplans.Active then
    exit;
  if jcdsQryvehiclepeopleplans.RecordCount = 0 then
    exit;
  NovaHelpVehicleno.OnIdChange := nil;
  with jcdsQryvehiclepeopleplans do
  begin
    NovaHelpVehicleno.Text := FieldByName('vehicleno').AsString;
    NovaHelpVehicleno.Id := FieldByName('planvehicleid').AsLargeInt;
    NovaHUnit.Text := FieldByName('unitname').AsString;
    NovaHelpVehicletype.Text := FieldByName('vehicletypename').AsString;
    NovaHelpVehicletype.Id := FieldByName('planvehicletypeid').AsLargeInt;
    NovaHelpBalanceUnit.Text :=  FieldByName('unitname').AsString;
    NovaHelpBalanceUnit.Id :=  FieldByName('planunitid').AsLargeInt;
    NovaHelpVehicleno.OnIdChange := NovaHelpVehiclenoIdChange;
    seatnum := FieldByName('vehicleseatnum').AsInteger;
    orderno := FieldByName('orderno').AsString;
    nvhlpdriver.Id := FieldByName('plandriver1id').AsLargeInt;
    nvhlpdriver.Text := FieldByName('driver1').AsString;
    NovaHelpcopilot1.Id := FieldByName('plandriver2id').AsLargeInt;
    NovaHelpcopilot1.Text := FieldByName('driver2').AsString;
    NovaHelpcopilot2.Id := FieldByName('plandriver3id').AsLargeInt;
    NovaHelpcopilot2.Text := FieldByName('driver3').AsString;
    NovaHelpcopilot3.Id := FieldByName('plandriver4id').AsLargeInt;
    NovaHelpcopilot3.Text := FieldByName('driver4').AsString;
    NovaHelpsteward.Id := FieldByName('plansteward1id').AsLargeInt;
    NovaHelpsteward.Text := FieldByName('stwname1').AsString;

    NovaHelpVehicleno.SetFocus;
  end;
end;

procedure TFrmVehicleReport.nvedtbdcardChange(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if trim(nvedtbdcard.Text) = '' then
    exit;
  if Length(nvedtbdcard.Text) = sysInfo.curBillLength.Items['Vehicle'] then
  begin
    vehReport.QryVehicleinfo(nvedtbdcard.Text);
    with vehReport.jcsdQryVehicleinfo do
    begin
      nResult := vehReport.res.flag;
      sResult := vehReport.res.msg;
      if (RecordCount = 1) then
      begin
         try
            vehReport.vehicleid:=FieldByName('id').AsLargeInt;
           // NovaHelpVehicleno.OnIdChange := nil;
            try
                NovaHelpVehicleno.Text :=FieldByName('vehicleno').AsString;// Params.ParamValues['vehicleno'];
                NovaHelpVehicleno.Id :=FieldByName('id').AsLargeInt;// Params.ParamValues['vehicleid'];
                keybd_event(VK_RETURN,0,WM_KEYDOWN,0);
                keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0);
            except on e:Exception do
                ShowMessage(e.Message);
            end;
           { NovaHelpVehicleno.OnIdChange := NovaHelpVehiclenoIdChange;
            seatnum :=FieldByName('seatnum').AsInteger;// Params.ParamValues['seatnum'];
            NovaHUnit.Text :=FieldByName('unitname').AsString;// Params.ParamValues['unitname'];
            NovaHUnit.Id := FieldByName('unitid').AsLargeInt;//Params.ParamValues['unitid'];
            NovaHelpVehicletype.Text :=FieldByName('vehicletypename').AsString;// Params.ParamValues['vehicletypename'];
            NovaHelpVehicletype.Id :=FieldByName('vehicletypeid').AsLargeInt;// Params.ParamValues['vehicletypeid'];
            NovaHelpBalanceUnit.Text := FieldByName('balanceunitname').AsString;// Params.ParamValues['balanceunitname'];
            NovaHelpBalanceUnit.Id :=FieldByName('balanceunitid').AsLargeInt;//  Params.ParamValues['balanceunitid'];
            try
              Edtlicenseenddate.text:= FieldByName('licenseenddate').AsString;//Params.ParamValues['licenseenddate'];
              Edtliabilityinsureenddate.Text:=FieldByName('liabilityinsureenddate').AsString;// Params.ParamValues['liabilityinsureenddate'];
              Edtworkenddate.Text:=FieldByName('workenddate').AsString;//Params.ParamValues['workenddate'];
              Edtworkno.Text:=FieldByName('roadno').AsString;//Params.ParamValues['roadno'];
              edtcompulsoryinsureenddate.Text:=FieldByName('compulsoryinsureenddate').AsString;//Params.ParamValues['compulsoryinsureenddate'];
    //        Edtlicenseenddate.text:=FormatDateTime('yyyy-mm-dd',Params.ParamValues['licenseenddate']) ;
            except on e:Exception do
               SysLog.WriteErr(e.Message);
            end;  }
            isVehicleEmployee := FieldByName('isneedfinger').AsBoolean;//Params.ParamValues['isneedfinger'];
            {**********************���ݱ����������������ʻԱ**************************}
            {****����2038****IC������ʱ�Ƿ�����ͨ�����ƺŻ�ȡ��ʻԱ����Ϣ��0��1��****}
            if(vehReport.p2038='1') then
            begin
              with jcdsVehicleDriver do
              begin
                Active:=False;
                Params.ParamValues['vehicleid']:=NovaHelpVehicleno.Id;
                Params.ParamValues['departdate']:=FormatDateTime('yyyy-mm-dd', DpDepartDate.DateTime);
                if (NovaHReprotSchedule.Id>0) and (Trim(NovaHReprotSchedule.Text) <> '')  then
                   begin
                     Params.ParamValues['scheduleid']:=NovaHReprotSchedule.Id;
                   end
                else
                begin
                   Params.ParamValues['scheduleid']:='';
                end;
                active:=True;
                if RecordCount > 0 then
                begin
                  if FieldByName('driverid').AsInteger>0 then
                  begin
                    nvhlpdriver.Text:=FieldByName('drivername').AsString;
                    nvhlpdriver.Id:=FieldByName('driverid').AsInteger;
                    nvhlpdriver.OnIdChange:=nvhlpdriverIdChange;
                  end;
                  if FieldByName('drivercopilot1id').AsInteger>0 then
                  begin
                    NovaHelpcopilot1.Text:=FieldByName('drivercopilot1name').AsString;
                    NovaHelpcopilot1.Id:=FieldByName('drivercopilot1id').AsInteger;
                    NovaHelpcopilot1.OnIdChange:=NovaHelpcopilot1IdChange;
                  end;
                end;
              end;
            end;
         except on e:Exception do
            SysLog.WriteErr(e.Message);
         end;
        checkVehicles(NovaHelpVehicleno.Id, FormatDateTime('yyyy-mm-dd',
            DpDepartDate.DateTime));
        //nvhlpdriver.SetFocus;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        nvedtbdcard.SetFocus;
        nvedtbdcard.SelectAll;
      end;
    end;
  end;
end;

procedure TFrmVehicleReport.nvedtylNumExit(Sender: TObject);
begin
  inherited;
  //�ж�Ԥ����λ���Ƿ���ֵ
  if nvedtylNum.text = '' then
     nvedtylNum.text := '0';
end;

procedure TFrmVehicleReport.nvedtylNumKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  //��Ӽ�����Ӧ��ֻ������0-9������  ��ʵ��
  if (key = #48) or (key = #49) or (key = #50) or (key = #51) or (key = #52)
     or (key = #53) or (key = #54) or (key = #55) or (key = #56) or (key = #57) then

end;

procedure TFrmVehicleReport.finddriverbycardno(cardno: string);
begin
  with jcdsqryDriverbycardno do
  begin
    Active := false;
    Params.ParamValues['cardno'] := cardno;
    Active := True;
    if RecordCount > 0 then
    begin
      if nvhlpdriver.Id <= 0 then
      begin
        nvhlpdriver.Text := FieldByName('drivername').AsString;
        nvhlpdriver.Id := FieldByName('id').AsInteger;
      end
      else
      begin
        if NovaHelpcopilot1.Id <= 0 then
        begin
          NovaHelpcopilot1.Text := FieldByName('drivername').AsString;
          NovaHelpcopilot1.Id := FieldByName('id').AsInteger;
        end
        else
        begin
          if NovaHelpcopilot2.Id <= 0 then
          begin
            NovaHelpcopilot2.Text := FieldByName('drivername').AsString;
            NovaHelpcopilot2.Id := FieldByName('id').AsInteger;
          end;
         { else
          begin
            NovaHelpcopilot3.Text := FieldByName('drivername').AsString;
            NovaHelpcopilot3.Id := FieldByName('id').AsInteger;
          end; }
        end;
      end;
    end
    else
    begin
      SysDialogs.showmessage('δ�ҵ��ü�ʻԱ����Ӧ��ʻԱ��Ϣ��');
      exit;
    end;
  end;
end;

// ����ʻԱ
procedure TFrmVehicleReport.nvhlpdriverIdChange(Sender: TObject);
var
  HexStr: String;
begin
  inherited;
  if nvhlpdriver.Id > 0 then
  begin
    with jcdsQryDriver do
    begin
      active := false;
      Params.ParamValues['driverid'] := nvhlpdriver.Id;
      active := true;
      if RecordCount > 0 then
      begin
         //��ʻ֤��Ч��
        if(fieldbyname('drivinglicenseenddate').IsNull) then
        begin
           Edtdrivinglicenseenddate.Text:='δ¼��';
        end
        else
        begin
          Edtdrivinglicenseenddate.Text :=FormatDateTime('yyyy-mm-dd',
              fieldbyname('drivinglicenseenddate').AsDateTime);
          if fieldbyname('drivinglicenseenddate').AsDateTime>=now  then
          begin
             Chkddrivinglicenseres.Checked:=true;
          end
          else
          begin
             Chkddrivinglicenseres.Checked:=false;
          end;
        end;
         //��ҵ�ʸ�֤��Ч��
        if(fieldbyname('qualificationenddate').IsNull) then
        begin
           Editqualificationenddate.Text:='δ¼��';
        end
        else
        begin
          Editqualificationenddate.Text :=FormatDateTime('yyyy-mm-dd',
              fieldbyname('qualificationenddate').AsDateTime);
          if fieldbyname('qualificationenddate').AsDateTime>=now  then
          begin
             Chkdqualificationres.Checked:=true;
          end
          else
          begin
             Chkdqualificationres.Checked:=false;
          end;
        end;
         //�ϸ�֤
        if(fieldbyname('workenddate').IsNull) then
        begin
           Edit1.Text:='δ¼��';
        end
        else
        begin
          Edit1.Text :=FormatDateTime('yyyy-mm-dd',
              fieldbyname('workenddate').AsDateTime);
          if fieldbyname('workenddate').AsDateTime>=now  then
          begin
             Chkdworknores.Checked:=true;
          end
          else
          begin
             Chkdworknores.Checked:=false;
          end;
        end;
       { HexStr := FieldByName('picture').AsString;
        if HexStr = '' then
          Image1.Picture.Bitmap := nil
        else
          Image1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));  }
      end;
    end;
    //if NovaHelpcopilot1.Visible and NovaHelpcopilot1.Enabled then
    //    NovaHelpcopilot1.SetFocus;
  end
  else
  begin
    Edtdrivinglicenseenddate.Text:='';//��ʻ֤��Ч��
    Editqualificationenddate.Text:='';//��ҵ�ʸ�֤
    Edit1.Text:='';//�ϸ�֤
  end;

end;

procedure TFrmVehicleReport.pgc1Change(Sender: TObject);
begin
  inherited;
  NovaHelpVehicleno.SetFocus;
end;

procedure TFrmVehicleReport.pnlOperationResize(Sender: TObject);
begin
  // inherited;

end;

procedure TFrmVehicleReport.qryScheduleplanInfo;
begin
  if (NovaHReprotSchedule.Id > 0) then
  begin
    {......��ʻԱ����Ա���ƺ����}
    nvhlpdriver.Id := 0;
    nvhlpdriver.Text := '';
    NovaHelpcopilot1.Id := 0;
    NovaHelpcopilot1.Text := '';
    NovaHelpcopilot2.Id := 0;
    NovaHelpcopilot2.Text := '';
    NovaHelpsteward.Id := 0;
    NovaHelpsteward.Text := '';
    NovaHelpVehicleno.Text := '';
    NovaHelpVehicleno.Id := 0;
    with jcdsQryvehiclepeopleplans do
    begin
      Active := false;
      Params.ParamValues['vehiclereport.scheduleid'] := NovaHReprotSchedule.Id;
      Params.ParamValues['vehiclereport.departdate'] := FormatDateTime
        ('yyyy-mm-dd', DpDepartDate.DateTime);
      Params.ParamValues['departstationid'] := curstationid;
      Active := True;
      if RecordCount > 0 then
      begin
        scheduleplanid := FieldByName('id').AsLargeInt;
        // ����ˮ��begin
        if (not FieldByName('islinework').AsBoolean) then
        begin
          pgc1.ActivePageIndex := 0;
          nvhlpdriver.Id := FieldByName('plandriver1id').AsLargeInt;
          nvhlpdriver.Text := FieldByName('driver1').AsString;
          NovaHelpcopilot1.Id := FieldByName('plandriver2id').AsLargeInt;
          NovaHelpcopilot1.Text := FieldByName('driver2').AsString;
          NovaHelpcopilot2.Id := FieldByName('plandriver3id').AsLargeInt;
          NovaHelpcopilot2.Text := FieldByName('driver3').AsString;
          NovaHelpcopilot3.Id := FieldByName('plandriver4id').AsLargeInt;
          NovaHelpcopilot3.Text := FieldByName('driver4').AsString;
          NovaHelpsteward.Id := FieldByName('plansteward1id').AsLargeInt;
          NovaHelpsteward.Text := FieldByName('stwname1').AsString;
          // �����Ϣ
          NvEdtRoute.Text := FieldByName('routename').AsString;
          nvedttickettype.Text := FieldByName('vehicletypename').AsString;
          nvedtcode.Text := FieldByName('code').AsString;
          nvedDeparttime.Text := FieldByName('departtime').AsString;
          nvedtSeatnum.Text := FieldByName('seatnum').AsString;
          nvedtSeatnumhid.Text := FieldByName('seatnum').AsString;

          nvedtSoldeatnum.Text := FieldByName('soldeatnum').AsString;
          nvedtylNum.Text := inttostr(FieldByName('autocancelreserveseatnum')
              .AsInteger + FieldByName('unautocancelreserveseatnum')
              .AsInteger + FieldByName('fixedreserveseatnum')
              .AsInteger);
          nvedtyzNum.Text := FieldByName('leaveseat').AsString;
          scheduleEmployees := FieldByName('driverfingernum').AsInteger;
          if NovaHelpVehicleno.Text = '' then
          begin
              NovaHelpVehicleno.Text := FieldByName('vehicleno').AsString;
              NovaHelpVehicleno.Id := FieldByName('planvehicleid').AsLargeInt;
              NovaHUnit.Text := FieldByName('unitname').AsString;
              NovaHUnit.Id := FieldByName('planunitid').AsLargeInt;
              NovaHelpVehicletype.Text := FieldByName('vehicletypename').AsString;
              NovaHelpVehicletype.Id := FieldByName('planvehicletypeid')
                .AsLargeInt;
          end;
        end
        else
        begin
          pgc1.ActivePageIndex := 1;  //��ʾѡ�е�Ϊ��ˮ��
          // ��ʾ��ˮ����ʾ��ʻԱ��Ϣ
          nvhlpdriver.Id := FieldByName('plandriver1id').AsLargeInt;
          nvhlpdriver.Text := FieldByName('driver1').AsString;
          NovaHelpcopilot1.Id := FieldByName('plandriver2id').AsLargeInt;
          NovaHelpcopilot1.Text := FieldByName('driver2').AsString;
          NovaHelpcopilot2.Id := FieldByName('plandriver3id').AsLargeInt;
          NovaHelpcopilot2.Text := FieldByName('driver3').AsString;
          NovaHelpcopilot3.Id := FieldByName('plandriver4id').AsLargeInt;
          NovaHelpcopilot3.Text := FieldByName('driver4').AsString;
          NovaHelpsteward.Id := FieldByName('plansteward1id').AsLargeInt;
          NovaHelpsteward.Text := FieldByName('stwname1').AsString;

         //clearNotScheduleplan;
        end;
      end
      else
      begin
        //SysDialogs.showmessage('�ð�ε���ûӪ�˼ƻ���');
        //clearNotScheduleplan;
        NovaHReprotSchedule.SetFocus;
        NovaHReprotSchedule.SelectAll;
      end;
    end;
  end;
end;

end.

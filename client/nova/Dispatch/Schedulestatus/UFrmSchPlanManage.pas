unit UFrmSchPlanManage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaHComboBox, NovaComboBox, NovaEdit, NovaHelp, DBGridEhGrouping,
  NovaCheckedComboBox, UDMPublic, Menus;

type
  TFrmSchPlanManage = class(TSimpleCRUDForm)
    lbldate: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lblstation: TLabel;
    lbl1: TLabel;
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    lbl6: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlpendstation: TNovaHelp;
    nvhlpvehicletype: TNovaHelp;
    yes: TCheckBox;
    no: TCheckBox;
    nvhlpunit: TNovaHelp;
    NovaCobbScheduleStatus: TNovaComboBox;
    chkIssaleafterreport: TCheckBox;
    NovaHCbbOrg: TNovaHComboBox;
    jcdsScheduleStatus: TjsonClientDataSet;
    jcdsResultautocancelreserveseatnum: TIntegerField;
    jcdsResultunautocancelreserveseatnum: TIntegerField;
    jcdsResultdeparttime: TWideStringField;
    w: TLargeintField;
    jcdsResultdepartdate: TDateField;
    jcdsResultseatnum: TIntegerField;
    d: TIntegerField;
    jcdsResultsoldeatnum: TIntegerField;
    jcdsResultissellable: TBooleanField;
    jcdsResultisovertime: TBooleanField;
    jcdsResultisproprietary: TBooleanField;
    jcdsResultdepartname: TWideStringField;
    jcdsResultschedulename: TWideStringField;
    jcdsResultunitname: TWideStringField;
    jcdsResultstartroutename: TWideStringField;
    jcdsResultendroutename: TWideStringField;
    jcdsResultbegincheck: TBooleanField;
    jcdsResultvehicleno: TWideStringField;
    jcdsResultreportvehicleno: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultbuspark: TWideStringField;
    jcdsResultviastation: TWideStringField;
    jcdsResultvtname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultschedulestatusid: TLargeintField;
    jcdsResultvehicletypeid: TLargeintField;
    jcdsResultvehiclebrandmodelid: TLargeintField;
    jcdsResultscheduleid: TLargeintField;
    jcdsResultplanvehicleid: TLargeintField;
    jcdsResultschedulevehiclepeopleplanid: TLargeintField;
    jcdsResultislinework: TBooleanField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultreservenum: TIntegerField;
    jcdsResultisdeparted: TBooleanField;
    jcdsResultissaleafterreport: TBooleanField;
    jcdsResultruntime: TFloatField;
    jcdsResultorgname: TWideStringField;
    jcdsResultdepartstationid: TLargeintField;
    jcdsResultvcstatus: TWideStringField;
    jcdsResultreporttime: TDateTimeField;
    ChkIsDepart: TCheckBox;
    ChkIsNotDepart: TCheckBox;
    jcdsResultdistricttype: TWideStringField;
    jscdUpdateSale: TjsonClientDataSet;
    Panel2: TPanel;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jscdAllowTicketsell: TjsonClientDataSet;
    jscdStopTicketsell: TjsonClientDataSet;
    jcsdallowScheduleplan: TjsonClientDataSet;
    jcdsResultbrandmodelname: TWideStringField;
    jcdsworkways: TjsonClientDataSet;
    jcdsResultworkways: TWideStringField;
    jcdsResultvcworkways: TWideStringField;
    jcdsResultplanunit: TWideStringField;
    jcdsResultremark: TWideStringField;
    lblRun: TLabel;
    nvcbbType: TNovaCheckedComboBox;
    ChkFullseats: TCheckBox;
    jcdsResultcarrychildnum: TIntegerField;
    jcdsResultplanunitid: TLargeintField;
    jcdsResultschtype: TWideStringField;
    jcdsResultlocalsell: TIntegerField;
    jcdsResultothersell: TIntegerField;
    lbl8: TLabel;
    nvhlpDeparts: TNovaHelp;
    jcdsResultworktype: TWideStringField;
    jcdsResultstarttime: TWideStringField;
    jcdsResultdepartinvoicesno: TWideStringField;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    seatinfo: TToolButton;
    cancleshift: TToolButton;
    jsonCancelShift: TjsonClientDataSet;
    jsoncheck: TjsonClientDataSet;
    canticketsell: TToolButton;
    jcdscansaleticket: TjsonClientDataSet;
    jcdsworktypename: TjsonClientDataSet;
    jcdsResultworktypename: TWideStringField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure nvhlprouteIdChange(Sender: TObject);
    procedure dtpstartdateChange(Sender: TObject);
    procedure dtpenddateChange(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    // procedure ToolButton50Click(Sender: TObject);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure ToolButton53Click(Sender: TObject);
    procedure ToolButton51Click(Sender: TObject);
    procedure tbtn4Click(Sender: TObject);
    procedure ModelPlus(Sender: TObject);
    procedure RoutePlus(Sender: TObject);
    procedure seatinfoClick(Sender: TObject);
    procedure cancleshiftClick(Sender: TObject);
    procedure checkticketstatus(sender: TObject);
    procedure canticketsellClick(Sender: TObject);
  private
    { Private declarations }
    parameter: string;
    ischecked : Boolean;
    // ͣ��ָ�
    procedure allowScheduleplan(curid: int64);
    procedure stopTicketsell(curid: int64; departstationsid: int64);
    procedure allowTicketsell(curid: int64; departstationsid: int64);
    // ���ַ�����ʽ"yyyy-mm-dd hh:mm:ss" ת��Ϊ����ʱ���ʽ
    function StringToDateTime(ADateTimeStr: string): TDateTime;
  public
    { Public declarations }
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmSchPlanManage: TFrmSchPlanManage;

implementation

uses Services, PubFn, UFrmSchSeatReserve, UFrmSchPlanModfiy,
  UFrmStatiionPriceEdt, UFrmVehicletypestatusEdit, UFrmScheduleplanPlus,
  UFrmScheduleplanRoutePlus, UFrmSchedulestatusStop, UFrmSeatnumEdit,
  UFrmAddStationprice, UFrmSeatingInformation;
{$R *.dfm}

procedure TFrmSchPlanManage.allowScheduleplan(curid: int64);
var
  nResult: integer;
  sResult: string;
begin

  try
    with jcsdallowScheduleplan do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamByName('ip').Value := Sysinfo.LocalHostAddress;
      Params.ParamValues['departstationid'] := Sysinfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        Sysinfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�ָ���ͣ��β���ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmSchPlanManage.allowTicketsell(curid, departstationsid: int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jscdAllowTicketsell do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamValues['departstationid'] := departstationsid;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        Sysinfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('���۲���ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmSchPlanManage.canticketsellClick(Sender: TObject);
var msg: String;
begin
  inherited;
   if (jcdsResult.FieldByName('status').AsString <> '') then
   begin
     if (jcdsResult.FieldByName('status').AsString = '3') then
    begin
        if not SysDialogs.Confirm('��ʾ','ȷ��Ҫ�ָ���Ʊ��') then
          begin
            exit;
          end;
       with jcdscansaleticket do
      begin
        Close;
         Params.ParamValues['schedulename'] := jcdsResult.FieldByName('schedulename').AsString;
         Params.ParamValues['departdate'] := jcdsResult.FieldByName('departdate').AsString;
         Params.ParamValues['oldscheduleplanid'] := jcdsResult.FieldByName('id').AsString;
        Execute;
         msg := Params.ParamValues['msg'];
         Sysdialogs.showmessage(msg);
      end;
    end
    else
    begin
       begin
         Sysdialogs.showmessage('�ð�β��Ǳ���״̬�����ָܻ���Ʊ��');
      end;
    end;
       tbtnFilterClick(Sender);
   end;
end;

//ȡ���������  ���־  2015��6��16�� 15:55:41
procedure TFrmSchPlanManage.cancleshiftClick(Sender: TObject);
var msg: String;
begin
  inherited;
  //ȡ��ѡ�а�����һ�β���֮ǰ����λ״̬
  //��ȡѡ�а�ΰ��id �� ״̬  ���Ǳ���״̬(3)��ʾ����ȡ������
  if (jcdsResult.FieldByName('status').AsString <> '') then
  begin
      if (jcdsResult.FieldByName('status').AsString = '3') then
      begin
          with jsonCancelShift do
          begin
              Close;
              Params.ParamValues['schedulename'] := jcdsResult.FieldByName('schedulename').AsString;
              Params.ParamValues['departdate'] := jcdsResult.FieldByName('departdate').AsString;
              Params.ParamValues['oldscheduleplanid'] := jcdsResult.FieldByName('id').AsString;
              Execute;
              msg := Params.ParamValues['msg'];
              Sysdialogs.showmessage(msg);
          end;
      end
      else
      begin
         Sysdialogs.showmessage('�ð�β��Ǳ���״̬������ȡ�����࣡');
      end;
      tbtnFilterClick(Sender);
      end;
end;

procedure TFrmSchPlanManage.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if (jcdsResult.FieldByName('issaleafterreport').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clOlive;
    // dbgrdhResult.Canvas.Font.Color := clOlive;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // ��ͣ
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    Background := clRed; // clYellow;
    // dbgrdhResult.Canvas.Font.Color := clRed; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // ����
  if (jcdsResult.FieldByName('status').AsString = '3') and not
    (gdSelected in State) then
  begin
    Background := clOlive;
    // dbgrdhResult.Canvas.Font.Color := clLtGray; // clYellow;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // �Ѱ�
  if (jcdsResult.FieldByName('status').AsString = '4') and not
    (gdSelected in State) then
  begin
    Background := clYellow;
    // dbgrdhResult.Canvas.Font.Color := clOlive;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  // ͣ��
  if (jcdsResult.FieldByName('status').AsString = '5') and not
    (gdSelected in State) then
  begin
    Background := clFuchsia;
    // dbgrdhResult.Canvas.Font.Color := clFuchsia;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('reportvehicleno').AsString <> '') and not
    (gdSelected in State) then
  begin
    Background := clSkyBlue;
    // dbgrdhResult.Canvas.Font.Color := clBlue;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
  if (jcdsResult.FieldByName('isdeparted').AsBoolean) and not
    (gdSelected in State) then
  begin
    Background := clMoneyGreen;
    // dbgrdhResult.Canvas.Font.Color := clBlue;
    // dbgrdhResult.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

procedure TFrmSchPlanManage.dtpenddateChange(Sender: TObject);
begin
  inherited;
  if trunc(dtpstartdate.Date) > trunc(dtpenddate.Date) then
  begin
    dtpstartdate.Date := dtpenddate.Date;
  end;
end;

procedure TFrmSchPlanManage.dtpstartdateChange(Sender: TObject);
begin
  inherited;
  if trunc(dtpstartdate.Date) > trunc(dtpenddate.Date) then
  begin
    dtpenddate.Date := dtpstartdate.Date;
  end;

end;

procedure TFrmSchPlanManage.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCobbScheduleStatus.Active := false;
  NovaCobbScheduleStatus.Active := True;
end;

procedure TFrmSchPlanManage.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := Sysinfo.LoginUserInfo.UserID;
  dtpstartdate.Date := Now();
  dtpenddate.Date := Now();
  jcdsScheduleStatus.Active := false;
  jcdsScheduleStatus.Active := True;
  jcdsworkways.Active := false;
  jcdsworkways.Active := True;
  nvcbbType.Active := false;
  nvcbbType.Active := True;
  with NovaHCbbOrg do
  begin
    Active := false;
    Params.ParamValues['orgids'] := Sysinfo.LoginUserInfo.OrgIDs;
    Active := True;
    NovaHCbbOrg.SetItemIndexByField('id', Sysinfo.LoginUserInfo.StationID);
  end;
  nvhlproute.SetFocus;
end;

procedure TFrmSchPlanManage.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  // inherited;
  if GUIDToString(Key) = '{FB5B6A6A-E265-4034-9A92-1AF98F6BC770}' then //
  begin
    tbtnInsert.Visible := aEnable;
  end;
  // �޸�
  if GUIDToString(Key) = '{5C8F9473-2269-409A-AE82-B6F90EA95F01}' then
  begin
    tbtnEdit.Visible := aEnable;
  end;
  // ����Excel
  if GUIDToString(Key) = '{1B056E18-9825-4026-B655-EAC57161CE3C}' then
  begin
    tbtnDelete.Visible := aEnable;
  end;
  // �Ӱ�
  if GUIDToString(Key) = '{CB172F0A-9A3D-476D-826E-ABC93C6A0F5A}' then
  begin
    ToolButton50.Visible := aEnable;
  end;
  // ��λ��
  if GUIDToString(Key) = '{2E143F92-9E0F-4C73-8C93-6157278D312A}' then
  begin
    ToolButton51.Visible := aEnable;
  end;
  // ͣ��/����
  if GUIDToString(Key) = '{4244307F-AED1-422B-A440-37C19E32F148}' then
  begin
    tbtnSave.Visible := aEnable;
  end;
  // ������Ʊ
  if GUIDToString(Key) = '{154E140B-FFA4-4C98-9B86-DBF3F03C3A3D}' then
  begin
    tbtnCancel.Visible := aEnable;
  end;
  // ͣ��
  if GUIDToString(Key) = '{7502E6AC-AB7A-4149-BD01-F94D84CF22BB}' then
  begin
    ToolButton52.Visible := aEnable;
  end;
  // ����
  if GUIDToString(Key) = '{1837213A-30BF-42AA-8DF5-F6DC72174F39}' then
  begin
    ToolButton53.Visible := aEnable;
  end;
  // ͣ����
  if GUIDToString(Key) = '{9B901772-EC39-4B0D-975A-5E2F1C8FBFD1}' then
  begin
    tbtn4.Visible := aEnable;
  end;
  //��λ��Ϣ
  if GUIDToString(Key) = '{2B3BF9FD-4280-46AD-A10C-6B15452682E9}' then
  begin
    seatinfo.Visible := aEnable;
  end;
  //ȡ������
  if GUIDToString(Key) = '{6B49FC01-E576-4801-ABC7-5A93FBB1B2B4}' then
  begin
    cancleshift.Visible := aEnable;
  end;
  //�ָ���Ʊ
  if GUIDToString(Key) = '{8D3533AD-C69F-4CF7-A50E-2A3954E8B4C8}' then
  begin
    canticketsell.Visible := aEnable;
  end;

  // ��ӡ
  if GUIDToString(Key) = '{766157C9-A126-46B8-BF4C-9E487976E178}' then
  begin
    tbtnPrinter.Visible := aEnable;
  end;
end;

procedure TFrmSchPlanManage.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;

  if jcdsResult.FieldByName('status').AsString = '1' then // ��ͣ
  begin
    tbtnSave.Caption := '�ָ�';
  end
  else
  begin
    tbtnSave.Caption := 'ͣ��';
  end;

  if jcdsResult.FieldByName('vcstatus').AsString = '����' then // ����
  begin
    ToolButton52.Caption := 'ͣ��';
  end
  else if jcdsResult.FieldByName('vcstatus').AsString = 'ͣ��' then
  begin
    ToolButton52.Caption := '����';
  end;
  if self.jcdsResult.FieldByName('issaleafterreport').AsBoolean then
    tbtnCancel.Caption := '������Ʊ'
  else
    tbtnCancel.Caption := '������Ʊ';
  // �ѷ��࣬���޸�Ʊ�� ,�����ڿͻ��˿��ƣ��������ڿ�����͵㻹δ����Ӧ�����޸�
  { if jcdsResult.FieldByName('isdeparted').AsBoolean then
    tbtnDelete.Enabled := false
    else
    tbtnDelete.Enabled := true; }

end;

procedure TFrmSchPlanManage.ModelPlus(Sender: TObject);
var
  newid: int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    SysDialogs.ShowMessage('���ȵ����ѯ��');
  // exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    SysDialogs.ShowMessage('��ˮ�಻��Ҫ�Ӱ࣡');
    exit;
  end;

  begin
    FrmScheduleplanPlus := TFrmScheduleplanPlus.Create(self);
    with FrmScheduleplanPlus do
    begin
      Caption := 'ģ��Ӱ�';
      scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaHelpRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
      NvHcbbVehiclebrandmodel.Text := jcdsResult.FieldByName('brandmodelname')
        .AsString;
      NvHcbbVehiclebrandmodel.Id := jcdsResult.FieldByName
        ('vehiclebrandmodelid').AsLargeInt;
      NEdtPLANSEATNUM.Text := jcdsResult.FieldByName('seatnum').AsString;
      // NvHcbbVehiclebrandmodelChange(Sender);

      // dtpStartdate_p.Mindate := Date;
      // dtpEnddate_p.Mindate := Date;
      if dtpstartdate.Date >= trunc(Now) then
      begin
        dtpStartdate_p.Date := dtpstartdate.Date;
        dtpEnddate_p.Date := dtpstartdate.Date;
      end
      else
      begin
        dtpStartdate_p.Date := Now;
        dtpEnddate_p.Date := Now;
      end;
      CobWORKTYPE.SetItemIndexByCode
        (jcdsResult.FieldByName('worktype').AsString);
      if SysMainForm.showFormModal(FrmScheduleplanPlus, false) = mrOk then
      begin
        newid := scheduleplanid;
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', newid, []);
      end;
    end;
  end;

end;

procedure TFrmSchPlanManage.nvhlprouteIdChange(Sender: TObject);
begin
  parameter := getParametervalue('2018', Sysinfo.LoginUserInfo.OrgID);
  if parameter = '1' then
  begin
    tbtnFilterClick(Sender);
    self.nvhlproute.SelectAll;
  end;
end;

procedure TFrmSchPlanManage.RoutePlus(Sender: TObject);
var
  newid: int64;
begin
  inherited;

  begin
    FrmScheduleplanRoutePlus := TFrmScheduleplanRoutePlus.Create(self);
    try
      with FrmScheduleplanRoutePlus do
      begin
        Caption := '���߼Ӱ�';
        if dtpstartdate.Date >= trunc(Now) then
        begin
          dtpStartdate_p.Date := dtpstartdate.Date;
          dtpEnddate_p.Date := dtpstartdate.Date;
        end
        else
        begin
          dtpStartdate_p.Date := Now;
          dtpEnddate_p.Date := Now;
        end;
        if SysMainForm.showFormModal(FrmScheduleplanRoutePlus, false)
          = mrOk then
        begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('scheduleid', scheduleid, []);
        end;
      end;
    finally
      FreeAndNil(FrmScheduleplanRoutePlus);
    end;
  end;

end;



procedure TFrmSchPlanManage.stopTicketsell(curid, departstationsid: int64);
var
  nResult: integer;
  sResult: string;
begin
  try
    with jscdStopTicketsell do
    begin
      Active := false;
      Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := curid;
      Params.ParamValues['departstationid'] := departstationsid;
      Params.ParamValues['vehiclepeopleplan.createby'] :=
        Sysinfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('ͣ�۲���ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmSchPlanManage.tbtn4Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  FrmAddStationprice := TFrmAddStationprice.Create(self);
  with FrmAddStationprice do
  begin
    Caption := '���ͣ��վ��Ʊ��';
    departstationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    if SysMainForm.showFormModal(FrmAddStationprice, false) = mrOk then
    begin
      //
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnCancelClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  curid: int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫ' + tbtnCancel.Caption + '��') then
    exit;

  curid := jcdsResult.FieldByName('id').AsLargeInt;
  try
    with jscdUpdateSale do
    begin
      Active := false;
      Params.ParamValues['scheduleplanid'] := curid;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);

        tbtnFilterClick(nil);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�ָ�������Ʊ����ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnDeleteClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  begin
    FrmStatiionPriceEdt := TFrmStatiionPriceEdt.Create(self);
    with FrmStatiionPriceEdt do
    begin
      // dtpstartdate.Enabled := false;
      dtpstartdate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
      dtpenddate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
      routeid := jcdsResult.FieldByName('routeid').AsLargeInt;
      edtroute.Text := jcdsResult.FieldByName('routename').AsString;
      edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
      scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmStatiionPriceEdt, false) = mrOk then
      begin
        // tbtnFilterClick(sender);
        // jcdsResult.Locate('id',curid,[]);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnEditClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  { if formatdatetime('yyyymmdd',
    jcdsResult.FieldByName('departdate').AsDateTime) < formatdatetime
    ('yyyymmdd', Now) then
    begin
    SysDialogs.Warning('�ѹ��������ڲ������޸ģ�');
    exit;
    end; }

  begin
    FrmSchPlanModfiy := TFrmSchPlanModfiy.Create(self);
    with FrmSchPlanModfiy do
    begin
      dpstartdate.Enabled := false;
      dpstartdate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
      dpenddate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
      edtroute.Text := jcdsResult.FieldByName('routename').AsString;
      edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
      edtstarttime.DateTime := jcdsResult.FieldByName('departtime').AsDateTime;
      routeid := jcdsResult.FieldByName('routeid').AsLargeInt;

      departstationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
      scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
      curid := scheduleplanid;
      edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
      edtschedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
      // dpstartdate.Mindate := Date;
      // dpenddate.Mindate := Date;

      buspark := jcdsResult.FieldByName('buspark').AsString;
      ticketentrance := jcdsResult.FieldByName('ticketentrance').AsString;
      departtime := jcdsResult.FieldByName('departtime').AsString;
      schedulestatusid := jcdsResult.FieldByName('schedulestatusid').AsLargeInt;
      chkWorkline.Checked := jcdsResult.FieldByName('islinework').AsBoolean;
      CobWORKTYPE.SetItemIndexByCode
        (jcdsResult.FieldByName('worktype').AsString);

      CobWORKWAYS.SetItemIndexByCode
        (jcdsResult.FieldByName('workways').AsString);
      EdtRemark.Text := jcdsResult.FieldByName('remarks').AsString;
      if formatdatetime('yyyymmdd',
        jcdsResult.FieldByName('departdate').AsDateTime) < formatdatetime
        ('yyyymmdd', Now) then
      begin
        CobWORKTYPE.Enabled := false;
        chkWorkline.Enabled := false;
        nvdbgrdh2.Enabled := false;
        edtstarttime.Enabled := false;
      end;
      if SysMainForm.showFormModal(FrmSchPlanModfiy, false) = mrOk then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.tbtnFilterClick(Sender: TObject);
var
  planid: int64;
begin
  inherited;
  if (trunc(dtpenddate.Date - dtpstartdate.Date) > 0) and
    ((self.nvhlproute.Text = '') and (NovaCobbScheduleStatus.ItemIndex < 2)
      and (nvhlpschedule.Text = '')) then
  begin
    SysDialogs.Warning('δ����Ӫ����·����λ���״̬��ѯ������ֻ�ܲ�ѯһ��İ�����мƻ���Ϣ��');
    exit;
  end;

  if (StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID)) <= trunc
      (dtpenddate.Date - dtpstartdate.Date)) then
  begin
    SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  planid := 0;
  if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
    planid := jcdsResult.FieldByName('id').AsLargeInt;
  with jcdsResult do
  begin
    Active := false;
    if nvhlpDeparts.Id = 0 then
      Params.ParamValues['filter_EQL_ss!departstationid'] := null
    else
      Params.ParamValues['filter_EQL_ss!departstationid'] := nvhlpDeparts.Id;
    {
    // �˴�Ϊ����������Ӧ��վ��ID
    Params.ParamValues['departstationid'] := NovaHCbbOrg.HelpFieldValue['id'];
    }

    { 20160413��Ѩ����
    ��Ʊ����ʼ����Σ�����Ʊ����Ϊ�������в�ѯ (���뷢��վ���ɲ�ѯ)
    }
    //�������վid�������stationid��ͬ���������Ӧ��վ��ID(�ò���)ȡ�ؼ��еķ���վid������ȡ������stationid
    if (nvhlpDeparts.Id > 0) and (nvhlpDeparts.Id <> StrToInt(NovaHCbbOrg.HelpFieldValue['id'])) then
    begin
      Params.ParamValues['departstationid'] := nvhlpDeparts.Id;
    end
    else
    begin
      Params.ParamValues['departstationid'] := NovaHCbbOrg.HelpFieldValue['id'];
    end;

    Params.ParamValues['filter_GED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_sp!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpenddate.Date);

    Params.ParamValues['fromdate'] := formatdatetime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := formatdatetime('yyyy-mm-dd',
      dtpenddate.Date);
    if trim(nvhlpschedule.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_s!id'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_s!id'] := nvhlpschedule.Id;
    end;
    if trim(nvhlproute.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_r!id'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
    end;
    if trim(nvhlpendstation.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := '';
    end
    else
    begin
      Params.ParamValues['filter_EQL_sv!planvehicleid'] := nvhlpendstation.Id;
    end;
    if (ChkIsDepart.Checked) and (not ChkIsNotDepart.Checked) then
    begin
      Params.ParamValues['filter_EQS_ss!isdeparted'] := 1;
    end
    else if (not ChkIsDepart.Checked) and (ChkIsNotDepart.Checked) then
    begin
      Params.ParamValues['filter_EQS_ss!isdeparted'] := 0;
    end
    else
    begin
      Params.ParamValues['filter_EQS_ss!isdeparted'] := null;
    end;

    if trim(nvhlpvehicletype.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_vt!id'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQL_vt!id'] := nvhlpvehicletype.Id;
    end;
    if NovaCobbScheduleStatus.ItemIndex <= 0 then
    begin
      Params.ParamValues['filter_EQS_ss!status'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQS_ss!status'] :=
        NovaCobbScheduleStatus.GetSelectCode;
    end;
    if ((yes.Checked) and (no.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := 'true';
    end
    else if ((yes.Checked = false) and (no.Checked)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := 'false';
    end
    else if ((yes.Checked) and (no.Checked)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := null;
    end
    else if ((yes.Checked = false) and (no.Checked = false)) then
    begin
      Params.ParamValues['filter_EQB_sp!isovertime'] := null;
    end;
    if (trim(nvhlpunit.Text) = '') or (nvhlpunit.Id = 0) then
    begin
      Params.ParamValues['filter_EQL_vrr!unitid'] := null;
    end
    else
    begin
      Params.ParamValues['filter_EQL_vrr!unitid'] := nvhlpunit.Id;
    end;
    if chkIssaleafterreport.Checked then
      Params.ParamValues['filter_EQB_sp!issaleafterreport'] := True
    else
      Params.ParamValues['filter_EQB_sp!issaleafterreport'] := null;
    if nvcbbType.GetSelectID <> '' then
      Params.ParamValues['filter_INS_s!districttype'] := nvcbbType.GetSelectID
    else
      Params.ParamValues['filter_INS_s!districttype'] := null;

    if ChkFullseats.Checked then
      Params.ParamValues['isfullseat'] := True
    else
      Params.ParamValues['isfullseat'] := false;

    Active := True;
    if planid > 0 then
    begin
      jcdsResult.Locate('id', planid, []);
    end;

  end;
end;

procedure TFrmSchPlanManage.seatinfoClick(Sender: TObject);
begin
  inherited;
    if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
//  if (jcdsResult.FieldByName('status').AsString = '1') then
//  begin
//    SysDialogs.ShowMessage('�ð���Ѿ�ͣ�࣬������λ��');
//    exit;
//  end;
  with FrmSeatingInformation do
  begin
    FrmSeatingInformation := TFrmSeatingInformation.Create(self);
    Caption := '��λ��Ϣ';

   edtroute.Text := jcdsResult.FieldByName('routename').AsString;
    routeid := jcdsResult.FieldByName('routeid').AsInteger;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    departstationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    departdate := jcdsResult.FieldByName('departdate').AsDateTime;
    dtpstartdate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
    departtime := jcdsResult.FieldByName('departtime').AsString;
    brandModelid := jcdsResult.FieldByName('vehiclebrandmodelid').AsInteger;
    districttype := jcdsResult.FieldByName('districttype').AsInteger;
    NovaEdtDepartTime.Text := jcdsResult.FieldByName('departtime').AsString;
     ShowModal;
  end;

end;
procedure TFrmSchPlanManage.tbtnInsertClick(Sender: TObject);
var
  departdatetime: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if (jcdsResult.FieldByName('status').AsString = '1') then
  begin
    SysDialogs.ShowMessage('�ð���Ѿ�ͣ�࣬������λ��');
    exit;
  end;
  if jcdsResult.FieldByName('islinework').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('�ð������ˮ�࣬������λ��');
    exit;
  end;
  if jcdsResult.FieldByName('isdeparted').AsBoolean = True then
  begin
    SysDialogs.ShowMessage('�ð���ѷ��࣬������λ��');
    exit;
  end;
  // departdatetime := jcdsResult.FieldByName('departdate').asstring +' '+
  // jcdsResult.FieldByName('departtime').asstring +':00';
  // if StringToDateTime(departdatetime) < now then
  // begin
  // SysDialogs.ShowMessage('�ð���ѹ�����ʱ�䣬������λ');
  // exit;
  // end;

  with FrmSchSeatReserve do
  begin
    FrmSchSeatReserve := TFrmSchSeatReserve.Create(self);
    Caption := '��λ/ȡ����λ';
    edtroute.Text := jcdsResult.FieldByName('routename').AsString;
    routeid := jcdsResult.FieldByName('routeid').AsInteger;
    // edtstartdate.text := jcdsResult.FieldByName('departdate').AsString;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    // edtplanvehicle.text := jcdsResult.FieldByName('vehicleno').AsString;
    // OrgID := jcdsResult.FieldByName('orgid').AsLargeInt;
    departstationid := jcdsResult.FieldByName('departstationid').AsLargeInt;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsLargeInt;
    scheduleplanid := jcdsResult.FieldByName('id').AsLargeInt;
    departdate := jcdsResult.FieldByName('departdate').AsDateTime;
    dtpstartdate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
    departtime := jcdsResult.FieldByName('departtime').AsString;
    brandModelid := jcdsResult.FieldByName('vehiclebrandmodelid').AsInteger;
    districttype := jcdsResult.FieldByName('districttype').AsInteger;
    NovaEdtDepartTime.Text := jcdsResult.FieldByName('departtime').AsString;
    // chkAutoCancel.Checked := True;
    cds := jcdsResult;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', scheduleplanid, []);
    end;
  end;
end;

// ���ַ�����ʽ"yyyy-mm-dd hh:mm:ss" ת��Ϊ����ʱ���ʽ
function TFrmSchPlanManage.StringToDateTime(ADateTimeStr: string): TDateTime;
var
  AFormatSettings: TFormatSettings;
  ShortDateFormat, ShortTimeFormat: string;
  DateSeparator, TimeSeparator: char;
begin
  ShortDateFormat := 'yyyy-MM-dd';
  DateSeparator := '-';
  ShortTimeFormat := 'HH:mm:ss';
  TimeSeparator := ':';
  AFormatSettings.ShortDateFormat := ShortDateFormat;
  AFormatSettings.DateSeparator := DateSeparator;
  AFormatSettings.ShortTimeFormat := ShortTimeFormat;
  AFormatSettings.TimeSeparator := TimeSeparator;
  Result := StrToDateTime(ADateTimeStr, AFormatSettings);
end;

procedure TFrmSchPlanManage.tbtnSaveClick(Sender: TObject);
var
  scheduleplanid: int64;
begin
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('isdeparted').AsBoolean then
  begin
    SysDialogs.ShowInfo('�ð���Ѿ����࣬���ܽ���' + tbtnSave.Caption + '����');
    exit;
  end;
  checkticketstatus(Sender);
  if ischecked then
  begin
    SysDialogs.ShowInfo('�ð���Ѿ���ʼ��Ʊ�����ܽ���ͣ�ദ��');
    exit;
  end;
  scheduleplanid := jcdsResult.FieldByName('id').AsInteger;
  begin
    FrmSchedulestatusStop := TFrmSchedulestatusStop.Create(self);
    with FrmSchedulestatusStop do
    begin
      Caption := '���ͣ��/���ദ��';
      if jcdsResult.FieldByName('status').AsString = '1' then
      begin
        cbbOpertype.ItemIndex := 1;
        Label5.Caption := '�ָ�ԭ��';
        // DTPStartDay.Mindate := Date-3;
        // DTPEndDay.Mindate := Date-3;
      end
      else
      begin
        if formatdatetime('yyyymmdd',
          jcdsResult.FieldByName('departdate').AsDateTime) < formatdatetime
          ('yyyymmdd', Now) then
        begin
          SysDialogs.ShowInfo('���ܶԹ��ڵİ�ν���ͣ�ദ��');
          exit;
        end;
        if (jcdsResult.FieldByName('unautocancelreserveseatnum').AsLargeInt<>0) or
           (jcdsResult.FieldByName('fixedreserveseatnum').AsLargeInt<>0) or
           (jcdsResult.FieldByName('soldeatnum').AsLargeInt<>0) or
           (jcdsResult.FieldByName('localsell').AsLargeInt<>0) or
           (jcdsResult.FieldByName('othersell').AsLargeInt<>0) then
        if not SysDialogs.Confirm('��Ϣ��ʾ','�ð������λ�����۳���Ʊ,�Ƿ�ͣ��?') then
        exit;
//        if jcdsResult.FieldByName('begincheck').AsBoolean then
//        begin
//           SysDialogs.Warning('�ð���ѿ���,������ͣ��!');
//           exit;
//        end;
        cbbOpertype.ItemIndex := 0;
        Label5.Caption := 'ͣ��ԭ��';
        DTPStartDay.Mindate := Date;
        DTPEndDay.Mindate := Date;

      end;
      NovaHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaHelpRoute.Id := jcdsResult.FieldByName('routeid').AsInteger;
      NovaHelpSchedule.Text := jcdsResult.FieldByName('schedulename').AsString;
      NovaHelpSchedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
      cbbOpertype.Enabled := false;

      DTPStartDay.Date := jcdsResult.FieldByName('departdate').AsDateTime;
      DTPEndDay.Date := jcdsResult.FieldByName('departdate').AsDateTime;

      if SysMainForm.showFormModal(FrmSchedulestatusStop, false) = mrOk then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('id', scheduleplanid, []);
      end;
    end;
  end;
end;

procedure TFrmSchPlanManage.ToolButton51Click(Sender: TObject);
var
  reservenum, fixedreserveseatnum, autocancelreserveseatnum,
    unautocancelreserveseatnum: integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  { if jcdsResult.FieldByName('islinework').AsBoolean then
    begin
    SysDialogs.ShowMessage('�ð������ˮ�࣬����Ҫ�޸���λ����');
    exit;
    end; }
  { if (not jcdsResult.FieldByName('islinework').AsBoolean)
    and (jcdsResult.FieldByName('begincheck').AsBoolean) then
    begin
    SysDialogs.ShowMessage('�ð���Ѿ����࣬���ܽ��е�����');
    exit;
    end;
    if jcdsResult.FieldByName('soldeatnum').AsInteger > 0 then
    begin
    if not SysDialogs.Confirm('��Ϣ��ʾ', '��Ӫ�˰���Ѿ���Ʊ���Ƿ�Ҫ�޸���λ����') then
    exit;
    end; }
  with FrmSeatnumEdit do
  begin
    FrmSeatnumEdit := TFrmSeatnumEdit.Create(self);
    Caption := '��λ������';
    sign := false;
    Id := jcdsResult.FieldByName('id').AsString;
    edtroute.Text := jcdsResult.FieldByName('routename').AsString;
    edtstartdate.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    edtplanvehicle.Text := jcdsResult.FieldByName('vehicleno').AsString;
    edtsoldeatnum.Text := jcdsResult.FieldByName('soldeatnum').AsString;
    edtseatnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    fixedreserveseatnum := jcdsResult.FieldByName('fixedreserveseatnum')
      .AsInteger;
    autocancelreserveseatnum := jcdsResult.FieldByName
      ('autocancelreserveseatnum').AsInteger;
    unautocancelreserveseatnum := jcdsResult.FieldByName
      ('unautocancelreserveseatnum').AsInteger;
    reservenum := fixedreserveseatnum + autocancelreserveseatnum +
      unautocancelreserveseatnum;
    edtreservenum.Text := IntToStr(reservenum);
    edtnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    dtp1.DateTime := jcdsResult.FieldByName('departdate').AsDateTime;
    departdate := jcdsResult.FieldByName('departdate').AsDateTime;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsString;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', Id, []);
    end;
  end;
end;

procedure TFrmSchPlanManage.ToolButton52Click(Sender: TObject);
var
  curid, departstationsid: int64;
begin
  inherited;
  // ͣ�۲���
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if SysDialogs.Confirm(tbtnSave.Caption + '����',
    'ȷ��Ҫ' + ToolButton52.Caption + '�ð����') then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
    departstationsid := jcdsResult.FieldByName('departstationid').AsLargeInt;
    //
    if jcdsResult.FieldByName('status').AsString = '5' then
    begin
      allowTicketsell(curid, departstationsid) // ����
    end
    else
      stopTicketsell(curid, departstationsid); // ͣ��
  end;
end;

procedure TFrmSchPlanManage.ToolButton53Click(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if jcdsResult.FieldByName('begincheck').AsBoolean then
  begin
    SysDialogs.ShowMessage('��Ӫ�˰���Ѿ���Ʊ�����ܽ��е�����');
    exit;
  end;
  if jcdsResult.FieldByName('islinework').AsBoolean then
  begin
    SysDialogs.ShowMessage('�ð��Ϊ��ˮ�࣬����Ҫ�������ͣ�');
    exit;
  end;
  with FrmVehicletypestatusEdit do
  begin
    FrmVehicletypestatusEdit := TFrmVehicletypestatusEdit.Create(self);
    Caption := '��������';
    sign := false;
    Id := jcdsResult.FieldByName('schedulevehiclepeopleplanid').AsLargeInt;
    edtroute.Text := jcdsResult.FieldByName('routename').AsString;
    edtschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    edtstartdate.Text := jcdsResult.FieldByName('departdate').AsString;
    edtdeparttime.Text := jcdsResult.FieldByName('departtime').AsString;
    edtstartstation.Text := jcdsResult.FieldByName('startroutename').AsString;
    edtendstation.Text := jcdsResult.FieldByName('endroutename').AsString;
    nvhlptypename.Id := jcdsResult.FieldByName('vehicletypeid').AsLargeInt;
    nvhlptypename.Text := jcdsResult.FieldByName('vtname').AsString;
    edtbrandmodel.Id := jcdsResult.FieldByName('vehiclebrandmodelid')
      .AsLargeInt;
    edtbrandmodel.Text := jcdsResult.FieldByName('brandmodelname').AsString;
    // edtbrandmodel.Text := cbbVehiclebrandmodel.Text;
    // cbbplanvehicletype.Text := jcdsResult.FieldByName('vtname').AsString;

    // edtbrandmodel.Text := jcdsResult.FieldByName('brandmodelname').AsString;
    // nvhlptypename.Text := jcdsResult.FieldByName('vtname').AsString;
    edtseatnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    // edtnum.Text := jcdsResult.FieldByName('seatnum').AsString;
    planid := jcdsResult.FieldByName('id').AsLargeInt;
    nvhelpVehicleno.Id := jcdsResult.FieldByName('planvehicleid').AsLargeInt;
    nvhelpVehicleno.Text := jcdsResult.FieldByName('vehicleno').AsString;
    nvhlpunit.Id := jcdsResult.FieldByName('planunitid').AsLargeInt;
    nvhlpunit.Text := jcdsResult.FieldByName('planunit').AsString;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', planid, []);
    end;
  end;

end;

procedure TFrmSchPlanManage.checkticketstatus(sender: TObject);
begin
  with jsoncheck do
  begin
    Active := False;
    Params.ParamValues['schedulecode'] := jcdsResult.FieldByName('schedulename').AsString;
    Params.ParamValues['departdate'] := formatdatetime
      ('yyyy-mm-dd', jcdsResult.FieldByName('departdate').AsDateTime);
    Active := True;
    ischecked := False;
    while not Eof do
    begin
      if FieldByName('ischecked').AsBoolean then
      ischecked := True;
      Next;
    end;
  end;
end;

end.

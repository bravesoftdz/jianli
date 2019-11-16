unit UFrmBalanceformulaApplyEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmBalanceformulaApplyEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    LabRemark: TLabel;
    Label10: TLabel;
    DTPBuildStartDay: TDateTimePicker;
    DTPBuildEndDay: TDateTimePicker;
    GroupBox1: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    NovaHelpRoute: TNovaHelp;
    NovaHelpSchedule: TNovaHelp;
    NovaHelpUnit: TNovaHelp;
    NovaHelpVehicle: TNovaHelp;
    MeRemark: TMemo;
    NovaCobTarget: TNovaHComboBox;
    jcdsSaveApply: TjsonClientDataSet;
    Label12: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    LabRoute: TLabel;
    LabOrg: TLabel;
    LabUnit: TLabel;
    LabVehicle: TLabel;
    LabSchedule: TLabel;
    NovaHCobFormula: TNovaHComboBox;
    NovaHCobOrg: TNovaHComboBox;
    procedure FormCreate(Sender: TObject);
    procedure NovaCobTargetChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    id, createby, balanceformulaid: int64;
    createtime: String;
    isauditpass, isaudited: boolean;
  end;

var
  FrmBalanceformulaApplyEdt: TFrmBalanceformulaApplyEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmBalanceformulaApplyEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result: String;
  scheduleid, vehicleid, routeid, orgid, unitid: int64;
begin
  inherited;
  scheduleid := 0;
  vehicleid := 0;
  routeid := 0;
  unitid := 0;
  orgid := 0;
  if NovaCobTarget.ItemIndex < 0 then
  begin
    SysDialogs.Warning('������ѡ��۷Ѷ���');
    NovaCobTarget.SetFocus;
    exit;
  end;
  if NovaHCobFormula.ItemIndex<0 then
  begin
    SysDialogs.Warning('��ѡ��۷ѹ�ʽ��');
    NovaHCobFormula.SetFocus;
    exit;
  end;
  if (formatdatetime('yyyymmdd', DTPBuildStartDay.Date) > formatdatetime
      ('yyyymmdd', DTPBuildEndDay.Date)) then
  begin
    SysDialogs.Warning('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    DTPBuildStartDay.SetFocus;
    exit;
  end;
  if NovaCobTarget.ItemIndex = 0 then
  begin
    // ����+���
    if (trim(NovaHelpSchedule.Text) = '') or (NovaHelpSchedule.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˰�Σ�');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    if (trim(NovaHelpVehicle.Text) = '') or (NovaHelpVehicle.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˳�����');
      NovaHelpVehicle.SetFocus;
      exit;
    end;
    scheduleid := NovaHelpSchedule.id;
    vehicleid := NovaHelpVehicle.id;
  end
  else if NovaCobTarget.ItemIndex = 1 then
  begin
    // Ӫ�˵�λ+���
    if (trim(NovaHelpSchedule.Text) = '') or (NovaHelpSchedule.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˰�Σ�');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˵�λ��');
      NovaHelpUnit.SetFocus;
      exit;
    end;
    scheduleid := NovaHelpSchedule.id;
    unitid := NovaHelpUnit.id;
  end
  else if NovaCobTarget.ItemIndex = 2 then
  begin
    // ����
    if (trim(NovaHelpVehicle.Text) = '') or (NovaHelpVehicle.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˳�����');
      NovaHelpVehicle.SetFocus;
      exit;
    end;
    vehicleid := NovaHelpVehicle.id;
  end
  else if NovaCobTarget.ItemIndex = 3 then
  begin
    // ���
    if (trim(NovaHelpSchedule.Text) = '') or (NovaHelpSchedule.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˰�Σ�');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    scheduleid := NovaHelpSchedule.id;
  end
  else if NovaCobTarget.ItemIndex = 4 then
  begin
    // Ӫ�˵�λ+��·
    if (trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ����·��');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˵�λ��');
      NovaHelpUnit.SetFocus;
      exit;
    end;
    routeid := NovaHelpRoute.id;
    unitid := NovaHelpUnit.id;
  end
  else if NovaCobTarget.ItemIndex = 5 then
  begin
    // Ӫ�˵�λ
    if (trim(NovaHelpUnit.Text) = '') or (NovaHelpUnit.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ�˵�λ��');
      NovaHelpUnit.SetFocus;
      exit;
    end;
    unitid := NovaHelpUnit.id;
  end
  else if NovaCobTarget.ItemIndex = 6 then
  begin
    // ��·
    if (trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.id = 0) then
    begin
      SysDialogs.Warning('������Ӫ����·��');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    routeid := NovaHelpRoute.id;
  end
  else if NovaCobTarget.ItemIndex = 7 then
  begin
    // ����
    if NovaHCobOrg.ItemIndex < 0 then
    begin
      SysDialogs.Warning('��ѡ�������');
      NovaHCobOrg.SetFocus;
      exit;
    end;
    orgid := NovaHCobOrg.HelpFieldValue['id'];
  end;
  try
    with jcdsSaveApply do
    begin
      active := false;
      Params.ParamValues['balanceformulaapply.id'] := id;
      Params.ParamValues['balanceformulaapply.balanceformulaid'] :=
        NovaHCobFormula.HelpFieldValue['id'];
      Params.ParamValues['balanceformulaapply.balancededucttargetid'] :=
        NovaCobTarget.HelpFieldValue['id'];
      Params.ParamValues['balanceformulaapply.createby'] := createby;
      Params.ParamValues['balanceformulaapply.createtime'] := createtime;
      Params.ParamValues['balanceformulaapply.enddate'] := formatdatetime
        ('yyyy-mm-dd', DTPBuildEndDay.Date);
      Params.ParamValues['balanceformulaapply.isaudited'] := isaudited;
      Params.ParamValues['balanceformulaapply.isauditpass'] := isauditpass;
      Params.ParamValues['balanceformulaapply.remarks'] := MeRemark.Text;
      if routeid > 0 then
        Params.ParamValues['balanceformulaapply.route.id'] := routeid;
      if scheduleid > 0 then
        Params.ParamValues['balanceformulaapply.schedule.id'] := scheduleid;
      Params.ParamValues['balanceformulaapply.startdate'] := formatdatetime
        ('yyyy-mm-dd', DTPBuildStartDay.Date);
      if unitid > 0 then
        Params.ParamValues['balanceformulaapply.unit.id'] := unitid;
      if vehicleid > 0 then
        Params.ParamValues['balanceformulaapply.vehicle.id'] := vehicleid;
      if orgid > 0 then
        Params.ParamValues['balanceformulaapply.org.id'] := orgid;
      bbtnSave.Enabled := true;//���水ť������
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        log := result +'��ʽ�۷���ĿӦ�ã��۷Ѷ���='+NovaCobTarget.Text+',�۷�����='
        +NovaHCobFormula.Text+',��ʼ����='+formatdatetime('yyyy-mm-dd', DTPBuildStartDay.Date)+
        ',��������='+formatdatetime('yyyy-mm-dd', DTPBuildEndDay.Date);
        if NovaCobTarget.ItemIndex = 0 then
        begin
          log := log + ',���='+NovaHelpSchedule.Text+',����='+
          NovaHelpVehicle.Text;
        end
        else if NovaCobTarget.ItemIndex = 1 then
        begin
          log := log + ',���'+NovaHelpSchedule.Text+',Ӫ�˵�λ='+
          NovaHelpUnit.Text;
        end
        else if NovaCobTarget.ItemIndex = 2 then
        begin
          log := log +',���ƺ�='+NovaHelpVehicle.Text;
        end
        else if NovaCobTarget.ItemIndex = 3 then
        begin
          log:=log+',���='+NovaHelpSchedule.Text;
        end
        else if NovaCobTarget.ItemIndex = 4 then
        begin
          log := log +',Ӫ�˵�λ='+NovaHelpUnit.Text+',��·='+
          NovaHelpRoute.Text;
        end
        else if NovaCobTarget.ItemIndex = 5 then
        begin
          log:=log+',Ӫ�˵�λ='+NovaHelpUnit.Text;
        end
        else if NovaCobTarget.ItemIndex = 6 then
        begin
          log:=log+',��·='+NovaHelpRoute.Text;
        end
        else if NovaCobTarget.ItemIndex = 7 then
        begin
          log:=log+',����='+NovaHCobOrg.Text;
        end;
        SysLog.WriteLog('�������->��ʽ�۷���ĿӦ��',result,log);
        id := Params.ParamByName('curid').Value;
        SysDialogs.ShowMessage(sResult);

        if (self.edittype = Tedittype.add) then
        begin
          //��Ӳ��������ر�ҳ��
          bbtnSave.Enabled := True;//���水ť��Ϊ����
          //��տؼ���ֵ
          id := 0;
          NovaHCobOrg.Clear;
          NovaHelpRoute.Clear;
          NovaHelpSchedule.Clear;
          NovaHelpUnit.Clear;
          NovaHelpVehicle.Clear;
          MeRemark.Clear;
        end
        else
        begin
          ModalResult := mrok;
        end;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        DTPBuildStartDay.SetFocus;
         bbtnSave.Enabled := True;//���水ť��Ϊ����
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('������㹫ʽ�۷���ĿӦ�ò���ʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmBalanceformulaApplyEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCobTarget.active := false;
  NovaCobTarget.active := true;
  NovaHCobOrg.active := false;
  NovaHCobOrg.active := true;
  NovaHCobFormula.Active:=false;
  NovaHCobFormula.Active:=true;
end;

procedure TFrmBalanceformulaApplyEdt.NovaCobTargetChange(Sender: TObject);
begin
  inherited;
  if NovaCobTarget.ItemIndex = 0 then
  begin
    // ����+���
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := true;
    NovaHelpSchedule.SetFocus;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := true;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := true;
    self.LabSchedule.Visible := true;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := false;
    self.LabRoute.Visible := false;
  end
  else if NovaCobTarget.ItemIndex = 1 then
  begin
    // Ӫ�˵�λ+���
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := true;
    NovaHelpSchedule.SetFocus;
    NovaHelpUnit.Enabled := true;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := false;
    self.LabSchedule.Visible := true;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := true;
    self.LabRoute.Visible := false;

  end
  else if NovaCobTarget.ItemIndex = 2 then
  begin
    // ����
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := true;
    NovaHelpVehicle.SetFocus;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := true;
    self.LabSchedule.Visible := false;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := false;
    self.LabRoute.Visible := false;
  end
  else if NovaCobTarget.ItemIndex = 3 then
  begin
    // ���
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := true;
    NovaHelpSchedule.SetFocus;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := false;
    self.LabSchedule.Visible := true;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := false;
    self.LabRoute.Visible := false;
  end
  else if NovaCobTarget.ItemIndex = 4 then
  begin
    // Ӫ�˵�λ+��·
    NovaHelpRoute.Enabled := true;
    NovaHelpRoute.SetFocus;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := true;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := false;
    self.LabSchedule.Visible := false;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := true;
    self.LabRoute.Visible := true;
  end
  else if NovaCobTarget.ItemIndex = 5 then
  begin
    // Ӫ�˵�λ
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := true;
    NovaHelpUnit.SetFocus;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := false;
    self.LabSchedule.Visible := false;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := true;
    self.LabRoute.Visible := false;
  end
  else if NovaCobTarget.ItemIndex = 6 then
  begin
    // ��·
    NovaHelpRoute.Enabled := true;
    NovaHelpRoute.SetFocus;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := false;
    NovaHCobOrg.ItemIndex := -1;
    LabVehicle.Visible := false;
    self.LabSchedule.Visible := false;
    self.LabOrg.Visible := false;
    self.LabUnit.Visible := false;
    self.LabRoute.Visible := true;
  end
  else if NovaCobTarget.ItemIndex = 7 then
  begin
    // ����
    NovaHelpRoute.Enabled := false;
    NovaHelpRoute.Clear;
    NovaHelpSchedule.Enabled := false;
    NovaHelpSchedule.Clear;
    NovaHelpUnit.Enabled := false;
    NovaHelpUnit.Clear;
    NovaHelpVehicle.Enabled := false;
    NovaHelpVehicle.Clear;
    NovaHCobOrg.Enabled := true;
    NovaHCobOrg.SetFocus;
    LabVehicle.Visible := false;
    self.LabSchedule.Visible := false;
    self.LabOrg.Visible := true;
    self.LabUnit.Visible := false;
    self.LabRoute.Visible := false;
  end
  else
  begin
    NovaHelpRoute.Enabled := true;
    NovaHelpSchedule.Enabled := true;
    NovaHelpUnit.Enabled := true;
    NovaHelpVehicle.Enabled := true;
  end;
end;

end.

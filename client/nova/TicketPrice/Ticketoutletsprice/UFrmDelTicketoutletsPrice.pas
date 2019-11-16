unit UFrmDelTicketoutletsPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaListView,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmDelTicketoutletsPrice = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    NovaHelpRoute: TNovaHelp;
    NovaHelpSchedule: TNovaHelp;
    NovaListSchedule: TNovaListView;
    Label5: TLabel;
    RbtnCurSchedule: TRadioButton;
    RbtnCurRoute: TRadioButton;
    RbtnCurOrg: TRadioButton;
    jcdsDelhandprice: TjsonClientDataSet;
    RbtnTickeoutlets: TRadioButton;
    LabelTickeoutlets: TLabel;
    NvHelpTickeoutlets: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpRouteIdChange(Sender: TObject);
    procedure RbtnCurRouteClick(Sender: TObject);
    procedure RbtnCurOrgClick(Sender: TObject);
    procedure RbtnCurScheduleClick(Sender: TObject);
  private
    { Private declarations }
     day:integer;
     log : String;
  public
    { Public declarations }
    scheduleplanlog: string;
    createby, routeid, orgid,vehicletypeid,scheduleid,ticketoutletsid: int64;
  end;

var
  FrmDelTicketoutletsPrice: TFrmDelTicketoutletsPrice;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDelTicketoutletsPrice.bbtnSaveClick(Sender: TObject);
var
  operationtype, types, sResult: string;
  nResult: integer;
  typeid: int64;
begin
  inherited;
  typeid := 0;
  if RbtnCurOrg.Checked then
  begin
    types := '0';
    typeid := orgid;
  end
  else if RbtnCurRoute.Checked then
  begin
    if ((trim(NovaHelpRoute.Text) = '') or (NovaHelpRoute.Id = 0)) then
    begin
      SysDialogs.Warning('��ѡ����·��');
      NovaHelpRoute.SetFocus;
      exit;
    end;
    types := '1';
    typeid := NovaHelpRoute.Id;
  end
  else
  begin
    if (NovaHelpSchedule.Id <= 0) and (NovaListSchedule.CheckedCount <= 0) then
    begin
      SysDialogs.Warning('��ѡ���Σ�');
      NovaHelpSchedule.SetFocus;
      exit;
    end;
    types := '2';
  end;

  screen.Cursor := crHourGlass;
  with jcdsDelhandprice do
  begin
    try
      active := false;
      if RbtnCurSchedule.Checked then   //ɾ����ǰѡ�а��
      begin
        if NovaListSchedule.CheckedCount <= 0 then
          Params.ParamByName('filter_INS_s!id')
            .Value := '(' + inttostr(NovaHelpSchedule.Id) + ')'
        else
//          Params.ParamByName('filter_INS_s!id')
//            .Value := '(' + NovaListSchedule.GetSelected + ')';
//        Params.ParamValues['filter_EQL_h!vehicletypeid'] := vehicletypeid;
      end;
      if RbtnCurRoute.Checked then   //ɾ����·���а��
      begin
        Params.ParamValues['filter_EQL_r!id'] := NovaHelpRoute.Id;
        //Params.ParamValues['filter_EQL_h!vehicletypeid'] := vehicletypeid;
      end;
       if RbtnTickeoutlets.Checked then  //ɾ����Ʊ�����а��
      begin
        Params.ParamValues['filter_EQL_h!ticketoutletsid'] := ticketoutletsid;
      end;
      if RbtnCurOrg.Checked then   //ɾ�����������а��
      begin
        if orgid = 0 then
        begin
          SysDialogs.ShowMessage('��ѡ��Ļ���������ȷ����Ҫɾ������Ϣ��');
        end;
        params.ParamValues['filter_EQL_o!id'] := orgid;
        //Params.ParamValues['filter_EQL_h!vehicletypeid'] := vehicletypeid;
      end;

      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      SysDialogs.ShowMessage(sResult);
      if nResult = 1 then
      begin
          log := 'ɾ����Ʊ��Ʊ�۲�Ӫ����·='+NovaHelpRoute.Text+',ѡ������=';
          if RbtnCurSchedule.Checked then
            log := log + '��ǰѡ�а��'+NovaHelpSchedule.Text;
          if RbtnCurRoute.Checked then
            log := log + '����·���а��';
          if RbtnCurOrg.Checked then
            log := log + '���������а��';
          if RbtnTickeoutlets.Checked then
            log := log + '��Ʊ�㣺'+NvHelpTickeoutlets.Text+' �����а��';
          SysLog.WriteLog('Ʊ�۹���-->��Ʊ��Ʊ�۲�����','ɾ��Ʊ�۲������',log);
      end;
    except
      on E: Exception do
      begin
        self.Enabled := true;
        screen.Cursor := crDefault;
        SysLog.WriteErr('ɾ��ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
  ModalResult := mrok;
end;

procedure TFrmDelTicketoutletsPrice.NovaHelpRouteIdChange(Sender: TObject);
begin
  inherited;
  with NovaListSchedule do
  begin
    active := false;
    Params.ParamValues['routeid'] := NovaHelpRoute.Id;
    active := true;
  end;
end;

procedure TFrmDelTicketoutletsPrice.RbtnCurOrgClick(Sender: TObject);
begin
  inherited;
  NovaListSchedule.CheckAll(true);
  GroupBox1.Enabled := false;
end;

procedure TFrmDelTicketoutletsPrice.RbtnCurRouteClick(Sender: TObject);
begin
  inherited;
  NovaListSchedule.CheckAll(true);
  GroupBox1.Enabled := false;

end;

procedure TFrmDelTicketoutletsPrice.RbtnCurScheduleClick(Sender: TObject);
begin
  inherited;
  GroupBox1.Enabled := true;
end;



end.

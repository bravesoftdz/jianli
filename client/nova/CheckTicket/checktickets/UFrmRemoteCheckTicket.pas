unit UFrmRemoteCheckTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  NovaCheckedComboBox, ComCtrls, NovaEdit, NovaComboBox, NovaHComboBox, DB,
  DBClient, jsonClientDataSet;

type
  TFrmRemoteCheckTicket = class(TSimpleEditForm)
    lbl1: TLabel;
    Label10: TLabel;
    grp1: TGroupBox;
    LabcurFromStation: TLabel;
    lbl2: TLabel;
    LabcurTostation: TLabel;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl3: TBevel;
    LabcurSeatnum: TLabel;
    lbl3: TLabel;
    LabcurPrice: TLabel;
    bvl4: TBevel;
    shp1: TShape;
    lbl4: TLabel;
    LabcurDepartdate: TLabel;
    bvl5: TBevel;
    bvl6: TBevel;
    bvl7: TBevel;
    lbl5: TLabel;
    LabcurEntrance: TLabel;
    lbl6: TLabel;
    LabcurBuspark: TLabel;
    bvl8: TBevel;
    lbl8: TLabel;
    LabcurCode: TLabel;
    lbl9: TLabel;
    LabcurDeparttime: TLabel;
    bvl10: TBevel;
    LabcurTickettype: TLabel;
    lbllabremark: TLabel;
    LabcurRemark: TLabel;
    lbl10: TLabel;
    bvl11: TBevel;
    LabcurTicketStatus: TLabel;
    Label16: TLabel;
    NovaEdtTicketNo: TNovaEdit;
    dtpDepartdate: TDateTimePicker;
    Label1: TLabel;
    NovaDepartOrg: TNovaHComboBox;
    jscdQryRemoteticket: TjsonClientDataSet;
    jscdRemoteCheck: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure NovaEdtTicketNoKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    ticketsellorgcode:string;
    procedure clearTicket;
    procedure qryTicket(departcode, ticketno: String);
  public
    { Public declarations }
    sresult,vehicleno: String;
    reportid:int64;
  end;

var
  FrmRemoteCheckTicket: TFrmRemoteCheckTicket;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmRemoteCheckTicket.bbtnSaveClick(Sender: TObject);
var
  nresult: Integer;
  orgcode:string;
begin
  if (NovaDepartOrg.Text)='' then
  begin
    SysDialogs.Warning('请选择发车站！');
    NovaDepartOrg.SetFocus;
    exit;
  end;
  if trim(NovaEdtTicketNo.text) = '' then
  begin
    SysDialogs.Warning('请输入退检的车票！');
    NovaEdtTicketNo.SetFocus;
    exit;
  end;
  if length(trim(NovaEdtTicketNo.text)) = Sysinfo.curBillLength.Items['Ticket']
    then
  begin
    with jscdRemoteCheck do
    begin
      active := false;
      //if(NovaDepartOrg.SelText<>'') then
      if (LabcurFromStation.Caption='') or (ticketsellorgcode='') then
      begin
        SysDialogs.ShowMessage('车票信息为空，请输入票号，敲回车查询车票信息');
        exit;
      end;

      orgcode := NovaDepartOrg.HelpFieldValue['code'];
      Params.ParamValues['inparam.departorgcode'] :=orgcode;
      Params.ParamValues['inparam.vehicleno'] := vehicleno;
      Params.ParamValues['inparam.ticketno'] := trim(NovaEdtTicketNo.text);
      Params.ParamValues['inparam.checkby'] :=  Sysinfo.LoginUserInfo.UserName;
      Params.ParamValues['inparam.reportid'] := reportid;
      Params.ParamValues['inparam.ticketsellorgcode'] := ticketsellorgcode;
      execute;
      nresult := Params.ParamValues['outparam.result'];
      sresult := Params.ParamValues['outparam.resultMsg'];
      if nresult = 1 then
      begin
        SysDialogs.ShowMessage(sresult);
        NovaEdtTicketNo.Clear;
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sresult);
        NovaEdtTicketNo.SetFocus;
        NovaEdtTicketNo.SelectAll;
      end;
    end;
  end
  else
  begin
    SysDialogs.Warning('您输入的票号长度有误！');
    NovaEdtTicketNo.SetFocus;
  end;
end;

procedure TFrmRemoteCheckTicket.clearTicket;
begin
  LabcurFromStation.Caption := '';
  LabcurTostation.Caption := '';
  LabcurSeatnum.Caption := '';
  LabcurPrice.Caption := '';
  LabcurDepartdate.Caption := '';
  LabcurEntrance.Caption := '';
  LabcurBuspark.Caption := '';
  LabcurCode.Caption := '';
  LabcurDeparttime.Caption := '';
  LabcurRemark.Caption := '';
  LabcurTickettype.Caption := '';
  LabcurTicketStatus.Caption := '';
end;

procedure TFrmRemoteCheckTicket.FormShow(Sender: TObject);
begin
  inherited;
  NovaDepartOrg.Active := false;
  NovaDepartOrg.Active := true;
  clearTicket;
end;

procedure TFrmRemoteCheckTicket.NovaEdtTicketNoKeyPress(Sender: TObject;
  var Key: Char);
var
  orgcode: string;
  templen, ticketlength: Integer;
begin
  inherited;
  if Key = #13 then
  begin
    if NovaDepartOrg.ItemIndex<0 then
    begin
       SysDialogs.Warning('请选择发车站！');
       NovaDepartOrg.SetFocus;
       exit;
    end;
    ticketlength := Sysinfo.curBillLength.Items['Ticket'];
    if length(trim(NovaEdtTicketNo.text)) > ticketlength then
    begin
      // 如果获取的车票长度大于系统票据长度，则从后面截取到符合系统的票据长度
      templen := length(trim(NovaEdtTicketNo.text)) - ticketlength;
      NovaEdtTicketNo.text := copy(NovaEdtTicketNo.text, templen + 1,
        length(NovaEdtTicketNo.text));
    end;
    orgcode := NovaDepartOrg.HelpFieldValue['code'];
    qryTicket(orgcode, trim(NovaEdtTicketNo.text));
  end;
end;

procedure TFrmRemoteCheckTicket.qryTicket(departcode, ticketno: String);
begin
  with jscdQryRemoteticket do
  begin
    Active := false;
    Params.ParamValues['inparam.departorgcode'] := departcode;
    Params.ParamValues['inparam.ticketno'] := ticketno;
    execute;
    if Params.ParamValues['outparam.result'] = 1 then
    begin
      //NovaEdtTicketNo.text := Params.ParamValues['outparam.result'];
      LabcurFromStation.Caption := Params.ParamValues['outparam.departStationName'];
      LabcurTostation.Caption := Params.ParamValues['outparam.reachStationName'];
      LabcurSeatnum.Caption := inttostr(Params.ParamValues['outparam.seatno']);
      LabcurPrice.Caption := floattostr(Params.ParamValues['outparam.price']);
      LabcurDepartdate.Caption := Params.ParamValues['outparam.strdepartdate'];
      LabcurEntrance.Caption := Params.ParamValues['outparam.ticketentrance'];
      LabcurBuspark.Caption := Params.ParamValues['outparam.buspark'];
      LabcurCode.Caption := Params.ParamValues['outparam.scheduleCode'];
      LabcurTickettype.Caption := '('+Params.ParamValues['outparam.tickettypeName']+')';
      LabcurDeparttime.Caption := Params.ParamValues['outparam.departtime'];
      LabcurRemark.Caption := '';
      ticketsellorgcode:= Params.ParamValues['outparam.ticketsellorgcode'];
      if Params.ParamValues['outparam.ticketstatus'] = '0' then
        LabcurTicketStatus.Caption := '正常'
      else if Params.ParamValues['outparam.ticketstatus'] = '1' then
        LabcurTicketStatus.Caption := '已退票'
      else if Params.ParamValues['outparam.ticketstatus'] = '2' then
        LabcurTicketStatus.Caption := '已作废'
      else
        LabcurTicketStatus.Caption := '未知状态';
    end
    else
    begin
      clearTicket;
      SysDialogs.Warning(Params.ParamValues['outparam.resultMsg']);
      exit;
    end;
  end;
end;

end.

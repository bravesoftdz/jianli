unit UFrmAutoReportResult;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaHelp,
  NovaEdit, UICcardRW,Dispatch,Sockets;

type
  TFrmAutoReportResult = class(TSimpleEditForm,IBaseCardfound)
    NovaEdtCardNo: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    nvhlpVehicleNo: TNovaHelp;
    nvhlpSchedule: TNovaHelp;
    nvhlpRoute: TNovaHelp;
    NovaEdtSeatnum: TNovaEdit;
    NovaEdtDeparttime: TNovaEdit;
    nvhlpUnit: TNovaHelp;
    NovaEdtReportDateTime: TNovaEdit;
    mmoResult: TMemo;
    grp1: TGroupBox;
    grp2: TGroupBox;
    grp3: TGroupBox;
    pnl1: TPanel;
    grp4: TGroupBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
   private
    { Private declarations }
    procedure clear();
    procedure iccardfound(icCard:TBaseCard);
    procedure report();
    procedure notifyMiniScreenSchedule;
  public
    { Public declarations }
  end;
  TMiniScreenMSG = (LISTSCHEDULE, // 显示班次
    FINISH, // 售票完成显示等待界面
    EXITSELL // 退出售票时
    );

var
  FrmAutoReportResult: TFrmAutoReportResult;
  tcpclient: TTcpClient;


procedure TcpClientError(Sender: TObject; SocketError: Integer);
procedure notifyMiniScreen(msg: TMiniScreenMSG; info: String);
implementation
 uses PubFn, Services, UDMPublic, UFrmDispatchManage, UFrmScheduleReport;
{$R *.dfm}

procedure TFrmAutoReportResult.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  ModalResult := mrok;
end;

procedure TFrmAutoReportResult.clear;
begin
   nvhlpSchedule.Id:=0;
   nvhlpSchedule.Clear;
   nvhlpRoute.Id:=0;
   nvhlpRoute.Clear;
   NovaEdtReportDateTime.Clear;
   NovaEdtDeparttime.Clear;
end;

procedure TFrmAutoReportResult.FormCreate(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
//    SysDialogs.Warning('读卡器初始化失败');
  end;
    setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
    setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
    setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
    setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
    setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
    setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

procedure TFrmAutoReportResult.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
  except
  end;
end;
procedure TFrmAutoReportResult.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key=VK_ESCAPE then
    close;
end;

procedure TFrmAutoReportResult.FormShow(Sender: TObject);
begin
  inherited;
  NovaEdtCardNo.Text:= vehReport.cardno;
  report;
end;

procedure TFrmAutoReportResult.iccardfound(icCard: TBaseCard);
begin

  if integer(icCard.cardtype) <> 0 then
  begin
//    该卡不是报到卡，不能用于报到！
  end
  else
  begin
    vehReport.cardno:=icCard.cardNo;
    NovaEdtCardNo.Text:= vehReport.cardno;
    vehReport.QryVehicleinfo(vehReport.cardno);
    if vehReport.res.flag<0 then
      begin
        //自动报班不出现提示框
        //SysDialogs.Warning(sResult);
        mmoResult.Lines.Insert(0, vehReport.res.msg);
        //NovaEdtCardNo.Clear;
        //NovaEdtCardNo.SetFocus;
        exit;
      end
    else
    begin
        nvhlpVehicleNo.Text:= vehReport.jcsdQryVehicleinfo.FieldByName('vehicleno').AsString;
        nvhlpVehicleNo.id:=vehReport.jcsdQryVehicleinfo.FieldByName('id').AsLargeInt;
        vehReport.vehicleid:=vehReport.jcsdQryVehicleinfo.FieldByName('id').AsLargeInt;
        vehReport.vehicleno:=vehReport.jcsdQryVehicleinfo.FieldByName('vehicleno').AsString;
        NovaEdtSeatnum.Text:=vehReport.jcsdQryVehicleinfo.FieldByName('seatnum').AsString;
        nvhlpUnit.Text:=vehReport.jcsdQryVehicleinfo.FieldByName('unitname').AsString;
        vehReport.QryScheduleplan(formatdatetime('yyyy-mm-dd', now),
             sysInfo.LoginUserInfo.StationID,0,nvhlpVehicleNo.id,0);
        report;
       // NovaHelpVehicleNoIdChange(nil);
    end;
  end;
end;

procedure TFrmAutoReportResult.report;
var
  curseats,busseats:integer;
begin
  with vehReport.jcsdQryScheduleplan do
  begin
    if RecordCount = 1 then
    begin
//        if FormatDateTime('yyyymmdd',
//          vehReport.jcsdQryScheduleplan.FieldByName('departdate').AsDateTime) <> FormatDateTime('yyyymmdd', now) then
//        begin
//          if not SysDialogs.Confirm('报到提示',
//            '该车辆报的发车日期是' + FormatDateTime('yyyy-mm-dd',
//              vehReport.jcsdQryScheduleplan.FieldByName('departdate').AsDateTime)
//              + '的班次，是否继续') then
//          begin
//            exit;
//          end;
//        end;
//        if ((vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsString) <> '') and
//          (vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsInteger> 0) then
//        begin
//          curseats := vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsInteger;
//          busseats := vehReport.jcsdQryScheduleplan.FieldByName('vehicleseat').AsInteger;
//          if busseats <> curseats then
//          begin
//            if busseats > curseats then
//            begin
//              if not SysDialogs.Confirm('报到提示',
//                '当前报到车辆座位数(' + inttostr(busseats) + ')大于该班次计划座位数，是否继续报到？') then
//              begin
//                exit;
//              end;
//            end
//            else if busseats < curseats then
//            begin
//              if not SysDialogs.Confirm('报到提示',
//                '当前报到车辆座位数(' + inttostr(busseats) + ')小于该班次计划座位数，是否继续报到？') then
//              begin
//                exit;
//              end;
//            end;
//          end;
//        end;
        nvhlpSchedule.Text:=vehReport.jcsdQryScheduleplan.FieldByName('code').AsString;
        nvhlpSchedule.id:=vehReport.jcsdQryScheduleplan.FieldByName('scheduleid').AsLargeInt;
        repAskCondition.scheduleplanid:=vehReport.jcsdQryScheduleplan.FieldByName('ID').AsLargeInt;
        nvhlpRoute.Text:=vehReport.jcsdQryScheduleplan.FieldByName('endstationname').AsString;
        nvhlpRoute.id:=vehReport.jcsdQryScheduleplan.FieldByName('endstationid').AsLargeInt;
        NovaEdtSeatnum.Text:=vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsString;
        NovaEdtDeparttime.Text:=vehReport.jcsdQryScheduleplan.FieldByName('departtime').AsString;
        nvhlpUnit.Text:=vehReport.jcsdQryScheduleplan.FieldByName('unitname').AsString;
        NovaEdtReportDateTime.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
        repAskCondition.scheduleid:=nvhlpSchedule.id;

        repAskCondition.vehicleno:=nvhlpVehicleNo.Text;
        repAskCondition.vehicleunit:=nvhlpUnit.Text;
        repAskCondition.departtime:=NovaEdtDeparttime.Text;
        repAskCondition.schedulecode:=nvhlpSchedule.Text;
        repAskCondition.seatno:=NovaEdtSeatnum.Text;
        repAskCondition.reachstation:=nvhlpRoute.Text;

        repAskCondition.vehicleid:=vehReport.vehicleid;
        vehReport.report(repAskCondition);
        mmoResult.Text:=vehReport.res.msg;
    end
    else if  RecordCount=0 then
    begin
        clear;
        mmoResult.Text:='该车辆当天没有排班计划信息';
    end
    //记录条数不为1时
    else
    begin
      clear;
      mmoResult.Text:='该车辆计划数大于1!';
//      FrmScheduleReport := TFrmScheduleReport.Create(self);
//      try
//        with FrmScheduleReport do
//        begin
//          Caption := '车辆报班';
//          LblVehicleNo.Caption := vehReport.vehicleno;
//          ds1.DataSet:=vehReport.jcsdQryScheduleplan;
//          departdate:=FormatDateTime('yyyymmdd',
//          vehReport.jcsdQryScheduleplan.FieldByName('departdate').AsDateTime);
//          vehicleid:=vehReport.vehicleid;
//          vehReport.isShowmsg:=false;
//          if SysMainForm.showFormModal(FrmScheduleReport, false)
//            = mrok then
//          begin
//            nvhlpSchedule.Text:=vehReport.jcsdQryScheduleplan.FieldByName('code').AsString;
//            nvhlpSchedule.id:=vehReport.jcsdQryScheduleplan.FieldByName('scheduleid').AsLargeInt;
//
//            nvhlpRoute.Text:=vehReport.jcsdQryScheduleplan.FieldByName('endstationname').AsString;
//            nvhlpRoute.id:=vehReport.jcsdQryScheduleplan.FieldByName('endstationid').AsLargeInt;
//            NovaEdtSeatnum.Text:=vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsString;
//            NovaEdtDeparttime.Text:=vehReport.jcsdQryScheduleplan.FieldByName('departtime').AsString;
//            nvhlpUnit.Text:=vehReport.jcsdQryScheduleplan.FieldByName('unitname').AsString;
//            //nvhlpUnit.Text:=jsonAutoGetUnitByVehicle.FieldByName('unitname').AsString;
//            //nvhlpUnit.id:=jsonAutoGetUnitByVehicle.FieldByName('unitid').AsLargeInt;
//            NovaEdtReportDateTime.Text:=FormatDateTime('yyyy-mm-dd hh:nn:ss', now);
//            mmoResult.Text:=vehReport.res.msg;
//          end;
//        end;
//      finally
//        FreeAndNil(FrmScheduleReport);
//      end;
    end;
    notifyMiniScreenSchedule;
  end;
end;


procedure TFrmAutoReportResult.notifyMiniScreenSchedule;
var
  info: String;

begin

//       info := vehReport.cardno+',' + vehReport.vehicleno+ ',' +
//            vehReport.jcsdQryScheduleplan.FieldByName('code').AsString + ',' +
//            vehReport.jcsdQryScheduleplan.FieldByName('endstationname').AsString + ',' +
//            vehReport.jcsdQryScheduleplan.FieldByName('seatnum').AsString+','+
//            vehReport.jcsdQryScheduleplan.FieldByName('departtime').AsString +','+
//            vehReport.jcsdQryScheduleplan.FieldByName('unitname').AsString +','+
//            FormatDateTime('yyyy-mm-dd hh:nn:ss', now) +','+
//            mmoResult.Text;
    info := NovaEdtCardNo.Text+',' + nvhlpVehicleNo.Text+ ',' +
            nvhlpSchedule.Text + ',' + nvhlpRoute.Text + ',' +
            NovaEdtSeatnum.Text +','+ NovaEdtDeparttime.Text +','+
            nvhlpUnit.Text +','+
            FormatDateTime('yyyy-mm-dd hh:nn:ss', now) +','+
            mmoResult.Text;
    notifyMiniScreen(FINISH, info);
end;

procedure TcpClientError(Sender: TObject; SocketError: Integer);
begin
  tcpclient.Close;
end;

procedure notifyMiniScreen(msg: TMiniScreenMSG; info: String);
begin
//  if not openSaleHintScreen then
//    exit;
  if FindWindow(nil, '自动报班') = 0 then
    exit;
  if tcpclient = nil then
  begin
    tcpclient := TTcpClient.Create(Application);
    tcpclient.RemoteHost := '127.0.0.1';
    tcpclient.RemotePort := '7989';
    @tcpclient.OnError := @TcpClientError;
  end;

  if not tcpclient.Connected then
  begin
    if not tcpclient.Connect then
    begin
      exit;
    end;
  end;
  tcpclient.Sendln(inttostr(ord(msg)) + ';' + info);
end;
end.

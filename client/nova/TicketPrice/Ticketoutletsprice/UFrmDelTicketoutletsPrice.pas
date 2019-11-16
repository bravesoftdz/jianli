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
      SysDialogs.Warning('请选择线路！');
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
      SysDialogs.Warning('请选择班次！');
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
      if RbtnCurSchedule.Checked then   //删除当前选中班次
      begin
        if NovaListSchedule.CheckedCount <= 0 then
          Params.ParamByName('filter_INS_s!id')
            .Value := '(' + inttostr(NovaHelpSchedule.Id) + ')'
        else
//          Params.ParamByName('filter_INS_s!id')
//            .Value := '(' + NovaListSchedule.GetSelected + ')';
//        Params.ParamValues['filter_EQL_h!vehicletypeid'] := vehicletypeid;
      end;
      if RbtnCurRoute.Checked then   //删除线路所有班次
      begin
        Params.ParamValues['filter_EQL_r!id'] := NovaHelpRoute.Id;
        //Params.ParamValues['filter_EQL_h!vehicletypeid'] := vehicletypeid;
      end;
       if RbtnTickeoutlets.Checked then  //删除售票点所有班次
      begin
        Params.ParamValues['filter_EQL_h!ticketoutletsid'] := ticketoutletsid;
      end;
      if RbtnCurOrg.Checked then   //删除本机构所有班次
      begin
        if orgid = 0 then
        begin
          SysDialogs.ShowMessage('你选择的机构有误，请确认你要删除的信息。');
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
          log := '删除售票点票价差额：营运线路='+NovaHelpRoute.Text+',选择类型=';
          if RbtnCurSchedule.Checked then
            log := log + '当前选中班次'+NovaHelpSchedule.Text;
          if RbtnCurRoute.Checked then
            log := log + '本线路所有班次';
          if RbtnCurOrg.Checked then
            log := log + '本机构所有班次';
          if RbtnTickeoutlets.Checked then
            log := log + '售票点：'+NvHelpTickeoutlets.Text+' 的所有班次';
          SysLog.WriteLog('票价管理-->售票点票价差额管理','删除票价差额设置',log);
      end;
    except
      on E: Exception do
      begin
        self.Enabled := true;
        screen.Cursor := crDefault;
        SysLog.WriteErr('删除失败：' + E.Message);
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

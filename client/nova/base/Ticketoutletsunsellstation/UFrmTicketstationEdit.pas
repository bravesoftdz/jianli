unit UFrmTicketstationEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaEdit,
  NovaHelp, NovaComboBox, DB, DBClient, jsonClientDataSet, NovaListView,
  NovaHComboBox, ImgList;

type
  TFrmTicketstationEdit = class(TSimpleEditForm)
    lblticket: TLabel;
    lblroute: TLabel;
    lblschedule: TLabel;
    lbl4: TLabel;
    lbltype: TLabel;
    lblstartdate: TLabel;
    lblenddate: TLabel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl6: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    jsonCDSTicketoutletSave: TjsonClientDataSet;
    lbl9: TLabel;
    lbl13: TLabel;
    cbbOrgid: TNovaHComboBox;
    cbbtype: TNovaComboBox;
    nvhlproute: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    nvhlpschedulestop: TNovaHelp;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbbticket: TNovaHelp;
    Label1: TLabel;
    Label2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhlprouteChange(Sender: TObject);
    procedure nvhlprouteExit(Sender: TObject);
    procedure cbbtypeChange(Sender: TObject);
    procedure cbbOrgidExit(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    sign: Boolean;
    id, createby, updateby, ticketid: LongWord;
    createtime, updatetime: TDateTime;
  end;

var
  FrmTicketstationEdit: TFrmTicketstationEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmTicketstationEdit.bbtnSaveClick(Sender: TObject);
var nResult: LongWord;
    sResult: string;
begin
  inherited;
  with jsonCDSTicketoutletSave do
  begin
    Close;

    if Trim(cbbtype.Text) = '' then
    begin
      SysDialogs.Warning('请选择类型！');
      cbbtype.SetFocus;
      exit;
    end;
    if cbbtype.ItemIndex = 0 then
    begin
      Params.ParamByName('ticketoutletsunsellstation.typeid').Value :=0 ;
    end else if cbbtype.ItemIndex = 1 then
    begin
      if Trim(nvhlproute.Text) = ''  then
      begin
        SysDialogs.Warning('请输入线路信息!');
        nvhlproute.SetFocus;
        Exit;
      end;
      Params.ParamByName('ticketoutletsunsellstation.typeid').Value :=nvhlproute.Id ;
    end else if cbbtype.ItemIndex = 2 then
    begin
      if nvhlproute.Id = 0  then
      begin
        SysDialogs.Warning('请输入线路信息!');
        nvhlproute.SetFocus;
        Exit;
      end;
      if nvhlpschedule.Id = 0  then
      begin
        SysDialogs.Warning('请输入班次信息!');
        nvhlpschedule.SetFocus;
        Exit;
      end;
      Params.ParamByName('ticketoutletsunsellstation.typeid').Value :=nvhlpschedule.HelpFieldValue['id'] ;
    end;
     if cbbticket.Id=0 then
    begin
      SysDialogs.Warning('请选择售票点！');
      cbbticket.SetFocus;
      exit;
    end;
    if nvhlpschedulestop.Id=0 then
    begin
      SysDialogs.Warning('请输入停靠点！');
      nvhlpschedulestop.SetFocus;
      exit;
    end;
    if Trunc(dtpstartdate.Date) >Trunc(dtpenddate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      dtpenddate.SetFocus;
      exit;
    end;
    if cbbticket.Id > 0 then
    begin
     ticketid := cbbticket.Id;
    end;
    Params.ParamByName('ticketoutletsunsellstation.ticketoutletsid').Value := ticketid;
    Params.ParamByName('ticketoutletsunsellstation.id').Value :=id ;
    Params.ParamByName('ticketoutletsunsellstation.createby').Value :=createby ;
    Params.ParamByName('ticketoutletsunsellstation.updateby').Value :=updateby ;
    Params.ParamByName('ticketoutletsunsellstation.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('ticketoutletsunsellstation.updatetime').Value := DateTimeToStr(updatetime);

    Params.ParamByName('ticketoutletsunsellstation.type').Value :=TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    Params.ParamByName('ticketoutletsunsellstation.startdate').Value :=DateTimeToStr(dtpstartdate.DateTime);
    Params.ParamByName('ticketoutletsunsellstation.enddate').Value := DateTimeToStr(dtpenddate.DateTime);
    //Params.ParamByName('route.id').Value :=nvhlproute.Id ;
    //Params.ParamByName('schedule.id').Value :=nvhlpschedule.Id;
    Params.ParamByName('ticketoutletsunsellstation.stationid').Value :=nvhlpschedulestop.Id;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <> 1) then
      begin
        cbbticket.SetFocus;
      end
      else
      begin
        log := '添加售票点不可售站点：机构='+cbbOrgid.Text+',售票点='+cbbticket.Text
        +',类型='+cbbtype.Text;
        if cbbtype.ItemIndex = 1 then
        begin
          log := log +',线路='+nvhlproute.Text;
        end
        else if cbbtype.ItemIndex = 2 then
        begin
          log := log +',线路='+nvhlproute.Text+',班次='+nvhlpschedule.Text;
        end;
        log := log + nvhlpschedulestop.Text;
        SysLog.WriteLog('业务管理——>售票点不可售站点','添加',log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('售票点售票控制添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTicketstationEdit.cbbOrgidExit(Sender: TObject);
begin
  inherited;
  with cbbticket do
  begin
    params.ParamByName('orgid').Value := cbbOrgid.HelpFieldValue['id'];
  end;
end;

procedure TFrmTicketstationEdit.cbbtypeChange(Sender: TObject);
begin
  inherited;
  if cbbtype.ItemIndex = 0 then
  begin
    nvhlproute.Enabled := False;
    nvhlpschedule.Enabled := False;
    Label1.Visible := False;
    Label2.Visible := False;
  end else if cbbtype.ItemIndex = 1 then
  begin
    nvhlproute.Enabled := True;
    nvhlpschedule.Enabled := False;
    Label2.Visible := True;
    Label1.Visible := False;
  end else if cbbtype.ItemIndex = 2 then
  begin
    nvhlproute.Enabled := True;
    nvhlpschedule.Enabled := True;
    Label1.Visible := True;
    Label1.Visible := True;
  end;
end;

procedure TFrmTicketstationEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime:= Now();
  dtpenddate.DateTime:= Now();

  cbbtype.Active:= False;
  cbbtype.Active:= true;

  cbbOrgid.Active := False;
  cbbOrgid.Active := True;
end;

procedure TFrmTicketstationEdit.nvhlprouteChange(Sender: TObject);
begin
  inherited;
  nvhlpschedule.Text:= '';
end;

procedure TFrmTicketstationEdit.nvhlprouteExit(Sender: TObject);
begin
  inherited;
  with nvhlpschedule do
  begin
    Params.ParamValues['filter_EQL_r!id'] := nvhlproute.Id;
  end;
end;

end.

unit UFrmHandHolidayPriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaCheckedComboBox,
  NovaEdit, DBGridEhGrouping, NovaHelp, ComCtrls, GridsEh, DBGridEh, NvDbgridEh,
  DB, DBClient, jsonClientDataSet, NovaHComboBox, ImgList;

type
  TFrmHandHolidayPriceEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtRoute: TNovaEdit;
    NovaEditSchedule: TNovaEdit;
    NvCcbVehileType: TNovaCheckedComboBox;
    GroupBox1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    jscdQryVehicleType: TjsonClientDataSet;
    jcsdQryDepartStation: TjsonClientDataSet;
    jcdsQryStopStation: TjsonClientDataSet;
    dsholidayprice: TDataSource;
    jcdsQrySeatTypes: TjsonClientDataSet;
    jcsdQryHolidayHandprice: TjsonClientDataSet;
    jcsdQryHolidayHandpricescheduleid: TLargeintField;
    jcsdQryHolidayHandpricedepartstationid: TLargeintField;
    jcsdQryHolidayHandpricereachstationid: TLargeintField;
    jcsdQryHolidayHandpriceseattype: TWideStringField;
    jcsdQryHolidayHandpricefullprice: TFloatField;
    jcsdQryHolidayHandpricehalfprice: TFloatField;
    jcsdQryHolidayHandpricestudentprice: TFloatField;
    jcsdQryHolidayHandpriceseats: TWideStringField;
    jcsdQryHolidayHandpricetoplimitprice: TFloatField;
    jcsdQryHolidayHandpricelowerlimitprice: TFloatField;
    jcsdQryHolidayHandpricevehicletypeid: TLargeintField;
    jcsdQryHolidayHandpriceid: TLargeintField;
    jcsdQryHolidayHandpricecreateby: TLargeintField;
    jcsdQryHolidayHandpricevehicletype: TWideStringField;
    jcsdQryHolidayHandpricedepartstation: TWideStringField;
    jcsdQryHolidayHandpricereachstation: TWideStringField;
    jcsdQryHolidayHandpriceseattypename: TWideStringField;
    jcsdQryHolidayHandpricevehiclebrandmodelid: TLargeintField;
    NovaHcbbHoliday: TNovaHComboBox;
    jcsdQryHolidayHandpriceholidayid: TLargeintField;
    jcsdQryHolidayHandpricestartdate: TDateField;
    jcsdQryHolidayHandpriceenddate: TDateField;
    chkIsSameRoute: TCheckBox;
    jcsdQryHolidayHandpricemoreprice: TFloatField;
    procedure NvCcbVehileTypeCheckClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure NovaHcbbHolidayChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure DateTpFromDateChange(Sender: TObject);
    procedure DateTpEndDateChange(Sender: TObject);
    procedure jcsdQryHolidayHandpricefullpriceChange(Sender: TField);
    procedure jcsdQryHolidayHandpricehalfpriceChange(Sender: TField);
    procedure jcsdQryHolidayHandpricestudentpriceChange(Sender: TField);
  private
    { Private declarations }
    startdate, enddate, log: string;
  public
    { Public declarations }
    createby, id: int64;
    curVehileTypeid: int64;
  end;

var
  FrmHandHolidayPriceEdt: TFrmHandHolidayPriceEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmHandHolidayPriceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, curstartdate, curenddate, result: string;
begin
  inherited;

  if NvCcbVehileType.GetCount <= 0 then
  begin
    SysDialogs.Warning('请选择车型！');
    NvCcbVehileType.SetFocus;
    exit;
  end;
  if NovaHcbbHoliday.ItemIndex < 0 then
  begin
    SysDialogs.Warning('请选择节日！');
    NovaHcbbHoliday.SetFocus;
    exit;
  end;
  curstartdate := formatdatetime('yyyy-mm-dd', DateTpFromDate.Date);
  curenddate := formatdatetime('yyyy-mm-dd', DateTpEndDate.Date);

  if curstartdate < startdate then
  begin
    SysDialogs.Warning('开始日期不能小于该节日的开始日期：' + startdate);
    DateTpFromDate.SetFocus;
    exit;
  end;
  if curstartdate > enddate then
  begin
    SysDialogs.Warning('开始日期不能大于该节日的结束日期：' + enddate);
    DateTpFromDate.SetFocus;
    exit;
  end;
  if curenddate < startdate then
  begin
    SysDialogs.Warning('结束日期不能小于该节日的开始日期：' + startdate);
    DateTpEndDate.SetFocus;
    exit;
  end;
  if curenddate > enddate then
  begin
    SysDialogs.Warning('结束日期不能大于该节日的结束日期：' + enddate);
    DateTpEndDate.SetFocus;
    exit;
  end;

  try

    with jcsdQryHolidayHandprice do
      while (not eof) do
      begin
       { if (FieldByName('fullprice').AsFloat > FieldByName('toplimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('全票票价不能超过上限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end; }
        if (FieldByName('halfprice').AsFloat > FieldByName('fullprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('半票票价不能超过全票票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('studentprice').AsFloat > FieldByName('toplimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('学生票价不能超过上限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('fullprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('全票票价不能低于下限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('halfprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('半票票价不能低于下限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('studentprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('学生票价不能低于下限票价！');
          NvDbgridEh1.SetFocus;
          exit;
        end;

        next;
      end;

    with jcsdQryHolidayHandprice do
    begin
      Params.ParamValues['holiday.id'] := NovaHcbbHoliday.HelpFieldValue['id'];
      Params.ParamValues['holiday.startdate'] := curstartdate;
      Params.ParamValues['holiday.enddate'] := curenddate;
      Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
      Params.ParamValues['vehicletypeids'] := NvCcbVehileType.GetSelectID;
      Params.ParamValues['savesameroute'] := chkIsSameRoute.Checked;
      ApplyUpdates(-1);
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        log := '营运线路='+NovaEdtRoute.Text+',班次号='+NovaEditSchedule.Text+',营运车型='+
        NvCcbVehileType.Text+',节日'+NovaHcbbHoliday.Text+',开始日期='+curstartdate+
        ',结束日期='+curenddate;
        if chkIsSameRoute.Checked then
        begin
          log := log + ',同时复制到本线路其它班次。';
        end;
        result := '';
        with jcsdQryHolidayHandprice do
        while (not eof) do
        begin
          result := result + '上车站='+FieldByName('departstation').AsString+',到达站'+
          FieldByName('reachstation').AsString+',车型='+FieldByName('vehicletype').AsString+',座位类型='+
          FieldByName('seattypename').AsString+',全价='+FieldByName('fullprice').AsString+',半价='+
          FieldByName('halfprice').AsString+',学生价='+FieldByName('studentprice').AsString+
          ',票价差='+fieldbyname('moreprice').AsString;
          next;
        end;
        log := log + result;
        SysLog.WriteLog('票价管理——>节日票价','添加',log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NvCcbVehileTypeCheckClick(Sender);
        if DateTpFromDate.Enabled then
          DateTpFromDate.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('节日票价保存失败：' + E.Message);
    end;
  end;

end;

procedure TFrmHandHolidayPriceEdt.DateTpEndDateChange(Sender: TObject);
begin
  inherited;
  // NovaHcbbHolidayChange(sender);
end;

procedure TFrmHandHolidayPriceEdt.DateTpFromDateChange(Sender: TObject);
begin
  inherited;
  // NovaHcbbHolidayChange(sender);
end;

procedure TFrmHandHolidayPriceEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHcbbHoliday.Active := false;
  NovaHcbbHoliday.Params.ParamValues['filter_GED_t!enddate']:= formatdatetime
      ('yyyy-mm-dd', now);
  NovaHcbbHoliday.Active := true;
  jcdsQrySeatTypes.Active := false;
  jcdsQrySeatTypes.Active := true;
end;

procedure TFrmHandHolidayPriceEdt.FormShow(Sender: TObject);
begin
  inherited;
  with NvCcbVehileType do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Active := true;
  end;

  with jscdQryVehicleType do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Active := true;
  end;
  with jcsdQryDepartStation do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Params.ParamValues['isdepart'] := true;
    Active := true;
  end;
  with jcdsQryStopStation do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
    Params.ParamValues['isdepart'] := false;
    Active := true;
  end;
  NovaHcbbHolidayChange(Sender);

end;

procedure TFrmHandHolidayPriceEdt.jcsdQryHolidayHandpricefullpriceChange
  (Sender: TField);
var
  price: double;
  toplimitprice, lowerlimitprice: double;
begin
  inherited;
  if Sender.Value=null then
  begin
     Sender.Value:=0;
  end;
  price := Sender.Value;
  toplimitprice := jcsdQryHolidayHandprice.FieldByName('toplimitprice').AsFloat;
  lowerlimitprice := jcsdQryHolidayHandprice.FieldByName('lowerlimitprice')
    .AsFloat;
  jcsdQryHolidayHandprice.FieldByName('halfprice').Value:=round(price/2);
  //jcsdQryHolidayHandprice.FieldByName('studentprice').Value:=price;
  if (price > toplimitprice) then
  begin
    SysDialogs.Warning('全票票价不能超过上限票价！');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('全票票价不能低于下限票价！');
    // Sender.Value:=Sender.OldValue;
  end;
end;

procedure TFrmHandHolidayPriceEdt.jcsdQryHolidayHandpricehalfpriceChange
  (Sender: TField);
var
  price, fullprice: double;
  lowerlimitprice: double;
begin
  inherited;
  if Sender.Value=null then
  begin
     Sender.Value:=0;
  end;
  price := Sender.Value;
  fullprice := jcsdQryHolidayHandprice.FieldByName('fullprice').AsFloat;
  lowerlimitprice := jcsdQryHolidayHandprice.FieldByName('lowerlimitprice')
    .AsFloat;
  if (price > fullprice) then
  begin
    SysDialogs.Warning('半票票价不能超过全票票价！');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('半票票价不能低于下限票价！');
    // Sender.Value:=Sender.OldValue;
  end;

end;

procedure TFrmHandHolidayPriceEdt.jcsdQryHolidayHandpricestudentpriceChange
  (Sender: TField);
var
  price, toplimitprice: double;
  lowerlimitprice: double;
begin
  inherited;
  if Sender.Value=null then
  begin
     Sender.Value:=0;
  end;
  price := Sender.Value;
  toplimitprice := jcsdQryHolidayHandprice.FieldByName('toplimitprice').AsFloat;
  lowerlimitprice := jcsdQryHolidayHandprice.FieldByName('lowerlimitprice')
    .AsFloat;
  if (price > toplimitprice) then
  begin
    SysDialogs.Warning('学生票票价不能超过全票票价！');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('学生票价不能低于下限票价！');
    // Sender.Value:=Sender.OldValue;
  end;
end;

procedure TFrmHandHolidayPriceEdt.NovaHcbbHolidayChange(Sender: TObject);
begin
  inherited;
  if (NovaHcbbHoliday.ItemIndex >= 0) then
  begin
    startdate := FormatDateTime('yyyy-mm-dd',NovaHcbbHoliday.HelpFieldValue['startdate']);
    enddate := FormatDateTime('yyyy-mm-dd',NovaHcbbHoliday.HelpFieldValue['enddate']);
    if edittype = add then
    begin
      DateTpFromDate.Date := _strtodate(startdate);
      DateTpEndDate.Date := _strtodate(enddate);
    end;
    NvCcbVehileTypeCheckClick(Sender);
  end;
end;

procedure TFrmHandHolidayPriceEdt.NvCcbVehileTypeCheckClick(Sender: TObject);
begin
  inherited;
  if NvCcbVehileType.CheckedCount > 0 then
    with jcsdQryHolidayHandprice do
    begin
      Active := false;
      Params.ParamValues['holiday.id'] := NovaHcbbHoliday.HelpFieldValue['id'];
      Params.ParamValues['holiday.startdate'] := formatdatetime('yyyy-mm-dd',
        DateTpFromDate.Date);
      Params.ParamValues['holiday.enddate'] := formatdatetime('yyyy-mm-dd',
        DateTpEndDate.Date); ;
      Params.ParamValues['scheduleid'] := NovaEditSchedule.id;
      Params.ParamValues['vehicletypeids'] := NvCcbVehileType.GetSelectID;
      Active := true;
      if recordcount = 0 then
      begin
        SysDialogs.Warning('该班次还没设置硬调票价！');
        exit;
      end;
    end;
end;

end.

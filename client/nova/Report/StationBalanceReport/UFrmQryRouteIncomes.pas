unit UFrmQryRouteIncomes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls,UDMPublic, NovaEdit, NovaHelp;

type
  TFrmQryRouteIncomes = class(TSimpleCRUDForm)
    Label2: TLabel;
    Label3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    cbbyroute: TCheckBox;
    cbbyschedule: TCheckBox;
    cbbyreachstation: TCheckBox;
    nvhelpRoute: TNovaHelp;
    nvhelpstation: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryRouteIncomes: TFrmQryRouteIncomes;

implementation
 uses PubFn, Services;
{$R *.dfm}

procedure TFrmQryRouteIncomes.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date:=now;
  dtpenddate.Date:=now;
end;

procedure TFrmQryRouteIncomes.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
   if cbbyroute.Checked then
      dbgrdhResult.Columns[0].Visible :=True
   else
     dbgrdhResult.Columns[0].Visible :=False;

   if cbbyreachstation.Checked then
      dbgrdhResult.Columns[1].Visible :=True
   else
      dbgrdhResult.Columns[1].Visible :=False;

    if cbbyschedule.Checked then
    begin
      dbgrdhResult.Columns[2].Visible :=True;
      dbgrdhResult.Columns[13].Visible :=True;
    end
    else
    begin
     dbgrdhResult.Columns[2].Visible :=False;
     dbgrdhResult.Columns[13].Visible :=False;
    end;

  end;
end;

procedure TFrmQryRouteIncomes.tbtnFilterClick(Sender: TObject);
begin
  inherited;


  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['startdate'] := formatdatetime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := formatdatetime('yyyy-mm-dd',
      dtpenddate.Date);

    if cbbyroute.Checked then
        params.ParamValues['isroutegroup'] := True
      else
        params.ParamValues['isroutegroup'] := False;
    if cbbyreachstation.Checked then
        params.ParamValues['isstationgroup'] := True
      else
        params.ParamValues['isstationgroup'] := False;
    if cbbyschedule.Checked then
        params.ParamValues['isschedulegroup'] := True
      else
        params.ParamValues['isschedulegroup'] := False;

    if nvhelpRoute.Id>0 then
    begin
      params.ParamValues['routeid'] := nvhelpRoute.Id;
    end
    else
    begin
       params.ParamValues['routeid'] := '0';
    end;

    if nvhelpstation.Id>0 then
    begin
       params.ParamValues['stationid'] := nvhelpstation.Id;
    end
    else
    begin
       params.ParamValues['stationid'] := '0';
    end;

     if nvhlpschedule.Id>0 then
    begin
      params.ParamValues['scheduleid'] := nvhlpschedule.Id;
    end
    else
    begin
      params.ParamValues['scheduleid'] := '0';
    end;

    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;

    dbgrdhResult.PrintInfo.PageTopRight := '发车日期：' + formatdatetime
      ('yyyy-mm-dd', dtpstartdate.Date) +'  至'+ formatdatetime
      ('yyyy-mm-dd', dtpenddate.Date);
    Active := true;
  end;
end;

end.

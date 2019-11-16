unit UFrmQueryOrgDataSummary;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls,
  ComCtrls, Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit,
  NovaHelp, UDMPublic,
  NovaHComboBox;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
  TfrmQueryOrgDataSummary = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    compareObjectid:String ;
    { Public declarations }
  end;

var
  frmQueryOrgDataSummary: TfrmQueryOrgDataSummary;

implementation

uses SystemInstance, SysInfoIntf,PubFn;
{$R *.dfm}

procedure TfrmQueryOrgDataSummary.FormCreate(Sender: TObject);
var columntitle:TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryOrgDataSummary.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TfrmQueryOrgDataSummary.jcdsResultAfterOpen(DataSet: TDataSet);
var I,j: Integer;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    DataSet.First;
    for j := 0 to DataSet.Fields.Count - 1 do
      for I := 0 to DataSet.Fields.Count - 1 do
      begin
        dbgrdhResult.Columns.Items[i].Index:=
        DataSet.FieldByName(dbgrdhResult.Columns.Items[i].FieldName).AsInteger;
        dbgrdhResult.Columns.Items[i].Width := 100;
      end;
    DataSet.Delete;
    dbgrdhResult.Columns.Items[0].Visible := false;//sort
    dbgrdhResult.Columns.Items[1].Visible := false;//sort2
//    dbgrdhResult.Columns.Items[0].Footer.DisplayFormat := '合计';
//    dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtCount;
//    dbgrdhResult.Columns.Items[1].Width := 80;
//    dbgrdhResult.Columns.Items[1].Footer.ValueType := fvtCount;
//    dbgrdhResult.Columns.Items[DataSet.Fields.Count - 1].Width := 100;
//    dbgrdhResult.Columns.Items[2].Width := 150;
//    dbgrdhResult.Columns.Items[3].Width := 150;
//    for I := 4 to DataSet.Fields.Count - 2 do
//    begin
//        dbgrdhResult.Columns.Items[i].Footer.ValueType := fvtSum;
//    end;
  end;
end;

procedure TfrmQueryOrgDataSummary.tbtnFilterClick(Sender: TObject);
var
  log:string;
begin
  inherited;
  nvckbOrgid.SetFocus;//消除选择时间bug
  if nvckbOrgid.GetCount = 0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if FormatDateTime('yyyy', dtpstartdate.Date) <> FormatDateTime('yyyy',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('只能记同一年的数据！');
    exit;
  end;

  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;

    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
      Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);

    Active := True;

    if RecordCount=0 then
    begin
      dbgrdhResult.Columns.Items[0].Width := 80;
    end;

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '查询条件有：[日期]'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[机构]：'+nvckbOrgid.Text;


    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->站务作业统计报表','查询',log);
  end;

end;

end.
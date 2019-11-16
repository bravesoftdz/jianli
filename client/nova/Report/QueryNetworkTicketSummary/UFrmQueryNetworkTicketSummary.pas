unit UFrmQueryNetworkTicketSummary;

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
    TfrmQueryNetworkTicketSummary = class(TSimpleCRUDForm)lbl1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    pnl1: TPanel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    lbldate: TLabel;
    Label1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    dtpComStar: TDateTimePicker;
    dtpComEnd: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dtpComStarChange(Sender: TObject);
    procedure dtpComEndChange(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    function SplitString(src, dec: string): TStringList; stdcall;

  public
    compareObjectid: String;
    { Public declarations }
  end;

var
  frmQueryNetworkTicketSummary: TfrmQueryNetworkTicketSummary;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TfrmQueryNetworkTicketSummary.dtpComEndChange(Sender: TObject);
begin
  if dtpComEnd.Checked then
  begin
    dtpComStar.Checked := true;
    dtpComEnd.Date := dtpComStar.Date + dtpenddate.Date - dtpstartdate.Date;
  end
  else
  begin
    dtpComStar.Checked := false;
  end;
end;

procedure TfrmQueryNetworkTicketSummary.dtpComStarChange(Sender: TObject);
begin
  inherited;
  if dtpComStar.Checked then
  begin
    dtpComEnd.Checked := true;
    dtpComEnd.Date := dtpComStar.Date + dtpenddate.Date - dtpstartdate.Date;
  end
  else
  begin
    dtpComEnd.Checked := false;
  end;
end;

procedure TfrmQueryNetworkTicketSummary.FormCreate(Sender: TObject);
var
  columntitle: TColumnTitleEh;
begin
  inherited;
  nvckbOrgid.Active := false;
  nvckbOrgid.Active := true;
  nvckbOrgid.CheckById(true, sysinfo.LoginUserInfo.OrgID);
end;

procedure TfrmQueryNetworkTicketSummary.FormShow(Sender: TObject);
var
 i:integer ;
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  dtpComStar.Date := Now - 30;
  dtpComEnd.Date := Now - 30;
  dbgrdhResult.GridUser := sysinfo.LoginUserInfo.UserID;
  for I := 0 to dbgrdhResult.Columns.Count - 1 do
  begin
    dbgrdhResult.Columns.Items[I].Visible := false;
  end;
end;

procedure TfrmQueryNetworkTicketSummary.jcdsResultAfterOpen(DataSet: TDataSet);
var
  I, j: Integer;
  sumcol: Integer;
begin
  inherited;
  { if DataSet.RecordCount > 0 then
    begin
    DataSet.First;
    for I := 0 to DataSet.Fields.Count - 1 do
    begin
    dbgrdhResult.Columns.Items[I].Width := 80;
    end;

    for j := 0 to DataSet.Fields.Count - 1 do
    for I := 0 to DataSet.Fields.Count - 1 do
    begin
    dbgrdhResult.Columns.Items[I].Index := DataSet.FieldByName
    (dbgrdhResult.Columns.Items[I].FieldName).AsInteger;
    dbgrdhResult.Columns.Items[I].Width := 60;
    end;
    DataSet.Delete;
    dbgrdhResult.Columns.Items[0].Width := 120;
    dbgrdhResult.Columns.Items[0].Footer.DisplayFormat := '合计';
    dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtCount;
    dbgrdhResult.Columns.Items[1].Width := 60;
    dbgrdhResult.Columns.Items[1].Footer.ValueType := fvtSum;
    dbgrdhResult.Columns.Items[2].Footer.ValueType := fvtSum;
    //dbgrdhResult.Columns.Items[3].Footer.ValueType := fvtSum;
    sumcol :=1;//判断需要合计的行
    if dtpComStar.Checked then
    begin
    //j:=0;
    for I := 0 to trunc((DataSet.Fields.Count-1)/6)-1 do
    begin
    dbgrdhResult.Columns.Items[I*6+1].Footer.ValueType := fvtSum;
    dbgrdhResult.Columns.Items[I*6+2].Footer.ValueType := fvtSum;

    dbgrdhResult.Columns.Items[I*6+4].Footer.ValueType := fvtSum;
    dbgrdhResult.Columns.Items[I*6+5].Footer.ValueType := fvtSum;
    //j:=j+3;
    end;
    end
    else
    begin
    for I := 1 to DataSet.Fields.Count - 1 do
    begin
    dbgrdhResult.Columns.Items[i].Footer.ValueType := fvtSum;
    end;
    end;


    end;
    }

end;

function TfrmQueryNetworkTicketSummary.SplitString(src, dec: string)
  : TStringList;
var
  I: Integer;
  str: string;
begin
  result := TStringList.Create;
  repeat
    I := pos(dec, src);
    str := copy(src, 1, I - 1);
    if (str = '') and (I > 0) then
    begin
      delete(src, 1, length(dec));
      continue;
    end;
    if I > 0 then
    begin
      result.Add(str);
      delete(src, 1, I + length(dec) - 1);
    end;
  until I <= 0;
  if src <> '' then
    result.Add(src);

end;

procedure TfrmQueryNetworkTicketSummary.tbtnFilterClick(Sender: TObject);
var
  log, titlename: string;
  // Columninfo: array of TColumninfo;
  I, j, idx: Integer;
  Columns: TDBGridColumnsEh;
  Column_n: TColumnEh;
  st: TStringList;
begin
  inherited;
  // nvckbOrgid.SetFocus; // 消除选择时间bug
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
  if FormatDateTime('yyyymmdd', dtpComStar.Date) > FormatDateTime('yyyymmdd',
    dtpComEnd.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', sysinfo.LoginUserInfo.OrgID)) <= Trunc
    (dtpenddate.Date - dtpstartdate.Date) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  { if not (dtpenddate.Date = dtpstartdate.Date + dtpComEnd.Date - dtpComStar.Date) then
    begin
    SysDialogs.Warning('同比日期天数差必须等于发车日期天数差!');
    Exit;
    end; }

  for I := 0 to dbgrdhResult.Columns.Count - 1 do
  begin
    dbgrdhResult.Columns.Items[I].Visible := false;
  end;
  dbgrdhResult.Columns.Clear;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_s!orgid'] := nvckbOrgid.GetSelectID;
    // if (Trim(nvhlpRoute.Text)<>'')  and (nvhlpRoute.HelpFieldValue['id']>0) then
    // begin
    // Params.ParamValues['filter_EQL_r!id']:= nvhlpRoute.HelpFieldValue['id'];
    // end
    // else
    // begin
    // Params.ParamValues['filter_EQL_r!id']:= '';
    // end;
    Params.ParamValues['filter_GED_p!startdate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date);
    Params.ParamValues['filter_LED_p!enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    if dtpComStar.Checked then
    begin
      Params.ParamValues['filter_GED_c!compSdate'] := FormatDateTime
        ('yyyy-mm-dd', dtpComStar.Date);
      Params.ParamValues['filter_LED_c!compEdate'] := FormatDateTime
        ('yyyy-mm-dd', dtpComEnd.Date);
    end
    else
    begin
      Params.ParamValues['filter_GED_c!compSdate'] := null;
      Params.ParamValues['filter_LED_c!compEdate'] := null;
    end;

    Active := true;
    if recordcount > 0 then
    begin
      dbgrdhResult.Columns.BeginUpdate;
      titlename := Params.ParamValues['titlename'];
      st := SplitString(titlename, ',');
      Columns := dbgrdhResult.Columns;
      for I := 0 to FieldCount - 1 do
      begin
        Column_n := Columns.Add;
         Column_n.FieldName := 'a' + inttostr(I);
         Column_n.Width := 60;
         Column_n.Title.Caption := st[I];
      end;
      dbgrdhResult.Columns.Items[0].Width := 100;
    dbgrdhResult.Columns.Items[0].Footer.value := '合计';
    dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtStaticText;
      if dtpComStar.Checked then
      begin
        for I := 0 to Trunc((FieldCount - 1) / 6) - 1 do
        begin
          dbgrdhResult.Columns.Items[I * 6 + 1].Footer.ValueType := fvtSum;
          dbgrdhResult.Columns.Items[I * 6 + 2].Footer.ValueType := fvtSum;

          dbgrdhResult.Columns.Items[I * 6 + 4].Footer.ValueType := fvtSum;
          dbgrdhResult.Columns.Items[I * 6 + 5].Footer.ValueType := fvtSum;
        end;
      end
      else
      begin
        for I := 1 to FieldCount - 1 do
        begin
          dbgrdhResult.Columns.Items[I].Footer.ValueType := fvtSum;
        end;
      end;
      dbgrdhResult.DataSource := dsResult;
    end;
    dbgrdhResult.Columns.EndUpdate;
    dbgrdhResult.Refresh;
    dbgrdhResult.PrintInfo.PageTopLeft :=
      '制表机构：' + sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight := '售票日期：' + FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.Date) + ' 至' + FormatDateTime
      ('yyyy-mm-dd', dtpenddate.Date) + ' 同比日期：' + FormatDateTime
      ('yyyy-mm-dd', dtpComStar.Date) + ' 至' + FormatDateTime('yyyy-mm-dd',
      dtpComEnd.Date);

    log := '查询条件有：[售票日期]从 ' + FormatDateTime('yyyy-mm-dd', dtpstartdate.Date)
      + ' 至 ' + FormatDateTime('yyyy-mm-dd', dtpenddate.Date)
      + '[同比日期] 从 ' + FormatDateTime('yyyy-mm-dd', dtpComStar.Date)
      + ' 至 ' + FormatDateTime('yyyy-mm-dd', dtpComEnd.Date);
    if trim(nvckbOrgid.Text) <> '' then
      log := log + ',[机构]：' + nvckbOrgid.Text;

    log := log + ' 。[查询结果]:返回 ' + inttostr(recordcount) + ' 条记录！';
    SysLog.WriteLog('报表统计->联网售票统计报表表', '查询', log);
  end;

end;

end.

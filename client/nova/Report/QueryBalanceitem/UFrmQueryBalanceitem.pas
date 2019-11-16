unit UFrmQueryBalanceitem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, StdCtrls, NovaHComboBox, ComCtrls,
  NovaCheckedComboBox, NvPrnDbgeh, DB, DBClient, jsonClientDataSet, ImgList,
  GridsEh, DBGridEh, NvDbgridEh, ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmQueryBalanceitem = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    nvcbbNovaCkbOrg: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    nvhelpvehicleno: TNovaHelp;
    Label4: TLabel;
    nvhelpunitname: TNovaHelp;
    sellOrgid: TNovaCheckedComboBox;
    lblroute: TLabel;
    nvhlproute: TNovaHelp;
    Label2: TLabel;
    EditBalanceno: TEdit;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryBalanceitem: TFrmQueryBalanceitem;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmQueryBalanceitem.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbNovaCkbOrg.Active := False;
  nvcbbNovaCkbOrg.Active := True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  sellOrgid.Active := False;
  sellOrgid.Active := True;
end;

procedure TFrmQueryBalanceitem.jcdsResultAfterOpen(DataSet: TDataSet);
var
  I,j: Integer;
begin
  inherited;
  if DataSet.RecordCount>0 then
  begin
    DataSet.First;
    for j := 0 to DataSet.Fields.Count - 1 do
      dbgrdhResult.Columns[j].Width:=75;
      for I := 0 to DataSet.Fields.Count - 1 do
      begin
        dbgrdhResult.Columns.Items[i].Index:=
        DataSet.FieldByName(dbgrdhResult.Columns.Items[i].FieldName).AsInteger;
      end;
    DataSet.Delete;
    dbgrdhResult.Columns.Items[0].Width := 100;
    dbgrdhResult.Columns.Items[0].Footer.DisplayFormat := '合计';
    dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtCount;
    dbgrdhResult.Columns.Items[1].Width := 80;
    dbgrdhResult.Columns.Items[1].Footer.ValueType := fvtCount;
    dbgrdhResult.Columns.Items[DataSet.Fields.Count - 1].Width := 100;
    dbgrdhResult.Columns.Items[2].Width := 150;
    dbgrdhResult.Columns.Items[3].Width := 150;
    for I := 4 to DataSet.Fields.Count - 2 do
    begin
        dbgrdhResult.Columns.Items[i].Footer.ValueType := fvtSum;
    end;
  end;
end;

procedure TFrmQueryBalanceitem.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
  then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
    exit;
  end;
  if Trim(sellOrgid.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择所属机构！');
    Exit;
  end;
  try
  SendMessage(dbgrdhResult.handle, WM_VSCROLL, SB_LEFT, 0);

  except
      on E: Exception do
      begin
        SysLog.WriteErr('用户添加失败：' + E.Message);
      end;
  end;
  jcdsResult.Close;
  with jcdsResult do
  begin
      try
    Active := False;
      //dbgrdhResult.HorzScrollBar.Visible := False;
      Params.ParamValues['orgid'] := sellOrgid.GetSelectID;
      params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
      Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date+1);
      if Trim(nvhelpvehicleno.Text) = '' then
        Params.ParamValues['vehicleno'] := ''
      else
        Params.ParamValues['vehicleno'] := nvhelpvehicleno.Text;
      if Trim(nvhelpunitname.Text) = '' then
        Params.ParamValues['unitid'] := ''
      else
        Params.ParamValues['unitid'] := nvhelpunitname.Id;
      if Trim(nvhlproute.Text) = '' then
        Params.ParamValues['routename'] := ''
      else
        Params.ParamValues['routename'] := nvhlproute.Text;
      if Trim(EditBalanceno.Text) = '' then
        Params.ParamValues['balanceno'] := ''
      else
        Params.ParamValues['balanceno'] := EditBalanceno.Text;

    Active := True;

//    dbgrdhResult.HorzScrollBar.Visible := True;
    log := '查询条件有：[结算日期]从 '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' 至 '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(sellOrgid.GetSelectID) <>'' then
      log := log +',[所属机构]：'+sellOrgid.Text;
    if nvhelpvehicleno.Id <> 0 then
      log := log +',[车牌号]：'+nvhelpvehicleno.Text;
    if nvhelpunitname.Id <>0 then
      log := log +',[结算单位]:'+nvhelpunitname.Text;
    log := log+' 。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->运费结算明细表','查询',log);
    except
      on E: Exception do
      begin
        with jcdsResult do
        begin
          Active := False;
          //dbgrdhResult.HorzScrollBar.Visible := False;
          Params.ParamValues['orgid'] := sellOrgid.GetSelectID;
          params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
          Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',dtpenddate.Date+1);
          if Trim(nvhelpvehicleno.Text) = '' then
            Params.ParamValues['vehicleno'] := ''
          else
            Params.ParamValues['vehicleno'] := nvhelpvehicleno.Text;
          if Trim(nvhelpunitname.Text) = '' then
            Params.ParamValues['unitid'] := ''
          else
            Params.ParamValues['unitid'] := nvhelpunitname.Id;
          Active := True;
        end;
        //SysLog.WriteErr('用户添加失败：' + IntToStr(dbgrdhResult.Columns.Count));
        //SysLog.WriteErr('用户添加失败：' + E.Message);
      end;
    end;

  end;
end;

end.

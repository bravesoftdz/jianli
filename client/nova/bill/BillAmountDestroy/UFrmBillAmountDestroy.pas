unit UFrmBillAmountDestroy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uBaseForm, USimpleCRUDForm, ImgList, ComCtrls, ToolWin, ExtCtrls,
  Buttons,
  GridsEh, DBGridEh, PrnDbgeh, DBGridEhGrouping, DB, DBClient, UFrmInfo,
  jsonClientDataSet, jsonConnection, UDMPublic, StdCtrls, NvPrnDbgeh,
  NvDbgridEh,
  NovaCheckedComboBox, NovaComboBox, NovaEdit, NovaHelp,
  UFrmBillAmountDestroyEdit;

type
  TFrmBillAmountDestroy = class(TBaseForm)
    ilToolBar: TImageList;
    ilToolBarDisable: TImageList;
    pnlQuery: TPanel;
    tlbShortCut: TToolBar;
    tbtnFilter: TToolButton;
    tbtn1: TToolButton;
    tbtnInsert: TToolButton;
    tbtnEdit: TToolButton;
    tbtnDelete: TToolButton;
    tbtn3: TToolButton;
    tbtnInfo: TToolButton;
    tbtn5: TToolButton;
    tbtn6: TToolButton;
    tbtnClose: TToolButton;
    jcdsResult: TjsonClientDataSet;
    dsResult: TDataSource;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    prntdbgrdhResult: TNvPrintDBGridEh;
    nvcbbOrgid: TNovaCheckedComboBox;
    lbl2: TLabel;
    nvhlpUserid: TNovaHelp;
    Label1: TLabel;
    dtpBselldate: TDateTimePicker;
    dtpEselldate: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    dbgrdhResult: TNvDbgridEh;
    jsonCDSDelBillamountdestroy: TjsonClientDataSet;
    procedure tbtnCloseClick(Sender: TObject);
    procedure tbtnInfoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBillAmountDestroy: TFrmBillAmountDestroy;

implementation

uses Services,
  PubFn;
{$R *.dfm}

procedure TFrmBillAmountDestroy.FormCreate(Sender: TObject);
begin
  inherited;
  self.jcdsResult.RemoteServer := UDMPublic.DMPublic.jcon;
  dtpBselldate.Date := Now;
  dtpEselldate.Date := Now;
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(True, sysinfo.LoginUserInfo.OrgID);
end;

procedure TFrmBillAmountDestroy.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  SysMainForm.CloseForm(self);
end;

procedure TFrmBillAmountDestroy.tbtnDeleteClick(Sender: TObject);
var flag: Integer;
    msg: String;
    log: String;
begin
  inherited;
    if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDelBillamountdestroy do
    try
      close;
      Params.ParamByName('billamountdestroy.id').Value := jcdsResult.FieldByName('id').AsLargeInt;
      Execute;
      flag := Params.ParamByName('flag').Value;
      msg := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(msg);
      if (flag = 1) then
      begin
        log := '删除票据金额核销信息：核销人=' + jcdsResult.FieldByName('billcancelername').AsString +
               ',机构=' + jcdsResult.FieldByName('orgname').AsString +
               ',核销金额=' + jcdsResult.FieldByName('cancelprice').AsString +
               ',核销日期=' + DateToStr(jcdsResult.FieldByName('canceldate').AsDateTime);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据金额核销删除失败：' + E.Message);
      end;
    end;
end;

procedure TFrmBillAmountDestroy.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmBillAmountDestroyEdit do
  begin
    FrmBillAmountDestroyEdit := TFrmBillAmountDestroyEdit.Create(self);
    Caption := '修改票据金额核销信息';

    id := jcdsResult.FieldByName('id').AsInteger;
    nvhlpUserid.Text := jcdsResult.FieldByName('billcancelername').AsString;
    nvhlpUserid.Id := jcdsResult.FieldByName('billcanceler').AsInteger;
    nvcbbOrgid.Text := jcdsResult.FieldByName('orgname').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    dtpDdate.DateTime := jcdsResult.FieldByName('canceldate').AsDateTime;
    edtparvalue.Text := jcdsResult.FieldByName('cancelprice').AsString;

    if SysMainForm.showFormModal(FrmBillAmountDestroyEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', Id, []);
    end;
  end;
end;

procedure TFrmBillAmountDestroy.tbtnFilterClick(Sender: TObject);
var
  log: string;
  orgid: integer;
begin
  inherited;
  if nvcbbOrgid.Text = '' then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;
  if dtpBselldate.Checked and (FormatDateTime('yyyymmdd',
      dtpBselldate.Date) > FormatDateTime('yyyymmdd', dtpEselldate.Date)) then
  begin
    SysDialogs.ShowMessage('核销开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToInt(getParametervalue('0006', sysinfo.LoginUserInfo.OrgID)) <= trunc
      (dtpEselldate.Date - dtpBselldate.Date)) then
  begin
    SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数(' + getParametervalue('0006',
        sysinfo.LoginUserInfo.OrgID) + '),请重新选择');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamByName('filter_INS_org!id').Value := nvcbbOrgid.GetSelectID;
    log := '机构:' + nvcbbOrgid.Text;
    Params.ParamValues['filter_GED_bc!canceldate'] := FormatDateTime
      ('yyyy-mm-dd hh:mm:ss', dtpBselldate.DateTime) + ' 00:00:00';
    Params.ParamValues['filter_LED_bc!canceldate'] := FormatDateTime
      ('yyyy-mm-dd hh:mm:ss', dtpEselldate.DateTime) + ' 23:59:59';
    log := log + ', 核销日期从' + DateToStr(dtpBselldate.DateTime) + '到' + DateToStr
      (dtpEselldate.DateTime) + ', ';

    if (not(Trim(nvhlpUserid.Text) = '')) and (nvhlpUserid.Id >= 0) then
    // 售票员
    begin
      Params.ParamValues['filter_EQL_u!id'] := nvhlpUserid.HelpFieldValue['id'];
      log := log + ' ,核销人;' + nvhlpUserid.Text;
    end
    else
    begin
      Params.ParamValues['filter_EQL_u!id'] := '';
    end;
    Active := True;

  end
end;

procedure TFrmBillAmountDestroy.tbtnInfoClick(Sender: TObject);
begin
  inherited;
  FrmInfo := TFrmInfo.Create(self);
  with FrmInfo do
  begin
    Caption := self.Caption + '模块功能说明';
    jscdQryFunInfo.RemoteServer := UDMPublic.DMPublic.jcon;
    key := GuidtoString(self.FfunctionItem.key);
    ShowModal;
  end;
end;

procedure TFrmBillAmountDestroy.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmBillAmountDestroyEdit := TFrmBillAmountDestroyEdit.Create(self);
  with FrmBillAmountDestroyEdit do
  begin
    Caption := '添加票据金额核销信息';
    if SysMainForm.showFormModal(FrmBillAmountDestroyEdit) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', Id, []);
    end;
  end;
end;

end.

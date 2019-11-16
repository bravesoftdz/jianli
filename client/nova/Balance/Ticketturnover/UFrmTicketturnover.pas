unit UFrmTicketturnover;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, UFrmTicketturnoverEdit,
  FunctionItemIntf,
  NovaCheckedComboBox, Menus, UDMPublic, DateUtils, StrUtils;

type
  TFrmTicketturnover = class(TSimpleCRUDForm)
    lbl1: TLabel;
    dataSource: TDataSource;
    jcdsResult1: TjsonClientDataSet;
    il1: TImageList;
    jsonDelDepartinvoicesotherdetail: TjsonClientDataSet;
    grp1: TGroupBox;
    nvdbgrdhdbgrdh1: TNvDbgridEh;
    mmo: TMemo;
    tlb1: TToolBar;
    btnInsertDep: TToolButton;
    btnUpdateDep: TToolButton;
    btn1: TToolButton;
    btndelDep: TToolButton;
    lbl2: TLabel;
    chkyes: TCheckBox;
    chkno: TCheckBox;
    dsTicketReturn: TDataSource;
    jcdsResultTicketReturn: TjsonClientDataSet;
    pnl3: TPanel;
    pnl1: TPanel;
    grp2: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    grp4: TGroupBox;
    nvdbgrdh2: TNvDbgridEh;
    grp3: TGroupBox;
    nvdbgrdh3: TNvDbgridEh;
    pnl2: TPanel;
    grp5: TGroupBox;
    nvdbgrdh4: TNvDbgridEh;
    grp6: TGroupBox;
    nvdbgrdh5: TNvDbgridEh;
    grp7: TGroupBox;
    nvdbgrdh6: TNvDbgridEh;
    dsTicketCancel: TDataSource;
    jcdsResultTicketCancel: TjsonClientDataSet;
    jcdsResultTicketBill: TjsonClientDataSet;
    dsTicketBill: TDataSource;
    dsInsurReturn: TDataSource;
    dsInsureCancel: TDataSource;
    dsInsureBill: TDataSource;
    jcdsResultInsurReturn: TjsonClientDataSet;
    jcdsResultInsureCancel: TjsonClientDataSet;
    jcdsResultInsureBill: TjsonClientDataSet;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    tbtnday: TToolButton;
    tbtnmonth: TToolButton;
    jcdsqueryrevenue: TjsonClientDataSet;
    Label1: TLabel;
    Novaopby: TNovaHelp;
    jcdsqrylostmoney: TjsonClientDataSet;
    cbborg: TNovaCheckedComboBox;
    nvhlpseller: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure ToolButton50Click(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure pnl3Resize(Sender: TObject);
    procedure pnl2Resize(Sender: TObject);
    procedure jcdsResult1AfterScroll(DataSet: TDataSet);
    procedure jcdsResult1AfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure tbtnCloseClick(Sender: TObject);
    procedure ToolButton53Click(Sender: TObject);
    procedure ToolButton52Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dataSourceDataChange(Sender: TObject; Field: TField);
    procedure ToolButton51Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnerrorClick(Sender: TObject);
    procedure nvhlpseller1IdChange(Sender: TObject);
    procedure tbtndayClick(Sender: TObject);
    procedure dbgrdhResultKeyPress(Sender: TObject; var Key: Char);
    procedure dbgrdhResultCellClick(Column: TColumnEh);
    procedure nvdbgrdhdbgrdh1CellClick(Column: TColumnEh);
  private
    { Private declarations }
    functiontype: string; // ��������  0Ӫ�սɿ�  1�ѽɿ��ѯ 2δ�ɿ��ѯ  3��ƱԱ�鿴�Լ���δ�ɿ�
    Fsellinsure: Boolean; // ϵͳ�Ƿ��۱���
    guid: String;
    log: String;
    iscanselectother, isvisible, isshowbutton: Boolean;
    procedure refreshTicketDetail();
    procedure refreshInsuranceDetail();
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent; functionItem: IFunctionItem = nil;
      parameter: TFunctionItemParameters = nil;
      checkpermission: Boolean = true); override;
    procedure HandleAuthority(const Key: TGUID; aEnable: Boolean); override;
  end;

var
  FrmTicketturnover: TFrmTicketturnover;

implementation

uses Services, UFrmTicketturnoverReport, UFrmTicketturnoverQuery, PubFn,
  UFrmTicketturnoverRevenue, UFrmTicketTurnOverErrorReport;
{$R *.dfm}

constructor TFrmTicketturnover.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;
  checkpermission: Boolean);
begin
  inherited;
  Fsellinsure := (getParametervalue('1022', SysInfo.LoginUserInfo.OrgID) = '1')
    and (getParametervalue('1045', SysInfo.LoginUserInfo.OrgID) = '1');
  grp1.Visible := Fsellinsure;
  pnl2.Visible := Fsellinsure;
  ToolButton53.Visible := Fsellinsure;

  functiontype := parameter.strings[0];
  // ��������  0Ӫ�սɿ�  1�ѽɿ��ѯ 2δ�ɿ��ѯ  3��ƱԱ�鿴�Լ���δ�ɿ�
  dbgrdhResult.Columns.Items[0].Visible := functiontype = '0';
  dbgrdhResult.Columns.Items[1].Visible := functiontype = '0';
  nvdbgrdhdbgrdh1.Columns.Items[0].Visible := functiontype = '0';
  nvdbgrdhdbgrdh1.Columns.Items[1].Visible := functiontype = '0';

  // ���û��Ȩ�� ����ƱԱ��ɵ�ǰ��ƱԱ�Ҳ����޸�
  if not iscanselectother then
  begin
    nvhlpseller.HelpFieldValue['id'] := SysInfo.LoginUserInfo.UserID;
    nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;
    nvhlpseller.Enabled := False;
  end;

  if functiontype = '0' then
  begin
    lbl1.Visible := true;
    nvhlpseller.Visible := true;
    tbtnFilter.Visible := true;
    tbtnInsert.Visible := isshowbutton;
    tbtnday.Visible := true;
    tbtnmonth.Visible := true;
    lbl2.Visible := true;
    chkyes.Visible := true;
    chkno.Visible := true;
    ToolButton50.Visible := true;
    tbtnEdit.Visible := False;
    tbtnDelete.Visible := False;
  end
  else if functiontype = '1' then
  begin
    lbl1.Visible := true;
    // nvhlpseller.Enabled := true;
    // if iscanselectother then
    // begin
    // nvhlpseller.Id:=sysinfo.LoginUserInfo.UserID ;
    // end;
    Novaopby.Visible := iscanselectother;
    Label1.Visible := iscanselectother;
    tbtnFilter.Visible := False;
    tbtnInsert.Visible := False;
    tbtnday.Visible := False;
    tbtnmonth.Visible := False;
    lbl2.Visible := False;
    chkyes.Visible := False;
    chkno.Visible := False;
//    chkyes.Visible := True;
//    chkno.Visible := True;
    ToolButton50.Visible := true;
    tbtnEdit.Visible := true;
    tbtnDelete.Visible := False;
    dbgrdhResult.Columns.Items[2].Footer.valueType := fvtStaticText;
    dbgrdhResult.Columns.Items[2].Footer.value := '�ϼ�';
    dbgrdhResult.Columns.Items[3].Footer.valueType := fvtCount;
  end
  else if functiontype = '2' then
  begin
    lbl1.Visible := true;
    // nvhlpseller.Enabled := true;
    // if iscanselectother then
    // begin
    // nvhlpseller.Id:=sysinfo.LoginUserInfo.UserID ;
    // end;
    Novaopby.Visible := iscanselectother;
    Label1.Visible := iscanselectother;
    tbtnFilter.Visible := False;
    tbtnInsert.Visible := isshowbutton;
    tbtnday.Visible := False;
    tbtnmonth.Visible := False;
    lbl2.Visible := False;
    chkyes.Visible := False;
    chkno.Visible := False;
    ToolButton50.Visible := False;
    tbtnEdit.Visible := False;
    tbtnDelete.Visible := true;
    dbgrdhResult.Columns.Items[2].Footer.valueType := fvtStaticText;
    dbgrdhResult.Columns.Items[2].Footer.value := '�ϼ�';
    dbgrdhResult.Columns.Items[3].Footer.valueType := fvtCount;
  end
  else if functiontype = '3' then
  begin
    lbl1.Visible := False;
    nvhlpseller.Visible := False;
    tbtnFilter.Visible := False;
    lbl2.Visible := False;
    chkyes.Visible := True;
    chkno.Visible := True;
    tbtnEdit.Visible := True;
    tbtnDelete.Visible := true;
    Self.BorderStyle := bsSingle;

    { TODO : ��ϵͳ������������ƱԱ�Ƿ��Լ���ӡ�ɿ }
    tbtnInsert.Visible := (getParametervalue('0010',
        SysInfo.LoginUserInfo.OrgID) = '1');
    ToolButton50.Visible := tbtnInsert.Visible;
    dbgrdhResult.Columns.Items[0].Visible := tbtnInsert.Visible;
    dbgrdhResult.Columns.Items[1].Visible := tbtnInsert.Visible;
    nvdbgrdhdbgrdh1.Columns.Items[0].Visible := tbtnInsert.Visible;
    nvdbgrdhdbgrdh1.Columns.Items[1].Visible := tbtnInsert.Visible;
    if not tbtnInsert.Visible then
    begin
      dbgrdhResult.Columns.Items[3].Footer.valueType := fvtStaticText;
      dbgrdhResult.Columns.Items[3].Footer.value := '�ϼ�';
      dbgrdhResult.Columns.Items[4].Footer.valueType := fvtCount;
    end;
    dbgrdhResult.Columns.Items[2].Visible := False;
    nvdbgrdhdbgrdh1.Columns.Items[2].Visible := False;
  end;
end;

procedure TFrmTicketturnover.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(Key) = '{9FE832DC-1DD5-460E-A4D1-6296C16F7B35}' then
  begin
    guid := '{9FE832DC-1DD5-460E-A4D1-6296C16F7B35}';
    isvisible := aEnable;
  end;
  if GUIDToString(Key) = '{5D53D224-EAD3-4A3F-AAB6-06A38683FAA5}' then
  begin
    isshowbutton := aEnable; // Ȩ�޿����Ƿ����Ӫ�սɿ� ��ť�Ĺ���
  end;
  if GUIDToString(Key) = '{4146270C-1A10-4320-BF91-79415EF50779}' then
  begin
    iscanselectother := aEnable; // Ȩ�޿����Ƿ����Ӫ�սɿ� ��ť�Ĺ���
  end;
end;

procedure TFrmTicketturnover.dataSourceDataChange(Sender: TObject;
  Field: TField);
begin
  inherited;
  // if jcdsResult1.FieldByName('isturnover').AsBoolean then
  // nvdbgrdhdbgrdh1.FieldColumns['ischoose'].ReadOnly := true
  // else
  // nvdbgrdhdbgrdh1.FieldColumns['ischoose'].ReadOnly := false;
end;



procedure TFrmTicketturnover.dbgrdhResultKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if Key = #13 then
  begin
    tbtnInsertClick(Sender);
  end;
end;

procedure TFrmTicketturnover.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();

  cbborg.Active := False;
  cbborg.Active := true;
end;

procedure TFrmTicketturnover.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key = VK_ESCAPE) and (functiontype = '3') then
  begin
    Self.Close;
  end;
end;

procedure TFrmTicketturnover.FormShow(Sender: TObject);
begin
  inherited;
  if functiontype = '3' then
  begin
    WindowState := wsMaximized;
    tbtnDeleteClick(tbtnDelete);
  end;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  if nvhlpseller.Enabled then
  begin
    nvhlpseller.SetFocus;
  end;
end;

procedure TFrmTicketturnover.jcdsResult1AfterOpen(DataSet: TDataSet);
begin
  inherited;
  {if dataSource.DataSet.RecordCount < 1 then
  begin
    jcdsResultInsurReturn.Close;
    jcdsResultInsureCancel.Close;
    jcdsResultInsureBill.Close;
  end; }
end;

procedure TFrmTicketturnover.jcdsResult1AfterScroll(DataSet: TDataSet);
begin
  inherited;
  //refreshInsuranceDetail;
end;

procedure TFrmTicketturnover.nvdbgrdhdbgrdh1CellClick(Column: TColumnEh);
begin
  inherited;
  refreshInsuranceDetail;
end;

procedure TFrmTicketturnover.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  {if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsResultTicketReturn.Close;
    jcdsResultTicketCancel.Close;
    jcdsResultTicketBill.Close;
    Exit;
  end;
  refreshTicketDetail(); }
end;

procedure TFrmTicketturnover.dbgrdhResultCellClick(Column: TColumnEh);
begin
  inherited;
   if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsResultTicketReturn.Close;
    jcdsResultTicketCancel.Close;
    jcdsResultTicketBill.Close;
    Exit;
  end;
  refreshTicketDetail();
end;

procedure TFrmTicketturnover.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischoose').value := true;
        next;
      end;
    end;
  end;
end;

procedure TFrmTicketturnover.N2Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischoose').value := not fieldbyname('ischoose').AsBoolean;
        next;
      end;
    end;
  end;
end;

procedure TFrmTicketturnover.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('ischoose').value := False;
        next;
      end;
    end;
  end;
end;



procedure TFrmTicketturnover.nvhlpseller1IdChange(Sender: TObject);
begin
  inherited;
  //
  tbtnFilterClick(Sender);
end;

procedure TFrmTicketturnover.pnl2Resize(Sender: TObject);
begin
  inherited;
  grp5.Width := pnl2.Width div 3;
  grp7.Width := pnl2.Width div 3;
end;

procedure TFrmTicketturnover.pnl3Resize(Sender: TObject);
begin
  inherited;
  grp2.Width := pnl1.Width div 3;
  grp3.Width := pnl1.Width div 3;
end;

procedure TFrmTicketturnover.refreshInsuranceDetail;
begin
  if not dataSource.DataSet.Active then
    Exit;
  if dataSource.DataSet.RecordCount < 1 then
    Exit;
  with jcdsResultInsurReturn do
  begin
    Active := False;
    Params.ParamValues['filter_INS_i!turnoverdetailid'] :=
      jcdsResult1.fieldbyname('id').AsString;
    Active := true;
  end;

  with jcdsResultInsureCancel do
  begin
    Active := False;
    Params.ParamValues['filter_INS_i!turnoverdetailid'] :=
      jcdsResult1.fieldbyname('id').AsString;
    Active := true;
  end;

  with jcdsResultInsureBill do
  begin
    Active := False;
    Params.ParamValues['filter_INS_b!turnoverdetailid'] :=
      jcdsResult1.fieldbyname('id').AsString;
    Active := true;
  end;
end;

procedure TFrmTicketturnover.refreshTicketDetail;
begin
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jcdsResultTicketReturn do
  begin
    Active := False;
    Params.ParamValues['filter_INS_tr!turnoverdetailid'] :=
      jcdsResult.fieldbyname('id').AsString;
    Active := true;
  end;

  with jcdsResultTicketCancel do
  begin
    Active := False;
    Params.ParamValues['filter_INS_tc!turnoverdetailid'] :=
      jcdsResult.fieldbyname('id').AsString;
    Active := true;
  end;

  with jcdsResultTicketBill do
  begin
    Active := False;
    Params.ParamValues['filter_INS_b!turnoverdetailid'] :=
      jcdsResult.fieldbyname('id').AsString;
    Active := true;
  end;
end;

procedure TFrmTicketturnover.tbtnCloseClick(Sender: TObject);
begin
  if functiontype = '3' then
    Self.Close
  else
    inherited;
end;

procedure TFrmTicketturnover.tbtndayClick(Sender: TObject);
begin
  inherited;
  FrmTicketturnoverRevenue := TFrmTicketturnoverRevenue.Create(Self);
  try
    with FrmTicketturnoverRevenue do
    begin
      Caption := '��Ӫ�յ�';
      cbbuser.Visible := true;
      FrmTicketturnoverRevenue.nvhlpseller.Visible := true;
      // ���û��Ȩ�ޣ�������ԭ���� cbbuser����ʾ nvhlpseller
      if not iscanselectother then
      begin
        cbbuser.Visible := False;
        FrmTicketturnoverRevenue.nvhlpseller.HelpFieldValue['id'] :=
          SysInfo.LoginUserInfo.UserID;
        FrmTicketturnoverRevenue.nvhlpseller.Text :=
          SysInfo.LoginUserInfo.UserName;
        FrmTicketturnoverRevenue.nvhlpseller.Enabled := False;
      end
      else
      begin // �������� nvhlpseller
        FrmTicketturnoverRevenue.nvhlpseller.Visible := False;
      end;
      if SysMainForm.showFormModal(FrmTicketturnoverRevenue, False) = mrok then
      begin
        jcdsResultAfterScroll(nil);
      end;
    end;
  finally
    FreeAndNil(FrmTicketturnoverRevenue);
  end;
end;

procedure TFrmTicketturnover.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������!');
    Exit;
  end;
  with jcdsResult do
  begin
    AfterScroll := nil;
    Active := False;
    Params.ParamValues['filter_GED_t!moneydate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_t!moneydate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);
    // if functiontype = '3' then
    // begin
    // Params.ParamValues['filter_EQL_t!seller'] := SysInfo.LoginUserInfo.UserID;
    // Params.ParamValues['filter_EQB_t!isturnover'] := null;
    // end
    // else
    // begin
    // Params.ParamValues['filter_EQB_t!isturnover'] := 'false';
    // if Trim(nvhlpseller.Text) = '' then
    // Params.ParamValues['filter_EQL_t!seller'] := ''
    // else
    // Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.HelpFieldValue
    // ['id'];
    // end;
    if not iscanselectother then
    begin
      Params.ParamValues['filter_EQL_t!seller'] := SysInfo.LoginUserInfo.UserID;
      Params.ParamValues['filter_EQB_t!isturnover'] := False;
    end
    else
    begin
      Params.ParamValues['filter_EQB_t!isturnover'] := 'false';
      if Trim(nvhlpseller.Text) = '' then
        Params.ParamValues['filter_EQL_t!seller'] := ''
      else
        Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.HelpFieldValue
          ['id'];
    end;
    if Trim(cbborg.Text) <> '' then
      Params.ParamValues['filter_INS_us!orgid'] := cbborg.GetSelectID
    else
      Params.ParamValues['filter_INS_us!orgid'] := SysInfo.LoginUserInfo.OrgIDs;
    Active := true;
    jcdsResultAfterScroll(jcdsResult);
    jcdsResult.AfterScroll := jcdsResultAfterScroll;
  end;

  if Fsellinsure then
  begin
    with jcdsResult1 do
    begin
      AfterScroll := nil;
      Active := False;
      Params.ParamValues['filter_GED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
      // if functiontype = '3' then
      // begin
      // Params.ParamValues['filter_EQL_t!seller'] :=
      // SysInfo.LoginUserInfo.UserID;
      // Params.ParamValues['filter_EQB_t!isturnover'] := null;
      // end
      // else
      // begin
      // Params.ParamValues['filter_EQB_t!isturnover'] := 'false';
      // if Trim(nvhlpseller.Text) = '' then
      // begin
      // Params.ParamValues['filter_EQL_t!seller'] := '';
      // end
      // else
      // begin
      // Params.ParamValues['filter_EQL_t!seller'] :=
      // nvhlpseller.HelpFieldValue['id'];
      // end;
      // end;
      if not iscanselectother then
      begin
        Params.ParamValues['filter_EQL_t!seller'] :=
          SysInfo.LoginUserInfo.UserID;
        Params.ParamValues['filter_EQB_t!isturnover'] := False;
      end
      else
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := 'false';
        if Trim(nvhlpseller.Text) = '' then
        begin
          Params.ParamValues['filter_EQL_t!seller'] := '';
        end
        else
        begin
          Params.ParamValues['filter_EQL_t!seller'] :=
            nvhlpseller.HelpFieldValue['id'];
        end;
      end;
      if Trim(cbborg.Text) <> '' then
        Params.ParamValues['filter_INS_u!orgid'] := cbborg.GetSelectID
      else
        Params.ParamValues['filter_INS_u!orgid'] :=
          SysInfo.LoginUserInfo.OrgIDs;
      Active := true;
      jcdsResult1AfterScroll(jcdsResult1);
      jcdsResult1.AfterScroll := jcdsResult1AfterScroll;
    end;
  end;
end;

procedure TFrmTicketturnover.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������!');
    Exit;
  end;
  with jcdsResult do
  begin
    AfterScroll := nil;
    Active := False;
    Params.ParamValues['filter_GED_t!moneydate'] := FormatDateTime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_t!moneydate'] := FormatDateTime
      ('yyyy-mm-dd', dtpenddate.DateTime);

    if not iscanselectother then
    begin
      Params.ParamValues['filter_EQL_t!seller'] := SysInfo.LoginUserInfo.UserID
    end
    else
     //�����жϣ���ƱԱ�պͷǿյ����
    begin

      if Trim(nvhlpseller.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!seller'] := '';
      end
      else
      begin
        Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.HelpFieldValue
          ['id'];
      end;
    end;
    if Trim(cbborg.Text) <> '' then
      Params.ParamValues['filter_INS_us!orgid'] := cbborg.GetSelectID
    else
      Params.ParamValues['filter_INS_us!orgid'] := SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_EQB_t!isturnover'] := 'true';
    Active := true;
    jcdsResultAfterScroll(jcdsResult);
    jcdsResult.AfterScroll := jcdsResultAfterScroll;
  end;

  if Fsellinsure then
  begin
    with jcdsResult1 do
    begin
      AfterScroll := nil;
      Active := False;
      Params.ParamValues['filter_GED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
      // if Trim(nvhlpseller.Text) = '' then
      // Params.ParamValues['filter_EQL_t!seller'] := ''
      // else
      // Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.HelpFieldValue
      // ['id'];
      if not iscanselectother then
      begin
        Params.ParamValues['filter_EQL_t!seller'] :=
          SysInfo.LoginUserInfo.UserID;
      end
      else
      begin
        Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.HelpFieldValue
          ['id'];
      end;

      if Trim(cbborg.Text) <> '' then
        Params.ParamValues['filter_INS_u!orgid'] := cbborg.GetSelectID
      else
        Params.ParamValues['filter_INS_u!orgid'] :=
          SysInfo.LoginUserInfo.OrgIDs;
      Params.ParamValues['filter_EQB_t!isturnover'] := 'true';
      Active := true;
      jcdsResult1AfterScroll(jcdsResult1);
      jcdsResult1.AfterScroll := jcdsResult1AfterScroll;
    end;
  end;
end;

procedure TFrmTicketturnover.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������!');
    Exit;
  end;

  jcdsResult.AfterScroll := nil;
  try
    with jcdsResult do
    begin
      Active := False;
      Params.ParamValues['filter_GED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);

      // if functiontype = '3' then
      // begin
      // Params.ParamValues['filter_EQL_t!seller'] :=
      // SysInfo.LoginUserInfo.UserID;
      // end

      if Trim(nvhlpseller.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!seller'] := '';
      end
      else
      begin
        Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.HelpFieldValue
          ['id'];
      end;
      if chkyes.Checked and chkno.Checked then
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := '';
      end
      else if chkyes.Checked then
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := 'true';
      end
      else if chkno.Checked then
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := 'false';
      end
      else
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := '';
      end;
      // ������
      if Trim(Novaopby.Text) <> '' then
        Params.ParamValues['filter_EQL_T!updateby'] := Novaopby.id
      else
        Params.ParamValues['filter_EQL_T!updateby'] := null;

      if Trim(cbborg.Text) <> '' then
        Params.ParamValues['filter_INS_us!orgid'] := cbborg.GetSelectID
      else
        Params.ParamValues['filter_INS_us!orgid'] :=
          SysInfo.LoginUserInfo.OrgIDs;
      if Trim(nvhlpseller.Text) = '' then
      begin
        Params.ParamValues['seller'] := '';
      end
      else
      begin
        Params.ParamValues['seller'] := nvhlpseller.HelpFieldValue['id'];
      end;

      Active := true;
      jcdsResult.AfterScroll := jcdsResultAfterScroll;
      if RecordCount = 1 then
      begin
        refreshTicketDetail();
      end;
    end;
  except
    on E: exception do
    begin
      SysLog.WriteErr('����ʧ�ܣ�' + E.Message);
    end;
  end;
  // jcdsResultAfterScroll(jcdsResult);

  if Fsellinsure then
  begin
    with jcdsResult1 do
    begin
      jcdsResult1.AfterScroll := nil;
      Active := False;
      Params.ParamValues['filter_GED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
      if functiontype = '3' then
      begin
        Params.ParamValues['filter_EQL_t!seller'] :=
          SysInfo.LoginUserInfo.UserID;
      end
      else
      //��ƱԱ�ж�
      begin
        if Trim(nvhlpseller.Text) = '' then
        begin
          Params.ParamValues['filter_EQL_t!seller'] := '';
        end
        else
        begin
           Params.ParamValues['filter_EQL_t!seller'] :=
            nvhlpseller.HelpFieldValue['id'];
        end;
      end;
      if chkyes.Checked and chkno.Checked then
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := '';
      end
      else if chkyes.Checked then
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := 'true';
      end
      else if chkno.Checked then
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := 'false';
      end
      else
      begin
        Params.ParamValues['filter_EQB_t!isturnover'] := '';
      end;
      if Trim(cbborg.Text) <> '' then
        Params.ParamValues['filter_INS_u!orgid'] := cbborg.GetSelectID
      else
        Params.ParamValues['filter_INS_u!orgid'] :=
          SysInfo.LoginUserInfo.OrgIDs;
      Active := true;

    end;
  end;

  jcdsResult1AfterScroll(jcdsResult1);
  jcdsResult1.AfterScroll := jcdsResult1AfterScroll;
end;

procedure TFrmTicketturnover.tbtnInsertClick(Sender: TObject);
var
  i, returnticketcount, cancelticketcount, billticketcount, returninsurecount,
    cancelinsurecount, billinsurecount, sellreturntripnum, returnprintnum,
    billdamagednum: Integer;
  insurename, insuresellername, name, sellername, turnoverdetailid,
    insuredetailid, lostmoney: string;

  hasselect: Boolean;
  _selectseller: Int64;
begin
  inherited;
  hasselect := False;
  jcdsResult.AfterScroll := nil;
  with FrmTicketturnoverEdit do
  begin
    FrmTicketturnoverEdit := TFrmTicketturnoverEdit.Create(Self);
    Caption := 'Ӫ�սɿ�';
    grp2.Visible := Fsellinsure;
    sign := true;
    if (not dsResult.DataSet.Active) and (not dataSource.DataSet.Active) then
      Exit;
    if (dsResult.DataSet.RecordCount < 1) and
      (dataSource.DataSet.RecordCount < 1) then
      Exit;
    with jcdsResult do
    begin
      try
        DisableControls;
        first;
        while not eof do
        begin
          if fieldbyname('ischoose').AsBoolean then
          begin
            hasselect := true;
            _selectseller := fieldbyname('seller').AsLargeInt;
            if sellername <> '' then
            begin
              if sellername <> fieldbyname('sellername').AsString then
              begin
                SysDialogs.ShowMessage('��ѡ��Ĳ���ͬһ���˵���Ʊ��¼��');
                Locate('id', fieldbyname('id').AsString, []);
                if not(State in [dsEdit, dsInsert]) then
                begin
                  edit;
                end;
                Exit;
              end;
            end
            else
            begin
              Caption := Caption + '��' + fieldbyname('sellername')
                .AsString + '��';
            end;
            if fieldbyname('isturnover').AsBoolean then
            begin
              SysDialogs.ShowMessage('��ʼƱ��Ϊ��' + fieldbyname('ticketendno')
                  .AsString + ' �ĳ�Ʊ�Ѿ��ɿ�.');
              Locate('id', fieldbyname('id').AsString, []);
              if not(State in [dsEdit, dsInsert]) then
              begin
                edit;
              end;
              Exit;
            end;
            if billnouse = '' then
              billnouse := fieldbyname('ticketstartno')
                .AsString + '����' + fieldbyname('ticketendno').AsString
            else
              billnouse := billnouse + '��' + fieldbyname('ticketstartno')
                .AsString + '����' + fieldbyname('ticketendno').AsString;
            if moneydate = '' then
              moneydate := fieldbyname('moneydate').AsString
            else
              moneydate := moneydate + '��' + fieldbyname('moneydate').AsString;
            sellnum := sellnum + fieldbyname('sellnum').AsLargeInt;
            returnnum := returnnum + fieldbyname('returnnum').AsLargeInt;
            cancelnum := cancelnum + fieldbyname('cancelnum').AsLargeInt;
            noncashnum := noncashnum + fieldbyname('noncashnum').AsLargeInt;
            eticketnum := eticketnum + fieldbyname('eticketnum').AsLargeInt;
            moneypayable := moneypayable + fieldbyname('moneypayable')
              .AsCurrency;
            sellmoney := sellmoney + fieldbyname('sellmoney').AsCurrency;
            cancelmoney := cancelmoney + fieldbyname('cancelmoney').AsCurrency;
            noncashmoney := noncashmoney + fieldbyname('noncashmoney')
              .AsCurrency;
            returnmoney := returnmoney + fieldbyname('returnmoney').AsCurrency;
            returnhandcharge := returnhandcharge + fieldbyname
              ('returnhandcharge').AsCurrency;
            nonvouchermoneypayable := nonvouchermoneypayable + fieldbyname
              ('nonvouchermoneypayable').AsCurrency;
            servicefee := servicefee + fieldbyname('servicefee').AsCurrency;
            bookservicefee := bookservicefee + fieldbyname('bookservicefee')
              .AsCurrency;
            changeservicefee := changeservicefee + fieldbyname
              ('changeservicefee').AsCurrency;
            ticketdetailid := ticketdetailid + fieldbyname('id').AsString + ',';
            sellername := fieldbyname('sellername').AsString;
            sellreturntripnum := sellreturntripnum + fieldbyname
              ('sellreturntripnum').AsLargeInt;
            returnprintnum := returnprintnum + fieldbyname('returnprintnum')
              .AsLargeInt;
            billdamagednum := billdamagednum + fieldbyname('billdamagednum')
              .AsLargeInt;
            lastlost := fieldbyname('lastlost').AsCurrency;
            tchangenum := tchangenum + fieldbyname('changenum').AsInteger;
          end;
          next;
        end;
      finally
        EnableControls;
      end;
    end;
    with jcdsqrylostmoney do
    begin
      Active := False;
      Params.ParamValues['seller0'] := jcdsResult.fieldbyname('seller')
        .AsString;
      try
        Execute;
        lostmoney := Params.ParamValues['lostmoney'];
        if lostmoney = '' then
        begin
          lostmoney := '0';
        end;
      except
        on E: exception do
          ShowMessage(E.Message);
      end;
    end;
    Delete(ticketdetailid, Length(ticketdetailid), 1);
    if not(ticketdetailid = '') then
    begin
      turnoverdetailid := '(' + ticketdetailid + ')';
    end;
    edtsellnum.Text := IntToStr(sellnum);
    edtreturnnum.Text := IntToStr(returnnum);
    edtcancelnum.Text := IntToStr(cancelnum);
    edtnoncashnum.Text := IntToStr(noncashnum);
    edteticketnum.Text := IntToStr(eticketnum);
    edtmoneypayable.Text := currtostr(moneypayable);
    edtticketmoneypayable.Text := currtostr(moneypayable);
    edtsellmoney.Text := currtostr(sellmoney);
    edtcancelmoney.Text := currtostr(cancelmoney);
    edtnoncashmoney.Text := currtostr(noncashmoney);
    edtreturnmoney.Text := currtostr(returnmoney);
    edtreturnhandcharge.Text := currtostr(returnhandcharge);
    edtnonvouchermoneypayable.Text := currtostr(nonvouchermoneypayable);
    edtservicefee.Text := currtostr(servicefee);
    edtbookservicefee.Text := currtostr(bookservicefee);
    edtchangsservicefee.Text := currtostr(changeservicefee);
    edtsellreturntripnum.Text := IntToStr(sellreturntripnum);
    edtreturnprintnum.Text := IntToStr(returnprintnum);
    edtbilldamagednum.Text := IntToStr(billdamagednum);
    try
      edtlastlost.Text := lostmoney;
    except
      on E: exception do
        SysLog.WriteErr(E.Message + '');
    end;

    if Fsellinsure then
    begin
      with jcdsResult1 do
      begin
        try
          DisableControls;
          first;
          while not eof do
          begin
            if fieldbyname('ischoose').AsBoolean then
            begin
              hasselect := true;
              _selectseller := fieldbyname('seller').AsLargeInt;
              if fieldbyname('isturnover').AsBoolean then
              begin
                SysDialogs.ShowMessage('��ʼƱ��Ϊ��' + fieldbyname('ticketendno')
                    .AsString + ' �ı��տ����Ͻ�.');
                Locate('id', fieldbyname('id').AsString, []);
                if not(State in [dsEdit, dsInsert]) then
                begin
                  edit;
                end;
                Exit;
              end;
              insuresellnum := insuresellnum + fieldbyname('sellnum')
                .AsLargeInt;
              insurereturnnum := insurereturnnum + fieldbyname('returnnum')
                .AsLargeInt;
              insurecancelnum := insurecancelnum + fieldbyname('cancelnum')
                .AsLargeInt;
              insureeticketnum := insureeticketnum + fieldbyname('eticketnum')
                .AsLargeInt;
              insurenoncashnum := insurenoncashnum + fieldbyname('noncashnum')
                .AsLargeInt;
              insuremoneypayable := insuremoneypayable + fieldbyname
                ('moneypayable').AsCurrency;
              insuresellmoney := insuresellmoney + fieldbyname('sellmoney')
                .AsCurrency;
              insurecancelmoney := insurecancelmoney + fieldbyname
                ('cancelmoney').AsCurrency;
              insurenoncashmoney := insurenoncashmoney + fieldbyname
                ('noncashmoney').AsCurrency;
              insurereturnmoney := insurereturnmoney + fieldbyname
                ('returnmoney').AsCurrency;
              insurereturnhandcharge := insurereturnhandcharge + fieldbyname
                ('returnhandcharge').AsCurrency;
              insurenonvouchermoneypayable :=
                insurenonvouchermoneypayable + fieldbyname
                ('nonvouchermoneypayable').AsCurrency;
              insuredetail := insuredetail + fieldbyname('id').AsString + ',';
            end;
            next;
          end;
        finally
          EnableControls;
        end;
      end;
      Delete(insuredetail, Length(insuredetail), 1);
      if not(insuredetail = '') then
      begin
        insuredetailid := '(' + insuredetail + ')';
      end;
      edtinsuresellnum.Text := IntToStr(insuresellnum);
      edtinsurereturnnum.Text := IntToStr(insurereturnnum);
      edtinsurecancelnum.Text := IntToStr(insurecancelnum);
      edtinsureeticketnum.Text := IntToStr(insureeticketnum);
      edtinsurenoncashnum.Text := IntToStr(insurenoncashnum);
      edtinsuremoneypayable.Text := currtostr(insuremoneypayable);
      nedtinsuremoneypayable.Text := currtostr(insuremoneypayable);
      edtinsuresellmoney.Text := currtostr(insuresellmoney);
      edtinsurecancelmoney.Text := currtostr(insurecancelmoney);
      edtinsurenoncashmoney.Text := currtostr(insurenoncashmoney);
      edtinsurereturnmoney.Text := currtostr(insurereturnmoney);
      edtinsurereturnhandcharge.Text := currtostr(insurereturnhandcharge);
      edtinsurenonvouchermoneypayable.Text := currtostr
        (insurenonvouchermoneypayable);
    end;
    if (functiontype = '3') and (not hasselect) then
    begin
      SysDialogs.ShowInfo('��ѡ��Ҫ�ɿ�ļ�¼');
      Exit;
    end;
    if getParametervalue('4014', SysInfo.LoginUserInfo.OrgID) = '0' then
      edtpayable.Text := currtostr(moneypayable + insuremoneypayable)
    else
      edtpayable.Text := currtostr(moneypayable + insuremoneypayable + StrToCurr
          (lostmoney));
    nvedtallnonvouchermoneypayable.Text := currtostr
      (StrToCurrDef(edtinsurenonvouchermoneypayable.Text, 0) + StrToCurrDef
        (edtnonvouchermoneypayable.Text, 0));
    nvedtallvouchermoneypayable.Text := currtostr(StrToCurrDef(edtpayable.Text,
        0) - StrToCurrDef(nvedtallnonvouchermoneypayable.Text, 0));

    seller := _selectseller;

    if (not hasselect) then
    begin
      if (nvhlpseller.id <= 0) then
      begin
        SysDialogs.ShowInfo('��ƱԱΪ��ʱ����ѡ��Ҫ�ɿ�ļ�¼');
        Exit;
      end
      else
      begin
        Caption := Caption + '��' + nvhlpseller.HelpFieldValue['name'] + '��';
        seller := nvhlpseller.id;
      end;
    end;

    if turnoverdetailid <> '' then
    begin
      // ��ѯ����ѡ�ĳ�Ʊ�ɿ���ϸ��Ӧ��Ʊ��
      with jcdsResultTicketReturn do
      begin
        Active := False;
        Params.ParamValues['filter_INS_tr!turnoverdetailid'] :=
          turnoverdetailid;
        Active := true;
      end;

      with jcdsResultTicketCancel do
      begin
        Active := False;
        Params.ParamValues['filter_INS_tc!turnoverdetailid'] :=
          turnoverdetailid;
        Active := true;
      end;

      with jcdsResultTicketBill do
      begin
        Active := False;
        Params.ParamValues['filter_INS_b!turnoverdetailid'] := turnoverdetailid;
        Active := true;
      end;

      with jcdsResultTicketReturn do
      begin
        DisableControls;
        first;
        while not eof do
        begin
          if returnticketcount < dsTicketReturn.DataSet.RecordCount then
          begin
            returnticketno := returnticketno + fieldbyname('returnticketno')
              .AsString + ',';
            returnticketcount := returnticketcount + 1;
          end;
          next;
        end;
        EnableControls;
      end;
      Delete(returnticketno, Length(returnticketno), 1);

      with jcdsResultTicketCancel do
      begin
        DisableControls;
        first;
        while not eof do
        begin
          if cancelticketcount < dsTicketReturn.DataSet.RecordCount then
          begin
            cancelticketno := cancelticketno + fieldbyname('cancelticketno')
              .AsString + ',';
            cancelticketcount := cancelticketcount + 1;
          end;
          next;
        end;
        EnableControls;
      end;
      Delete(cancelticketno, Length(cancelticketno), 1);

      with jcdsResultTicketBill do
      begin
        DisableControls;
        first;
        while not eof do
        begin
          if billticketcount < dsTicketReturn.DataSet.RecordCount then
          begin
            damagedticketno := damagedticketno + fieldbyname('startno')
              .AsString + '-' + fieldbyname('endno').AsString + ',';
            billticketcount := billticketcount + 1;
          end;
          next;
        end;
        EnableControls;
      end;
      Delete(damagedticketno, Length(damagedticketno), 1);
    end;

    if Fsellinsure and (insuredetailid <> '') then
    begin
      // ��ѯ����ѡ�ı��սɿ���ϸ��Ӧ��Ʊ��
      with jcdsResultInsurReturn do
      begin
        Active := False;
        Params.ParamValues['filter_INS_i!turnoverdetailid'] := insuredetailid;
        Active := true;
      end;

      with jcdsResultInsureCancel do
      begin
        Active := False;
        Params.ParamValues['filter_INS_i!turnoverdetailid'] := insuredetailid;
        Active := true;
      end;

      with jcdsResultInsureBill do
      begin
        Active := False;
        Params.ParamValues['filter_INS_b!turnoverdetailid'] := insuredetailid;
        Active := true;
      end;

      with jcdsResultInsurReturn do
      begin
        DisableControls;
        first;
        while not eof do
        begin
          if returninsurecount < dsTicketReturn.DataSet.RecordCount then
          begin
            returninsureno := returninsureno + fieldbyname('insuranceno')
              .AsString + ',';
            returninsurecount := returninsurecount + 1;
          end;
          next;
        end;
        EnableControls;
      end;
      Delete(returninsureno, Length(returninsureno), 1);

      with jcdsResultInsureCancel do
      begin
        DisableControls;
        first;
        while not eof do
        begin
          if cancelinsurecount < dsTicketReturn.DataSet.RecordCount then
          begin
            cancelinsureno := cancelinsureno + fieldbyname('insuranceno')
              .AsString + ',';
            cancelinsurecount := cancelinsurecount + 1;
          end;
          next;
        end;
        EnableControls;
      end;
      Delete(cancelinsureno, Length(cancelinsureno), 1);

      with jcdsResultInsureBill do
      begin
        DisableControls;
        first;
        while not eof do
        begin
          if billinsurecount < dsTicketReturn.DataSet.RecordCount then
          begin
            damagedinsureno := damagedinsureno + fieldbyname('startno')
              .AsString + '-' + fieldbyname('endno').AsString + ',';
            billinsurecount := billinsurecount + 1;
          end;
          next;
        end;
        EnableControls;
      end;
      Delete(damagedinsureno, Length(damagedinsureno), 1);
    end;

    ShowModal;
    if ModalResult = mrok then
    begin
      if functiontype = '0' then
      begin
        tbtnFilterClick(nil);
      end
      else if functiontype = '1' then
      begin
        tbtnEditClick(nil);
      end
      else
      begin
        tbtnDeleteClick(nil);
      end
    end;
  end;
  // jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmTicketturnover.tbtnerrorClick(Sender: TObject);
begin
  inherited;
  FrmTicketTurnOverErrorReport := TFrmTicketTurnOverErrorReport.Create(Self);
  try
    with FrmTicketTurnOverErrorReport do
    begin
      Caption := '��Ʊ�����ϸ';
      if SysMainForm.showFormModal(FrmTicketTurnOverErrorReport, False)
        = mrok then
      begin
        jcdsResultAfterScroll(nil);
      end;
    end;
  finally
    FreeAndNil(FrmTicketTurnOverErrorReport);
  end;
end;

procedure TFrmTicketturnover.ToolButton50Click(Sender: TObject);
begin
  inherited;
  with FrmTicketturnoverQuery do
  begin
    FrmTicketturnoverQuery := TFrmTicketturnoverQuery.Create(Self);
    // tbtnEdit.Visible :=  isvisible;
    // if functiontype = '3' then
    // begin
    // Label2.Visible := false;
    // nvhlpseller.Visible := false;
    // end;

    // ���û��Ȩ�ޣ������޸���ƱԱ
    if not iscanselectother then
    begin
      FrmTicketturnoverQuery.nvhlpseller.HelpFieldValue['id'] :=
        SysInfo.LoginUserInfo.UserID;
      FrmTicketturnoverQuery.nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;
      FrmTicketturnoverQuery.nvhlpseller.Enabled := False;
    end;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Self);
    end;
  end;
end;

procedure TFrmTicketturnover.ToolButton51Click(Sender: TObject);
var
  i, j, seller: Integer;
  sname, startno, endno, log: string;
  startdate, enddate: TDateTime;
  Tstationservicefee, Tfueladditionfee, Tcomputefee, Tcoolairfee, Tadditionfee,
    Twaterfee, Tinsurefee, Totherfee: Integer;
  detailIds : string;//ticketturnoverdetail_ids �ɿ���ϸids����acreport��ӡƱ��ʱ��ѯƱ��ʹ��
begin
  inherited;
  startdate := Now; //�ɿʼ���ڳ�ʼ��Ϊ��ǰʱ�䣬����ȡ������С�Ľɿ�����

  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;

  with FrmTicketturnoverreport do
  begin
    FrmTicketturnoverreport := TFrmTicketturnoverreport.Create(Self);
    try
    with jcdsResult do
    begin
      DisableControls;
      try
        first;
        i := 0;
        while not eof do
        begin
          if fieldbyname('ischoose').AsBoolean then
          begin
            i := i + 1;
            seller := fieldbyname('seller').AsLargeInt;

            detailIds := detailIds + fieldbyname('id').AsString + ',' ;//�ɿ���ϸids����acreport��ӡƱ��ʱ��ѯƱ��ʹ��

            if sname <> '' then
            begin
              if sname <> fieldbyname('sellername').AsString then
              begin
                detailIds := '';//�ɿ���ϸids����acreport��ӡƱ��ʱ��ѯƱ��ʹ��
                SysDialogs.ShowMessage('��ѡ��Ĳ���ͬһ���˵���Ʊ��¼��');
                Locate('id', fieldbyname('id').AsString, []);
                if not(State in [dsEdit, dsInsert]) then
                begin
                  edit;
                end;
                Exit;
              end;
            end;
            if startno <> '' then
            begin
              //if strtoint(startno) > fieldbyname('ticketstartno')
              if StrToInt64(startno) > fieldbyname('ticketstartno')
                .AsLargeInt then
              begin
                startno := fieldbyname('ticketstartno').AsString;
              end;
            end
            else
            begin
              startno := fieldbyname('ticketstartno').AsString;
            end;
            {
              if startdate <> 0 then
              begin
                if startdate > fieldbyname('moneydate').AsDateTime then
                begin
                  // startdate := FieldByName('moneydate').AsDateTime;
                  startmoneydate := fieldbyname('moneydate').AsDateTime;
                  // startno := FieldByName('ticketstartno').AsString;
                end;
              end
              else
              begin
                // startdate := FieldByName('moneydate').AsDateTime;
                  startmoneydate := fieldbyname('moneydate').AsDateTime;
                // startno := FieldByName('ticketstartno').AsString;
              end;
            }
            //��ʼ����ȡ��С������
            if startdate > fieldbyname('moneydate').AsDateTime then
            begin
              startdate := fieldbyname('moneydate').AsDateTime;
              startmoneydate := startdate;
            end;

            if enddate <> 0 then
            begin
              if enddate < fieldbyname('moneydate').AsDateTime then
              begin
                // enddate := FieldByName('moneydate').AsDateTime;
                endmoneydate := fieldbyname('moneydate').AsDateTime;
                // endno := FieldByName('ticketendno').AsString;
              end;
            end
            else
            begin
              if enddate < fieldbyname('moneydate').AsDateTime then
              begin
                enddate := fieldbyname('moneydate').AsDateTime;
               	endmoneydate := enddate;
              end;
              // enddate := fieldbyname('moneydate').AsDateTime;
              // endno := FieldByName('ticketendno').AsString;
            end;

            if endno <> '' then
            begin
//              if strtoint(endno) < fieldbyname('ticketendno').AsLargeInt then
              if StrToInt64(endno) < fieldbyname('ticketendno').AsLargeInt then
              begin
                endno := fieldbyname('ticketendno').AsString;
              end;
            end
            else
            begin
              endno := fieldbyname('ticketendno').AsString;
            end;

            if fieldbyname('isturnover').AsBoolean then
            begin
              turnoverid := turnoverid + fieldbyname('ticketturnoverid')
                .AsString + ',';
            end;
            // startmoneydate := startdate;
            // endmoneydate := enddate;
            endticketno := endno;
            startticketno := startno;

            sname := fieldbyname('sellername').AsString;
            bookservicefee := bookservicefee + fieldbyname('bookservicefee')
              .AsCurrency;
            cancelnum := cancelnum + fieldbyname('cancelnum').AsInteger;
            changeservicefee := changeservicefee + fieldbyname
              ('changeservicefee').AsCurrency;
            changenum := changenum + fieldbyname('changenum').AsInteger;
            eticketnum := eticketnum + fieldbyname('eticketnum').AsInteger;
            moneypayable := moneypayable + fieldbyname('moneypayable')
              .AsCurrency;
            noncashmoney := noncashmoney + fieldbyname('noncashmoney')
              .AsCurrency;
            noncashnum := noncashnum + fieldbyname('noncashnum').AsInteger;
            nonvouchermoneypayable := nonvouchermoneypayable + fieldbyname
              ('nonvouchermoneypayable').AsCurrency;
            returnhandcharge := returnhandcharge + fieldbyname
              ('returnhandcharge').AsCurrency;
            returnmoney := returnmoney + fieldbyname('returnmoney').AsCurrency;
            returnnum := returnnum + fieldbyname('returnnum').AsInteger;
            sellmoney := sellmoney + fieldbyname('sellmoney').AsCurrency;
            sellnum := sellnum + fieldbyname('sellnum').AsInteger;
            servicefee := servicefee + fieldbyname('servicefee').AsCurrency;
            cancelmoney := cancelmoney + fieldbyname('cancelmoney').AsCurrency;
            sellreturntripnum := sellreturntripnum + fieldbyname
              ('sellreturntripnum').AsInteger;
            returnprintnum := returnprintnum + fieldbyname('returnprintnum')
              .AsInteger;
            billdamagednum := billdamagednum + fieldbyname('billdamagednum')
              .AsInteger;

            money := 0;
            orgname := SysInfo.LoginUserInfo.orgname;
            receivername := SysInfo.LoginUserInfo.UserName;
            remarks := '';
            sellercode := fieldbyname('code').AsString;
            sellername := fieldbyname('sellername').AsString;
            turnovertime := fieldbyname('turnovertime').AsString;
            // ���ֿ۷�
            Tstationservicefee := Tstationservicefee + fieldbyname
              ('stationservicefee').AsInteger;
            Tfueladditionfee := Tfueladditionfee + fieldbyname
              ('fueladditionfee').AsInteger;
            Tcomputefee := Tcomputefee + fieldbyname('computefee').AsInteger;
            Tcoolairfee := Tcoolairfee + fieldbyname('coolairfee').AsInteger;
            Tadditionfee := Tadditionfee + fieldbyname('additionfee').AsInteger;
            Twaterfee := Twaterfee + fieldbyname('waterfee').AsInteger;
            Tinsurefee := Tinsurefee + fieldbyname('insurefee').AsInteger;
            Totherfee := Totherfee + fieldbyname('otherfee').AsInteger;
          end;
          next;
        end;
      finally
        EnableControls;
      end;
      log := '��ӡӦ�ɿ�ϼƣ��տ����=' + SysInfo.LoginUserInfo.orgname + ',��ƱԱ=' +
        fieldbyname('sellername').AsString + ',��Ʊ��=' + currtostr(sellmoney)
        + ',��Ʊ��=' + IntToStr(sellnum) + ',ʵ�ɿ�=' + currtostr(money)
        + ',����Ӧ�ɿ�=' + currtostr(moneypayable)
        + ',�տ���=' + SysInfo.LoginUserInfo.UserName + ',�տ�IP=' +
        SysInfo.LocalHostAddress;
    end;
    except
      on e:exception do
      SysLog.WriteErr('��ӡӦ�ɿ�ϼƱ���:' + e.Message);
    end;

    if Fsellinsure then
    begin
      with jcdsResult1 do
      begin
        DisableControls;
        try
          first;
          j := 0;
          while not eof do
          begin
            if fieldbyname('ischoose').AsBoolean then
            begin
              j := j + 1;
              seller := fieldbyname('seller').AsLargeInt;
              if sname <> '' then
              begin
                if sname <> fieldbyname('sellername').AsString then
                begin
                  detailIds := '';//�ɿ���ϸids����acreport��ӡƱ��ʱ��ѯƱ��ʹ��
                  SysDialogs.ShowMessage('��ѡ��Ĳ���ͬһ���˵��۱��ռ�¼��');
                  Locate('id', fieldbyname('id').AsString, []);
                  if not(State in [dsEdit, dsInsert]) then
                  begin
                    edit;
                  end;
                  Exit;
                end;
              end;

              sname := fieldbyname('sellername').AsString;
              insuresellnum := insuresellnum + fieldbyname('sellnum').AsInteger;
              insuresellmoney := insuresellmoney + fieldbyname('sellmoney')
                .AsCurrency;
              insurereturnnum := insurereturnnum + fieldbyname('returnnum')
                .AsInteger;
              insurereturnmoney := insurereturnmoney + fieldbyname
                ('returnmoney').AsCurrency;
              insurecancelnum := insurecancelnum + fieldbyname('cancelnum')
                .AsInteger;
              insurecancelmoney := insurecancelmoney + fieldbyname
                ('cancelmoney').AsCurrency;
              insuremoneypayable := insuremoneypayable + fieldbyname
                ('moneypayable').AsCurrency;
            end;
            next;
          end;
        finally
          EnableControls;
        end;
      end;
    end;

    if i + j < 1 then
    begin
      SysDialogs.ShowMessage('��ѡ��һ�����ݽ��д�ӡ��');
      Exit;
    end;

    SysLog.WriteLog('�������->Ӫ�սɿ�', '�ش�ɿ', log);

    stationservicefee := IntToStr(Tstationservicefee);
    fueladditionfee := IntToStr(Tfueladditionfee);
    computefee := IntToStr(Tcomputefee);
    coolairfee := IntToStr(Tcoolairfee);
    additionfee := IntToStr(Tadditionfee);
    waterfee := IntToStr(Twaterfee);
    insurefee := IntToStr(Tinsurefee);
    otherfee := IntToStr(Totherfee);
//    PrintTicketturnover;  //֮ǰ�Ĵ�ӡ��ֻ��ģ���ӡ��û��acreport

    if (tbtnEdit.Visible = true) then
    begin
       isturnover := true;
    end;
    ticketturnoverdetails :=  LeftStr(detailIds, Length(detailIds) -1);//�ɿ���ϸids
    PrintReCelTicketnoByAcReport; //���ô�ӡ
    isturnover := false;//��ӡ���ʼ��Ϊ false;
    ticketturnoverdetails := '';//��ӡ���ʼ��Ϊ'' Ӫ�սɿ���ϸids����acreport��ӡδӪ�սɿ���ѽɿ�Ӫ��ʹ��

    ModalResult := mrok;

    //��ӡ��Ӧ�ɺϼƺ�Ӧ��ִ����Ӧҳ��Ĳ�ѯ
    if (tbtnEdit.Visible = true) then
    begin
       tbtnEdit.Click;
    end
    else if (tbtnDelete.Visible = true) then
    begin
      tbtnDelete.Click;
    end
    else
    begin
      tbtnFilterClick(Self);
    end;
  end;
end;

procedure TFrmTicketturnover.ToolButton52Click(Sender: TObject);
begin
  inherited;
  refreshTicketDetail();
end;

procedure TFrmTicketturnover.ToolButton53Click(Sender: TObject);
begin
  inherited;
  refreshInsuranceDetail;
end;

end.

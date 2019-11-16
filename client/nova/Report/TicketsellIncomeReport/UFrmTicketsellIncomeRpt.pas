unit UFrmTicketsellIncomeRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping, NovaEdit, NovaHelp, NovaComboBox
  , UFrmTicketsellDetail,UDMPublic;

type
  TFrmTicketsellIncomeRpt = class(TSimpleCRUDForm)
    nvcbbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    lbl6: TLabel;
    nvhelpUserid: TNovaHelp;
    nvcbbticketstatus: TNovaComboBox;
    lbl13: TLabel;
    chkIschangeticket: TCheckBox;
    nvedtTicketno: TNovaEdit;
    lbl17: TLabel;
    lbl2: TLabel;
    lblBegintimes: TLabel;
    lblEndtimes: TLabel;
    sellBegindate: TDateTimePicker;
    sellEnddate: TDateTimePicker;
    sellEndtime: TDateTimePicker;
    sellBegintime: TDateTimePicker;
    reportnum: TNovaComboBox;
    Label1: TLabel;
    Label2: TLabel;
    departBegindate: TDateTimePicker;
    departEnddate: TDateTimePicker;
    lbl3: TLabel;
    nvcbbTicketoutlets: TNovaCheckedComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure sellBegindateChange(Sender: TObject);
    procedure departBegindateChange(Sender: TObject);
    procedure nvcbbOrgidCheckClick(Sender: TObject);
  private
    procedure searchbyObjectchange();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketsellIncomeRpt: TFrmTicketsellIncomeRpt;

implementation
 uses   PubFn,Services;

{$R *.dfm}

procedure TFrmTicketsellIncomeRpt.departBegindateChange(Sender: TObject);
begin
  inherited;

  if departBegindate.Checked = True  then
    begin
       departEnddate.Checked := True;
    end;
   if  departBegindate.Checked =False then
    begin
       departEnddate.Checked := False;
    end;
end;

procedure TFrmTicketsellIncomeRpt.FormShow(Sender: TObject);
begin
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  sellBegindate.Date := Now;
  sellEnddate.Date := Now;
  departBegindate.Date := Now;
  departEnddate.Date := Now;
  nvcbbticketstatus.Active := False;
  nvcbbticketstatus.Active := True;
  reportnum.Active := False;
  reportnum.Active := True;
  reportnum.SetItemIndexByID(1);
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;

end;

procedure TFrmTicketsellIncomeRpt.nvcbbOrgidCheckClick(Sender: TObject);
begin
  inherited;
  nvcbbTicketoutlets.Active := False;
  nvcbbTicketoutlets.Params.ParamValues['param']:= nvcbbOrgid.GetSelectID;
  nvcbbTicketoutlets.Active := True;
end;

procedure TFrmTicketsellIncomeRpt.searchbyObjectchange();
var curcolumn:TColumnTitleEh;
begin
   if reportnum.GetSelectID = 1 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
       curcolumn.Caption := '����';
       dbgrdhResult.Columns[0].Width := 50;
       curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '����';
       dbgrdhResult.Columns[1].Width := 50;
       curcolumn :=dbgrdhResult.Columns[2].Title;
       curcolumn.Caption := '��Ʊ����';
       dbgrdhResult.Columns[2].Visible :=True;
   end
   else if reportnum.GetSelectID = 2 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
       curcolumn.Caption := '��Ʊվ';
       dbgrdhResult.Columns[0].Width := 100;
       curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '�˳�վ';
       dbgrdhResult.Columns[1].Width := 100;
       dbgrdhResult.Columns[2].Visible := False;
   end
   else if reportnum.GetSelectID = 3 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
       curcolumn.Caption := '��Ʊ����';
       dbgrdhResult.Columns[0].Width := 75;
       curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '��Ʊվ';
       dbgrdhResult.Columns[1].Width := 100;
       curcolumn :=dbgrdhResult.Columns[2].Title;
       curcolumn.Caption := '�˳�վ';
       dbgrdhResult.Columns[2].Visible :=True;
   end;



end;


procedure TFrmTicketsellIncomeRpt.sellBegindateChange(Sender: TObject);
begin
  inherited;
  if sellBegindate.Checked = True  then
    begin
       sellEnddate.Checked := True;
    end;
   if  sellBegindate.Checked =False then
    begin
       sellEnddate.Checked := False;
    end;
end;

procedure TFrmTicketsellIncomeRpt.tbtnEditClick(Sender: TObject);
var cancel_returnno : string;
begin
  inherited;
  if not jcdsResult.active then
    exit;
  if jcdsResult.RecordCount = 0 then
    exit;
  if jcdsResult.FieldByName('totalnum').AsInteger <= 0 then
  begin
     SysDialogs.ShowMessage('��ѡ��Ҫ�鿴�����ݣ�');
  end;

  with FrmTicketsellDetail do
  begin
    FrmTicketsellDetail := TFrmTicketsellDetail.Create(Self);
  column1:= jcdsResult.FieldByName('column1').AsString;
  column2:= jcdsResult.FieldByName('column2').AsString;
  column3:= jcdsResult.FieldByName('column3').AsString;
  sellorgid:= nvcbbOrgid.GetSelectID;
  sellerid:= nvhelpUserid.Id;
  ticketstatus:= nvcbbticketstatus.GetSelectCode;
  returnticketno  := nvedtTicketno.Text;
    if chkIschangeticket.Checked then
      begin
        ischangeticket := true;
      end
    else
      begin
        ischangeticket := false;
      end;
    reportnum1 := reportnum.GetSelectID;

    sellstartdatetime :=
        formatdatetime('yyyy-mm-dd',sellBegindate.Date)+' '+ formatdatetime('hh:mm:ss',sellBegintime.Time);
    sellenddatetime :=
        formatdatetime('yyyy-mm-dd',sellEnddate.Date)+' '+formatdatetime('hh:mm:ss',sellEndtime.Time);

    depstartdate := formatdatetime('yyyy-mm-dd',departBegindate.Date);
    dependdate := formatdatetime('yyyy-mm-dd',departEnddate.Date);
  end;

  FrmTicketsellDetail.Show;
//   FrmTicketsellDetail.mmoContent.Text:= cancel_returnno;
end;


procedure TFrmTicketsellIncomeRpt.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
  if nvcbbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    exit;
  end;

  if sellBegindate.Checked and (FormatDateTime('yyyymmdd', sellBegindate.Date) >
      FormatDateTime('yyyymmdd',sellEnddate.Date)) then
  begin
    SysDialogs.ShowMessage('��Ʊ��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end
  else if sellBegindate.Checked and (FormatDateTime('yyyymmdd', sellBegindate.Date) =
      FormatDateTime('yyyymmdd',sellEnddate.Date)) then
  begin
      if  formatdatetime('hh:mm:ss',sellBegintime.Time) >
          formatdatetime('hh:mm:ss',sellEndtime.Time) then
      begin
        SysDialogs.ShowMessage('��Ʊ��ʼʱ�䲻�ܴ��ڽ���ʱ�䣡');
        exit;
      end;
  end;

  if departBegindate.Checked and (FormatDateTime('yyyymmdd', departBegindate.Date) >
      FormatDateTime('yyyymmdd',departEnddate.Date)) then
  begin
    SysDialogs.ShowMessage('������ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end ;

  if reportnum.GetSelectID <=0 then
  begin
     SysDialogs.Warning('��ѡ��һ��ͳ�Ʒ�ʽ��');
     exit;
  end;

  searchbyObjectchange();

  with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['sellorgid']:= nvcbbOrgid.GetSelectID;
    Params.ParamValues['sellerid']:= nvhelpUserid.Id;
    Params.ParamValues['ticketstatus']:= nvcbbticketstatus.GetSelectCode;
    Params.ParamValues['returnticketno']  := nvedtTicketno.Text;
    Params.ParamValues['ticketoutletsid'] := nvcbbTicketoutlets.GetSelectID;
    if chkIschangeticket.Checked then
      begin
        Params.ParamValues['ischangeticket'] := 1;
      end
    else
      begin
        Params.ParamValues['ischangeticket'] := 0;
      end;
    Params.ParamValues['reportnum'] := reportnum.GetSelectID;

    if sellBegindate.Checked then
    begin
    Params.ParamValues['sellstartdatetime'] :=
        formatdatetime('yyyy-mm-dd',sellBegindate.Date);
    Params.ParamValues['sellstarttime'] :=
        formatdatetime('hh:mm:ss',sellBegintime.Time);
    Params.ParamValues['sellenddatetime'] :=
        formatdatetime('yyyy-mm-dd',sellEnddate.Date);
    Params.ParamValues['sellendtime'] :=
    formatdatetime('hh:mm:ss',sellEndtime.Time);

    end else
    begin
        Params.ParamValues['sellstartdatetime'] :=null;
        Params.ParamValues['sellstarttime'] :=null;
        Params.ParamValues['sellenddatetime'] :=null;
        Params.ParamValues['sellendtime'] :=null;
    end;
    if departBegindate.Checked then
    begin
    Params.ParamValues['departstartdate'] := formatdatetime('yyyy-mm-dd',departBegindate.Date);
    Params.ParamValues['departenddate'] := formatdatetime('yyyy-mm-dd',departEnddate.Date+0.99999);
    end else
    begin
      Params.ParamValues['departstartdate'] := null;
      Params.ParamValues['departenddate'] :=  null;
    end;
    Active:=true;

     log := '��ѯ�����У�[��������] �� '+ formatdatetime('yyyy-mm-dd',departBegindate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',departEnddate.Date)
      +',[��Ʊʱ��]��'+ formatdatetime('yyyy-mm-dd',sellBegindate.Date)+' '+ formatdatetime('hh:mm:ss',sellBegintime.Time)
      +' �� '+formatdatetime('yyyy-mm-dd',sellEnddate.Date)+' '+formatdatetime('hh:mm:ss',sellEndtime.Time);
    if Trim(nvcbbOrgid.Text) <>'' then
      log := log +',[��Ʊ����]��'+nvcbbOrgid.Text;
    if nvhelpUserid.Id <> 0 then
      log := log+',[��ƱԱ]��'+nvhelpUserid.Text;
    if Trim(nvedtTicketno.Text)<>'' then
      log := log +',[Ʊ��]'+nvedtTicketno.Text;
    if Trim(nvcbbticketstatus.Text) <> '' then
      log := log +',[״̬]:'+nvcbbticketstatus.Text;
    if reportnum.Text <>'' then
      log := log +',[ͳ�Ʒ�ʽ]:'+reportnum.Text;
    if chkIschangeticket.Checked then
      log := log +',[��ǩƱ]';

    log := log+'����ѯ���:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��ƱӪ�ձ���','��ѯ',log);

    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='��Ʊ���ڣ�'+ formatdatetime('yyyy-mm-dd',sellBegindate.Date)
    +' ��'+formatdatetime('yyyy-mm-dd',sellEnddate.Date);
  end;

end;

end.

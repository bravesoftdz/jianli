unit UFrmUnitRouteVehicleRpt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaComboBox,
  CheckLst, NovaHComboBox,UDMPublic;

type
  TFrmUnitRouteVehicleRpt = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl2: TLabel;
    chkScheduleorg: TCheckBox;
    chkSchedule: TCheckBox;
    chkRoute: TCheckBox;
    chkUnit: TCheckBox;
    chkPrintorg: TCheckBox;
    chkVehicle: TCheckBox;
    nvcbbgroup: TNovaComboBox;
    nvhlpVehicle: TNovaHelp;
    lbl3: TLabel;
    nvcbbType: TNovaCheckedComboBox;
    lblRun: TLabel;
    lbl4: TLabel;
    cbbtype: TNovaComboBox;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure nvcbbgroupChange(Sender: TObject);

  private
  procedure groupbyObjectchange();
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmUnitRouteVehicleRpt: TFrmUnitRouteVehicleRpt;

implementation
 uses   PubFn,Services;
{$R *.dfm}


procedure TFrmUnitRouteVehicleRpt.FormCreate(Sender: TObject);
begin
  inherited;
  //dbgrdhResult.OddRowColor:=clSkyBlue; //��������ɫ
  cbbtype.Active := False;
  cbbtype.Active := True;
end;

procedure TFrmUnitRouteVehicleRpt.FormShow(Sender: TObject);
begin
  inherited;
  dbgrdhResult.GridUser := Sysinfo.LoginUserInfo.UserID;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  nvckbOrgid.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
  nvcbbgroup.Active := False;
   nvcbbgroup.Active := True;
  dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
  nvcbbgroup.SetItemIndexByID(1);
  nvcbbType.Active:=false;
  nvcbbType.Active:=true;
end;

procedure TFrmUnitRouteVehicleRpt.groupbyObjectchange();
var curcolumn:TColumnTitleEh;
begin
   if nvcbbgroup.GetSelectID = 1 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
       curcolumn.Caption := '��·';
       curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '���㵥λ';
       dbgrdhResult.Columns[1].Visible := True;
   end
   else if nvcbbgroup.GetSelectID = 2 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
       curcolumn.Caption := '��·';
       curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '����';
       dbgrdhResult.Columns[1].Visible := True;
   end
   else if nvcbbgroup.GetSelectID = 3 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
        curcolumn.Caption := '��·';
        curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '����ʱ��';
       dbgrdhResult.Columns[1].Visible := True;
   end
    else if nvcbbgroup.GetSelectID = 4 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
        curcolumn.Caption := '����';
        curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '��·';
       dbgrdhResult.Columns[1].Visible := True;
   end
   else if nvcbbgroup.GetSelectID = 5 then
   begin
     curcolumn :=dbgrdhResult.Columns[0].Title;
     curcolumn.Caption := '��������';
     dbgrdhResult.Columns[1].Visible := False;
   end
   else if nvcbbgroup.GetSelectID = 6 then
   begin
       curcolumn :=dbgrdhResult.Columns[0].Title;
       curcolumn.Caption := '��·';
       curcolumn :=dbgrdhResult.Columns[1].Title;
       curcolumn.Caption := '������λ';
       dbgrdhResult.Columns[1].Visible := True;
   end;



end;

procedure TFrmUnitRouteVehicleRpt.nvcbbgroupChange(Sender: TObject);
begin
  inherited;
//  if nvcbbgroup.GetSelectID = 3 then
//  begin
//    nvhlpVehicle.Enabled := False;
//  end
//  else if nvcbbgroup.GetSelectID = 5 then
//  begin
//     nvhlpVehicle.Enabled := False;
//  end
//  else
//  begin
//    nvhlpVehicle.Enabled := True;
//  end;
   ;
end;

procedure TFrmUnitRouteVehicleRpt.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
  if nvckbOrgid.GetSelectID='' then
  begin
    SysDialogs.ShowMessage('��ѡ�������');
    nvckbOrgid.SetFocus;
    exit;
  end;
    if Trim(nvcbbType.Text) = '' then
  begin
    SysDialogs.ShowMessage('����������Ϊ�գ�');
    nvcbbType.SetFocus;
    Exit;
  end;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    dtpenddate.SetFocus;
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('ѡ�����ڵ��������ϵͳ���õ����ɲ�ѯ����,������ѡ��');
    exit;
  end;
  if dtpenddate.Date>Now then
  begin
    dtpenddate.Date := Now;
  end;
  groupbyObjectchange();

  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgids'] := nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd',
      dtpstartdate.Date);
    Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd',
      dtpenddate.Date);
    Params.ParamValues['groupby'] := nvcbbgroup.GetSelectID;
    Params.ParamByName('districttype').Value := nvcbbType.GetSelectID;
    if (trim(nvhlpVehicle.Text) <> '') and (nvhlpVehicle.id > 0) then
      Params.ParamValues['vehicleid'] := nvhlpVehicle.id
    else
      Params.ParamValues['vehicleid'] := null;
    if Trim(cbbtype.Text) = '' then             //��λ����
    begin
      Params.ParamByName('type').Value := '';
    end
    else
    begin
      Params.ParamByName('type').Value := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;

     Active := True;

    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
   +' ��'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);

   log := '��ѯ�����У�[��������]�� '+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
      +' �� '+formatdatetime('yyyy-mm-dd',dtpenddate.Date) ;
    if Trim(nvckbOrgid.Text) <>'' then
      log := log +',[��λ���]��'+nvckbOrgid.Text;
    if Trim(nvhlpVehicle.Text) <>'' then
      log := log +',[����]:'+ nvhlpVehicle.Text;
    if Trim(nvcbbType.Text) <>'' then
      log := log +',[��������]:'+ nvcbbType.Text;
    if Trim(nvcbbgroup.Text) <>'' then
      log := log +',[ͳ�Ʒ�ʽ]:'+ nvcbbgroup.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('����ͳ��->��������ͳ�Ʊ�','��ѯ',log);

  end
end;

end.

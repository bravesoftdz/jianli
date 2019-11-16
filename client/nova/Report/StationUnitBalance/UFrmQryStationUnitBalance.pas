unit UFrmQryStationUnitBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmQryStationUnitBalance = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    Label1: TLabel;
    nvckbOrgid: TNovaCheckedComboBox;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    NvRadioUnit: TRadioButton;
    NvRadioVehicleno: TRadioButton;
    NovaHelpUnit: TNovaHelp;
    edtvehicleno: TNovaHelp;
    procedure NvRadioUnitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryStationUnitBalance: TFrmQryStationUnitBalance;

implementation
uses UDMPublic,Services;
{$R *.dfm}

procedure TFrmQryStationUnitBalance.FormCreate(Sender: TObject);
begin
  inherited;
  nvckbOrgid.Active := False;
  nvckbOrgid.Active := True;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  NvRadioUnit.Checked := True;
end;

procedure TFrmQryStationUnitBalance.NvRadioUnitClick(Sender: TObject);
begin
  inherited;
//  if NvRadioUnit.Checked then
//  begin
//    NovaHelpUnit.Enabled := True;
//    edtvehicleno.Enabled := False;
//    edtvehicleno.Clear;
//    //dbgrdhResult.Columns[1].Visible := False;
//  end
//  else
//  if NvRadioVehicleno.Checked then
//  begin
//    NovaHelpUnit.Enabled := False;
//    edtvehicleno.Enabled := True;
//    NovaHelpUnit.Clear;
//    //dbgrdhResult.Columns[1].Visible := True;
//  end
//  else
//  begin
//    NovaHelpUnit.Enabled := False;
//    edtvehicleno.Enabled := False;
//    //dbgrdhResult.Columns[1].Visible := True;
//  end;
end;

procedure TFrmQryStationUnitBalance.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if dtpstartdate.Date > dtpenddate.Date then
  begin
    SysDialogs.Warning('开始日期不能大于结束日期!');
    Exit;
  end;
  if Trim(nvckbOrgid.GetSelectID) = '' then
  begin
    SysDialogs.Warning('请选择机构!');
    Exit;
  end;
  if NvRadioUnit.Checked then
  begin
    dbgrdhResult.Columns[1].Visible := False;
  end
  else
  if NvRadioVehicleno.Checked then
  begin
    dbgrdhResult.Columns[1].Visible := True;
  end
  else
  begin
    dbgrdhResult.Columns[1].Visible := True;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid']:= nvckbOrgid.GetSelectID;
    Params.ParamValues['startdate'] := Formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['enddate'] :=  FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Params.ParamValues['unitid'] := NovaHelpUnit.Id;
    Params.ParamValues['vehicleid'] := edtvehicleno.Id;
    if NvRadioUnit.Checked then
      Params.ParamValues['sign'] := '1'
    else
    if NvRadioVehicleno.Checked then
      Params.ParamValues['sign'] := '2'
    else
      Params.ParamValues['sign'] := '3';

    dbgrdhResult.PrintInfo.PageTopLeft:='制表机构：'+sysinfo.LoginUserInfo.OrgName
     +' 售票机构：'+nvckbOrgid.Text;


    dbgrdhResult.PrintInfo.PageTopRight:='发车日期：'+ formatdatetime('yyyy-mm-dd',dtpstartdate.Date)
    +' 至'+formatdatetime('yyyy-mm-dd',dtpenddate.Date);


    Active := True;
  end;
end;

end.

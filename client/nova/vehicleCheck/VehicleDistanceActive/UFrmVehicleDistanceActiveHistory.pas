unit UFrmVehicleDistanceActiveHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
   DB, DBClient, jsonClientDataSet,USimpleEditForm,
  ToolWin,Generics.Collections,FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh;
type
  TFrmVehicleDistanceActiveHistory = class(TSimpleEditForm)
    jcdsVehicledistancehistory: TjsonClientDataSet;
    lbl10: TLabel;
    lbldate: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvdbgrdh1: TNvDbgridEh;
    btn2: TBitBtn;
    btn1: TBitBtn;
    lbl2: TLabel;
    ds1: TDataSource;
    nvhlpUserid: TNovaHelp;
    nvhlpvehicleno: TNovaHelp;
    procedure btn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
 protected
 public
 var vehicleid : Integer;
 vehicleno:string;
    { Public declarations }


  end;

var
  FrmVehicleDistanceActiveHistory: TFrmVehicleDistanceActiveHistory;

implementation
 uses PubFn,Services;
 var FSubFunctionList:TList<TSubfunction>;
{$R *.dfm}

 procedure TFrmVehicleDistanceActiveHistory.btn1Click(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsVehicledistancehistory do
  begin
    Active := false;
    Params.ParamValues['filter_GTD_vd!createtime']
                :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_vd!createtime']
                :=  formatdatetime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime);

      if Trim(nvhlpvehicleno.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_v!id'] := '';
    end else
    begin
      if vehicleno <> nvhlpvehicleno.Text then
      begin
       Params.ParamValues['filter_EQL_v!id'] := nvhlpvehicleno.HelpFieldValue['id'];
      end
      else
      begin
        Params.ParamValues['filter_EQL_v!id'] :=vehicleid;
      end;
    end;
        if (not (Trim(nvhlpUserid.Text) = '')) and (nvhlpUserid.Id>0) then //用户名
    begin
      Params.ParamValues['filter_EQL_u!id']:= nvhlpUserid.HelpFieldValue['id'];
    end
   else
    begin
      Params.ParamValues['filter_EQL_u!id']:= '';
    end;

    Active := True;
  end;


end;

procedure TFrmVehicleDistanceActiveHistory.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
end;

end.








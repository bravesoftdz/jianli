unit UFrmChanageVehicleplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHelp, NovaEdit, DB,
  DBClient, jsonClientDataSet, ImgList;

type
  TFrmChanageVehicleplan = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl15: TLabel;
    lbl1: TLabel;
    NvEdtRoute: TNovaEdit;
    nvedtcode: TNovaEdit;
    NvedtDeparttimeL: TNovaEdit;
    nvedtSeatnum: TNovaEdit;
    nvedttickettype: TNovaEdit;
    NovaEdtDepartDate: TNovaEdit;
    GroupBox2: TGroupBox;
    lbl3: TLabel;
    Label1: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl10: TLabel;
    nvhlpdriver: TNovaHelp;
    NovaHelpVehicleno: TNovaHelp;
    jcdsChanageVehicleplan: TjsonClientDataSet;
    nvhlpcopilot1: TNovaHelp;
    nvhlpcopilot2: TNovaHelp;
    nvhlpcopilot3: TNovaHelp;
    nvhlpsteward: TNovaHelp;
    lbl2: TLabel;
    lbl4: TLabel;
    NovaHUnit: TNovaHelp;
    procedure FormShow(Sender: TObject);
    procedure NovaEdtUnitIdChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    unitid:int64;
    scheduleplanid:int64;
  end;

var
  FrmChanageVehicleplan: TFrmChanageVehicleplan;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmChanageVehicleplan.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (trim(NovaHUnit.Text)='') or (NovaHUnit.Id=0)  then
  begin
    SysDialogs.Warning('请输入营运单位！');
    NovaHUnit.SetFocus;
    exit;
  end;
  if (trim(NovaHelpVehicleno.Text)='') or (NovaHelpVehicleno.Id=0)  then
  begin
    SysDialogs.Warning('请输入计划车辆！');
    NovaHelpVehicleno.SetFocus;
    exit;
  end;
  with jcdsChanageVehicleplan do
  begin
    Active := false;
    Params.ParamValues['vehiclepeopleplan.scheduleplan.id'] := scheduleplanid;
    Params.ParamValues['vehiclepeopleplan.planunitid'] := NovaHUnit.id;
    Params.ParamValues['vehiclepeopleplan.orgid'] := SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['vehiclepeopleplan.createby'] := SysInfo.LoginUserInfo.UserID;
    Params.ParamValues['vehiclepeopleplan.planvehicle.id'] := NovaHelpVehicleno.Id;
    Params.ParamValues['vehiclepeopleplan.plandriver1.id'] := nvhlpdriver.id;
    Params.ParamValues['vehiclepeopleplan.plandriver2.id'] := nvhlpcopilot1.id ;
    Params.ParamValues['vehiclepeopleplan.plandriver3.id'] := nvhlpcopilot2.id ;
    Params.ParamValues['vehiclepeopleplan.plandriver4.id'] := nvhlpcopilot3.id ;
    Params.ParamValues['vehiclepeopleplan.plansteward1.id'] := nvhlpsteward.id;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('顶班操作失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmChanageVehicleplan.FormShow(Sender: TObject);
begin
  inherited;
  NovaHUnit.SetFocus;
end;

procedure TFrmChanageVehicleplan.NovaEdtUnitIdChange(Sender: TObject);
begin
  inherited;
  if (trim(NovaHUnit.text)<>'') and (NovaHUnit.Id<>unitid)
  and (NovaHUnit.Id>0) then
  begin
    NovaHelpVehicleno.Clear;
    nvhlpdriver.Clear;
    nvhlpcopilot1.Clear;
    nvhlpcopilot2.Clear;
    nvhlpcopilot3.Clear;
    nvhlpsteward.Clear;
  end;
end;

end.

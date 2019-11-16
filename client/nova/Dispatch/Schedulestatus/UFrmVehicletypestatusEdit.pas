unit UFrmVehicletypestatusEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHComboBox,
  DB, DBClient, jsonClientDataSet, NovaComboBox, ImgList, NovaHelp,UDMPublic;

type
  TFrmVehicletypestatusEdit = class(TSimpleEditForm)
    lblroute: TLabel;
    lblschedule: TLabel;
    lbldepartdate: TLabel;
    edtroute: TNovaEdit;
    edtstartdate: TNovaEdit;
    edtschedule: TNovaEdit;
    edtdeparttime: TNovaEdit;
    lblplanvehicle: TLabel;
    edtstartstation: TNovaEdit;
    edtendstation: TNovaEdit;
    lblstartstation: TLabel;
    lblendstation: TLabel;
    jsonCDSVehicletypeSave: TjsonClientDataSet;
    lblseatnum: TLabel;
    edtseatnum: TNovaEdit;
    Label1: TLabel;
    lbl1: TLabel;
    Label4: TLabel;
    nvhlpunit: TNovaHelp;
    Label5: TLabel;
    nvhelpVehicleno: TNovaHelp;
    nvhlptypename: TNovaHelp;
    Label2: TLabel;
    Label3: TLabel;
    Label6: TLabel;
    edtbrandmodel: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhelpVehiclenoIdChange(Sender: TObject);
    procedure edtbrandmodelIdChange(Sender: TObject);
    procedure nvhlptypenameIdChange(Sender: TObject);
    procedure nvhlpunitIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vehicletypeid : string;
    id, planid : Int64;
    sign : Boolean;
  end;

var
  FrmVehicletypestatusEdit: TFrmVehicletypestatusEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmVehicletypestatusEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  vehiclebrandmodelid : Int64;
begin

  if nvhlptypename.id= 0 then
  begin
    nvhlptypename.SetFocus;
    SysDialogs.ShowMessage('请选择车型！');
    Exit;
  end;
  if edtbrandmodel.id = 0 then
  begin
    edtbrandmodel.SetFocus;
    SysDialogs.ShowMessage('请选择品牌型号！');
    Exit;
  end;
  with jsonCDSVehicletypeSave do
  begin
    Close;
    Params.ParamByName('peopleplan.id').Value := id;
    params.ParamByName('peopleplan.departdate').Value := edtstartdate.Text;
    Params.ParamByName('peopleplan.planvehicletypeid').Value := nvhlptypename.Id;
    if (nvhlpunit.Text<>'') and  (nvhlpunit.Id>0) then
      Params.ParamByName('peopleplan.planunit.id').Value := nvhlpunit.Id
    else
      Params.ParamByName('peopleplan.planunit.id').Value := null;
    if (nvhelpVehicleno.Text<>'') and (nvhelpVehicleno.Id>0) then
      Params.ParamByName('peopleplan.planvehicle.id').Value := nvhelpVehicleno.Id
    else
      Params.ParamByName('peopleplan.planvehicle.id').Value := null;
    Params.ParamByName('peopleplan.planvehiclebrandmodelid').Value := edtbrandmodel.Id;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlptypename.SetFocus;
      end else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('计划车型调整失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehicletypestatusEdit.edtbrandmodelIdChange(Sender: TObject);
begin
  inherited;
  if (edtbrandmodel.isactive) and (edtbrandmodel.Id>0) then
  begin
    nvhelpVehicleno.Clear;
    nvhlptypename.Id:= edtbrandmodel.HelpFieldValue['vehicletypeid'];
    nvhlptypename.text:= edtbrandmodel.HelpFieldValue['vehicletypename'];
    nvhlptypename.Enabled:=false;
    edtseatnum.Text:= edtbrandmodel.HelpFieldValue['rationseatnum'];
  end
  else
  begin
    nvhlptypename.Enabled:=true;
  end;
end;

procedure TFrmVehicletypestatusEdit.nvhelpVehiclenoIdChange(Sender: TObject);
begin
  inherited;
  if (nvhelpVehicleno.isactive) and (nvhelpVehicleno.Id>0) then
  begin
    nvhlpunit.Id:= nvhelpVehicleno.HelpFieldValue['unitid'];
    nvhlpunit.text:= nvhelpVehicleno.HelpFieldValue['unitname'];
    nvhlpunit.Enabled:=false;
    nvhlptypename.Id:= nvhelpVehicleno.HelpFieldValue['vehicletypeid'];
    nvhlptypename.text:= nvhelpVehicleno.HelpFieldValue['vehicletypename'];
    nvhlptypename.Enabled:=false;
    edtbrandmodel.Id:= nvhelpVehicleno.HelpFieldValue['brandid'];
    edtbrandmodel.text:= nvhelpVehicleno.HelpFieldValue['balancename'];
    edtbrandmodel.Enabled:=false;
    edtseatnum.Text:= nvhelpVehicleno.HelpFieldValue['seatnum'];
  end
  else
  begin
    nvhlpunit.Enabled:=true;
    nvhlptypename.Enabled:=true;
    edtbrandmodel.Enabled:=true;
  end;

end;

procedure TFrmVehicletypestatusEdit.nvhlptypenameIdChange(Sender: TObject);
begin
  inherited;
  if (nvhlptypename.isactive) and (nvhlptypename.Id>0) then
  begin
    nvhelpVehicleno.Clear;
    edtbrandmodel.Clear ;
  end;
end;

procedure TFrmVehicletypestatusEdit.nvhlpunitIdChange(Sender: TObject);
begin
  inherited;
  if (nvhlpunit.isactive) and (nvhlpunit.Id>0) then
  begin
    nvhelpVehicleno.Clear;
  end;
end;

end.

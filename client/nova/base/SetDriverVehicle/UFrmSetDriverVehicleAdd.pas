unit UFrmSetDriverVehicleAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, NovaEdit, NovaHelp, NovaHComboBox, DB, DBClient,
  jsonClientDataSet, Menus, GridsEh, DBGridEh, NvDbgridEh;

type
  TfrmSetDriverVehicleAdd = class(TSimpleEditForm)
    grp1: TGroupBox;
    nvdbgrdhvehicle: TNvDbgridEh;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    ds1: TDataSource;
    jcdsQueryvehicle: TjsonClientDataSet;
    jcdssetdrivervehiclesave: TjsonClientDataSet;
    lbl1: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    lbl2: TLabel;
    NovaHelpDriver: TNovaHelp;
    lblxing11: TLabel;
    lbl3: TLabel;
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpDriverIdChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetDriverVehicleAdd: TfrmSetDriverVehicleAdd;

implementation
uses Services;
{$R *.dfm}

procedure TfrmSetDriverVehicleAdd.bbtnSaveClick(Sender: TObject);
var
  vehicleids,sResult:String;
  nResult:integer;
begin
  inherited;
  if NovaHCbbOrg.HelpFieldValue['id']<0 then
  begin
    SysDialogs.ShowInfo('«Î—°‘Òª˙ππ£°');
    NovaHCbbOrg.SetFocus;
    exit;
  end;
  if (Trim(NovaHelpDriver.Text)='') or (NovaHelpDriver.Id<0)  then
  begin
    SysDialogs.ShowInfo('«Î—°‘Òº› ª‘±£°');
    NovaHelpDriver.SetFocus;
    exit;
  end;

  with jcdsQueryvehicle do
  begin
    try
      DisableControls;
      first;
      while not eof do
      begin
        if jcdsQueryvehicle.fieldbyname('isselect').AsBoolean then
        begin
          if vehicleids<>'' then
            vehicleids := vehicleids + ',' + jcdsQueryvehicle.fieldbyname('id').AsString
          else
            vehicleids := vehicleids + jcdsQueryvehicle.fieldbyname('id').AsString;
        end;
        next;
      end;
    finally
      EnableControls;
    end;
  end;
  if (vehicleids=null) or (vehicleids='') then
  begin
    SysDialogs.ShowInfo('«Î—°‘Ò≥µ≈∆∫≈£°');
    exit;
  end;

  with jcdssetdrivervehiclesave do
  begin
    Params.ParamValues['setdrivervehicle.orgid']:= NovaHCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['setdrivervehicle.driverid']:= NovaHelpDriver.HelpFieldValue['id'];
    Params.ParamValues['setdrivervehicle.vehicleids']:= vehicleids;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
          //±‡º≠ ß∞‹
      end;
      ModalResult := mrok;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('º› ª‘±º› ª≥µ¡æ…Ë÷√ÃÌº” ß∞‹£∫' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmSetDriverVehicleAdd.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active := False;
  NovaHCbbOrg.Active := True;
end;

procedure TfrmSetDriverVehicleAdd.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsQueryvehicle do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := true;
        next;
      end;
    end;
  end;
end;

procedure TfrmSetDriverVehicleAdd.N2Click(Sender: TObject);
begin
  inherited;
  with jcdsQueryvehicle do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := false;
        next;
      end;
    end;
  end;
end;

procedure TfrmSetDriverVehicleAdd.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsQueryvehicle do
  begin
    if Active and (RecordCount > 0) then
    begin
      first;
      while (not eof) do
      begin
        edit;
        fieldbyname('isselect').value := not fieldbyname('isselect').AsBoolean;
        next;
      end;
    end;
  end;
end;

procedure TfrmSetDriverVehicleAdd.NovaHelpDriverIdChange(Sender: TObject);
begin
  inherited;
  with jcdsQueryvehicle do
  begin
    active:=false;
    if NovaHCbbOrg.SelText<>'' then
    begin
      Params.ParamValues['orgid']:=NovaHCbbOrg.HelpFieldValue['id'].value;
    end
    else
    begin
      Params.ParamValues['orgid']:='';
    end;
    if NovaHelpDriver.Text<>''  then
    begin
      Params.ParamValues['driverid']:=NovaHelpDriver.Id;
    end
    else
    begin
      Params.ParamValues['driverid']:='';
    end;
    Active:=true;
  end;
end;

end.

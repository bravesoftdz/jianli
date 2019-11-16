unit UFrmVehicletypestatusEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHComboBox,
  DB, DBClient, jsonClientDataSet, NovaComboBox, ImgList, NovaHelp;

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
    lbldriver1: TLabel;
    edtstartstation: TNovaEdit;
    edtendstation: TNovaEdit;
    lblstartstation: TLabel;
    lblendstation: TLabel;
    jsonCDSVehicletypeSave: TjsonClientDataSet;
    lblseatnum: TLabel;
    edtseatnum: TNovaEdit;
    Label1: TLabel;
    nvhlptypename: TNovaHelp;
    cbbplanvehicletype: TNovaHComboBox;
    cbbvehiclebrandmodel: TNovaHComboBox;
    Label2: TLabel;
    edtbrandmodel: TNovaEdit;
    lbl1: TLabel;
    Label3: TLabel;
    edtnum: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure cbbplanvehicletypeExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbbplanvehicletypeChange(Sender: TObject);
    procedure cbbvehiclebrandmodelChange(Sender: TObject);
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

  if cbbplanvehicletype.HelpFieldValue['id'] = 0 then
  begin
    cbbplanvehicletype.SetFocus;
    SysDialogs.ShowMessage('请选择车型！');
    Exit;
  end;
  if cbbvehiclebrandmodel.HelpFieldValue['id'] = 0 then
  begin
    cbbplanvehicletype.SetFocus;
    SysDialogs.ShowMessage('请选择品牌型号！');
    Exit;
  end;
  with jsonCDSVehicletypeSave do
  begin
    Close;
    vehicletypeid := cbbplanvehicletype.HelpFieldValue['id'];
    vehiclebrandmodelid := cbbvehiclebrandmodel.HelpFieldValue['id'];
    Params.ParamByName('peopleplan.id').Value := id;
    params.ParamByName('peopleplan.departdate').Value := edtstartdate.Text;
    Params.ParamByName('peopleplan.planvehicletypeid').Value := vehicletypeid;
    Params.ParamByName('peopleplan.planvehiclebrandmodelid').Value := vehiclebrandmodelid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbplanvehicletype.SetFocus;
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

procedure TFrmVehicletypestatusEdit.cbbplanvehicletypeChange(Sender: TObject);
begin
  inherited;
  cbbvehiclebrandmodel.Text := '';
  edtnum.Text := '';
end;

procedure TFrmVehicletypestatusEdit.cbbplanvehicletypeExit(Sender: TObject);
begin
  inherited;
  with cbbvehiclebrandmodel do
  begin
    Active := False;
      params.ParamValues['filter_EQL_v!id'] := cbbplanvehicletype.HelpFieldValue['id'];
    Active := True;
  end;
end;

procedure TFrmVehicletypestatusEdit.cbbvehiclebrandmodelChange(Sender: TObject);
begin
  inherited;
  edtnum.Text := cbbvehiclebrandmodel.HelpFieldValue['rationseatnum'];
end;

procedure TFrmVehicletypestatusEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbplanvehicletype.Active := false;
  cbbplanvehicletype.Active := True;
  cbbvehiclebrandmodel.Active := false;
  cbbvehiclebrandmodel.Active := True;
end;

end.

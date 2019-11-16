unit UFrmsetVehicleSpace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls,
  NovaHComboBox,UDMPublic,Services, ImgList;

type
  TFrmsetVehicleSpace = class(TSimpleEditForm)
    lblspace: TLabel;
    lblremarks: TLabel;
    lblseatno: TLabel;
    lblwidth: TLabel;
    lblheight: TLabel;
    lblrowno: TLabel;
    lblcolno: TLabel;
    nvedtrowno: TNovaEdit;
    nvedtcolno: TNovaEdit;
    memremarks: TMemo;
    nvedtseatno: TNovaEdit;
    nvedtwidth: TNovaEdit;
    nvedtheight: TNovaEdit;
    Nvhcbbspace: TNovaHComboBox;
    procedure NvhcbbspaceChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmsetVehicleSpace: TFrmsetVehicleSpace;

implementation

{$R *.dfm}

procedure TFrmsetVehicleSpace.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if Nvhcbbspace.ItemIndex<0 then
  begin
    SysDialogs.ShowError('空间类型不能为空，请选择！');
    Nvhcbbspace.SetFocus;
    exit;
  end;
  if (Nvhcbbspace.HelpFieldValue['ispassengerseat']='true') and ((nvedtseatno.Text='') or (StrToIntDef(nvedtseatno.Text,0)<=0)) then
  begin
    SysDialogs.ShowError('座位号必须大于0！');
    nvedtseatno.SetFocus;
    exit;
  end;
  if (nvedtwidth.Text='') or (StrToIntDef(nvedtwidth.Text,0)<=0) then
  begin
    SysDialogs.ShowError('宽度必须为整形且不能为空！');
    nvedtwidth.SetFocus;
    exit;
  end;
  if (nvedtheight.Text='') or (StrToIntDef(nvedtheight.Text,0)<=0) then
  begin
    SysDialogs.ShowError('高度必须为整形且不能为空！');
    nvedtheight.SetFocus;
    exit;
  end;
  self.ModalResult:=mrOk;
end;

procedure TFrmsetVehicleSpace.FormCreate(Sender: TObject);
begin
  inherited;
  Nvhcbbspace.Active:=true;
end;

procedure TFrmsetVehicleSpace.FormShow(Sender: TObject);
begin
  inherited;
  if nvedtseatno.Visible then
    nvedtseatno.SetFocus
  else
    Nvhcbbspace.SetFocus;
end;

procedure TFrmsetVehicleSpace.NvhcbbspaceChange(Sender: TObject);
begin
  inherited;
  lblseatno.Visible:=(Nvhcbbspace.HelpFieldValue['ispassengerseat']='true');
  nvedtseatno.Visible:=lblseatno.Visible;
end;

end.

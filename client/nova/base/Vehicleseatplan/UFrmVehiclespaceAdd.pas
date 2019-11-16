unit UFrmVehiclespaceAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit,UDMPublic,Services,jpeg,PubFn, ExtDlgs, Menus,
  NovaComboBox, ImgList;

type
  TFrmVehiclespaceAdd = class(TSimpleEditForm)
    lblname: TLabel;
    nvedtname: TNovaEdit;
    cbispassengerseat: TCheckBox;
    lblpicture: TLabel;
    imgpicture: TImage;
    jcdsVehiclespaceedit: TjsonClientDataSet;
    dlgOpenPic: TOpenPictureDialog;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    pnlpicture: TPanel;
    lblseattype: TLabel;
    lbl3: TLabel;
    nvcbbseattype: TNovaComboBox;
    lbl1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure imgpictureDblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbispassengerseatClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    id,orgid,isactive,islocaldelete,createby,createtime,updateby,updatetime:string;
    picture:string;
    property operationid:Integer read Foperationid;
  end;

var
  FrmVehiclespaceAdd: TFrmVehiclespaceAdd;

implementation

{$R *.dfm}

procedure TFrmVehiclespaceAdd.bbtnSaveClick(Sender: TObject);
var jpg :TJpegImage;
    mem :TMemoryStream;
begin
  inherited;
  if Trim(nvedtname.Text)='' then
  begin
    SysDialogs.ShowError('名称不能为空！');
    nvedtname.SetFocus;
    exit;
  end;
  if cbispassengerseat.Checked and (nvcbbseattype.ItemIndex<0) then
  begin
    SysDialogs.ShowError('请选择座位类型！');
    nvcbbseattype.SetFocus;
    exit;
  end;
  with jcdsVehiclespaceedit do
  begin
    if self.edittype=Tedittype.update then
    begin
      Params.ParamValues['vehiclespace.id'] := id;
      Params.ParamValues['vehiclespace.isactive'] := isactive;
      Params.ParamValues['vehiclespace.islocaldelete'] := islocaldelete;
      Params.ParamValues['vehiclespace.createby'] := createby;
      Params.ParamValues['vehiclespace.createtime'] := createtime;
      Params.ParamValues['vehiclespace.updateby'] := updateby;
      Params.ParamValues['vehiclespace.updatetime'] := updatetime;
      Params.ParamValues['vehiclespace.orgid'] := orgid;
    end;
    Params.ParamValues['vehiclespace.name'] := Trim(nvedtname.Text);
    if cbispassengerseat.Checked then
    begin
      Params.ParamValues['vehiclespace.seattype'] := nvcbbseattype.GetSelectCode;
    end
    else
    begin
      Params.ParamValues['vehiclespace.seattype'] := null;
    end;
    if cbispassengerseat.Checked then
    begin
      Params.ParamValues['vehiclespace.ispassengerseat'] := 'true';
    end
    else
    begin
      Params.ParamValues['vehiclespace.ispassengerseat'] := 'false';
    end;
    if (Assigned(imgpicture.Picture.Graphic)) and (not imgpicture.Picture.Graphic.Empty) then
    begin
      mem := TMemoryStream.Create;
      jpg := TJpegImage.Create;
      jpg.Assign(imgpicture.Picture.Graphic);
      jpg.SaveToStream(mem);
      jpg.Free;
//      if mem.Size > 32768 then
//      begin
//        SysDialogs.Warning('图片大小不能超过32K');
//        exit;
//      end;
      Params.ParamValues['picture']:=MemoryStreamToHexStr(mem);
      mem.Free;
    end ;
    Execute;
    if Params.ParamValues['msg']<>'' then
    begin
      SysDialogs.ShowMessage(Params.ParamValues['msg']);
    end;
    if Params.ParamValues['flag']=1 then
    begin
      Foperationid:=Params.ParamValues['vehiclespaceid'];
      self.ModalResult:=mrOk;
    end;
  end;
end;

procedure TFrmVehiclespaceAdd.cbispassengerseatClick(Sender: TObject);
begin
  inherited;
  lblseattype.Visible:=cbispassengerseat.Checked;
  lbl3.Visible:=lblseattype.Visible;
  nvcbbseattype.Visible:=lblseattype.Visible;
end;

procedure TFrmVehiclespaceAdd.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbseattype.Active:=true;
end;

procedure TFrmVehiclespaceAdd.FormShow(Sender: TObject);
begin
  inherited;
  if picture<>'' then
    imgpicture.Picture.Assign(HexStrToJpg(picture));
end;

procedure TFrmVehiclespaceAdd.imgpictureDblClick(Sender: TObject);
begin
  inherited;
  if dlgOpenPic.Execute then
  begin
    imgpicture.Picture.Assign(nil);
    imgpicture.Picture.LoadFromFile(dlgOpenPic.FileName);
    imgpicture.Repaint;
  end;
end;

procedure TFrmVehiclespaceAdd.N2Click(Sender: TObject);
begin
  inherited;
  imgpicture.Picture.Assign(nil);
end;

end.

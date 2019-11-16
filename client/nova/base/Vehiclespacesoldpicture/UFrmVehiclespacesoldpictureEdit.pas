unit UFrmVehiclespacesoldpictureEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, Menus,
  ExtDlgs, DB, DBClient, jsonClientDataSet, NovaComboBox, NovaHComboBox, ImgList;

type
  TFrmVehiclespacesoldpictureEdit = class(TSimpleEditForm)
    lblschedule: TLabel;
    lblplanvehicle: TLabel;
    dlgOpenPic: TOpenPictureDialog;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    jsonCDSVehiclepictureSave: TjsonClientDataSet;
    cbbvehiclespace: TNovaHComboBox;
    cbbticket: TNovaHComboBox;
    lbl1: TLabel;
    Label1: TLabel;
    pnlpicture: TPanel;
    imgpicture: TImage;
    Label2: TLabel;
    lbl2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgpictureDblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    log : String;
  public
    { Public declarations }
    picture,isactive,islocaldelete,createby,createtime,spaceid,typeid:string;
    id : Int64;
    property operationid:Integer read Foperationid;
  end;

var
  FrmVehiclespacesoldpictureEdit: TFrmVehiclespacesoldpictureEdit;

implementation

uses Services, PubFn, UDMPublic, jpeg;
{$R *.dfm}

procedure TFrmVehiclespacesoldpictureEdit.bbtnSaveClick(Sender: TObject);
var
  jpg :TJpegImage;
  mem :TMemoryStream;
begin
  if (not Assigned(imgpicture.Picture.Graphic)) or imgpicture.Picture.Graphic.Empty then
  begin
    SysDialogs.ShowMessage('请选择图片！');
    cbbvehiclespace.SetFocus;
    exit;
  end;
  if Trim(cbbvehiclespace.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择车辆内部空间！');
    cbbvehiclespace.SetFocus;
    exit;
  end;
  if Trim(cbbticket.Text) = '' then
  begin
    SysDialogs.ShowMessage('请选择票种！');
    cbbticket.SetFocus;
    exit;
  end;
  with jsonCDSVehiclepictureSave do
  begin
    Close;
    if cbbvehiclespace.ItemIndex >= 0 then
    begin
      spaceid := cbbvehiclespace.HelpFieldValue['id'];
    end;
    if cbbticket.ItemIndex >= 0 then
    begin
      typeid := cbbticket.HelpFieldValue['id'];
    end;
    if self.edittype=TEdittype.update then
    begin
      Params.ParamValues['vehiclespacesoldpicture.id']:=id;
      Params.ParamValues['vehiclespacesoldpicture.isactive']:=isactive;
      Params.ParamValues['vehiclespacesoldpicture.islocaldelete']:=islocaldelete;
      Params.ParamValues['vehiclespacesoldpicture.createtime']:=createtime;
      Params.ParamValues['vehiclespacesoldpicture.createby']:=createby;
    end;
    Params.ParamByName('vehiclespacesoldpicture.vehiclespaceid').Value := spaceid;
    Params.ParamByName('vehiclespacesoldpicture.ticktypeid').Value := typeid;
    if (Assigned(imgpicture.Picture.Graphic)) and (not imgpicture.Picture.Graphic.Empty) then
    begin
      imgpicture.Picture.Assign(nil);
      convertAndshrinkImage(dlgOpenPic.FileName,imgpicture,TGraphicType.Jpg,600,480);
      mem := TMemoryStream.Create;
      jpg := TJpegImage.Create;
      jpg.Assign(imgpicture.Picture.Graphic);
      jpg.SaveToStream(mem);
      jpg.Free;

      Params.ParamValues['picture']:=MemoryStreamToHexStr(mem);
      mem.Free;
    end ;
    try
      Execute;
      SysDialogs.ShowMessage(Params.ParamByName('msg').Value);
      if (Params.ParamByName('flag').Value <= 0) then
      begin
        cbbvehiclespace.SetFocus;
      end else
      begin
        if id > 0 then
        begin
          log := '修改车辆座位空间售出图片：内部空间名称='+cbbvehiclespace.Text+',票种='
          +cbbticket.Text;
          SysLog.WriteLog('业务管理——>车辆座位空间售出图片','修改',log);
        end
        else
        begin
          log := '添加车辆座位空间售出图片：内部空间名称='+cbbvehiclespace.Text+',票种='
          +cbbticket.Text;
          SysLog.WriteLog('业务管理——>车辆座位空间售出图片','添加',log);
        end;

       // Foperationid := Params.ParamValues['id'];
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('默认座位状态图增加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmVehiclespacesoldpictureEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbvehiclespace.Active := False;
  cbbvehiclespace.Active := true;

  cbbticket.Active := false;
  cbbticket.Active := True;
end;

procedure TFrmVehiclespacesoldpictureEdit.FormShow(Sender: TObject);
begin
  inherited;
  if picture<>'' then
    imgpicture.Picture.Assign(HexStrToJpg(picture));
end;

procedure TFrmVehiclespacesoldpictureEdit.imgpictureDblClick(Sender: TObject);
begin
  inherited;
  if dlgOpenPic.Execute then
  begin
    imgpicture.Picture.Assign(nil);
    imgpicture.Picture.LoadFromFile(dlgOpenPic.FileName);
    imgpicture.Repaint;
  end;
end;

procedure TFrmVehiclespacesoldpictureEdit.N2Click(Sender: TObject);
begin
  inherited;
  imgpicture.Picture.Assign(nil);
end;

end.

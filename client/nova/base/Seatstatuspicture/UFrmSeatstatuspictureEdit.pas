unit UFrmSeatstatuspictureEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, Menus, ExtDlgs,
  NovaComboBox, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmSeatstatuspictureEdit = class(TSimpleEditForm)
    dlgOpenPic: TOpenPictureDialog;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    lblseatstatus: TLabel;
    cbbseatstatus: TNovaComboBox;
    jsonCDSSeatstatuspictureSave: TjsonClientDataSet;
    lbl1: TLabel;
    Label1: TLabel;
    pnlpicture: TPanel;
    imgpicture: TImage;
    lbl2: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgpictureDblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    Fseatstatus:Integer;
    log : String;
  public
    { Public declarations }
    id,orgid,picture,isactive,islocaldelete,createby,createtime:string;
    property seatstatus:Integer read Fseatstatus;
  end;

var
  FrmSeatstatuspictureEdit: TFrmSeatstatuspictureEdit;

implementation

uses Services, jpeg, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmSeatstatuspictureEdit.bbtnSaveClick(Sender: TObject);
var
  bmp :TBitmap;
  mem :TMemoryStream;
begin
  if Trim(cbbseatstatus.Text)='' then
  begin
    SysDialogs.ShowMessage('品牌不能为空!');
    cbbseatstatus.SetFocus;
    exit;
  end;
  if (not Assigned(imgpicture.Picture.Graphic)) or imgpicture.Picture.Graphic.Empty then
  begin
    SysDialogs.ShowMessage('请选择图片！');
    cbbseatstatus.SetFocus;
    exit;
  end;
  with jsonCDSSeatstatuspictureSave do
  begin
    Close;
    if self.edittype=TEdittype.update then
    begin
      Params.ParamValues['seatstatuspicture.isactive']:=isactive;
      Params.ParamValues['seatstatuspicture.islocaldelete']:=islocaldelete;
      Params.ParamValues['seatstatuspicture.createtime']:=createtime;
      Params.ParamValues['seatstatuspicture.createby']:=createby;
      Params.ParamValues['seatstatuspicture.orgid']:=orgid;
    end;
    Params.ParamByName('seatstatuspicture.seatstatus').Value := TCommInfo(cbbseatstatus.Items.Objects[cbbseatstatus.ItemIndex]).Value;
    if (Assigned(imgpicture.Picture.Graphic)) and (not imgpicture.Picture.Graphic.Empty) then
    begin
//      imgpicture.Picture.Assign(nil);
      //convertAndshrinkImage(dlgOpenPic.FileName,imgpicture,TGraphicType.Jpg,600,480);
      mem := TMemoryStream.Create;
      bmp := TBitmap.Create;
      bmp.Assign(imgpicture.Picture.Graphic);
      bmp.SaveToStream(mem);
      bmp.Free;
      Params.ParamValues['picture']:=MemoryStreamToHexStr(mem);
      mem.Free;
    end ;
    try
      Execute;
      SysDialogs.ShowMessage(Params.ParamByName('msg').Value);
      if (Params.ParamByName('flag').Value <= 0) then
      begin
        cbbseatstatus.SetFocus;
      end else
      begin
        if self.edittype=TEdittype.update then
        begin
          log := '修改默认座位状态：座位图状态='+cbbseatstatus.Text;
          SysLog.WriteLog('业务管理——>默认座位状态','修改',log);
        end else
        begin
          log := '添加默认座位状态：座位图状态='+cbbseatstatus.Text;
          SysLog.WriteLog('业务管理——>默认座位状态','添加',log);
        end;
       // Fseatstatus := Params.ParamValues['seatstatus'];
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


procedure TFrmSeatstatuspictureEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbseatstatus.Active := false;
  cbbseatstatus.Active := true;

end;

procedure TFrmSeatstatuspictureEdit.FormShow(Sender: TObject);
begin
  inherited;
  if picture<>'' then
    imgpicture.Picture.Assign(HexStrToGraphic(picture));
end;

procedure TFrmSeatstatuspictureEdit.imgpictureDblClick(Sender: TObject);
begin
  inherited;
  if dlgOpenPic.Execute then
  begin
    imgpicture.Picture.Assign(nil);
    imgpicture.Picture.LoadFromFile(dlgOpenPic.FileName);
    imgpicture.Repaint;
  end;
end;

procedure TFrmSeatstatuspictureEdit.N2Click(Sender: TObject);
begin
  inherited;
  imgpicture.Picture.Assign(nil);
end;

end.

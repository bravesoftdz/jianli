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
    SysDialogs.ShowMessage('Ʒ�Ʋ���Ϊ��!');
    cbbseatstatus.SetFocus;
    exit;
  end;
  if (not Assigned(imgpicture.Picture.Graphic)) or imgpicture.Picture.Graphic.Empty then
  begin
    SysDialogs.ShowMessage('��ѡ��ͼƬ��');
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
          log := '�޸�Ĭ����λ״̬����λͼ״̬='+cbbseatstatus.Text;
          SysLog.WriteLog('ҵ�������>Ĭ����λ״̬','�޸�',log);
        end else
        begin
          log := '���Ĭ����λ״̬����λͼ״̬='+cbbseatstatus.Text;
          SysLog.WriteLog('ҵ�������>Ĭ����λ״̬','���',log);
        end;
       // Fseatstatus := Params.ParamValues['seatstatus'];
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ĭ����λ״̬ͼ����ʧ�ܣ�' + E.Message);
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

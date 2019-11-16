unit UFrmVehiclebrandmodelAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit,UDMPublic, DB,
  DBClient, jsonClientDataSet,Services,jpeg,ExtDlgs, Menus, ImgList,
  NovaHComboBox;

type
  TFrmVehiclebrandmodelAdd = class(TSimpleEditForm)
    nvedtbrandname: TNovaEdit;
    nvedtmodelcode: TNovaEdit;
    nvedtrationseatnum: TNovaEdit;
    lblbrandname: TLabel;
    lblmodelcode: TLabel;
    lblrationseatnum: TLabel;
    lblremarks: TLabel;
    lblpicture: TLabel;
    memremarks: TMemo;
    imgpicture: TImage;
    jcdsVehiclebrandmodelAdd: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    dlgOpenPic: TOpenPictureDialog;
    pmpicture: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    pnlpicture: TPanel;
    NovaHCobVehicletype: TNovaHComboBox;
    Label1: TLabel;
    Label2: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure imgpictureDblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    id,orgid,picture,isactive,islocaldelete,createby,createtime,updateby,updatetime,synccode:string;
    property operationid:Integer read Foperationid;
  end;

var
  FrmVehiclebrandmodelAdd: TFrmVehiclebrandmodelAdd;

implementation
uses PubFn;

{$R *.dfm}

procedure TFrmVehiclebrandmodelAdd.bbtnSaveClick(Sender: TObject);
var jpg :TJpegImage;
    mem :TMemoryStream;
begin
  inherited;
  if Trim(nvedtbrandname.Text)='' then
  begin
    SysDialogs.ShowMessage('品牌不能为空!');
    nvedtbrandname.SetFocus;
    exit;
  end;
  if Trim(nvedtmodelcode.Text)='' then
  begin
    SysDialogs.ShowMessage('型号不能为空!');
    nvedtmodelcode.SetFocus;
    exit;
  end;
  {if (Trim(nvedtrationseatnum.Text)='')  or (StrToIntDef(nvedtrationseatnum.Text,0)<=0) then
  begin
    SysDialogs.ShowMessage('乘客座位数必须大于0!');
    nvedtrationseatnum.SetFocus;
    exit;
  end; }
  if self.NovaHCobVehicletype.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择所属车型!');
    NovaHCobVehicletype.SetFocus;
    exit;
  end;
  with jcdsVehiclebrandmodelAdd do
  begin
    if self.edittype=TEdittype.update then
    begin
      Params.ParamValues['vehiclebrandmodel.id']:=id;
      Params.ParamValues['vehiclebrandmodel.isactive']:=isactive;
      Params.ParamValues['vehiclebrandmodel.islocaldelete']:=islocaldelete;
      Params.ParamValues['vehiclebrandmodel.createtime']:=createtime;
      Params.ParamValues['vehiclebrandmodel.createby']:=createby;
      Params.ParamValues['vehiclebrandmodel.updatetime']:=updatetime;
      Params.ParamValues['vehiclebrandmodel.updateby']:=updateby;
      Params.ParamValues['vehiclebrandmodel.orgid']:=orgid;
      Params.ParamValues['vehiclebrandmodel.synccode']:=synccode;
    end
    else
    begin
    end;
    Params.ParamValues['vehiclebrandmodel.vehicletypeid']:=NovaHCobVehicletype.HelpFieldValue['id'];
    Params.ParamValues['vehiclebrandmodel.brandname']:=trim(nvedtbrandname.Text);
    Params.ParamValues['vehiclebrandmodel.modelcode']:=trim(nvedtmodelcode.Text);
    Params.ParamValues['vehiclebrandmodel.rationseatnum']:=trim(nvedtrationseatnum.Text);
    Params.ParamValues['vehiclebrandmodel.remarks']:=trim(memremarks.Text);
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
      Foperationid:=Params.ParamValues['vehiclebrandmodelid'];
      self.ModalResult:=mrOk;
    end;
  end;
end;

procedure TFrmVehiclebrandmodelAdd.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCobVehicletype.Active:=false;
  NovaHCobVehicletype.Active:=true;
end;

procedure TFrmVehiclebrandmodelAdd.FormShow(Sender: TObject);
begin
  inherited;
  if picture<>'' then
    imgpicture.Picture.Assign(HexStrToJpg(picture));
end;

procedure TFrmVehiclebrandmodelAdd.imgpictureDblClick(Sender: TObject);
begin
  inherited;
  if dlgOpenPic.Execute then
  begin
    imgpicture.Picture.Assign(nil);
    convertAndshrinkImage(dlgOpenPic.FileName,imgpicture,TGraphicType.Jpg,600,480);
//    imgpicture.Picture.LoadFromFile(dlgOpenPic.FileName);
//    imgpicture.Repaint;
  end;
end;

procedure TFrmVehiclebrandmodelAdd.N2Click(Sender: TObject);
begin
  inherited;
  imgpicture.Picture.Assign(nil);
end;

end.

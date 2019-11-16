unit UFrmTickettypeAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, Services, StdCtrls, ExtCtrls, DB, DBClient,
  jsonClientDataSet, Buttons, ExtDlgs, NovaEdit, Jpeg, ImgList;

type
  TFrmTickettypeAdd = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl7: TLabel;
    jsonCDSTickettypeSave: TjsonClientDataSet;
    LblSOLDPICTURE: TLabel;
    Panel1: TPanel;
    Img_Picture: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    Label1: TLabel;
    edtname: TNovaEdit;
    edtcode: TNovaEdit;
    edtprintname: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Rb_ISSCORE1: TRadioButton;
    rb_ISSCORE2: TRadioButton;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtcodeKeyPress(Sender: TObject; var Key: Char);
    procedure Img_PictureDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log : String;
    mem: TMemoryStream;
    memstr: TStringStream;
  public
    id, createby,orgid, updateby,orderno: integer;
    createtime,synccode: String;
    isdefault:boolean;
  end;

var
  FrmTickettypeAdd: TFrmTickettypeAdd;

implementation

uses PubFn;
{$R *.dfm}

procedure TFrmTickettypeAdd.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, result: string;
  bmp: Tbitmap;
  jpg1: TJpegImage;
  c: Char;
  s1, s2: string;
begin
  inherited;
  if edtname.Text = '' then
  begin
    SysDialogs.ShowMessage('票种名称不能为空');
    edtname.SetFocus;
    exit;
  end;
  if edtcode.Text = '' then
  begin
    SysDialogs.ShowMessage('票种代码不能为空');
    edtcode.SetFocus;
    exit;
  end;
  if edtprintname.Text = '' then
  begin
    SysDialogs.ShowMessage('打印名称不能为空');
    edtprintname.SetFocus;
    exit;
  end;
  if Img_Picture.Picture = nil then
  begin
    SysDialogs.ShowMessage('请选择座位图标！');
    exit;
  end;
  if (Img_Picture.Picture.Width>80) or (Img_Picture.Picture.Height>80) then
  begin
     SysDialogs.ShowMessage('选择的票种图标过大，请重新选择！');
     exit;
  end;
  with jsonCDSTickettypeSave do
  begin
    close;
    Params.ParamByName('tickettype.id').Value := id;
    Params.ParamByName('tickettype.code').Value := edtcode.Text;
    Params.ParamByName('tickettype.name').Value := edtname.Text;
    Params.ParamByName('tickettype.orgid').Value := orgid;
    Params.ParamByName('tickettype.orderno').Value := orderno;
    Params.ParamByName('tickettype.printname').Value := edtprintname.Text;
    if Rb_ISSCORE1.Checked then
    begin
      Params.ParamByName('tickettype.isscore').Value := True;
    end
    else
    begin
      Params.ParamByName('tickettype.isscore').Value := False;
    end;
    Params.ParamByName('tickettype.isdefault').Value := isdefault;
    Params.ParamByName('tickettype.isactive').Value := True;
    Params.ParamByName('tickettype.islocaldelete').Value := False;
    Params.ParamByName('tickettype.synccode').Value :=  synccode;

    Params.ParamByName('tickettype.createby').Value :=
      SysInfo.LoginUserInfo.UserID;
    Params.ParamByName('tickettype.createtime').Value := createtime;
    if Img_Picture.Picture.Graphic = nil then
    begin
      SysDialogs.ShowMessage('请选择图片');
      exit;
    end;
    if (not Img_Picture.Picture.Graphic.Empty) then
    begin
      if not assigned(mem) then
      begin
        mem := TMemoryStream.Create;
      end
      else
        mem.Clear;
      // 转换为JPG格式
      jpg1 := TJpegImage.Create;
      jpg1.Assign(Img_Picture.Picture.Graphic);
      jpg1.SaveToStream(mem);
      jpg1.Free;


      if mem.Size > 32768 then
      begin
        SysDialogs.Warning('图片大小不能超过32K');
        exit;
      end;
      Params.ParamByName('seatpic').Value := MemoryStreamToHexStr(mem);
    end ;
      // 转为BMP格式
      { bmp := Tbitmap.Create;
        bmp.Assign(Img_Picture.Picture.Graphic);
        bmp.SaveToStream(mem);
        bmp.Free; }
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult =1)  then
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result +'票种设置：名称='+edtname.Text+',票种编码='+edtcode.Text+
        ',打印名称='+edtprintname.Text;
        SysLog.WriteLog('票价管理->票种设置',result,log);
        id:=Params.ParamByName('tickettypeid').Value;
        ModalResult := mrok;
      end
      else if (nResult = -1) then
      begin
        edtname.SetFocus;
      end
      else if (nResult = -2) then
      begin
        edtcode.SetFocus;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票种增加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmTickettypeAdd.edtcodeKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not(Key in ['A' .. 'Z','a' .. 'z',#8,#13]) then
    Key := #0;
end;

procedure TFrmTickettypeAdd.FormShow(Sender: TObject);
begin
  inherited;
  edtcode.Enabled:=not isdefault;
  edtname.Enabled:=not isdefault;
end;

procedure TFrmTickettypeAdd.Img_PictureDblClick(Sender: TObject);
begin
  inherited;
  if OpenPictureDialog1.Execute then
  begin
    Img_Picture.Picture.Assign(nil);
    Img_Picture.Picture.LoadFromFile(OpenPictureDialog1.FileName);
    Img_Picture.Repaint;
  end;
end;

end.

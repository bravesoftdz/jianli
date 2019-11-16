unit PrintTemplatePlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,DBGridEh, ComCtrls, DB, DBClient,
  GdiPlus, GdiPlusHelpers,pBarCode,HBarCode,TypInfo,math,Jpeg,pubFn,Services;

type
  TPrintTemplatePlan = class(TPanel)
  private
    displayPx, displayPy: integer;
    cdsPrintTemplate, cdsPrintTemplateitem: TCustomClientDataSet;
    procedure DrawBackGround();
  protected
    procedure Paint; override;
  public
    jpeg: TJPEGImage;  //图片
    constructor Create(_cdsPrintTemplate,
      _cdsPrintTemplateitem: TCustomClientDataSet;
      _parentControl: TWinControl); dynamic;
    procedure setDisplayProperty(AControl: TControl);
    procedure createDisplayItem();
    function getComponentNameByid(id: int64): String;
    function getIdByComponentName(_name: String): int64;
    function getPixelByMm(mm: integer): integer;
    function getMmByPixel(pixel: integer): integer;
    function getPrintItemFont(AControl: TControl): TFont;
    function getDisplayItemById(id: int64): TControl;
    function locateCDSByDisplayItem(AControl: TControl): integer;
    function getDisplayItemByCDS: TControl;
  published
  end;

function displayPrintTemplate(_cdsPrintTemplate,
  _cdsPrintTemplateitem: TCustomClientDataSet;
  _parentControl: TWinControl): TPanel;

implementation

type
  TCrackControl = class(TControl);
  const
    namePrefix = 'printItem';

    function displayPrintTemplate(_cdsPrintTemplate,
      _cdsPrintTemplateitem: TCustomClientDataSet;
      _parentControl: TWinControl): TPanel;
    begin
      Result := TPrintTemplatePlan.Create(_cdsPrintTemplate,
        _cdsPrintTemplateitem, _parentControl);
    end;

    function TPrintTemplatePlan.getPixelByMm(mm: integer): integer;
    begin
      // 象素数 / DPI = 英寸数   英寸数 * 25.4 = 毫米数
//      Result := max(Round(mm / 254 * displayPx),1);
      Result := Round(mm / 254 * displayPx);
    end;

    function TPrintTemplatePlan.getPrintItemFont(AControl: TControl): TFont;
    begin
      Result := TCrackControl(AControl).Font;
    end;

    procedure TPrintTemplatePlan.DrawBackGround();

  var
    imageFullPath: String;
    gpImage: IGPImage;
    brush: IGPBrush;
  begin
    imageFullPath := ExtractFilePath(Application.ExeName)
      + cdsPrintTemplate.FieldByName('backgroundimage').AsString;
    if (Trim(imageFullPath) <> '') and (fileexists(imageFullPath)) then
    begin
      gpImage := TGPImage.Create(imageFullPath);
      self.ToGPGraphics.SetRenderingOrigin(displayPx, displayPy);
      self.ToGPGraphics.DrawImage(gpImage, 0, 0);
    end;
  end;

  function TPrintTemplatePlan.getComponentNameByid(id: int64): String;
  begin
    Result := namePrefix + StringReplace(IntToStr(id), '-', '_', []);
  end;

  function TPrintTemplatePlan.getMmByPixel(pixel: integer): integer;
  begin
    // 象素数 / DPI = 英寸数   英寸数 * 25.4 = 毫米数
//    Result := max(Round(pixel * 254 / displayPx),1);
    Result := Round(pixel * 254 / displayPx);
  end;

  procedure TPrintTemplatePlan.setDisplayProperty(AControl: TControl);
  var HexStr : string;
  Stream : TMemoryStream;

  begin
    with TCrackControl(AControl) do
    begin
      name := getComponentNameByid(cdsPrintTemplateitem.FieldByName('id')
          .AsLargeInt);
      Parent := self;
      if AControl is TLabel then
      begin
        TLabel(AControl).Transparent := true;
      end
      else if AControl is TBevel then
      begin
        TBevel(AControl).SendToBack;
        TBevel(AControl).Shape:=bsFrame; // .Brush.Color:=self.Color;
      end
      //else if AControl is TJPEGImage then
      else if AControl is TBarCode then
      begin
        TBarCode(AControl).BevelOuter:=bvNone;
        TBarCode(AControl).BarCode:='1234567890';
        TBarCode(AControl).BarType:=TBarType(GetEnumValue(TypeInfo(TBarType), cdsPrintTemplateitem.FieldByName('parameter').AsString));
      end
      else if AControl is TImage then
      begin
        HexStr := cdsPrintTemplateitem.FieldByName('printpicture').AsString;
        if HexStr <>'' then
        begin
          try
            (*Stream := TMemoryStream.Create;
            Stream.SetSize(Length(HexStr) div 2);
            HexToBin(Pchar(HexStr), Pchar(Integer(Stream.Memory)), Stream.Size);
            Stream.Seek(0, soFromBeginning);
            TImage(AControl).Picture.Graphic.LoadFromStream(Stream);
            Stream.Free; *)
            jpeg := HexStrToJpg(HexStr);
            TImage(AControl).Picture.Assign(jpeg);
            TImage(AControl).Stretch := True;
            TImage(AControl).AutoSize := False;
            TImage(AControl).Align := alNone;
            TImage(AControl).Width := getPixelByMm(cdsPrintTemplateitem.FieldByName('width')
          .AsInteger);
            TImage(AControl).Height := getPixelByMm(cdsPrintTemplateitem.FieldByName('height')
          .AsInteger);
            jpeg.Free;
          except on E: Exception do

          end;
          
        end;

      end;
      Caption := cdsPrintTemplateitem.FieldByName('title').AsString;
      Font.Name := cdsPrintTemplateitem.FieldByName('fontname').AsString;
      Font.Size := cdsPrintTemplateitem.FieldByName('fontsize').AsInteger;
      width := getPixelByMm(cdsPrintTemplateitem.FieldByName('width')
          .AsInteger);
      height := getPixelByMm(cdsPrintTemplateitem.FieldByName('height')
          .AsInteger);
      Left := getPixelByMm(cdsPrintTemplateitem.FieldByName('left').AsInteger+cdsPrintTemplate.FieldByName('left').AsInteger);
      top := getPixelByMm(cdsPrintTemplateitem.FieldByName('top').AsInteger+cdsPrintTemplate.FieldByName('top').AsInteger);
      if cdsPrintTemplateitem.FieldByName('valuetype').AsString <> '1' then
        Font.Color := clBlue
      else
        Font.Color := clBlack;
      if not cdsPrintTemplateitem.FieldByName('isprint').AsBoolean then
        Font.Style := Font.Style + [fsStrikeOut]
      else
        Font.Style := Font.Style - [fsStrikeOut];
    end;
  end;

  constructor TPrintTemplatePlan.Create(_cdsPrintTemplate,
    _cdsPrintTemplateitem: TCustomClientDataSet;
    _parentControl: TWinControl);
  begin
    // displayPx:=getdevicecaps(Self.Monitor.Handle,logpixelsx);
    // displayPy:=getdevicecaps(Self.Monitor.Handle,logpixelsy);
    inherited Create(_parentControl);
    Parent := _parentControl;
    bevelkind := bkFlat;
    BevelOuter := bvNone;
    displayPx := Screen.PixelsPerInch;
    displayPy := Screen.PixelsPerInch;
    cdsPrintTemplate := _cdsPrintTemplate;
    cdsPrintTemplateitem := _cdsPrintTemplateitem;
    Left := 0;
    top := 0;
    width := getPixelByMm(Max(2500,cdsPrintTemplate.FieldByName('width').AsInteger));
    height := getPixelByMm(cdsPrintTemplate.FieldByName('height').AsInteger);
    with cdsPrintTemplateitem do
    begin
      while not eof do
      begin
        createDisplayItem();
        next;
      end;
    end;
  end;

  procedure TPrintTemplatePlan.createDisplayItem();
  var HexStr : string;
  begin
    with self.cdsPrintTemplateitem do
    begin
      // 打印类型（0画线、1固定标题、2字符串、3大写数字、4小写数字、5日期时间、6-条形码、7-图片）字典
      if FieldByName('valuetype').AsString = '0' then
      begin
        setDisplayProperty(TBevel.Create(self));
      end
      else if FieldByName('valuetype').AsString = '6' then
      begin
        setDisplayProperty(TBarCode.Create(self));
      end
      else if FieldByName('valuetype').AsString = '7' then
         begin
             //HexStr := FieldByName('printpicture').AsString;
            //if (HexStr <> '') then
            //jpeg := HexStrToJpg(HexStr);
            //setDisplayProperty(TBitmap.Create);
           setDisplayProperty(TImage.Create(Self));
         end

      else
      begin
        setDisplayProperty(TLabel.Create(self));
      end;
    end;
  end;

  function TPrintTemplatePlan.getDisplayItemById(id: int64): TControl;
  begin
    Result := TControl(self.FindComponent(getComponentNameByid(id)));
  end;

  function TPrintTemplatePlan.getIdByComponentName(_name: String): int64;
  var tmpstr:string;
  begin
    tmpstr:=copy(_name, length(namePrefix) + 1,length(_name) - length(namePrefix));
    Result := StrToInt64(StringReplace(tmpstr, '_', '-', []));
  end;

  function TPrintTemplatePlan.locateCDSByDisplayItem(AControl: TControl)
    : integer;
  begin
    cdsPrintTemplateitem.Locate('id', getIdByComponentName(AControl.Name), [])
  end;

  procedure TPrintTemplatePlan.Paint;
  begin
    inherited;
    DrawBackGround();
  end;

  function TPrintTemplatePlan.getDisplayItemByCDS: TControl;
  begin
    Result := getDisplayItemById(cdsPrintTemplateitem.FieldByName('id')
        .AsInteger);
  end;

end.

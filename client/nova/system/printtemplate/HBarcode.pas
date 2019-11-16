// =============================================================================
//
// Barcode VCL Component
//
// For Delphi 4/5/6/7, C++ Builder 4/5/6, BDS 2005/2005, Turbo Delphi 2006
//
// Copyright (c) 2001, 2007  Han-soft Software, all rights reserved.
//
// $Rev: 44 $   $Id: HBarCode_src.pas 44 2007-01-16 01:16:04Z hanjy $
//
// =============================================================================

unit HBarCode;

interface

uses
  SysUtils, Classes, Graphics, Math, Printers, Windows;

{$I 'BarCode.inc'}

type
  TBCdata = record
    Name:string;
    num :Boolean;
  end;

  { Barcode Type }
  TBarType =
  (
    bcCode_2_5_interleaved,
    bcCode_2_5_industrial,
    bcCode_2_5_matrix,
    bcCode39,
    bcCode39Extended,
    bcCode128A,
    bcCode128B,
    bcCode128C,
    bcCode93,
    bcCode93Extended,
    bcCodeMSI,
    bcCodePostNet,
    bcCodeCodabar,
    bcCodeEAN8,
    bcCodeEAN13,
    bcCodeUPC_A,
    bcCodeUPC_E0,
    bcCodeUPC_E1,
    bcCodeUPC_Supp2,
    bcCodeUPC_Supp5,
    bcCodeEAN128A,
    bcCodeEAN128B,
    bcCodeEAN128C
  );

  TOrientation  = (toLeftRight, toRightLeft, toTopBottom, toBottomTop);

  TCheckSum     = (csNone, csModulo10);

  TTextShow     = (tsNone, tsBarCode, tsBarType, tsBoth);

  TTextPosition = (tpTopLeft, tpTopRight, tpTopCenter, tpBottomLeft,
    tpBottomRight, tpBottomCenter);

  TUnits        = (utMillimeter,utInch);

  TBarLineType  = (white, black, black_half);

const
  mmPerInch = 25.4;

  { Barcode name }
  BCData:array[bcCode_2_5_interleaved..bcCodeEAN128C] of TBCdata =
  (
    (Name:'Code25 interleaved'; num:True),
    (Name:'Code25 industrial';  num:True),
    (Name:'Code25 matrix';      num:True),
    (Name:'Code39';             num:False),
    (Name:'Code39 Extended';    num:False),
    (Name:'Code128A';           num:False),
    (Name:'Code128B';           num:False),
    (Name:'Code128C';           num:False),
    (Name:'Code93';             num:False),
    (Name:'Code93 Extended';    num:False),
    (Name:'MSI';                num:True),
    (Name:'PostNet';            num:True),
    (Name:'Codebar';            num:False),
    (Name:'EAN8';               num:True),
    (Name:'EAN13';              num:True),
    (Name:'UPC_A';              num:True),
    (Name:'UPC_E0';             num:True),
    (Name:'UPC_E1';             num:True),
    (Name:'UPC Supp2';          num:True),
    (Name:'UPC Supp5';          num:True),
    (Name:'EAN128A';            num:False),
    (Name:'EAN128B';            num:False),
    (Name:'EAN128C';            num:False)
  );

  { Draw barcode on canvas }
  procedure H_DrawBar(
          H_Canvas       : TCanvas;       //Canvas
    const H_BarType      : TBarType;      //Barcode type
    const H_BarCode      : string;        //Barcode value
    const H_Modul        : Integer;       //Width of thin bar
    const H_Ratio        : Double;        //Ratio of thin and thick bar
    const H_CheckSum     : TCheckSum;     //Algorithms of checksum
    const H_Left         : Integer;       //Left margin with form
    const H_Top          : Integer;       //Top margin with form
    const H_Height       : Integer;       //Barcode height
    const H_TextFont     : TFont;         //Font of brcode text to display
    const H_TextShow     : TTextShow;     //Content of barcode text to display
    const H_TextPosition : TTextPosition; //Position of barcode text
    const H_BarColor     : TColor;        //Color of bar
    const H_SpcColor     : TColor;        //Background Color of barcode
    const H_BackColor    : TColor;        //background Color of barcode text
    const H_Angle        : Double         //Angle of left rotate (degree)
    );


  { Get barcode width to display (pixels) }
  function  H_GetBarWidth(
    const BW_Type     : TBarType;         //Barcode type
    const BW_Code     : string;           //Barcode value
    const BW_Modul    : Integer;          //Width of thin bar (pixels)
    const BW_Ratio    : Double;           //Ratio of thick and thin bar
    const BW_CheckSum : TCheckSum         //Algorithms of checksum
    ) : Integer;

  { Get canvas width to display (pixels) }
  function H_GetCanvasWidth(
    const CW_Type      : TBarType;        //Barcode type
    const CW_Code      : string;          //Barcode value
    const CW_Modul     : Integer;         //Width of thin bar (pixels)
    const CW_Ratio     : Double;          //Ratio of thick and thin bar
    const CW_CheckSum  : TCheckSum;       //Algorithms of checksum
    const CW_Height    : Integer;         //Barcode height (pixels)
    const CW_Angle     : Double           //Angle of left rotate (degree)
    ): Integer;

  { Get Canvas height to display (pixels) }
  function H_GetCanvasHeight(
    const CH_Type      : TBarType;        //Barcode type
    const CH_Code      : string;          //Barcode value
    const CH_Modul     : Integer;         //Width of thin bar (pixels)
    const CH_Ratio     : Double;          //Ratio of thick and thin bar
    const CH_CheckSum  : TCheckSum;       //Algorithms of checksum
    const CH_Height    : Integer;         //Barcode height (pixels)
    const CH_Angle     : Double           //Angle of left rotate (degree)
    ):Integer;

  { Get barcode typename }
  function H_GetBarTypeName(
    const BN_BarType   : TBarType         //Barcode type
    ): string;

  { Print barcode }
  procedure H_PrintBar(
    const H_Unit           : TUnits;      //Unit of width and length (mm/inch)
    const H_BarType      : TBarType;      //Barcode type
    const H_BarCode      : string;        //Barcode value
    const H_Modul        : Double;        //Width of thin bar (mm/inch)
    const H_Ratio        : Double;        //Ratio of thick and thin bar
    const H_CheckSum     : TCheckSum;     //Algorithms of checksum
    const H_Left         : Double;        //Left margin from paper (mm/inch)
    const H_Top          : Double;        //Top margin from paper (mm/inch)
    const H_Height       : Double;        //Barcode height (mm/inch)
    const H_TextFont     : TFont;         //Font of brcode text to print
    const H_TextShow     : TTextShow;     //Content of barcode text to print
    const H_TextPosition : TTextPosition; //Position of barcode text
    const H_BarColor     : TColor;        //Color of bar
    const H_SpcColor     : TColor;        //Background color of barcode
    const H_BackColor    : TColor;        //Background color of barcode text
    const H_Angle        : Double         //Angle of left rotate (degree)
   );

  { Get basrcode width to print (mm/inch) }
  function H_GetPrnBarWidth(
    const BW_Unit      : TUnits;          //Unit of width and length (mm/inch)
    const BW_Type      : TBarType;        //Barcode type
    const BW_Code      : string;          //Barcode value
    const BW_Modul     : Double;          //Width of thin bar (mm/inch)
    const BW_Ratio     : Double;          //Ratio of thick and thin bar
    const BW_CheckSum  : TCheckSum        //Algorithms of checksum
   ):Double;

  { Get canvas width to print (mm/inch }
  function H_PrnCanvasWidth(
    const CW_Unit      : TUnits;          //Unit of width and length (mm/inch)
    const CW_Type      : TBarType;        //Barcode type
    const CW_Code      : string;          //Barcode value
    const CW_Modul     : Double;          //Width of thin bar (mm/inch)
    const CW_Ratio     : Double;          //Ratio of thick and thin bar
    const CW_CheckSum  : TCheckSum;       //Algorithms of checksum
    const CW_Height    : Double;          //Barcode height (mm/inch)
    const CW_Angle     : Double           //Angle of left rotate (degree)
    ):Double;
  
  { Get canvas height to print (mm/inch) }
  function H_PrnCanvasHeight(
    const CH_Unit      : TUnits;          //Unit of width and length (mm/inch)
    const CH_Type      : TBarType;        //Barcode type
    const CH_Code      : string;          //Barcode value
    const CH_Modul     : Double;          //Width of thin bar (mm/inch)
    const CH_Ratio     : Double;          //Ratio of thick and thin bar
    const CH_CheckSum  : TCheckSum;       //Algorithms of checksum
    const CH_Height    : Double;          //Barcode height (mm/inch)
    const CH_Angle     : Double           //Angle of left rotate (degree)
    ):Double;


implementation

var

  Modules : array[0..3] of shortint;


{*******************}
{   Internal Use    }
{*******************}

{$I BarFun.inc}
{$I BarDef.inc}

{ Make barcode data for display or print }
function MakeData(const MD_Type:TBarType; const MD_Code:string;
  const MD_Modul:Integer; var MD_Ratio:Double; const MD_CheckSum:TCheckSum;
  var MD_CheckNum:string) : string;
var
  i:   integer;
  bar: string;

begin
  { Modify ratio }
  case MD_Type of
    bcCode_2_5_interleaved,
    bcCode_2_5_industrial,
    bcCode39,
    bcCodeEAN8,
    bcCodeEAN13,
    bcCode39Extended,
    bcCodeCodabar,
    bcCodeUPC_A,
    bcCodeUPC_E0,
    bcCodeUPC_E1,
    bcCodeUPC_Supp2,
    bcCodeUPC_Supp5:
    begin
      if MD_Ratio < 2.0 then MD_Ratio := 2.0;
      if MD_Ratio > 3.0 then MD_Ratio := 3.0;
    end;

    bcCode_2_5_matrix:
    begin
      if MD_Ratio < 2.25 then MD_Ratio := 2.25;
      if MD_Ratio > 3.0 then MD_Ratio := 3.0;
    end;

    bcCode128A,
    bcCode128B,
    bcCode128C,
    bcCode93,
    bcCode93Extended,
    bcCodeMSI,
    bcCodePostNet: ;
  end;

  { Make modules }
  modules[0] := MD_Modul;
  modules[1] := Round(MD_Modul*MD_Ratio);
  modules[2] := modules[1] * 3 div 2;
  modules[3] := modules[1] * 2;

  { Check barcode }
  //bar := Trim(MD_Code);
  bar := MD_Code;
  if BCData[MD_Type].num then
  begin
    for i := 1 to Length(bar) do
      if (bar[i] > '9') or (bar[i] < '0') then
        raise Exception.CreateFmt('%s : %s', [bar,ErrorBarcode]);
  end;

  { Get barcode data }
  case MD_Type of
    bcCode_2_5_interleaved: Result := Code_2_5_interleaved(bar);
    bcCode_2_5_industrial:  Result := Code_2_5_industrial(bar);
    bcCode_2_5_matrix:      Result := Code_2_5_matrix(bar);
    bcCode39:               Result := Code_39(bar,MD_CheckSum);
    bcCode39Extended:       Result := Code_39Extended(bar,MD_CheckSum);
    bcCode128A,
    bcCode128B,
    bcCode128C,
    bcCodeEAN128A,
    bcCodeEAN128B,
    bcCodeEAN128C:          Result := Code_128(MD_Type,bar,MD_CheckSum,
      MD_CheckNum);
    bcCode93:               Result := Code_93(bar);
    bcCode93Extended:       Result := Code_93Extended(bar);
    bcCodeMSI:              Result := Code_MSI(bar);
    bcCodePostNet:          Result := Code_PostNet(bar);
    bcCodeCodabar:          Result := Code_Codabar(bar);
    bcCodeEAN8:             Result := Code_EAN8(bar,MD_CheckSum);
    bcCodeEAN13:            Result := Code_EAN13(bar,MD_CheckSum);
    bcCodeUPC_A:            Result := Code_UPC_A(bar,MD_CheckSum,MD_CheckNum);
    bcCodeUPC_E0:           Result := Code_UPC_E0(bar,MD_CheckSum,MD_CheckNum);
    bcCodeUPC_E1:           Result := Code_UPC_E1(bar,MD_CheckSum,MD_CheckNum);
    bcCodeUPC_Supp2:        Result := Code_Supp2(bar,MD_CheckSum,MD_CheckNum);
    bcCodeUPC_Supp5:        Result := Code_Supp5(bar,MD_CheckSum,MD_CheckNum);
  else
    raise Exception.CreateFmt('%s',[ErrorBarType]);
  end;
end;

{ Get barcode line data }
procedure OneBarProps(const code:char; var Width:integer; var lt:TBarLineType);
begin
  case code of
    '0': begin width := modules[0]; lt := white; end;
    '1': begin width := modules[1]; lt := white; end;
    '2': begin width := modules[2]; lt := white; end;
    '3': begin width := modules[3]; lt := white; end;

    '5': begin width := modules[0]; lt := black; end;
    '6': begin width := modules[1]; lt := black; end;
    '7': begin width := modules[2]; lt := black; end;
    '8': begin width := modules[3]; lt := black; end;

    'A': begin width := modules[0]; lt := black_half; end;
    'B': begin width := modules[1]; lt := black_half; end;
    'C': begin width := modules[2]; lt := black_half; end;
    'D': begin width := modules[3]; lt := black_half; end;
  else
    begin
      raise Exception.CreateFmt('%s', [ErrorInternal]);
    end;
  end;
end;

{ Display barcode }
procedure DoLines(const DL_Data:string; const DL_Canvas:TCanvas;
  const DL_BColor:TColor;  const DL_SColor:TColor; const DL_Left:Integer;
  const DL_Top:Integer;    const DL_Width:Integer;  const DL_Height:Integer;
  const DL_Angle:Double);
var
  i:integer;
  lt : TBarLineType;
  xadd:integer;
  width, height:integer;
  ystart:integer;  //2004-02-20
  a,b,c,d,
  orgin : TPoint;
  alpha:double;

 begin
  xadd := 0;
  orgin.x := DL_Left;
  orgin.y := DL_Top;

  alpha := DL_Angle/180.0*pi;

  orgin := TranslateQuad2D(alpha,orgin,Point(DL_Width,DL_Height));

  with DL_Canvas do begin
    Pen.Width := 1;

   for i:=1 to Length(DL_Data) do
    begin
      OneBarProps(DL_Data[i], width, lt);

      if (lt = black) or (lt = black_half) then
      begin
        Pen.Color := DL_BColor;
      end
      else
      begin
        Pen.Color := DL_SColor;
      end;
      Brush.Color := Pen.Color;
      {
      if lt = black_half then
        height := DL_Height * 2 div 5
      else
        height := DL_Height;

      a.x := xadd;
      a.y := 0;

      b.x := xadd;
      b.y := height;

      c.x := xadd+Width-1;
      c.y := height;

      d.x := xadd+Width-1;
      d.y := 0;
      }
      {New For PostNet}
      height := DL_Height;
      if lt = black_half then
        ystart := DL_Height * 3 div 5
      else
        ystart := 0;

      a.x := xadd;
      a.y := ystart;

      b.x := xadd;
      b.y := height;

      c.x := xadd+Width-1;
      c.y := height;

      d.x := xadd+Width-1;
      d.y := ystart;

      a := Translate2D(Rotate2D(a, alpha), orgin);
      b := Translate2D(Rotate2D(b, alpha), orgin);
      c := Translate2D(Rotate2D(c, alpha), orgin);
      d := Translate2D(Rotate2D(d, alpha), orgin);

      Polygon([a,b,c,d]);

      xadd := xadd + width;
    end;
  end;
end;

{ Display text }
procedure DoText(const DT_Text:string; const DT_Canvas:TCanvas;
  const DT_Color:TColor; const DT_Font:TFont; const DT_Left:Integer;
  const DT_Top:Integer; const DT_Width:Integer; const DT_Height:Integer;
  const DT_Angle:Double; const DT_TextPosition:TTextPosition);
var
  m_LF:LOGFONT;
  NewFont: HGDIOBJ;
  OrgFont: HGDIOBJ;
  orgin, P:   TPoint;
  Alpha:      Double;
  A : Integer;
begin
  DT_Canvas.Font.Assign(DT_Font);
  orgin.x := DT_Left;
  orgin.y := DT_Top;
  Alpha := DT_Angle/180.0*pi;
  orgin := TranslateQuad2D(Alpha,orgin,Point(DT_Width, DT_Height));
  p := Point(0,0);
  if DT_TextPosition in [tpTopLeft, tpBottomLeft] then
    p.X := 0
  else
    if DT_TextPosition in [tpTopRight, tpBottomRight] then
      p.X := DT_Width - DT_Canvas.TextWidth(DT_Text) - 1
    else
      p.X := Trunc((DT_Width - DT_Canvas.TextWidth(DT_Text))/2);

  if DT_TextPosition in [tpTopLeft, tpTopCenter, tpTopRight] then
    p.Y := 0
  else
    p.Y := DT_Height - DT_Canvas.TextHeight(DT_Text) ;
  p := Translate2D(Rotate2D(p, alpha), orgin);

  {Adjust text position}
  A := Round(DT_Angle) mod 360;
  if ((A<=45) or (A>315)) and
    (DT_TextPosition in [tpBottomLeft, tpBottomCenter, tpBottomRight]) then
    Inc(p.Y);
  if ((A<=45) or (A>315)) and
    (DT_TextPosition in [tpBottomRight, tpTopRight]) then
    Inc(p.X);
  if (A>135) and (A<=225) and
    (DT_TextPosition in [tpTopLeft, tpTopCenter, tpTopRight]) then
    Inc(p.Y);
  if (A>225) and (A<=315) then
    Inc(p.X);

  GetObject(DT_Canvas.Font.Handle,SizeOf(m_LF),Addr(m_LF));
  m_LF.lfEscapement:= Round(DT_Angle*10);
  m_LF.lfOrientation:= Round(DT_Angle*10);
  m_LF.lfOutPrecision := 0;
  NewFont := CreateFontIndirect(m_LF);
  OrgFont := SelectObject(DT_Canvas.Handle,NewFont);
  try
    DT_Canvas.Brush.Style := bsClear;
    DT_Canvas.Brush.Color := DT_Color;
    DT_Canvas.TextOut(p.X,p.Y,DT_Text);
  finally
    NewFont := SelectObject(DT_Canvas.Handle,OrgFont);
    DeleteObject(NewFont);
  end;
end;

{*******************}
{    For Display    }
{*******************}

{ Draw barcode and text }
procedure H_DrawBar(H_Canvas:TCanvas; const H_BarType:TBarType;
  const H_BarCode:string;const H_Modul:Integer;const H_Ratio:Double;
  const H_CheckSum:TCheckSum;const H_Left:Integer;const H_Top:Integer;
  const H_Height:Integer;const H_TextFont:TFont;const H_TextShow:TTextShow;
  const H_TextPosition:TTextPosition;const H_BarColor:TColor;
  const H_SpcColor:TColor;const H_BackColor:TColor;const H_Angle:Double);
var
  data, text : string;
  SaveFont: TFont;
  SavePen: TPen;
  SaveBrush: TBrush;
  CheckNum: string;
  rRatio: Double;
  bWdt  : Integer;
begin
  Savefont  := TFont.Create;
  SavePen   := TPen.Create;
  SaveBrush := TBrush.Create;
  CheckNum  := H_BarCode;
  rRatio    := H_Ratio;

  data := MakeData(H_BarType, H_BarCode, H_Modul, rRatio, H_CheckSum, CheckNum);
  bWdt := H_GetBarWidth(H_BarType, H_BarCode, H_Modul, rRatio, H_CheckSum);

  try
    Savefont.Assign(H_Canvas.Font);
    SavePen.Assign(H_Canvas.Pen);
    SaveBrush.Assign(H_Canvas.Brush);

    DoLines(data, H_Canvas, H_BarColor, H_SpcColor, H_Left, H_Top, bWdt,
      H_Height, H_Angle);

    if H_TextShow <> tsNone then
    begin
      case H_TextShow of
        tsBarCode: text := CheckNum;
        tsBarType: text := H_GetBarTypeName(H_BarType);
        tsBoth:    text := H_GetBarTypeName(H_BarType) + ' ' + CheckNum;
      end;
      DoText(text, H_Canvas, H_BackColor, H_TextFont, H_Left, H_Top, bWdt,
        H_Height, H_Angle, H_TextPosition);
    end;

    H_Canvas.Font.Assign(savefont);
    H_Canvas.Pen.Assign(SavePen);
    H_Canvas.Brush.Assign(SaveBrush);
  finally
    Savefont.Free;
    SavePen.Free;
    SaveBrush.Free;
  end;
end;

{ Get barcode display width in pixels }
function  H_GetBarWidth(const BW_Type:TBarType; const BW_Code:string;
  const BW_Modul:Integer; const BW_Ratio:Double;
  const BW_CheckSum:TCheckSum) : Integer;
var
  data,tmp : string;
  i,w  : integer;
  lt : TBarLineType;
  r  : Double;
begin
  r := BW_Ratio;
  Result := 0;
  data := MakeData(BW_Type,BW_Code,BW_Modul,r,BW_CheckSum,tmp);
  for i:=1 to Length(data) do
  begin
    OneBarProps(data[i], w, lt);
    Inc(Result, w);
  end;
end;

{ Get name of barcode type }
function H_GetBarTypeName(const BN_BarType:TBarType): string;
begin
  result := BCData[BN_BarType].Name;
end;

{ Get canvas height in pixels for display }
function H_GetCanvasHeight(const CH_Type:TBarType; const CH_Code:string;
  const CH_Modul:Integer; const CH_Ratio:Double; const CH_CheckSum:TCheckSum;
  const CH_Height:Integer; const CH_Angle:Double): Integer;
var
  alpha :Extended;
begin
  alpha := CH_Angle/180.0*pi;
  Result := Round(abs(cos(alpha))*H_GetBarWidth(CH_Type, CH_Code, CH_Modul,
    CH_Ratio,CH_CheckSum) + abs(sin(alpha))*CH_Height + 0.5);
end;

{ Get canvas width in pixels for display }
function H_GetCanvasWidth(const CW_Type:TBarType; const CW_Code:string;
  const CW_Modul:Integer; const CW_Ratio:Double; const CW_CheckSum:TCheckSum;
  const CW_Height:Integer; const CW_Angle:Double): Integer;
var
  alpha :Extended;
begin
  alpha := CW_Angle/180.0*pi;
  Result := Round(abs(sin(alpha))*H_GetBarWidth(CW_Type, CW_Code, CW_Modul,
    CW_Ratio, CW_CheckSum) + abs(cos(alpha))*CW_Height + 0.5);
end;

{*******************}
{     For Print     }
{*******************}

{ Print barcode to default printer }
procedure H_PrintBar(const H_Unit:TUnits; const H_BarType:TBarType;
  const H_BarCode:string; const H_Modul:Double; const H_Ratio:Double;
  const H_CheckSum:TCheckSum; const H_Left:Double; const H_Top:Double;
  const H_Height:Double; const H_TextFont:TFont; const H_TextShow:TTextShow;
  const H_TextPosition:TTextPosition; const H_BarColor:TColor;
  const H_SpcColor:TColor; const H_BackColor:TColor; const H_Angle:Double);
var
  l,t,h,m: Integer;
begin
  //printer.BeginDoc;
  case H_Unit of
    utMillimeter:
      begin
        l := ConvertMMtoPixelsX(H_Left);
        t := ConvertMMtoPixelsY(H_Top);
        h := ConvertMMtoPixelsY(H_Height);
        m := ConvertMMtoPixelsX(H_Modul);
      end;
    utInch:
      begin
        l := ConvertInchtoPixelsX(H_Left);
        t := ConvertInchtoPixelsY(H_Top);
        h := ConvertInchtoPixelsY(H_Height);
        m := ConvertInchtoPixelsX(H_Modul);
      end;
  else
    l := Round(H_Left);
    t := Round(H_Top);
    h := Round(H_Height);
    m := Round(H_Modul);
  end;
  H_DrawBar(Printer.Canvas, H_BarType, H_BarCode, m, H_Ratio, H_CheckSum,
    l, t, h, H_TextFont, H_TextShow, H_TextPosition, H_BarColor, H_SpcColor,
    H_BackColor, H_Angle);
  //printer.EndDoc;
end;

{ Get barcode width in millimeter or inch for print }
function  H_GetPrnBarWidth(const BW_Unit:TUnits; const BW_Type:TBarType;
  const BW_Code:string; const BW_Modul:Double; const BW_Ratio:Double;
  const BW_CheckSum:TCheckSum) : Double;
var
  m: Integer;
begin
  case BW_Unit of
    utMillimeter:
    begin
      m := ConvertMMtoPixelsX(BW_Modul);
      result := ConvertPixelstoMMX(H_GetBarWidth(BW_Type, BW_Code, m,
        BW_Ratio, BW_CheckSum));
    end;
    utInch:
    begin
      m := ConvertInchtoPixelsX(BW_Modul);
      result := ConvertPixelstoInchX(H_GetBarWidth(BW_Type, BW_Code, m,
        BW_Ratio, BW_CheckSum));
    end;
    else
      result := -1;
  end;
end;

{ Get canvas width in millimeter or inch for print }
function H_PrnCanvasWidth(const CW_Unit:TUnits; const CW_Type:TBarType;
  const CW_Code:string; const CW_Modul:Double; const CW_Ratio:Double;
  const CW_CheckSum:TCheckSum; const CW_Height:Double;
  const CW_Angle:Double):  Double;
var
  m, h: Integer;
begin
  case CW_Unit of
    utMillimeter:
    begin
      m := ConvertMMtoPixelsX(CW_Modul);
      h := ConvertMMtoPixelsX(CW_Height);
      result := ConvertPixelstoMMX(H_GetCanvasWidth(CW_Type, CW_Code, m,
        CW_Ratio, CW_CheckSum, h, CW_Angle));
    end;
    utInch:
    begin
      m := ConvertInchtoPixelsX(CW_Modul);
      h := ConvertInchtoPixelsX(CW_Height);
      result := ConvertPixelstoInchX(H_GetCanvasWidth(CW_Type, CW_Code, m,
        CW_Ratio, CW_CheckSum, h, CW_Angle));
    end;
    else
      result := -1;
  end;
end;

{ Get canvas height in millimeter or inch for print }
function H_PrnCanvasHeight(const CH_Unit:TUnits; const CH_Type:TBarType;
  const CH_Code:string; const CH_Modul:Double; const CH_Ratio:Double;
  const CH_CheckSum:TCheckSum; const CH_Height:Double;
  const CH_Angle:Double): Double;
var
  m, h: Integer;
begin
  case CH_Unit of
    utMillimeter:
    begin
      m := ConvertMMtoPixelsX(CH_Modul);
      h := ConvertMMtoPixelsX(CH_Height);
      result := ConvertPixelstoMMY(H_GetCanvasHeight(CH_Type, CH_Code, m,
        CH_Ratio, CH_CheckSum, h, CH_Angle));
    end;
    utInch:
    begin
      m := ConvertInchtoPixelsX(CH_Modul);
      h := ConvertInchtoPixelsX(CH_Height);
      result := ConvertPixelstoInchY(H_GetCanvasHeight(CH_Type, CH_Code, m,
        CH_Ratio, CH_CheckSum, h, CH_Angle));
    end;
    else
      result := -1;
  end;
end;

end.






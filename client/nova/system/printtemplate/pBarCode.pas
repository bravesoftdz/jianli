// =============================================================================
//
// Barcode VCL Component
//
// For Delphi 4/5/6/7, C++ Builder 4/5/6, BDS 2005/2005, Turbo Delphi 2006
//
// Copyright (c) 2001, 2007  Han-soft Software, all rights reserved.
//
// $Rev: 44 $   $Id: pBarCode.pas 44 2007-01-16 01:16:04Z hanjy $
//
// =============================================================================

unit pBarCode;

interface

uses
  SysUtils, Classes, Controls, ExtCtrls,  Graphics, WinTypes, Forms, Math,
  Windows, HBarCode;

{$I 'BarCode.inc'}

type

  TInvalidChar = procedure(Sender: TObject; var Barcode: string) of object;

  TBarCode = class(TCustomPanel)
  private
    { Private declarations }
    FBarCode        : string;           //Barcode value
    FBarType        : TBarType;         //Barcode Type
    FBarHeight      : Integer;          //Barcode Height
    FModul          : Integer;          //Width of thin bar
    FRatio          : Double;           //Ratio of thick and thin bar
    FCheckSum       : TCheckSum;        //Algorithms of checksum
    FColorSpc       : TColor;           //Background color
    FColorBar       : TColor;           //Bar color
    FOrientation    : TOrientation;     //Orientation of barcode
    FTextShow       : TTextShow;        //Content of barcode text to display
    FTextPosition   : TTextPosition;    //Position of barcode text to display
    FTextColor      : TColor;           //Background color of text to display
    FHMargin        : Integer;          //Left and right margin when auto width
    FAutoWidth      : Boolean;
    FOnChange       : TNotifyEvent;
    FOnInvalidChar  : TInvalidChar;

    function  GetAngle:Double;
    procedure SetBarType(const Value: TBarType);
    procedure SetBarHeight(const Value: Integer);
    procedure SetModul(const Value: Integer);
    procedure SetRatio(const Value: Double);
    procedure SetCheckSum(const Value: TCheckSum);
    procedure SetColorSpc(const Value: TColor);
    procedure SetColorBar(const Value: TColor);
    procedure SetOrientation(const Value: TOrientation);
    procedure SetTextShow(const Value: TTextShow);
    procedure SetTextPosition(const Value: TTextPosition);
    procedure SetTextColor(const Value: TColor);
    procedure SetHMargin(const Value: Integer);
    procedure SetAutoWidth(const Value: Boolean);
    function  GetBarTypeName: string;
    procedure SetAbout(const Value: string);
    function  GetAbout:string;
  protected
    { Protected declarations }
    procedure SetBarcode(const Value: string); virtual;
    procedure DoChange; virtual;
  public
    { Public declarations }
    constructor Create(Owner:TComponent); override;
    destructor  Destroy; override;

    procedure Assign(Source: TPersistent);override;
    procedure Paint;override;
    function  AutoSetWidth(H_Margin: Integer): Integer;

    { Display }
    procedure Draw(DCanvas:TCanvas; const DLeft:Integer; const DTop:Integer;
      const DHeight:Integer; const DAngle:Double);overload;
    procedure Draw(DCanvas:TCanvas; const DLeft:Integer; const DTop:Integer;
      const DHeight:Integer);overload;
    function  GetBarWidth: Integer;
    function  GetBarHeight: Integer;
    function  GetCanvasHeight(const DHeight:Integer;
      const DAngle:Double): Integer;overload;
    function  GetCanvasWidth(const DHeight:Integer;
      const DAngle:Double): Integer;overload;
    function  GetCanvasHeight(const DHeight:Integer): Integer;overload;
    function  GetCanvasWidth(const DHeight:Integer): Integer;overload;

    { Print }
    procedure Print(const DUnit:TUnits; const DLeft:Double; const DTop:Double;
      const DHeight:Double; const DModul:Double; const DAngle:Double);overload;
    procedure Print(const DUnit:TUnits; const DLeft:Double; const DTop:Double;
      const DHeight:Double; const DModul:Double);overload;
    function  GetPrnBarWidth(const DUnit:TUnits; const DModul:Double): Double;
    function  GetPrnCanvasHeight(const DUnit:TUnits; const DHeight:Double;
      const DModul:Double; const DAngle:Double): Double;overload;
    function  GetPrnCanvasWidth(const DUnit:TUnits; const DHeight:Double;
      const DModul:Double; const DAngle:Double): Double;overload;
    function  GetPrnCanvasHeight(const DUnit:TUnits; const DHeight:Double;
      const DModul:Double): Double;overload;
    function  GetPrnCanvasWidth(const DUnit:TUnits; const DHeight:Double;
      const DModul:Double): Double;overload;

    {HBarCode}
    procedure H_DrawBar(
            H_Canvas       : TCanvas;       //Canvas
      const H_BarType      : TBarType;      //Barcode type
      const H_BarCode      : string;        //Barcode value
      const H_Modul        : Integer;       //Width of thin bar (pixels)
      const H_Ratio        : Double;        //Ratio of thick and thin bar
      const H_CheckSum     : TCheckSum;     //Algorithms of checksum
      const H_Left         : Integer;       //Left margin with form (pixels)
      const H_Top          : Integer;       //Top margin with form (pixels)
      const H_Height       : Integer;       //Barcode height (pixels)
      const H_TextFont     : TFont;         //Font of brcode text to display
      const H_TextShow     : TTextShow;     //Content of barcode text to display
      const H_TextPosition : TTextPosition; //Position of barcode text
      const H_BarColor     : TColor;        //Color of bar
      const H_SpcColor     : TColor;        //Background Color of barcode
      const H_BackColor    : TColor;        //Background Color of barcode text
      const H_Angle        : Double         //Angle of left rotate (degree)
      );

    function  H_GetBarWidth(
      const BW_Type     : TBarType;         //Barcode type
      const BW_Code     : string;           //Barcode value
      const BW_Modul    : Integer;          //Width of thin bar (pixels)
      const BW_Ratio    : Double;           //Ratio of thick and thin bar
      const BW_CheckSum : TCheckSum         //Algorithms of checksum
      ) : Integer;

    function H_GetCanvasWidth(
      const CW_Type      : TBarType;        //Barcode type
      const CW_Code      : string;          //Barcode value
      const CW_Modul     : Integer;         //Width of thin bar (pixels)
      const CW_Ratio     : Double;          //Ratio of thick and thin bar
      const CW_CheckSum  : TCheckSum;       //Algorithms of checksum
      const CW_Height    : Integer;         //Barcode height (pixels)
      const CW_Angle     : Double           //Angle of left rotate (degree)
      ): Integer;

    function H_GetCanvasHeight(
      const CH_Type      : TBarType;        //Barcode type
      const CH_Code      : string;          //Barcode value
      const CH_Modul     : Integer;         //Width of thin bar (pixels)
      const CH_Ratio     : Double;          //Ratio of thick and thin bar
      const CH_CheckSum  : TCheckSum;       //Algorithms of checksum
      const CH_Height    : Integer;         //Barcode height (pixels)
      const CH_Angle     : Double           //Angle of left rotate (degree)
      ):Integer;

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

    function H_GetPrnBarWidth(
      const BW_Unit      : TUnits;          //Unit of width and length (mm/inch)
      const BW_Type      : TBarType;        //Barcode type
      const BW_Code      : string;          //Barcode value
      const BW_Modul     : Double;          //Width of thin bar (mm/inch)
      const BW_Ratio     : Double;          //Ratio of thick and thin bar
      const BW_CheckSum  : TCheckSum        //Algorithms of checksum
      ):Double;

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

    function H_GetBarTypeName(
      const BN_BarType   : TBarType         //Barcode type
      ): string;

    property  BarTypeName  :string  read GetBarTypeName;
    property  BarWidth     :Integer read GetBarWidth;
    property  DockManager;
  published
    { Published declarations }
    property BarType: TBarType read FBarType write SetBarType
      default bcCode39;
    property BarCode: string read FBarCode write SetBarCode;
    property BarHeight:Integer   read FBarHeight write SetBarHeight default 0;
    property Modul    :Integer    read FModul    write SetModul;
    property Ratio    :Double     read FRatio    write SetRatio;
    property CheckSum:TCheckSum read FCheckSum write SetCheckSum default csNone;
    property ColorSpc:TColor  read FColorSpc write SetColorSpc default clWhite;
    property ColorBar:TColor  read FColorBar write SetColorBar default clBlack;
    property Orientation:TOrientation read FOrientation write SetOrientation
      default toLeftRight;
    property TextShow:TTextShow read FTextShow write SetTextShow default tsNone;
    property TextPosition:TTextPosition read FTextPosition write SetTextPosition
      default tpBottomCenter;
    property TextColor:TColor read FTextColor write SetTextColor
      default clWhite;
    property AutoWidth: Boolean read FAutoWidth write SetAutoWidth default False;
    property HMargin: Integer read FHMargin write SetHMargin default 0;
    property About: string read GetAbout write SetAbout;
    property OnChange: TNotifyEvent read FOnChange     write FOnChange;
    property OnInvalidChar: TInvalidChar read FOnInvalidChar write FOnInvalidChar;

    property Align;
    property Alignment;
    property Anchors;
    property AutoSize;
    property BevelInner;
    property BevelOuter;
    property BevelWidth;
    property BiDiMode;
    property BorderWidth;
    property BorderStyle;
    property Color;
    property Constraints;
    property Ctl3D;
    property UseDockManager default True;
    property DockSite;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property FullRepaint;
    property Font;
    property Locked;
    property ParentBiDiMode;
{$IFDEF VER150}
    property ParentBackground;
{$ENDIF}
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnCanResize;
    property OnClick;
    property OnConstrainedResize;
{$IFNDEF VER120}
  {$IFNDEF VER125}
    property OnContextPopup;
  {$ENDIF}  
{$ENDIF}
    property OnDockDrop;
    property OnDockOver;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGetSiteInfo;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDock;
    property OnStartDrag;
    property OnUnDock;
  end;

implementation

{ Create method }
constructor TBarCode.Create(Owner:TComponent);
begin
  inherited Create(owner);
  FOrientation  := toLeftRight;
  FModul        := 1;
  FRatio        := 2.0;
  FColorSpc     := clWhite;
  FColorBar     := clBlack;
  FBarCode      := '';
  FBarType      := bcCode39;
  FBarHeight    := 0;
  FCheckSum     := csNone;
  FTextColor    := clWhite;
  FTextShow     := tsNone;
  FTextPosition := tpBottomCenter;
  FHMargin      := 0;
  Caption       := '';
end;

{ Destroy method }
destructor TBarCode.Destroy;
begin
  inherited;
end;

{ Assign method }
procedure TBarCode.Assign(Source: TPersistent);
var
   BSource : TBarCode;
begin
  if Source is TBarCode then
  begin
    inherited;
    BSource       := TBarCode(Source);
    FOrientation  := BSource.FOrientation;
    FModul        := BSource.FModul;
    FRatio        := BSource.FRatio;
    FColorSpc     := BSource.FColorSpc;
    FColorBar     := BSource.FColorBar;
    FBarType      := BSource.FBarType;
    FBarCode      := BSource.FBarCode;
    FBarHeight    := BSource.FBarHeight;
    FCheckSum     := BSource.FCheckSum;
    FTextColor    := BSource.FTextColor;
    FTextShow     := BSource.FTextShow;
    FTextPosition := BSource.FTextPosition;
    FHMargin      := BSource.FHMargin;
    FOnChange     := BSource.FOnChange;
  end;
end;

{ Paint method }
procedure TBarCode.Paint;
var
  Angle: Double;
  x,y,h: Integer;
  BW: Integer;
  SG: Integer;
begin
  inherited;
  BW := BorderWidth;
  if BevelInner <> bvNone then BW := BW + BevelWidth;
  if BevelOuter <> bvNone then BW := BW + BevelWidth;
  if BorderStyle = bsNone then SG := 0 else if Ctl3D then SG := 4 else SG := 2;

  if FAutoWidth then AutoSetWidth(FHMargin);

  x := 0;
  y := 0;
  h := 0;
  Angle := 0;
  Case FOrientation of
    toLeftRight :
    begin
      if FBarHeight = 0 then h := Height - 2*BW - SG - 1 else h := FBarHeight;
      Angle := 0;
      if Alignment = taLeftJustify then
       x := BW
      else
        if Alignment = taRightJustify then
          x := Width - BW - SG - GetBarWidth
        else
          x := (Width - SG - GetBarWidth) div 2;
      y := (Height - h - SG) div 2;
    end;
    toRightLeft :
    begin
      if FBarHeight = 0 then h := Height - 2*BW - SG - 1 else h := FBarHeight;
      Angle := 180;
      if Alignment = taLeftJustify then
       x := BW - 1
      else
        if Alignment = taRightJustify then
          x := Width - BW - SG - GetBarWidth - 1
        else
          x := (Width - SG - GetBarWidth) div 2;
      y := (Height - h - SG) div 2;
    end;
    toTopBottom:
    begin
      if FBarHeight = 0 then h := Width - 2*BW - SG - 1  else h := FBarHeight;
      Angle := 270;
      if Alignment = taLeftJustify then
       y := BW
      else
        if Alignment = taRightJustify then
          y := Height - BW - SG - GetBarWidth
        else
          y := (Height - SG - GetBarWidth) div 2;
      x := (Width - h - SG) div 2;
    end;
    toBottomTop:
    begin
      if FBarHeight = 0 then h := Width - 2*BW - SG - 1  else h := FBarHeight;
      Angle := 90;
      if Alignment = taLeftJustify then
       y := BW - 1
      else
        if Alignment = taRightJustify then
          y := Height - BW - SG - GetBarWidth - 1
        else
          y := (Height - SG - GetBarWidth) div 2;
      x := (Width - h - SG) div 2;
    end;
  end;
  //if FAutoWidth then AutoSetWidth(FHMargin);
  H_DrawBar(Canvas,FBarType,FBarCode,FModul,FRatio,FCheckSum,x,y,h,Font,
      FTextShow,FTextPosition,FColorBar,FColorSpc,FTextColor,Angle);
end;

{ OnChange Event }
procedure TBarCode.DoChange;
begin
 Paint;
 if Assigned(FOnChange) then
   FOnChange(Self);
end;

{ Auto adjust width method }
function TBarCode.AutoSetWidth(H_Margin: Integer): Integer;
var
  BW,SG: Integer;
begin
  BW := BorderWidth;
  if BevelInner <> bvNone then BW := BW + BevelWidth;
  if BevelOuter <> bvNone then BW := BW + BevelWidth;
  if BorderStyle = bsNone then SG := 0 else if Ctl3D then SG := 4 else SG := 2;
  result := GetBarWidth + 2 * (BW + SG + H_Margin);
  if FOrientation in [toLeftRight, toRightLeft] then
    Width := result
  else
    Height := result;
end;

{ Get barcode angle of left rotate }
function TBarCode.GetAngle:Double;
begin
  Case FOrientation of
    toLeftRight : result := 0;
    toRightLeft : result := 180;
    toTopBottom : result := 270;
    toBottomTop : result := 90;
    else
      result := 0;
  end ;
end;

{ Set HMargin }
procedure TBarCode.SetHMargin(const Value: Integer);
begin
  if Value <> FHMargin then
  begin
    FHMargin := Value;
    if FAutoWidth then DoChange;
  end;
end;

{ Get barcode width }
function TBarCode.GetBarWidth: Integer;
begin
    result := H_GetBarWidth(FBarType,FBarCode,FModul,FRatio,FCheckSum);
  end;

{ Set barcode value }
procedure TBarCode.SetBarcode(const Value: string);
label
  CheckAgain, TryAgain;
var
  tmp: string;
  chk: Boolean;
  i: Integer;
  NewValue: string;
begin
  if Value <> FBarCode then
  begin
    NewValue := Value;
    if BCdata[FBarType].num then
    begin
      CheckAgain:
      tmp := Trim(NewValue);
      chk := False;
      for i := 1 to Length(tmp) do
        chk := chk or ((tmp[i] > '9') or (tmp[i] < '0'));
      if chk then
      begin
        if Assigned(FOnInvalidChar) then FOnInvalidChar(Self, NewValue);
        if NewValue = Value then
          raise Exception.CreateFmt('%s: %s', [Value, ErrorBarcode])
        else
          goto CheckAgain;
      end
      else
        FBarCode := NewValue;
      DoChange;
    end
    else
    begin
      TryAgain:
      chk := False;
      try
        FBarCode := NewValue;
        DoChange;
      except
        if Assigned(FOnInvalidChar) then FOnInvalidChar(Self, NewValue);
        if NewValue = Value then
          raise Exception.CreateFmt('%s: %s', [Value, ErrorBarcode])
        else
          chk := True;
      end;
      if chk then goto TryAgain;
    end;
  end;
end;

{ Set barcode type }
procedure TBarCode.SetBarType(const Value: TBarType);
begin
  if Value <> FBarType then
  try
    FBarType := Value;
    DoChange;
  except
    if Assigned(FOnInvalidChar) then FOnInvalidChar(Self, FBarcode) else raise;
  end;
end;

{ Set barcode height }
procedure TBarCode.SetBarHeight(const Value: Integer);
var
  HeightLimt: Integer;
  BW,SG: Integer;
begin
  BW := BorderWidth;
  if BevelInner <> bvNone then BW := BW + BevelWidth;
  if BevelOuter <> bvNone then BW := BW + BevelWidth;
  if BorderStyle = bsNone then SG := 0 else if Ctl3D then SG := 4 else SG := 2;

  if FOrientation in [toTopBottom, toBottomTop] then
    HeightLimt := Width - BW * 2 - SG - 1
  else
    HeightLimt := Height - BW * 2 - SG - 1;

  if Value <> FBarHeight then
  begin
    if (Value >= 0) and (Value <= HeightLimt) then
      FBarHeight := Value
    else
      FBarHeight := 0;
    DoChange;
  end;
end;

{ Get barcode height }
function  TBarCode.GetBarHeight: Integer;
var
  BW,SG: Integer;
begin
  BW := BorderWidth;
  if BevelInner <> bvNone then BW := BW + BevelWidth;
  if BevelOuter <> bvNone then BW := BW + BevelWidth;
  if BorderStyle = bsNone then SG := 0 else if Ctl3D then SG := 4 else SG := 2;

  if FOrientation in [toTopBottom, toBottomTop] then
    Result := Width - BW * 2 - SG - 1
  else
    Result := Height - BW * 2 - SG - 1;

  if (FBarHeight > 0) and (FBarHeight < Result) then
    Result := FBarHeight
  else
    FBarHeight := 0;
end;

{ Set barcode Algorithms of checksum }
procedure TBarCode.SetCheckSum(const Value: TCheckSum);
begin
  if Value <> FCheckSum then
  begin
     FCheckSum := Value;
     DoChange;
  end;
end;

{ Set ratio of thick and thin bar }
procedure TBarCode.SetRatio(const Value: Double);
begin
  if Value <> FRatio then
  begin
     FRatio := Value;
     DoChange;
  end;
end;

{ Set color of bar }
procedure TBarCode.SetColorBar(const Value: TColor);
begin
  if Value <> FColorBar then
  begin
     FColorBar := Value;
     DoChange;
  end;
end;

{ Set background color of barcode }
procedure TBarCode.SetColorSpc(const Value: TColor);
begin
  if Value <> FColorSpc then
  begin
     FColorSpc := Value;
     DoChange;
  end;
end;

{ Set width of thin bar }
procedure TBarCode.SetModul(const Value: Integer);
begin
  if Value <> FModul then
  begin
    if (Value >= 1) and (Value < 50) then
    begin
      FModul := Value;
      DoChange;
    end;
  end;
end;

{ Set Orientation of barcode }
procedure TBarCode.SetOrientation(const Value: TOrientation);
begin
  if Value <> FOrientation then
  begin
     FOrientation := Value;
     DoChange;
  end;
end;

{ Set barcode of text }
procedure TBarCode.SetTextColor(const Value: TColor);
begin
  if Value <> FTextColor then
  begin
     FTextColor := Value;
     DoChange;
  end;
end;

{ Set position of text }
procedure TBarCode.SetTextPosition(const Value: TTextPosition);
begin
  if Value <> FTextPosition then
  begin
     FTextPosition := Value;
     DoChange;
  end;
end;

procedure TBarCode.SetAutoWidth(const Value: Boolean);
begin
  if Value <> FAutoWidth then
  begin
     FAutoWidth := Value;
     DoChange;
  end;
end;

{ Set content of text }
procedure TBarCode.SetTextShow(const Value: TTextShow);
begin
  if Value <> FTextShow then
  begin
     FTextShow := Value;
     DoChange;
  end;
end;

{ Get type name of current barcode }
function TBarCode.GetBarTypeName:string;
begin
  result := BCdata[FBarType].Name;
end;

{ Get About }
function TBarCode.GetAbout: string;
begin
  result := CopyrightInfo;
end;

{ Set About }
procedure TBarCode.SetAbout(const Value: string);
begin
//
end;

{ Draw current barcode (defing angle) }
procedure TBarCode.Draw(DCanvas:TCanvas;const DLeft:Integer; const DTop:Integer;
  const DHeight:Integer; const DAngle:Double);
begin
    H_DrawBar(DCanvas,FBarType,FBarCode,FModul,FRatio,FCheckSum,DLeft,DTop,
      DHeight,Font,FTextShow,FTextPosition,FColorBar,FColorSpc,FTextColor,DAngle);
end;

{ Draw current barcode (current orientation) }
procedure TBarCode.Draw(DCanvas:TCanvas; const DLeft:Integer;
  const DTop:Integer; const DHeight:Integer);
begin
    H_DrawBar(DCanvas,FBarType,FBarCode,FModul,FRatio,FCheckSum,DLeft,DTop,
      DHeight,Font,FTextShow,FTextPosition,FColorBar,FColorSpc,FTextColor,
      GetAngle)
end;

{ Get canvas height of current barcode (define angle) }
function TBarCode.GetCanvasHeight(const DHeight:Integer;
  const DAngle:Double): Integer;
begin
  result := H_GetCanvasHeight(FBarType,FBarCode,FModul,FRatio,FCheckSum,DHeight,
    DAngle);
end;

{ Get canvas height of current barcode (current orientation) }
function TBarCode.GetCanvasHeight(const DHeight:Integer): Integer;
begin
  result := H_GetCanvasHeight(FBarType,FBarCode,FModul,FRatio,FCheckSum,DHeight,
    GetAngle);
end;

{ Get canvas width of current barcode (define angle) }
function TBarCode.GetCanvasWidth(const DHeight:Integer;
  const DAngle:Double): Integer;
begin
  result := H_GetCanvasWidth(FBarType,FBarCode,FModul,FRatio,FCheckSum,DHeight,
    DAngle);
end;

{ Get canvas width of current barcode (current orientation) }
function TBarCode.GetCanvasWidth(const DHeight:Integer): Integer;
begin
  result := H_GetCanvasWidth(FBarType,FBarCode,FModul,FRatio,FCheckSum,DHeight,
    GetAngle);
end;

{ Print current barcode (define angle) }
procedure TBarCode.Print(const DUnit:TUnits; const DLeft:Double;
  const DTop:Double; const DHeight:Double; const DModul:Double;
  const DAngle:Double);
begin
  H_PrintBar(DUnit,FBarType,FBarCode,DModul,FRatio,FCheckSum,DLeft,DTop,DHeight,
    Font,FTextShow,FTextPosition,FColorBar,FColorSpc,FTextColor,DAngle);
end;

{ Print current barcode (current orientation) }
procedure TBarCode.Print(const DUnit:TUnits; const DLeft:Double;
  const DTop:Double; const DHeight:Double; const DModul:Double);
begin
  H_PrintBar(DUnit,FBarType,FBarCode,DModul,FRatio,FCheckSum,DLeft,DTop,DHeight,
    Font,FTextShow,FTextPosition,FColorBar,FColorSpc,FTextColor,GetAngle);
end;

{ Get Print widht of current barcode (mm/inch) }
function  TBarCode.GetPrnBarWidth(const DUnit:TUnits;
  const DModul:Double): Double;
begin
    result := H_GetPrnBarWidth(DUnit,FBarType,FBarCode,DModul,FRatio,FCheckSum);
end;

{ Get Print cancas height of current barcode (mm/inch, define angle) }
function  TBarCode.GetPrnCanvasHeight(const DUnit:TUnits; const DHeight:Double;
  const DModul:Double; const DAngle:Double): Double;
begin
    result := H_PrnCanvasWidth(DUnit,FBarType,FBarCode,DModul,FRatio,FCheckSum,
      DHeight,DAngle);
end;

{ Get Print cancas width of current barcode (mm/inch, define angle) }
function  TBarCode.GetPrnCanvasWidth(const DUnit:TUnits; const DHeight:Double;
  const DModul:Double; const DAngle:Double): Double;
begin
    result := H_PrnCanvasHeight(DUnit,FBarType,FBarCode,DModul,FRatio,
      FCheckSum,DHeight,DAngle);
end;

{ Get Print cancas height of current barcode (mm/inch, current orientation) }
function  TBarCode.GetPrnCanvasHeight(const DUnit:TUnits; const DHeight:Double;
  const DModul:Double): Double;
begin
    result := H_PrnCanvasWidth(DUnit,FBarType,FBarCode,DModul,FRatio,FCheckSum,
      DHeight,GetAngle);
end;

{ Get Print cancas width of current barcode (mm/inch, current orientation) }
function  TBarCode.GetPrnCanvasWidth(const DUnit:TUnits; const DHeight:Double;
  const DModul:Double): Double;
begin
    result := H_PrnCanvasHeight(DUnit,FBarType,FBarCode,DModul,FRatio,FCheckSum,
      DHeight,GetAngle);
end;

{ Draw a barcode on canvas }
procedure TBarCode.H_DrawBar(H_Canvas:TCanvas; const H_BarType:TBarType;
  const H_BarCode:string; const H_Modul:Integer; const H_Ratio:Double;
  const H_CheckSum:TCheckSum; const H_Left:Integer; const H_Top:Integer;
  const H_Height:Integer; const H_TextFont:TFont; const H_TextShow:TTextShow;
  const H_TextPosition:TTextPosition; const H_BarColor:TColor;
  const H_SpcColor:TColor; const H_BackColor:TColor; const H_Angle:Double);
begin
  HBarCode.H_DrawBar(H_Canvas, H_BarType, H_BarCode, H_Modul, H_Ratio,
    H_CheckSum, H_Left, H_Top, H_Height, H_TextFont, H_TextShow, H_TextPosition,
    H_BarColor, H_SpcColor, H_BackColor, H_Angle);
end;

{ Get barcode width to display (pixels) }
function  TBarCode.H_GetBarWidth(const BW_Type:TBarType; const BW_Code:string;
  const BW_Modul:Integer; const BW_Ratio:Double;
  const BW_CheckSum:TCheckSum):Integer;
begin
  result := HBarCode.H_GetBarWidth(BW_Type, BW_Code, BW_Modul, BW_Ratio,
    BW_CheckSum);
end;

{ Get cancas width to display (pixels) }
function TBarCode.H_GetCanvasWidth(const CW_Type:TBarType; const CW_Code:string;
  const CW_Modul:Integer; const CW_Ratio:Double; const CW_CheckSum:TCheckSum;
  const CW_Height:Integer; const CW_Angle:Double):Integer;
begin
  result := HBarCode.H_GetCanvasWidth(CW_Type, CW_Code, CW_Modul, CW_Ratio,
    CW_CheckSum, CW_Height, CW_Angle);
end;

{ Get cancas height to display (pixels) }
function TBarCode.H_GetCanvasHeight(const CH_Type:TBarType;
  const CH_Code:string; const CH_Modul:Integer; const CH_Ratio:Double;
  const CH_CheckSum:TCheckSum; const CH_Height:Integer;
  const CH_Angle:Double):Integer;
begin
  result := HBarCode.H_GetCanvasHeight(CH_Type, CH_Code, CH_Modul, CH_Ratio,
    CH_CheckSum, CH_Height, CH_Angle);
end;

{ Print barcode }
procedure TBarCode.H_PrintBar(const H_Unit:TUnits; const H_BarType:TBarType;
  const H_BarCode:string; const H_Modul:Double; const H_Ratio:Double;
  const H_CheckSum:TCheckSum; const H_Left:Double; const H_Top:Double;
  const H_Height:Double; const H_TextFont:TFont; const H_TextShow:TTextShow;
  const H_TextPosition:TTextPosition; const H_BarColor:TColor;
  const H_SpcColor:TColor; const H_BackColor:TColor; const H_Angle:Double);
begin
  HBarCode.H_PrintBar(H_Unit, H_BarType, H_BarCode, H_Modul, H_Ratio,
    H_CheckSum, H_Left,H_Top, H_Height, H_TextFont, H_TextShow, H_TextPosition,
    H_BarColor, H_SpcColor, H_BackColor, H_Angle);
end;

{ Get width of barcode to print (mm/inch) }
function TBarCode.H_GetPrnBarWidth(const BW_Unit:TUnits; const BW_Type:TBarType;
  const BW_Code:string; const BW_Modul:Double; const BW_Ratio:Double;
  const BW_CheckSum:TCheckSum):Double;
begin
  result := HBarCode.H_GetPrnBarWidth(BW_Unit, BW_Type, BW_Code, BW_Modul,
    BW_Ratio, BW_CheckSum);
end;

{ Get width of canvas to print (mm/inch) }
function TBarCode.H_PrnCanvasWidth(const CW_Unit:TUnits; const CW_Type:TBarType;
  const CW_Code:string; const CW_Modul:Double; const CW_Ratio:Double;
  const CW_CheckSum:TCheckSum; const CW_Height:Double;
  const CW_Angle:Double):Double;
begin
  result := HBarCode.H_PrnCanvasWidth(CW_Unit, CW_Type, CW_Code, CW_Modul,
    CW_Ratio, CW_CheckSum, CW_Height, CW_Angle);
end;

{ Get height of canvas to print (mm/inch) }
function TBarCode.H_PrnCanvasHeight(const CH_Unit:TUnits;
  const CH_Type:TBarType; const CH_Code:string; const CH_Modul:Double;
  const CH_Ratio:Double; const CH_CheckSum:TCheckSum;  const CH_Height:Double;
  const CH_Angle:Double):Double;
begin
  result := HBarCode.H_PrnCanvasHeight(CH_Unit, CH_Type, CH_Code, CH_Modul,
    CH_Ratio, CH_CheckSum, CH_Height, CH_Angle);
end;

{ Get name of barcode type }
function TBarCode.H_GetBarTypeName(const BN_BarType:TBarType): string;
begin
  result := BCData[BN_BarType].Name;
end;

end.

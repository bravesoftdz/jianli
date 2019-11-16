{************************************************}
{ xzhifei - xzhifei@163.net                      }
{ 2006.5.2                                       }
{************************************************}
unit ChnCalendar;

interface

uses
  Windows, DateUtils, Messages, DateWin, Forms, SysUtils, DateCn, StdCtrls, Classes, Controls, CommCtrl, ComCtrls, Graphics;

type
  tagRGBTRIPLE = packed record
    rgbtBlue: Byte;
    rgbtGreen: Byte;
    rgbtRed: Byte;
  end;
  TRGBTriple = tagRGBTRIPLE;
  PRGBTripleArray = ^TRGBTripleArray;
  TRGBTripleArray = array[0..32767] of TRGBTriple;
  TChnCalendar = class(TCustomControl)
  private
    { Private declarations }
//    isChangeBmp: Boolean;
    CnDate: string;
    ButtonRect: TRect;
    YearEdit,
      MonthEdit,
      DayEdit: TEdit;
    MouseStyle: integer;
    FLastChange: TSystemTime;
    FDateTime: TDateTime;
    FFrameColor: TColor;
    FCnDateColor: TColor;
    FButtonColor: TColor;
    FBackPicture: TbitMap;
    FAlphaBlend: Byte;
    procedure DrawButton(iStyle: integer);
    procedure SetDateTime(const Value: TDateTime);
    procedure WMSize(var Msg: TWMSize); message wm_Size;
    procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
    procedure SetFrameColor(const Value: TColor);
    procedure setCnDateColor(const Value: TColor);
    procedure setButtonColor(const Value: TColor);
    procedure SetBackPicture(const Value: TbitMap);
    procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
//    procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    procedure CMCtl3DChanged(var Message: TMessage); message CM_CTL3DCHANGED;
  protected
    { Protected declarations }
    procedure Paint; override;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    { Published declarations }
    property DateTime: TDateTime read FDateTime write SetDateTime;
    property FrameColor: TColor read FFrameColor write SetFrameColor;
    property CnDateColor: TColor read FCnDateColor write setCnDateColor;
    property ButtonColor: TColor read FButtonColor write setButtonColor;
    property BackPicture: TbitMap read FBackPicture write SetBackPicture;
    property AlphaBlend: Byte read FAlphaBlend write FAlphaBlend;
    property Color;
    property Align;
    property Anchors;
    property Enabled;
    property Font;
    property ParentBiDiMode;
    property ParentBackground;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property Ctl3D;
  end;

procedure Register;

implementation

uses Grids;

procedure Register;
begin
  RegisterComponents('Standard', [TChnCalendar]);
end;



{ TChnCalendar }

procedure BmpAlphaBlend(var dBmp: TBitMap; sBmp: TBitmap; Pos: TPoint; Alpha: integer; TranColor: TColor = -1);
  function IntToByte(i: Integer): Byte;
  begin
    if i > 255 then
      Result := 255
    else if i < 0 then
      Result := 0
    else
      Result := i;
  end;
  function GetSLColor(pRGB: TRGBTriple): TColor;
  begin
    Result := RGB(pRGB.rgbtRed, pRGB.rgbtGreen, pRGB.rgbtBlue);
  end;
var
  p0, p1: PRGBTripleArray;
  r, g, b, p, x, y: Integer;
begin
  sBmp.PixelFormat := pf24bit;
  dBmp.PixelFormat := pf24bit;
  if TranColor = -1 then
    TranColor := sBmp.Canvas.Pixels[0, 0];
  for y := 0 to sBmp.Height - 1 do
    if (y + Pos.y >= 0) and (y + Pos.Y < dBmp.Height) then
    begin
      p0 := dBmp.ScanLine[y + Pos.y];
      p1 := sBmp.ScanLine[y];
      for x := 0 to sBmp.Width - 1 do
        if (x + pos.X >= 0) and (x + Pos.X < dBmp.Width) then
          if GetSLCOlor(p1[x]) <> TranColor then
          begin
            p0[x + pos.X].rgbtRed := IntToByte((p0[x + pos.X].rgbtRed * (100 - Alpha) +
              p1[x].rgbtRed * Alpha) div 100);

            p0[x + pos.X].rgbtGreen := IntToByte((p0[x + pos.X].rgbtGreen * (100 - Alpha) +
              p1[x].rgbtGreen * Alpha) div 100);

            p0[x + pos.X].rgbtBlue := IntToByte((p0[x + pos.X].rgbtBlue * (100 - Alpha) +
              p1[x].rgbtBlue * Alpha) div 100);
          end;
    end;

end;


constructor TChnCalendar.Create(AOwner: TComponent);
var
  P: TPoint;
  bmp: TbitMap;
begin
//  CheckCommonControl(ICC_USEREX_CLASSES);
  inherited Create(AOwner);
//  DateTimeToSystemTime(DateTime, FLastChange);
//  FShowCheckbox := False;
//  FChecked := True;
  SetBounds(0, 0, 186, 21);
  Ctl3D := True;
  ControlStyle := ControlStyle + [csAcceptsControls];
  FBackPicture := TBitMap.Create;
  Color := clWindow;
  FCnDateColor := clGreen;
  FButtonColor := clPurple;
  FAlphaBlend := 50;
  ParentColor := False;
  TabStop := True;
  YearEdit := TEdit.Create(Self);
  with YearEdit do
  begin
    BorderStyle := bsNone;
    Parent := Self;
    SetBounds(0, 0, 31, 13);
    Left := 3;
    Top := 1;
    Text := FormatDateTime('YYYY', Now);
  end;

  MonthEdit := TEdit.Create(Self);
  with MonthEdit do
  begin
    BorderStyle := bsNone;
    Parent := Self;
    SetBounds(0, 0, 15, 13);
    Left := 41;
    Top := 1;
    Text := FormatDateTime('M', Now);
  end;

  DayEdit := TEdit.Create(Self);
  with DayEdit do
  begin
    BorderStyle := bsNone;
    Parent := Self;
    SetBounds(0, 0, 15, 13);
    Left := 65;
    Top := 1;
    Text := FormatDateTime('D', Now);
  end;

  FRM_Date := TFRM_Date.Create(Application);
  with FRM_Date do
  begin
    Image1.Picture.Bitmap.Assign(FBackPicture);
    Label16.Visible := FBackPicture.Width = 0;
    Label20.Visible := FBackPicture.Width = 0;
    if Image1.Picture.Graphic <> nil then
    begin
      bmp := TbitMap.Create;
      bmp.Width := Image1.Width;
      bmp.Height := Image1.Height;
      bmp.Canvas.Brush.Color := Color;
      bmp.Canvas.FillRect(RECT(0, 0, bmp.Width,
        bmp.Height));

      P := Point((bmp.Width - FBackPicture.Width) div 2,
        (bmp.Height - FBackPicture.Height) div 2);
      BmpAlphaBlend(bmp, FBackPicture, P, FAlphaBlend);
      Image1.Canvas.Draw(0, 0, bmp);
      bmp.free;

    end;
  end;

  DateTime := Now;
//  CnDate := CnanimalOfYear(DateTime) + CnMonthOfDate(DateTime) + CnDayOfDate(DateTime);

end;


destructor TChnCalendar.Destroy;
begin
  FBackPicture.Free;
  inherited;
end;


procedure DrawClt3DButton(aCanvas: TCanvas; R: TRect; IsDown: Boolean);
begin
  with aCanvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(R);
    FrameRect(R);
    if IsDown then
    begin
      Brush.Color := clBtnShadow  ;
      Pen.Color := clBtnShadow;
      FrameRect(R);
    end
    else
    begin
      Brush.Color := clBlack;
      Pen.Color := clBlack;
      MoveTo(r.Right - 1, r.Top);
      LineTo(r.Right - 1, r.Bottom);
      MoveTo(r.Left, r.Bottom - 1);
      LineTo(r.Right, r.Bottom - 1);

      InflateRect(R, -1, -1);
      Brush.Color := clBtnShadow;
      Pen.Color := clBtnShadow;
      FrameRect(R);

      Brush.Color := clBtnHighlight  ;
      Pen.Color := clBtnHighlight;
      MoveTo(r.Left, r.Top);
      LineTo(r.Right - 1, r.Top);
      MoveTo(r.Left, r.Top);
      LineTo(r.Left, r.Bottom - 1);
    end;
  end;
end;

procedure TChnCalendar.DrawButton(iStyle: integer);
  procedure Trigon(Canvas: TCanvas; xy1, xy2, xy3: TPoint);
  var
    xy: array[1..4] of TPoint;
  begin
    xy[1] := xy1;
    xy[2] := xy2;
    xy[3] := xy3;
    xy[4] := xy1;
    Canvas.Polygon(xy);
  end;
var
  TrigonLeft, TrigonTop: integer;
  R: TRect;
begin
  Canvas.Brush.Style := bsSolid;
  case iStyle of
    0:
      begin
        Canvas.Pen.Color := FrameColor;
        Canvas.Brush.Color := FButtonColor; // clPurple;
      end;
    1, 2:
      begin
        Canvas.Pen.Color := clBlack;
        Canvas.Brush.Color := $00E47AC8;
      end;
  end;
  if Ctl3D then
  begin
    R := RECT(Width - 20, 3, Width - 2, Height - 2);
    DrawClt3DButton(Canvas, R, iStyle = 1);
  end
  else
  begin
    R := RECT(Width - 15, 3, Width - 2, Height - 2);
    Canvas.Rectangle(R);
  end;
  //»­Èý½ÇÐÎ
  TrigonLeft := r.Left + ((r.Right - r.Left) - 6) div 2;
  TrigonTop := r.Top + ((r.Bottom - r.Top) - 3) div 2;
  if Ctl3D then
  begin
    Canvas.Brush.Color := clBtnText;
    Canvas.Pen.Color := clBtnText;
  end
  else
  begin
    case iStyle of
      0, 2:
        begin
          Canvas.Brush.Color := clWhite;
          Canvas.Pen.Color := clWhite;
        end;
      1:
        begin
          Canvas.Brush.Color := $00E4E4E4;
          Canvas.Pen.Color := $00E4E4E4;
        end;
    end;
  end;
  if iStyle = 1 then
  begin
    TrigonLeft := TrigonLeft + 1;
    TrigonTop := TrigonTop + 1;
  end;
  Trigon(Canvas,
    Point(TrigonLeft, TrigonTop),
    Point(TrigonLeft + 6, TrigonTop),
    Point(TrigonLeft + 3, TrigonTop + 3));
  ButtonRect := R;

end;


procedure DrawClt3D(aCanvas: TCanvas; R: TRect);
begin
  with aCanvas do
  begin
//    R := Label1.ClientRect; //Rect(0, H div 2 - 1, Panel1.Width, Panel1.Height);
    Brush.Color := clBtnHighlight;
    FillRect(R);
    FrameRect(R);

    Brush.Color := clBtnShadow;
    Pen.Color := clBtnShadow;
    MoveTo(r.Left, r.Top);
    LineTo(r.Right - 1, r.Top);
    MoveTo(r.Left, r.Top);
    LineTo(r.Left, r.Bottom - 1);

    InflateRect(R, -1, -1);
    Brush.Color := clBtnFace;
    FrameRect(R);

    Brush.Color := clBtnShadow;
    Pen.Color := clBtnShadow;
    MoveTo(r.Left, r.Top);
    LineTo(r.Right - 1, r.Top);
    MoveTo(r.Left, r.Top);
    LineTo(r.Left, r.Bottom - 1);
  end;
end;

procedure TChnCalendar.Paint;
var
  TextTop: integer;
begin
  YearEdit.Color := color;
  MonthEdit.Color := color;
  DayEdit.Color := Color;
//  ButtonRect := RECT(Width - 15, 1, Width - 1, Height - 1);

  Canvas.Pen.Color := FrameColor;
  Canvas.Brush.Color := Color;
  Canvas.FillRect(ClientRect);
  if Ctl3D then
  begin
    DrawClt3D(Canvas, ClientRect);
    Canvas.Pen.Color := FrameColor;
    Canvas.Brush.Color := Color;
  end
  else
  begin
    Canvas.Rectangle(ClientRect);
  end;


  canvas.Font.Color := Font.Color;
  TextTop := (Height - canvas.TextHeight('A')) div 2;
  Canvas.TextOut(33, TextTop, '-');
  Canvas.TextOut(60, TextTop, '-');
  canvas.Font.Color := FCnDateColor;
  Canvas.TextOut(84, TextTop, CnDate);
  canvas.Font.Color := Font.Color;


  DrawButton(0);
  inherited;
end;

procedure TChnCalendar.SetBackPicture(const Value: TbitMap);
begin
  FBackPicture.Assign(Value);

end;

procedure TChnCalendar.setButtonColor(const Value: TColor);
begin
  if FButtonColor <> Value then
  begin
    FButtonColor := Value;
    Invalidate;
  end;
end;

procedure TChnCalendar.setCnDateColor(const Value: TColor);
begin
  if FCnDateColor <> Value then
  begin
    FCnDateColor := Value;
    Invalidate;
  end;
end;

procedure TChnCalendar.SetDateTime(const Value: TDateTime);
begin
  if Value <> FDateTime then
  begin
    FDateTime := Value;
    YearEdit.Text := FormatDateTime('YYYY', FDateTime);
    MonthEdit.Text := FormatDateTime('m', FDateTime);
    DayEdit.Text := FormatDateTime('d', FDateTime);
    CnDate := CnanimalOfYear(DateTime) + CnMonthOfDate(DateTime) + CnDayOfDate(DateTime);
    Invalidate;
  end;
end;

procedure TChnCalendar.SetFrameColor(const Value: TColor);
begin
  FFrameColor := Value;
  Invalidate;
end;

function FormExists(FORM_NAME: string): BOOLEAN;
begin
  if Application.FindComponent(FORM_NAME) = nil then
    RESULT := FALSE
  else
    RESULT := TRUE;
end;

function DayOfMonth(Year, Month: Integer): integer; overload;
begin
  try
    Result := MonthDays[IsLeapYear(Year), Month];
  except
    Result := 0;
  end;
end;

function DayOfMonth(Dates: TDateTime): integer; overload;
var
  Year, Month, Day, Hour: Word;

begin
  DecodeDate(Dates, Year, Month, day);
  Result := MonthDays[IsLeapYear(Year), Month];
end;

function DaysOfMonth(Dates: TDateTime): Integer;
begin
  Result := DayOfMonth(YearOf(Dates), MonthOf(Dates));
end;


function SetDateTime(NYear, NMonth, NDay: Word): TDate;
var
  MyDay: Word;
begin
  MyDay := DayOfMonth(NYear, NMonth);
  if MyDay < NDay then
    NDay := MyDay;
  Result := EncodeDate(NYear, NMonth, NDay);

end;


procedure AdjustDropDownForm(AControl: TControl; HostControl: TControl);
var
  WorkArea: TRect;
  HostP, PDelpta: TPoint;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, @WorkArea, 0);
  HostP := HostControl.ClientToScreen(Point(0, 0));
  PDelpta := AControl.ClientToScreen(Point(0, 0));

  AControl.Left := HostP.x;
  AControl.Top := HostP.y + HostControl.Height + 1;

  if (AControl.Width > WorkArea.Right - WorkArea.Left) then
    AControl.Width := WorkArea.Right - WorkArea.Left;

  if (AControl.Left + AControl.Width > WorkArea.Right) then
    AControl.Left := WorkArea.Right - AControl.Width;
  if (AControl.Left < WorkArea.Left) then
    AControl.Left := WorkArea.Left;


  if (AControl.Top + AControl.Height > WorkArea.Bottom) then
  begin
    if (HostP.y - WorkArea.Top > WorkArea.Bottom - HostP.y - HostControl.Height) then
      AControl.Top := HostP.y - AControl.Height;
  end;

  if (AControl.Top < WorkArea.Top) then
  begin
    AControl.Height := AControl.Height - (WorkArea.Top - AControl.Top);
    AControl.Top := WorkArea.Top;
  end;

  if (AControl.Top + AControl.Height > WorkArea.Bottom) then
  begin
    AControl.Height := WorkArea.Bottom - AControl.Top;
  end;

end;


procedure TChnCalendar.WMLButtonDown(var Message: TWMLButtonDown);
var
  xy: TPoint;
  P: TPoint;
  bmp: TbitMap;
begin
  xy := Point(Message.Pos.x, Message.Pos.y);
  GetCursorPos(xy);
  xy := ScreenToClient(xy);
  if PtInRect(ButtonRect, xy) then
    if not IsWindowVisible(FRM_Date.Handle) then
    begin
      if MouseStyle <> 1 then
      begin
        MouseStyle := 1;
        DrawButton(1);
      end;
//    FRM_Date.ShowDateWin(YearEdit, MonthEdit, DayEdit, Self);
{  OutputDebugString(pchar(
    inttostr(ButtonRect.Left) + ',' +
    inttostr(ButtonRect.Right) + ',' +
    inttostr(ButtonRect.Top) + ',' +
    inttostr(ButtonRect.Bottom) + ' ' +
    inttostr(xy.X) + ',' +
    inttostr(xy.Y)
    ));
}
      FRM_Date.YearEdit := YearEdit;
      FRM_Date.MonthEdit := MonthEdit;
      FRM_Date.DayEdit := DayEdit;
      MHostControl := Self;
{
//if isChangeBmp then
    with FRM_Date do
    begin
      Image1.Picture.Bitmap.Assign(FBackPicture);
      Label16.Visible := FBackPicture.Width = 0;
      Label20.Visible := FBackPicture.Width = 0;
      if Image1.Picture.Graphic <> nil then
      begin
        bmp := TbitMap.Create;
        bmp.Width := Image1.Width;
        bmp.Height := Image1.Height;
        bmp.Canvas.Brush.Color := Color;
        bmp.Canvas.FillRect(RECT(0, 0, bmp.Width,
          bmp.Height));

        P := Point((bmp.Width - FBackPicture.Width) div 2,
          (bmp.Height - FBackPicture.Height) div 2);
        BmpAlphaBlend(bmp, FBackPicture, P, FAlphaBlend);
        Image1.Canvas.Draw(0, 0, bmp);
        bmp.free;

      end;
    end;
//    isChangeBmp := False;
}
      with FRM_Date do
      begin
        if Image1.Picture.Graphic = nil then
          StaticText1.Caption := 'aaaa';

        YearEdit.Text := IntToStr(StrTOIntDef(YearEdit.Text, YearOf(Date)));
        MonthEdit.Text := IntToStr(StrTOIntDef(MonthEdit.Text, MonthOf(Date)));
        DayEdit.Text := IntToStr(StrTOIntDef(DayEdit.Text, DayOfMonth(Date)));

        if (StrToInt(YearEdit.Text) > 2050) or (StrToInt(YearEdit.Text) < 1901) then
          YearEdit.Text := IntToStr(YearOf(Date));

        if (StrToInt(MonthEdit.Text) > 12) or (StrToInt(MonthEdit.Text) < 1) then
          MonthEdit.Text := IntToStr(MonthOf(Date));

        if StrToInt(DayEdit.Text) > DayOfMonth(StrToInt(YearEdit.Text), StrToInt(MonthEdit.Text)) then
          DayEdit.Text := IntToStr(DayOfMonth(StrToInt(YearEdit.Text), StrToInt(MonthEdit.Text)));

        NDate := EncodeDate(StrToInt(YearEdit.text), StrToInt(MonthEdit.text), StrToInt(DayEdit.text));
      end;
      AdjustDropDownForm(FRM_Date, Self);
      FRM_Date.Show;
//    ShowWindow(MonthWin.Handle, SW_SHOWNORMAL);
    end;

end;

procedure TChnCalendar.WMLButtonUp(var Message: TWMLButtonUp);
var
  xy: TPoint;
begin
  xy := Point(Message.Pos.x, Message.Pos.y);
  if PtInRect(ButtonRect, xy) then
  begin
    MouseStyle := 0;
    DrawButton(0);
  end;

end;

{
procedure TChnCalendar.WMMouseMove(var Message: TWMMouseMove);
var
  xy: TPoint;
begin
  xy := Point(Message.Pos.x, Message.Pos.y);
  if PtInRect(ButtonRect, xy) then
    if MouseStyle <> 1 then
    begin
      MouseStyle := 1;
      DrawButton(1);
    end;

end;
 }

procedure TChnCalendar.WMSize(var Msg: TWMSize);
begin
  YearEdit.Top := (Height - YearEdit.Height) div 2;
  MonthEdit.Top := YearEdit.Top;
  DayEdit.Top := YearEdit.Top;
end;

procedure TChnCalendar.CMCtl3DChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;

end;

procedure TChnCalendar.CMMouseLeave(var Message: TMessage);
begin
  if MouseStyle = 1 then
  begin
    MouseStyle := 0;
    DrawButton(0);
  end;

end;

end.


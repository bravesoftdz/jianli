unit DateWin;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, ComCtrls, DateUtils;

type
  TFRM_Date = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    day1: TLabel;
    Cnday: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Shape2: TShape;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    Label20: TLabel;
    StaticText1: TStaticText;
    Label21: TLabel;
    Label22: TLabel;
    Image1: TImage;
    Shape1: TShape;
    //CnDayClick
    procedure CnDayClick(Sender: TObject);
    procedure CHnDayClick(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure Label17Click(Sender: TObject);
    procedure UpDown2Click(Sender: TObject; Button: TUDBtnType);
    procedure Label5Click(Sender: TObject);
    procedure FormDeactivate(Sender: TObject);
    procedure CnDayMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ChnDateMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure StaticText1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormPaint(Sender: TObject);

  private
    { Private declarations }
    procedure LoadLAB;
    procedure DateChange(MyTime: TDateTime);
    procedure OK;
  public
    { Public declarations }
    FPicture_AlphaBlend: Byte;
    FPicture: TbitMap;
    NDate: Tdate;
    YearEdit, MonthEdit, DayEdit: TEdit;
    ChDateLabel: TLabel;

    procedure ShowDateWin(YearEdit1, MonthEdit1, DayEdit1: TEdit; {ChDateLabel1: TLabel;} HostControl: TControl; Bmp: TBitMap = nil; iAlphaBlend: Byte = 150);
  end;

var
  FRM_Date: TFRM_Date;
  CnDate: array[1..37] of TLabel;
  ChnDate: array[1..37] of TLabel;
  NYear, NMonth, NDay: Word;
  MHostControl: TControl;
implementation

uses DateCn, ChnCalendar;

{$R *.DFM}



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


procedure TFRM_Date.Label1Click(Sender: TObject);
begin
  //  Self.Close ;
  UpDown1.Visible := true;
  UpDown2.Visible := false;

end;

procedure TFRM_Date.LoadLAB;
var
  i: integer;
begin

  for i := 1 to 37 do
  begin
    CnDate[i] := TLabel.Create(self);
    CnDate[i].parent := self;
    ChnDate[i] := TLabel.Create(self);
    ChnDate[i].parent := self;

    CnDate[i].OnClick := CnDayClick;
    CnDate[i].OnMouseDown := CnDayMouseDown;
    ChnDate[i].OnClick := ChnDayClick;
    ChnDate[i].OnMouseDown := ChnDateMouseDown;
    CnDate[i].AutoSize := false;
    ChnDate[i].AutoSize := false;
    CnDate[i].Width := day1.Width;
    ChnDate[i].Width := Cnday.Width;
    CnDate[i].Height := day1.Height;
    ChnDate[i].Height := Cnday.Height;
    CnDate[i].Alignment := day1.Alignment;
    ChnDate[i].Alignment := Cnday.Alignment;
    CnDate[i].Layout := day1.Layout;
    ChnDate[i].Layout := Cnday.Layout;

    if i = 1 then
    begin
      CnDate[i].Left := day1.Left;
      CnDate[i].Top := day1.Top;
      ChnDate[i].Left := Cnday.Left;
      ChnDate[i].Top := Cnday.Top;

    end
    else
    begin

      if ((i - 1) / 7) = ((i - 1) div 7) then
      begin
        CnDate[i].Top := CnDate[i - 1].Top + 32;
        CnDate[i].Left := day1.Left;
        ChnDate[i].Top := ChnDate[i - 1].Top + 32;
        ChnDate[i].Left := Cnday.Left;

      end
      else
      begin

        CnDate[i].Top := CnDate[i - 1].Top;
        CnDate[i].Left := CnDate[i - 1].Left + 42;
        ChnDate[i].Top := ChnDate[i - 1].Top;
        ChnDate[i].Left := ChnDate[i - 1].Left + 42;

      end;
    end;
    CnDate[i].Font := day1.Font;
    ChnDate[i].Font := Cnday.Font;
    CnDate[i].Font.Color := clBlack;
    CnDate[i].AutoSize := false;
    ChnDate[i].AutoSize := false;
    CnDate[i].Transparent := true;
    ChnDate[i].Transparent := true;

      //        CnDate[i].Caption :='22';
      //        CnDate[i].Visible  :=true;
      //        ChnDate[i].Caption :='初一';

  end;

end;


procedure TFRM_Date.DateChange(MyTime: TDateTime);
var
  i, S: integer;
  StarNo: integer;
  Present: TDateTime;
  Year, Month, Day, Hour: Word;

begin
  //  Label6.Caption :=datetostr(MyTime);
  //  Label14.Caption :='今天:'+datetostr(date);
  //  MyDates:=MyTime;
  Label20.Caption := IntToStr(DateUtils.YearOf(Mytime));
  Label17.Caption := IntToStr(DateUtils.MonthOf(Mytime));
  Label16.Caption := Label17.Caption;
  Label1.Caption := IntToStr(DateUtils.YearOf(Mytime));
  Label21.Caption := CnanimalOfYear(Mytime);


  for i := 1 to 37 do
  begin
    CnDate[i].Visible := false;
    ChnDate[i].Visible := false;
    ChnDate[i].Font.Color := clBlack;
    CnDate[i].Font.Color := clBlack;
    CnDate[i].Font.Size := 11;
    CnDate[i].Color := self.Color;
    ChnDate[i].Color := self.Color;
  end;

  DecodeDate(MyTime, Year, Month, Day);
  Present := EncodeDate(Year, Month, 1);
  StarNo := dayofweek(Present);
  s := starno + DayOfMonth(Present) - 1;
  try
    for i := StarNo to s do
    begin
      Present := EncodeDate(Year, Month, i - StarNo + 1);
      CnDate[i].Caption := IntToStr(i - StarNo + 1);
      CnDate[i].Tag := i - StarNo + 1;
      ChnDate[i].Tag := CnDate[i].Tag;
      ChnDate[i].Caption := CnDayOfDate(Present);
      if ChnDate[i].Caption = '初一' then
      begin
        ChnDate[i].Caption := CnMonthOfDate(Present);
        ChnDate[i].Font.Color := clRed;
      end
      else
        ChnDate[i].Font.Color := Cnday.Font.Color;
      if length(Holiday(MyTime, i - StarNo + 1)) > 3 then
      begin
        ChnDate[i].Caption := Holiday(MyTime, i - StarNo + 1);
        ChnDate[i].Font.Color := $000080FF;
      end;
      if DateCn.GetLunarHolDay(Present) <> '' then
      begin
        ChnDate[i].Caption := GetLunarHolDay(Present);
        ChnDate[i].Font.Color := $00FF5353;
      end;
      if DateCn.CnDayOfDateJr(Present) <> '' then
      begin
        ChnDate[i].Caption := CnDayOfDateJr(Present);
        ChnDate[i].Font.Color := $000080FF;
      end;
      if i - StarNo + 1 = day then
      begin

        Shape2.Left := CnDate[i].left - 1;
        Shape2.Top := CnDate[i].top + 1;
        Label22.Caption := Constellation(Present, day);
      end;


      CnDate[i].Visible := true;
      ChnDate[i].Visible := true;

    end;

  except
    on EConvertError do
    begin
        //   showmessage(inttostr(i));
      exit;
    end
  else exit;
  end;

end;


procedure TFRM_Date.FormCreate(Sender: TObject);
begin
  LoadLAB;
  NDate := Date;

end;

procedure TFRM_Date.FormShow(Sender: TObject);
begin
  DecodeDate(NDate, NYear, NMonth, NDay);
  UpDown1.Position := NYear;
  UpDown2.Position := NMonth;

  DateChange(NDate);
end;

procedure TFRM_Date.CHnDayClick(Sender: TObject);
begin
  Label5Click(nil);
  Nday := (sender as TLabel).Tag;
  OK;
end;

procedure TFRM_Date.CnDayClick(Sender: TObject);
begin
  Label5Click(nil);
  Nday := (sender as TLabel).Tag;
  OK;

end;

procedure TFRM_Date.UpDown1Click(Sender: TObject; Button: TUDBtnType);
var
  Present: TDate;
begin
  NYear := UpDown1.Position;
  Present := SetDateTime(NYear, NMonth, NDay);
  DateChange(Present);
end;

procedure TFRM_Date.Label17Click(Sender: TObject);
begin
  UpDown2.Visible := true;
  UpDown1.Visible := false;
end;

procedure TFRM_Date.UpDown2Click(Sender: TObject; Button: TUDBtnType);
var
  Present: TDate;
begin
  NMonth := UpDown2.Position;
  Present := SetDateTime(NYear, NMonth, NDay);
  DateChange(Present);

end;

procedure TFRM_Date.Label5Click(Sender: TObject);
begin
  UpDown2.Visible := False;
  UpDown1.Visible := false;

end;

procedure TFRM_Date.FormDeactivate(Sender: TObject);
begin
  Self.Close;
end;

procedure TFRM_Date.ChnDateMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Shape2.Left := (sender as TLabel).left;
  Shape2.Top := (sender as TLabel).top - 16;

end;

procedure TFRM_Date.CnDayMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  Shape2.Left := (sender as TLabel).left - 1;
  Shape2.Top := (sender as TLabel).top + 1;

end;

procedure TFRM_Date.StaticText1Click(Sender: TObject);
begin
  NDate := Date;
  FormShow(nil);
end;

procedure TFRM_Date.OK;
begin
  NDate := EncodeDate(NYear, NMonth, NDay);
//  TChnCalendar(MHostControl).IsInit := False;
  TChnCalendar(MHostControl).DateTime := NDate;
  Close;
end;

procedure TFRM_Date.ShowDateWin(YearEdit1, MonthEdit1, DayEdit1: TEdit;
  HostControl: TControl; Bmp: TBitMap = nil; iAlphaBlend: Byte = 150);
var
  P: TPoint;
  FBackPicture: TbitMap;
begin
{  if not FormExists('FRM_Date') then
    Self := TFRM_Date.Create(Application);
  YearEdit := YearEdit1;
  MonthEdit := MonthEdit1;
  DayEdit := DayEdit1;
//  ChDateLabel := ChDateLabel1;
  MHostControl := HostControl;

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
  AdjustDropDownForm(Self, HostControl);

  Image1.Picture.Bitmap.Assign(Bmp);
  Label16.Visible := Image1.Picture.Graphic = nil;
  Label20.Visible := Image1.Picture.Graphic = nil;
  if Image1.Picture.Graphic <> nil then
  begin
    FBackPicture := TbitMap.Create;
    FBackPicture.Width := Image1.Width ;
    FBackPicture.Height := Image1.Height;
    FBackPicture.Canvas.Brush.Color := Color;
    FBackPicture.Canvas.FillRect(RECT(0, 0, FBackPicture.Width,
      FBackPicture.Height));

    P := Point((FBackPicture.Width - bmp.Width) div 2,
      (FBackPicture.Height - bmp.Height) div 2);
    BmpAlphaBlend(FBackPicture, Bmp, P, iAlphaBlend);
    Image1.Canvas.Draw(0, 0, FBackPicture);
    FBackPicture.free;

  end;
  Self.Show;  }
end;

procedure TFRM_Date.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Application.RemoveComponent(Self);
  Self := nil;
  Self.Free;

end;

procedure TFRM_Date.FormPaint(Sender: TObject);
var
  P: TPoint;
  FBackPicture: TbitMap;
begin
//
                         {
  if not FPicture.Empty then
  begin
    FBackPicture := TbitMap.Create;
    FBackPicture.Width := ClientWidth;
    FBackPicture.Height := ClientHeight;
    FBackPicture.Canvas.Brush.Color := Color;
    FBackPicture.Canvas.FillRect(RECT(0, 0, FBackPicture.Width,
      FBackPicture.Height));

    P := Point((FBackPicture.Width - FPicture.Width) div 2,
      (FBackPicture.Height - FPicture.Height) div 2);
    BmpAlphaBlend(FBackPicture, FPicture, P, FPicture_AlphaBlend);
    Canvas.Draw(0, 0, FBackPicture);
    FBackPicture.free;
  end;
  }
end;

end.


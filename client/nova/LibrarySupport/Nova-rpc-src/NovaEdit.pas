unit NovaEdit;
{------------------------------------
  功能说明：用于制定的输入控制的文本框
  创建日期：2011/01/30
  作者：lanck
  版权：nova
-------------------------------------}
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, StdCtrls,
  Forms, Clipbrd;

type
  TValueType = (ssString, ssNumber, ssDouble, ssTicket, ssHHMM, ssYYYYMMDD);

const
  WM_CHANGE = $0F01;

type
  TNovaEdit = class(TEdit)
  private
    FOnIDChange: TNotifyEvent;
    FExitcolor: Tcolor;
    FOnEnterColor: Tcolor;
    FStopErrorKey: boolean;
    FAutoTab: boolean;
    FNextTabComponent: TWinControl;
    FPerTabComponent: TWinControl;
    FOnFocusSelectAll: boolean;
    FDisEnableType: boolean;
    FDisEnableColor: Tcolor;
    FDisEnabledFont: TFont;
    FOnChangeColorSet: boolean;
    FOnChangeColor: Tcolor;
    FOldValue: string;
    FDoNilWhenNum: boolean;
    FBindLabel: TLabel;
    procedure SetId(value: integer);
    procedure SetValue(Wvalue: string);
    Procedure SetCode(value: string);
    function rTrim: string;
    procedure SetTrim(const value: string);
    function sFRid: integer;
    procedure SetValueType(const value: TValueType);
    function GetPerent(Sender: TWinControl): TWinControl;
    procedure SetStopErrorKey(const value: boolean);
    procedure SetAutoTab(const value: boolean);
    procedure SetNextTabComponent(const value: TWinControl);
    procedure SetPerTabComponent(const value: TWinControl);
    procedure FindParControl;
    procedure SetOnFocusSelectAll(const value: boolean);
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMChange(var Message: TWMPaint); message WM_CHANGE;
    procedure WMPaste(var Message: TMessage); message WM_PASTE;
    procedure SetDisEnableType(const value: boolean);
    procedure SetDisEnableColor(const value: Tcolor);
    procedure SetDisEnabledFont(const value: TFont);
    procedure SetonIdChange(const value: TNotifyEvent);
    function HaveChange: boolean;
    procedure SetOnChangeColor(const value: Tcolor);
    procedure SetOnChangeColorSet(const value: boolean);
    procedure SetOldValue(const value: string);
    procedure SetDoNilWhenNum(const value: boolean);
    procedure SetBindLabel(const value: TLabel);
  protected
    Fvalue: string;
    Fcode: string;
    FId: integer;
    FValueType: TValueType;
    StartChange: boolean;
    Procedure CheckValue;
    property Caption;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetChangeText: string;
  published
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure Change; OverRide;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure SetEnabled(value: boolean); override; // TControl
    property Id: integer read sFRid write SetId default 0;
    Property OnIdChange: TNotifyEvent read FOnIDChange write SetonIdChange;
    property value: String read Fvalue write SetValue;
    property Code: String read Fcode write SetCode;
    Property ValueTrim: string read rTrim Write SetTrim;
    property ValueType
      : TValueType read FValueType write SetValueType default ssString;
    property OnEnterColor: Tcolor read FOnEnterColor write FOnEnterColor;
    property OnExitColot: Tcolor read FExitcolor write FExitcolor;
    Property StopErrorKey: boolean read FStopErrorKey write SetStopErrorKey;
    Property AutoTab: boolean read FAutoTab write SetAutoTab default false;
    Property PerTabComponent: TWinControl read FPerTabComponent write
      SetPerTabComponent;
    Property NextTabComponent: TWinControl read FNextTabComponent write
      SetNextTabComponent;
    Property OnFocusSelectAll: boolean read FOnFocusSelectAll write
      SetOnFocusSelectAll default true;
    Property DisEnableFont: TFont read FDisEnabledFont write SetDisEnabledFont;
    Property DisEnableType
      : boolean read FDisEnableType write SetDisEnableType
      default true;
    Property DisEnableColor
      : Tcolor read FDisEnableColor write SetDisEnableColor;
    Property OnChangeColor: Tcolor read FOnChangeColor write SetOnChangeColor;
    property OldValue: string read FOldValue write SetOldValue;
    property OnChangeColorSet: boolean read FOnChangeColorSet write
      SetOnChangeColorSet default false;
    property DoNilWhenNum
      : boolean read FDoNilWhenNum write SetDoNilWhenNum default
      false;
    property BindLabel: TLabel read FBindLabel write SetBindLabel;
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nova', [TNovaEdit]);
end;

constructor TNovaEdit.Create(AOwner: TComponent);
begin
  value := '';
  Code := '';
  Id := 0;
  // imeMode:=imClose;
  inherited Create(AOwner);
  ValueType := ssString;
  FOnEnterColor := clSkyBlue;
  FExitcolor := clWindow;
  MaxLength := 50;
  FStopErrorKey := true;
  FAutoTab := false;
  FDisEnableColor := clred;
  FDisEnabledFont := Tfont.Create;
  FDisEnableType := true;
  StartChange := false;
  FOnChangeColor := $004ACBD9;
end;

destructor TNovaEdit.Destroy;
begin
  inherited Destroy;
end;

procedure TNovaEdit.SetId(value: integer);
begin
  if FId=value then exit;
  FId := value;
  if Assigned(FOnIDChange) then
    FOnIDChange(self);
end;

procedure TNovaEdit.SetValue(Wvalue: string);
begin
  Fvalue := Wvalue;
end;

Procedure TNovaEdit.SetCode(value: string);
begin
  Fcode := value;
end;

function TNovaEdit.rTrim: string;
begin
  result := trim(text);
end;

procedure TNovaEdit.SetTrim(const value: string);
begin
  if text <> trim(value) then
  begin
    // SetTextBuf(PChar(Value));
    text := trim(value);
  end;
end;

function TNovaEdit.sFRid: integer;
begin
  result := FId;
  // if Text = '' then
  // result := 0;
end;

procedure TNovaEdit.SetValueType(const value: TValueType);
begin
  FValueType := value;
end;

procedure TNovaEdit.CheckValue;
var
  i: integer;
  EdStr: string;
  Getstr: string;
  idx: integer;
  SelLen: integer;
begin
  EdStr := text;
  Getstr := '';
  idx := SelStart;
  SelLen := SelLength;
  case ValueType of
    ssString:
      begin
        for i := 1 to length(EdStr) do
        begin
          if not(ord(EdStr[i]) = 39) then
            Getstr := Getstr + copy(EdStr, i, 1);
        end;
        ValueTrim := Getstr;
        SelStart := idx;
        SelLength := SelLen;
      end;
    ssNumber:
      begin
        for i := 1 to length(EdStr) do
        begin
          if (EdStr[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            '.']) then
          begin
            if (pos('.', Getstr) = 0) or (copy(EdStr, i, 1) <> '.') then
            begin
              Getstr := Getstr + copy(EdStr, i, 1);
            end;
          end;
        end;
        if (length(Getstr) <= 0) and (not self.DoNilWhenNum) then
        begin
          Getstr := '0';
          SelLen := 1;
        end;

        ValueTrim := Getstr;
        SelStart := idx;
        SelLength := SelLen;
      end;
    ssDouble:
      begin
        for i := 1 to length(EdStr) do
        begin
          if (EdStr[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            '.', '-']) then
          begin
            if ((pos('.', Getstr) = 0) or (copy(EdStr, i, 1) <> '.')) and
              ((copy(EdStr, i, 1) <> '-') or (i = 1)) then
            begin
              Getstr := Getstr + copy(EdStr, i, 1);
            end;
          end;
        end;
        if (length(Getstr) <= 0) and (not self.DoNilWhenNum) then
        begin
          Getstr := '0';
          SelLen := 1;
        end;
        ValueTrim := Getstr;
        SelStart := idx;
        SelLength := SelLen;
      end;
    ssTicket:
      begin
        for i := 1 to length(EdStr) do
        begin
          if (EdStr[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
            then
            Getstr := Getstr + copy(EdStr, i, 1);
        end;
        ValueTrim := Getstr;
        SelStart := idx;
        SelLength := SelLen;
      end;
    ssHHMM:
      begin
        Getstr := '00:00';
        for i := 1 to length(copy(EdStr, 1, 5)) do
        begin
          if (EdStr[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
            ':']) then
            if i <> 3 then
              Getstr[i] := EdStr[i];
        end;

        if (length(Getstr) <= 0) then
        begin
          Getstr := '00:00';
        end;

        if pos(':', Getstr) <> 3 then
        begin
          Getstr := StringReplace(Getstr, ':', '0', [rfReplaceAll]);
          Getstr := copy(Getstr, 1, 2) + ':' + copy(Getstr, 3,
            length(Getstr) - 2);
        end;

        if (length(Getstr) > 5) then
        begin
          Getstr := copy(Getstr, 1, 5)
        end;

        Getstr := copy(Getstr, 1, 5);
        if copy(Getstr, 1, 1) > '2' then
          Getstr[1] := '0';
        if copy(Getstr, 1, 1) = '2' then
          if copy(Getstr, 2, 1) >= '4' then
            Getstr[2] := '0';
        if copy(Getstr, 4, 1) >= '6' then
          Getstr[4] := '0';
        ValueTrim := Getstr;
        if idx = 2 then
          inc(idx);
        SelStart := idx;
        SelLength := 1;
      end;
    ssYYYYMMDD:
      begin
        for i := 1 to length(EdStr) do
        begin
          if (EdStr[i] in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'])
            then
            Getstr := Getstr + copy(EdStr, i, 1);
        end;
        if (length(Getstr) <= 0) or (length(Getstr) < 8) then
          Getstr := Formatdatetime('yyyymmdd', now);
        Getstr := copy(Getstr, 1, 8);
        if copy(Getstr, 1, 1) > '2' then
        begin
          Getstr[1] := '2';
        end;
        if copy(Getstr, 2, 1) > '9' then
        begin
          Getstr[2] := '0';
        end;
        if copy(Getstr, 3, 1) > '9' then
        begin
          Getstr[3] := '0';
        end;
        if copy(Getstr, 4, 1) > '9' then
        begin
          Getstr[4] := '0';
        end;
        if copy(Getstr, 5, 1) > '1' then
          Getstr[5] := '0';
        if copy(Getstr, 6, 1) > '2' then
          Getstr[6] := '1';

        if copy(Getstr, 7, 1) > '3' then
          Getstr[7] := '0';

        if Getstr[7] = '0' then
          if copy(Getstr, 8, 1) > '9' then
            Getstr[8] := '1';

        if Getstr[7] = '2' then
          if copy(Getstr, 8, 1) > '9' then
            Getstr[8] := '1';

        if Getstr[7] = '3' then
          if copy(Getstr, 8, 1) > '2' then
            Getstr[8] := '1';
        ValueTrim := Getstr;
        SelStart := idx;
        SelLength := 1;
      end;
  end;
end;

procedure TNovaEdit.DoEnter;
begin
  inherited;
  { //20081116 ice屏蔽，TNovaEdit的OnFocusSelectAll与父类与的autoselect重复且冲突
    if OnFocusSelectAll then
    begin
    SelectAll;
    end
    else
    begin
    SelLength := 0;
    end; }
  Color := FOnEnterColor;

end;

procedure TNovaEdit.DoExit;
begin
  if FOnChangeColorSet then
  begin
    if HaveChange then
    begin
      Color := FOnChangeColor;
    end
    else
    begin
      Color := FExitcolor;
    end;
  end
  else
  begin
    Color := FExitcolor;
  end;
  inherited;
end;

procedure TNovaEdit.Change;
begin
  if not(csDesigning in ComponentState) then
    CheckValue;
  // Postmessage(Handle, WM_CHANGE, 0,0);
  inherited Change;

end;

procedure TNovaEdit.WMChange(var Message: TWMPaint);
begin

  CheckValue;
end;

procedure TNovaEdit.KeyDown(var Key: Word; Shift: TShiftState);
begin
  inherited;
  case ValueType of
    ssHHMM:
      begin
        SelLength := 1;
      end;
    ssYYYYMMDD:
      begin
        SelLength := 1;
      end;
  end;
end;

function TNovaEdit.GetPerent(Sender: TWinControl): TWinControl;
begin
  if Sender = nil then
  begin
    Sender := self;
  end;

  if Sender.Parent = nil then
  begin
    result := Sender;
  end
  else
  begin
    result := GetPerent(Sender.Parent);
  end;
end;

procedure TNovaEdit.KeyPress(var Key: Char);
begin
  inherited;
  if FStopErrorKey then
  begin // ' 空格
    if Key in [#39, #32] then
    begin
      Key := #0;
    end;
  end;
  if FAutoTab then
  begin
    if Key = #27 then
    begin
      if FPerTabComponent <> nil then
      begin
        if FPerTabComponent.CanFocus then
        begin
          FPerTabComponent.SetFocus;
        end;
      end
      else
      begin
        selectNext((GetPerent(nil) as Tform).activeControl, false, false);
      end;
    end;
    if Key = #13 then
    begin
      if FNextTabComponent <> nil then
      begin
        if FNextTabComponent.CanFocus then
        begin
          FNextTabComponent.SetFocus;
        end;
      end
      else
      begin
        keybd_event(9, 0, 0, 0);
        keybd_event(9, 0, 2, 0);
      end;
    end;
  end;

end;

procedure TNovaEdit.SetStopErrorKey(const value: boolean);
begin
  FStopErrorKey := value;
end;

procedure TNovaEdit.SetAutoTab(const value: boolean);
begin
  FAutoTab := value;
end;

procedure TNovaEdit.SetNextTabComponent(const value: TWinControl);
begin
  FNextTabComponent := value;
end;

procedure TNovaEdit.SetPerTabComponent(const value: TWinControl);
begin
  FPerTabComponent := value;
end;

procedure TNovaEdit.FindParControl;
var
  i: integer; // StartIndex
  ParForm: TWinControl;
begin
  try
    ParForm := Parent;
    for i := 0 to ParForm.ControlCount - 1 do
    begin
      if ParForm.Controls[i].Name = self.Name then
      begin
        if i = 0 then
        begin
          if (ParForm.Controls[ParForm.ControlCount - 1] as TWinControl)
            .CanFocus then
          begin (ParForm.Controls[ParForm.ControlCount - 1] as TWinControl)
            .SetFocus;
            break;
          end;
        end
        else
        begin
          if (ParForm.Controls[i - 1] as TWinControl).CanFocus then
          begin (ParForm.Controls[i - 1] as TWinControl)
            .SetFocus;
            break;
          end;
        end;
      end;
    end;
  finally

  end;
end;

procedure TNovaEdit.SetOnFocusSelectAll(const value: boolean);
begin
  FOnFocusSelectAll := value;
end;

procedure TNovaEdit.SetEnabled(value: boolean);
begin
  inherited;
end;

procedure TNovaEdit.WMPaint(var Message: TWMPaint);
var
  C: TControlCanvas;
  R: TRect;
begin
  inherited;
  if FDisEnableType then
  begin
    if not Enabled then
    begin
      C := TControlCanvas.Create;
      try
        C.Control := self;
        with C do
        begin
          R := ClientRect;
          C.Font := self.Font;
          C.Font.Color := FDisEnableColor;
          TextOut(R.Left+1, R.Top+1, text + ' ');
        end;
      finally
        C.Free;
      end;
    end;
  end;
end;

procedure TNovaEdit.SetDisEnableType(const value: boolean);
begin
  FDisEnableType := value;
end;

procedure TNovaEdit.SetDisEnableColor(const value: Tcolor);
begin
  FDisEnableColor := value;
end;

procedure TNovaEdit.SetDisEnabledFont(const value: TFont);
begin
  FDisEnabledFont := value;
end;

procedure TNovaEdit.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TNovaEdit.SetonIdChange(const value: TNotifyEvent);
begin
  FOnIDChange := value;
end;

function TNovaEdit.HaveChange: boolean;
begin
  result := false;

  if ((text = '') and (OldValue = '')) then
  begin
    result := false;
  end
  else
  begin
    result := not(trim(text) = trim(FOldValue));
  end;
end;

procedure TNovaEdit.SetOnChangeColor(const value: Tcolor);
begin
  FOnChangeColor := value;
end;

procedure TNovaEdit.SetOnChangeColorSet(const value: boolean);
begin
  FOnChangeColorSet := value;
end;

procedure TNovaEdit.SetOldValue(const value: string);
begin
  FOldValue := value;
  FOnChangeColorSet := value <> '';
end;

procedure TNovaEdit.SetDoNilWhenNum(const value: boolean);
begin
  FDoNilWhenNum := value;
end;

procedure TNovaEdit.SetBindLabel(const value: TLabel);
begin
  FBindLabel := value;
end;

function TNovaEdit.GetChangeText: string;
begin
  result := '';
  if not HaveChange then
    exit;

  if Assigned(FBindLabel) then
  begin
    result := FBindLabel.Caption;
  end;
  if self.OldValue = '' then
  begin
    result := result + '=' + text;
  end
  else
  begin
    result := result + '原:' + self.OldValue + ';新' + text;
  end;
end;

procedure TNovaEdit.WMPaste(var Message: TMessage);
begin

  inherited

end;

end.

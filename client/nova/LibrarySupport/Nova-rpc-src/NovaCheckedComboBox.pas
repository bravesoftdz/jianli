unit NovaCheckedComboBox;

{ ------------------------------------
  功能说明：用于实现可下拉的多选功能
  创建日期：2011/01/30
  作者：lanck
  版权：nova
  ------------------------------------- }
interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,jsonConnection, jsonClientDataSet,db;

type

  TCommInfo = Class(Tobject) // 一个通用的类用于保存一下几个信息，比如机构,有TCombobox的用途都可调用
    ID: Integer;
    Value: String;
    Name: String;
    IsSelected: boolean;
  end;

  THelpOptions = class(TPersistent)
  private
    FDataSourceName: String;
    FQueryAddress: String;
    FJSONConnection: TJSONConnection;
    FHelpType: String;
    FSelectAll: boolean;
    procedure SetDataSourceName(const Value: String);
    procedure SetJSONConnection(const Value: TJSONConnection);
    procedure SetQueryAddress(const Value: String);
    procedure SetHelpType(const Value: String);
    procedure SetSelectAll(const Value: boolean);

  public
    constructor Create(AOwner: TComponent); overload; // virtual;
    destructor Destroy; override;

  published
    Property HJSONConnection: TJSONConnection read FJSONConnection write
      SetJSONConnection;
    Property HDataSourceName
      : String read FDataSourceName write SetDataSourceName;
    Property HQueryAddress: String read FQueryAddress write SetQueryAddress;
    Property HelpType: String read FHelpType write SetHelpType;
    Property SelectAll: boolean read FSelectAll write SetSelectAll;
  end;

  TATCBQuoteStyle = (qsNone, qsSingle, qsDouble);

  TNovaCheckedComboBox = class(TCustomComboBox)
  private
    { Private declarations }
    FListInstance: Pointer;
    FDefListProc: Pointer;
    FListHandle: HWnd;
    FQuoteStyle: TATCBQuoteStyle;
    FColorNotFocus: TColor;
    FCheckedCount: Integer;
    FTextAsHint: boolean;
    FOnCheckClick: TNotifyEvent;
    FVersion: String;
    JsonClientDataSet1: TJsonClientDataSet;
    FHelpOptions: THelpOptions;
    FActive: boolean;
    procedure CNDrawItem(var Message: TWMDrawItem); message CN_DRAWITEM;
    procedure CMEnter(var Message: TCMEnter); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure ListWndProc(var Message: TMessage);
    procedure SetColorNotFocus(Value: TColor);
    procedure SetVersion(Value: String);
    procedure SetActive(const Value: boolean);
    procedure SetHelpOptions(const Value: THelpOptions);
    procedure initParamter;
    function GetParams: TParams;
    procedure SetParams(const Value: TParams);
  protected
    { Protected declarations }
    m_strText: string;
    m_bTextUpdated: boolean;
    procedure WndProc(var Message: TMessage); override;
    procedure RecalcText;
    function GetText: string;
    function GetCheckedCount: Integer;
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetCheck(nIndex: Integer; checked: boolean);
   // function AddChecked(Value: string; checked: boolean): Integer;
    function IsChecked(nIndex: Integer): boolean;
    procedure CheckAll(checked: boolean);
    procedure CheckById(checked: boolean;id:int64);
    property Text: string read GetText;
    property CheckedCount: Integer read GetCheckedCount;
    function GetSelectID:String;
  published
    { Published declarations }
    property Anchors;
    property BiDiMode;
    property Color;
    property ColorNotFocus: TColor read FColorNotFocus write SetColorNotFocus;
    property Constraints;
    property Ctl3D;
    property DragCursor;
    property DragKind;
    property DragMode;
    property DropDownCount;
    property Enabled;
    property Font;
    property ImeMode;
    property ImeName;
    property ItemHeight;
    property Items;
    property MaxLength;
    property ParentBiDiMode;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property QuoteStyle
      : TATCBQuoteStyle read FQuoteStyle write FQuoteStyle default
      qsNone;
    property ShowHint;
    property ShowTextAsHint
      : boolean read FTextAsHint write FTextAsHint default true;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property Version: string read FVersion write SetVersion; // ver 1.1
    property OnChange;
    property OnCheckClick: TNotifyEvent read FOnCheckClick write FOnCheckClick;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnStartDock;
    property OnStartDrag;
    property Active: boolean read FActive write SetActive default False;
    Property HelpOptions: THelpOptions read FHelpOptions write SetHelpOptions;
    property Params: TParams read GetParams write SetParams;
  end;

procedure Register;

implementation

{ TNovaCheckedComboBox }
procedure Register;
begin
  RegisterComponents('Nova', [TNovaCheckedComboBox]);
end;

var
  FCheckWidth, FCheckHeight: Integer;

procedure GetCheckSize;
begin
  with TBitmap.Create do
    try
      Handle := LoadBitmap(0, PChar(32759));
      FCheckWidth := Width div 4;
      FCheckHeight := Height div 3;
    finally
      Free;
    end;
end;

procedure TNovaCheckedComboBox.SetVersion(Value: String);
begin
  // read only
end;

procedure TNovaCheckedComboBox.SetActive(const Value: boolean);
var
   CommInfo:TCommInfo;
   i:integer;
begin
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then
    begin
      initParamter;

      if ((self.FHelpOptions.FJSONConnection.Connected) and
       (JsonClientDataSet1.RemoteServer <> nil)) then
      begin
        with JsonClientDataSet1 do
        begin
          Active := False;
          try
            Active := true;
            if recordcount > 0 then
            begin

              Self.Items.Clear;

              while not eof do
              begin
                CommInfo := TCommInfo.Create;
                CommInfo.ID := Fieldbyname('ID').AsInteger;
                CommInfo.Name := Fieldbyname('name').AsString;
                CommInfo.Value := Fieldbyname('CODE').AsString;
                Self.Items.AddObject(CommInfo.Name, CommInfo);
                Next;
              end;
              if ((FHelpOptions.FSelectAll) and (self.ItemCount>0)) then
              begin
                 for I := 0 to self.ItemCount - 1 do
                 begin
                    TCommInfo(Items.Objects[i]).IsSelected := true;
                 end;
              end;
               // CheckAll(true);
            //  for I := 0 to self.ItemCount - 1 do
            //  begin

                  //TCommInfo(Items.Objects[i]).IsSelected := true;
              //    SetCheck(i,true);
           //   end;
            end;
          except
            on E: Exception do
            begin
              FActive := false;
              ShowMessage('控件信息错误' + E.message);
            end;
          end;
        end;//end   with JsonClientDataSet1 do


      end;
    end;
  end;
end;

procedure TNovaCheckedComboBox.SetCheck(nIndex: Integer; checked: boolean);
begin
  if (nIndex > -1) and (nIndex < Items.count) then
  begin
  //Items.Objects[nIndex] := Tobject(checked);
    TCommInfo(Items.Objects[nIndex]).IsSelected := checked;
    m_bTextUpdated := False;
    Invalidate;
    if Assigned(FOnCheckClick) then
      OnCheckClick(self)
  end;
end;
  {
function TNovaCheckedComboBox.AddChecked(Value: string;
  checked: boolean): Integer;
begin
  result := Items.AddObject(Value, Tobject(checked));
  if result >= 0 then
  begin
    m_bTextUpdated := False;
    Invalidate;
  end;
end;  }

function TNovaCheckedComboBox.IsChecked(nIndex: Integer): boolean;
begin
  result := False;
  if (nIndex > -1) and (nIndex < Items.count) then
   // result := Items.Objects[nIndex] = Tobject(true)
    result := TCommInfo(Items.Objects[nIndex]).IsSelected = true
end;

procedure TNovaCheckedComboBox.CheckAll(checked: boolean);
var
  i: Integer;
begin
  for i := 0 to Items.count - 1 do
    //Items.Objects[i] := Tobject(checked);
  begin
    TCommInfo(Items.Objects[i]).IsSelected := checked;
    SetCheck(i,checked);
  end;
end;

function GetFormatedText(kind: TATCBQuoteStyle; str: string): string;
var
  s: string;
begin
  result := str;
  if length(str) > 0 then
  begin
    s := str;
    case kind of
      qsSingle:
        result := '''' + StringReplace(s, ',', ''',''', [rfReplaceAll]) + '''';
      qsDouble:
        result := '"' + StringReplace(s, ',', '","', [rfReplaceAll]) + '"';
    end;
  end;
end;

function TNovaCheckedComboBox.GetText: string;
begin
  RecalcText;
  if FQuoteStyle = qsNone then
    result := m_strText
  else
    result := GetFormatedText(FQuoteStyle, m_strText);
end;

procedure TNovaCheckedComboBox.initParamter;
begin
  if (JsonClientDataSet1.RemoteServer = nil) then
  begin
    JsonClientDataSet1.RemoteServer := HelpOptions.FJSONConnection;
    if HelpOptions.FQueryAddress = '' then
      JsonClientDataSet1.QueryAddress := 'system/queryhelpcombox'
    else
      JsonClientDataSet1.QueryAddress := HelpOptions.FQueryAddress;
    if HelpOptions.FDataSourceName = '' then
      JsonClientDataSet1.DataSourceName := 'datalist'
    else
      JsonClientDataSet1.DataSourceName := HelpOptions.FDataSourceName;
    if (FHelpOptions.FHelpType<>'') then
    begin
      JsonClientDataSet1.Params.CreateParam(ftString, 'helpType', ptInput);
      JsonClientDataSet1.Params.ParamByName('helpType').Value :=
       FHelpOptions.helpType;
    end;
  end;
end;

function TNovaCheckedComboBox.GetCheckedCount: Integer;
begin
  RecalcText;
  result := FCheckedCount;
end;

function TNovaCheckedComboBox.GetParams: TParams;
begin
  Result:=JsonClientDataSet1.Params;
end;

function TNovaCheckedComboBox.GetSelectID: String;
var
  id:string;
  i:integer;
begin
  id:='';
  for i := 0 to self.ItemCount - 1 do
  begin
    if IsChecked(i) then
    begin
      id:=id+','+inttostr(TCommInfo(Items.Objects[i]).ID);
    end;
  end;
  if length(id)>0 then
    result:='('+copy(id,2,length(id))+')'
  else
    result:='';
end;

procedure TNovaCheckedComboBox.RecalcText;
var
  nCount, i: Integer;
  strItem, strText, strSeparator: string;
begin
  if (not m_bTextUpdated) then
  begin
    FCheckedCount := 0;
    nCount := Items.count;
    strSeparator := '; ';
    strText := '';
    for i := 0 to nCount - 1 do
      if IsChecked(i) then
      begin
        inc(FCheckedCount);
        strItem := Items[i];
        if (strText <> '') then
          strText := strText + strSeparator;
        strText := strText + strItem;
      end;
    // Set the text
    m_strText := strText;
    if FTextAsHint then
      Hint := m_strText;
    m_bTextUpdated := true;
  end;
end;

procedure TNovaCheckedComboBox.SetColorNotFocus(Value: TColor);
begin
  if FColorNotFocus <> Value then
    FColorNotFocus := Value;
  Invalidate
end;

procedure TNovaCheckedComboBox.SetHelpOptions(const Value: THelpOptions);
begin
  FHelpOptions := Value;
end;

procedure TNovaCheckedComboBox.SetParams(const Value: TParams);
begin
  JsonClientDataSet1.Params.Assign(Value);
end;

procedure TNovaCheckedComboBox.CheckById(checked: boolean; id: int64);
var
 i:integer ;
begin
  CheckAll(false);
  for I := 0 to Items.Count - 1 do
  begin
    if TCommInfo(Items.Objects[i]).ID=ID then
    begin
        SetCheck(i,true);
        exit;
    end;
  end;
end;

procedure TNovaCheckedComboBox.CMEnter(var Message: TCMEnter);
begin
  self.Color := clWhite;//;   clInfoBk
  if Assigned(OnEnter) then
    OnEnter(self);
end;

procedure TNovaCheckedComboBox.CMExit(var Message: TCMExit);
begin
  self.Color := FColorNotFocus;
  if Assigned(OnExit) then
    OnExit(self);
end;

procedure TNovaCheckedComboBox.CNDrawItem(var Message: TWMDrawItem);
var
  State: TOwnerDrawState;
  rcBitmap, rcText: Trect;
  nCheck: Integer; // 0 - No check, 1 - Empty check, 2 - Checked
  nState: Integer;
  strText: string;
  ItId: Integer;
  dc: HDC;
begin
  with Message.DrawItemStruct^ do
  begin
    State := TOwnerDrawState(LongRec(itemState).Lo);
    dc := HDC;
    rcBitmap := rcItem;
    rcText := rcItem;
    ItId := itemID;
  end;
  // Check if we are drawing the static portion of the combobox
  if (ItId < 0) then
  begin
    RecalcText();
    strText := m_strText;
    nCheck := 0;
  end
  else
  begin
    strText := Items[ItId];
    rcBitmap.Left := 2;
    rcBitmap.Top := rcText.Top + (rcText.Bottom - rcText.Top - FCheckWidth)
      div 2;
    rcBitmap.Right := rcBitmap.Left + FCheckWidth;
    rcBitmap.Bottom := rcBitmap.Top + FCheckHeight;

    rcText.Left := rcBitmap.Right;
    nCheck := 1;
    if IsChecked(ItId) then
      inc(nCheck);
  end;
  if (nCheck > 0) then
  begin
    SetBkColor(dc, GetSysColor(COLOR_WINDOW));
    SetTextColor(dc, GetSysColor(COLOR_WINDOWTEXT));
    nState := DFCS_BUTTONCHECK;
    if (nCheck > 1) then
      nState := nState or DFCS_CHECKED;
    DrawFrameControl(dc, rcBitmap, DFC_BUTTON, nState);
  end;
  if (odSelected in State) then
  begin
		SetBkColor(dc, clSkyBlue);  // $0091622F
		SetTextColor(dc, GetSysColor(COLOR_HIGHLIGHTTEXT));
  end
  else
  begin
    if (nCheck = 0) then
    begin
      SetTextColor(dc, ColorToRGB(Font.Color));
      SetBkColor(dc, ColorToRGB(FColorNotFocus));
    end
    else
    begin
      SetTextColor(dc, ColorToRGB(Font.Color));
      SetBkColor(dc, ColorToRGB(Brush.Color));
    end;
  end;
  if ItId >= 0 then
    strText := ' ' + strText;
  ExtTextOut(dc, 0, 0, ETO_OPAQUE, @rcText, Nil, 0, Nil);
  DrawText(dc, PChar(strText), length(strText), rcText,
    DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
  if odFocused in State then
    DrawFocusRect(dc, rcText);
end;

// DefWindowProc
procedure TNovaCheckedComboBox.ListWndProc(var Message: TMessage);
var
  nItemHeight, nTopIndex, nIndex: Integer;
  rcItem, rcClient: Trect;
  pt: TPoint;
begin
  case Message.Msg of
    LB_GETCURSEL: // this is for to not draw the selected in the text area
      begin
        Message.result := -1;
        exit;
      end;
    WM_CHAR: // pressing space toggles the checked
      begin
        if (TWMKey(Message).CharCode = VK_SPACE) then
        begin
          // Get the current selection
          nIndex := CallWindowProcA(FDefListProc, FListHandle, LB_GETCURSEL,
              Message.wParam, Message.lParam);
          SendMessage(FListHandle, LB_GETITEMRECT, nIndex, LongInt(@rcItem));
          InvalidateRect(FListHandle, @rcItem, False);
          SetCheck(nIndex, not IsChecked(nIndex));
          SendMessage(WM_COMMAND, Handle, CBN_SELCHANGE, Handle);
          Message.result := 0;
          exit;
        end
      end;
    WM_LBUTTONDOWN:
      begin
        Windows.GetClientRect(FListHandle, rcClient);
        pt.x := TWMMouse(Message).XPos; // LOWORD(Message.lParam);
        pt.y := TWMMouse(Message).YPos; // HIWORD(Message.lParam);
        if (PtInRect(rcClient, pt)) then
        begin
          nItemHeight := SendMessage(FListHandle, LB_GETITEMHEIGHT, 0, 0);
          nTopIndex := SendMessage(FListHandle, LB_GETTOPINDEX, 0, 0);
          // Compute which index to check/uncheck
          nIndex := trunc(nTopIndex + pt.y / nItemHeight);
          SendMessage(FListHandle, LB_GETITEMRECT, nIndex, LongInt(@rcItem));
          if (PtInRect(rcItem, pt)) then
          begin
            InvalidateRect(FListHandle, @rcItem, False);
            SetCheck(nIndex, not IsChecked(nIndex));
            SendMessage(WM_COMMAND, Handle, CBN_SELCHANGE, Handle);
          end
        end
      end;
    WM_LBUTTONUP:
      begin
        Message.result := 0;
        exit;
      end;
  end;
  ComboWndProc(Message, FListHandle, FDefListProc);
end;

constructor TNovaCheckedComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FHelpOptions := THelpOptions.Create(Self);
  JsonClientDataSet1 := TJsonClientDataSet.Create(Self);
//  JsonClientDataSet1.Params.CreateParam(ftString, 'helpType', ptInput);
  ShowHint := true;
  FVersion := '1.2';
  FTextAsHint := true;
  ParentShowHint := False;
  FListHandle := 0;
  FQuoteStyle := qsNone;
  FColorNotFocus := clWhite;//clInfoBk;
  Style := csOwnerDrawVariable;
  m_bTextUpdated := False;
  FListInstance := MakeObjectInstance(ListWndProc);
end;

destructor TNovaCheckedComboBox.Destroy;
begin
  FreeObjectInstance(FListInstance);
  inherited Destroy;
end;

procedure TNovaCheckedComboBox.WndProc(var Message: TMessage);
var
  lWnd: HWnd;
begin
  if message.Msg = WM_CTLCOLORLISTBOX then
  begin
    // If the listbox hasn't been subclassed yet, do so...
    if (FListHandle = 0) then
    begin
      lWnd := message.lParam;
      if (lWnd <> 0) and (lWnd <> FDropHandle) then
      begin
        // Save the listbox handle
        FListHandle := lWnd;
        FDefListProc := Pointer(GetWindowLong(FListHandle, GWL_WNDPROC));
        SetWindowLong(FListHandle, GWL_WNDPROC, LongInt(FListInstance));
      end;
    end;
  end;
  inherited;
end;

{ THelpOptions }

constructor THelpOptions.Create(AOwner: TComponent);
begin
  FQueryAddress := 'system/queryhelpcombox';
  FDataSourceName := 'datalist';
  inherited Create; ;
end;

destructor THelpOptions.Destroy;
begin

  inherited;
end;

procedure THelpOptions.SetDataSourceName(const Value: String);
begin
  FDataSourceName := Value;
end;


procedure THelpOptions.SetHelpType(const Value: String);
begin
  FHelpType := Value;
end;

procedure THelpOptions.SetJSONConnection(const Value: TJSONConnection);
begin
  FJSONConnection := Value;
end;

procedure THelpOptions.SetQueryAddress(const Value: String);
begin
  FQueryAddress := Value;
end;

procedure THelpOptions.SetSelectAll(const Value: boolean);
begin
  FSelectAll := Value;
end;

initialization

GetCheckSize;

end.

unit DesignUtil;

interface

uses
  Windows, SysUtils, Messages, Classes, Controls, Forms, ComObj, ActiveX,
  Graphics, DBClient, DB, Variants, StdCtrls, ExtCtrls, Dialogs,
  Generics.Collections, Generics.Defaults;

const
  GrabHandleSize = 4;

type
  TControlTopComparer<TControl> = class(TComparer<TControl>)
    function Compare(const Left, Right: TControl): Integer; override;
  end;

  TControlLeftComparer<TControl> = class(TComparer<TControl>)
    function Compare(const Left, Right: TControl): Integer; override;
  end;

  TDesignerHook = class;
  TDesignControl = class;

  TCrackComponent = class(TComponent);
    TCrackControl = class(TControl);

    // IDesignerHook的实现部分
    TDesignerHook = class(TInterfacedObject, IDesignerNotify, IDesignerHook)
      private designControls: TDictionary<TControl, TDesignControl>;

    FForm: TCustomForm;
    FRoot: TWinControl;
    FDraggingControl: TControl;
    FDraggingControls: TList<TControl>;
    FDragging: Boolean;
    FBeforDragPos: TPoint;

    FSelecting: Boolean;
    FPointStart, FPointEnd: TPoint;
    FOldRect: TRect;
    FNewRect: TRect;
    FMouseRect: TRect; // 鼠标被限制的范围
    procedure MouseLock(Sender: TControl); // 锁定鼠标到某一个范围
    procedure MouseFree(); // 释放对鼠标的锁定

    function OnMessage(Sender: TControl; var Message: TMessage): Boolean;
    procedure Remove(AControl: TControl); overload;
    function Add(AControl: TControl): TControl; overload;
    procedure RemoveSelect(AControl: TControl); overload;
    function AddSelect(AControl: TControl): TControl; overload;
    procedure ShowGrabHandle(AControl: TControl; const Show: Boolean); overload;
    procedure posGrabHandle(AControl: TControl); overload;
    procedure SetDragging(const Value: Boolean);
    function GetControlCount: Integer;
    function GetControls(Index: Integer): TControl;
    procedure AddSelectRectControls(Parent: TWinControl; Rect: TRect);
    function OwnerCheck(Sender: TControl; CheckOnwer: TComponent): Boolean;
    procedure SynchroTop;
    procedure SynChroLeft;
    procedure SynchroWidth;
    procedure SynChroHeight;

    procedure MouseDown(Sender: TControl; Button: TMouseButton;
      Shift: TShiftState; X: Integer; Y: Integer); virtual;
    procedure MouseUp(Sender: TControl; Button: TMouseButton;
      Shift: TShiftState; X: Integer; Y: Integer); virtual;
    procedure MouseMove(Sender: TControl; Shift: TShiftState; X: Integer;
      Y: Integer); virtual;
    procedure KeyDown(Sender: TControl; var Key: Word; Shift: TShiftState);
      virtual;
  private
    FOnPaintForm: TNotifyEvent;
    procedure setRoot(const Value: TWinControl);
  public
    constructor Create();
    destructor Destroy; override;

    property Dragging: Boolean read FDragging write SetDragging;
    property ControlCount: Integer read GetControlCount;
    property Controls[Index: Integer]: TControl read GetControls;
  public
    { IDesignerNotify 的接口 }
    procedure Modified;
    procedure Notification(AnObject: TPersistent; Operation: TOperation);
  public
    procedure DoMouseDown(Sender: TControl; Button: TMouseButton;
      Shift: TShiftState; X: Integer; Y: Integer);
    procedure DoMouseUp(Sender: TControl; Button: TMouseButton;
      Shift: TShiftState; X: Integer; Y: Integer); virtual;
    procedure DoMouseMove(Sender: TControl; Shift: TShiftState; X: Integer;
      Y: Integer);
    procedure DoKeyDown(Sender: TControl; var Key: Word; Shift: TShiftState);
    // property CDS: TClientDataSet read FCDS write SetCDS;
    property OnPaintForm: TNotifyEvent read FOnPaintForm write FOnPaintForm;
    procedure Clear();
    procedure ClearSelect();
    procedure AlignLeft;
    procedure AlignRight;
    procedure AlignCenterV;
    procedure SpaceEquallyV;
    procedure AlignTop;
    procedure AlignBottom;
    procedure AlignCenterH;
    procedure SpaceEquallyH;
    procedure WidthGrow;
    procedure WidthCut;
    procedure HeightGrow;
    Procedure HeightCut;
    procedure InputWidth;
    procedure InputHeight;
  public
    { IDesignerHook 的接口 }
    function GetCustomForm: TCustomForm;
    procedure SetCustomForm(Value: TCustomForm);
    function GetIsControl: Boolean;
    procedure SetIsControl(Value: Boolean);
    function IsDesignMsg(Sender: TControl; var Message: TMessage): Boolean;
    procedure PaintGrid;
    procedure PaintMenu;
    procedure ValidateRename(AComponent: TComponent;
      const CurName, NewName: string);
    function UniqueName(const BaseName: string): string;
    function GetRoot: TComponent;

    property IsControl: Boolean read GetIsControl write SetIsControl;
    property Form: TCustomForm read GetCustomForm write SetCustomForm;
    property Root: TWinControl read FRoot write setRoot;
  end;

  // 小黑点的方向性
  TGrabHandleDirect = (fdLeftUp, fdUp, fdRightUp, fdRight, fdRightDown, fdDown,
    fdLeftDown, fdLeft);

  // 就是选中时空间边上那八个小黑点
  TGrabHandle = class(TCustomControl)
  private
    // FManager: TGrabHandleManager;
    FControl: TControl;
    FDirect: TGrabHandleDirect;
    // FDesigner: TDesignerHook;
    FDesignControl: TDesignControl;
    procedure Pos();
  protected
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X: Integer;
      Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X: Integer; Y: Integer); override;
  public
    constructor Create(designControl: TDesignControl;
      ADirect: TGrabHandleDirect);
    destructor Destroy; override;

    // property Designer: TDesignerHook read GetDesigner;
  end;

  TDesignControl = class(TComponent)
  private
    FControl: TControl;
    FBeforDragPos: TPoint;
    FSelected: Boolean; // 当前是否选中
    Dragging: Boolean;
    grabHandles: TDictionary<TGrabHandleDirect, TGrabHandle>;
  public
    constructor Create(AControl: TControl); dynamic;
  end;

function CreateComponent(iType: Integer; CDS: TClientDataSet;
  CtrlParent: TWinControl): TControl;

// 开始设计.设计整个窗口里,以窗口为Owner的控件
function BeginDesign(Form: TCustomForm): TDesignerHook; overload;
// 开始设计.设计窗口里,Root控件为Owner的控件
function BeginDesign(Form: TCustomForm; Root: TWinControl): TDesignerHook;
  overload;
// 终止设计
procedure EndDesign(Form: TCustomForm);

implementation

{ TDesignControl }

constructor TDesignControl.Create(AControl: TControl);
var
  D: TGrabHandleDirect;
begin
  inherited Create(nil);
  Self.FControl := AControl;
  grabHandles := TDictionary<TGrabHandleDirect, TGrabHandle>.Create;
  for D := fdLeftUp to fdLeft do
    grabHandles.Add(D, TGrabHandle.Create(Self, D));
end;

// 点到区的转化
function PointToRect(pt1, pt2: TPoint): TRect;
begin
  if pt1.X < pt2.X then
  begin
    Result.Left := pt1.X;
    Result.Right := pt2.X;
  end
  else
  begin
    Result.Left := pt2.X;
    Result.Right := pt1.X;
  end;
  if pt1.Y < pt2.Y then
  begin
    Result.Top := pt1.Y;
    Result.Bottom := pt2.Y;
  end
  else
  begin
    Result.Top := pt2.Y;
    Result.Bottom := pt1.Y;
  end;
end;

procedure EditFieldValue(CDS: TClientDataSet;
  const KeyFields, EditFields: string; const KeyValues, EditValues: Variant);
var
  I: Integer;
  Value: Variant;
  EFields: TList;
begin
  with CDS do
  begin
    First;
    if Locate(KeyFields, KeyValues, []) then
    begin
      Edit;
      EFields := TList.Create;
      try
        GetFieldList(EFields, EditFields);
        for I := 0 to EFields.Count - 1 do
        begin
          if (EFields.Count = 1) and not VarIsArray(EditValues) then
            Value := EditValues
          else
            Value := EditValues[I];
          TField(EFields[I]).Value := Value;
        end;
      finally
        EFields.Free;
      end;
      post;
    end;
  end;
end;

function CreateComponent(iType: Integer; CDS: TClientDataSet;
  CtrlParent: TWinControl): TControl;
begin
  if (iType = 1) or (iType = 11) or (iType = 3) then
  begin
    Result := TLabel.Create(nil);
  end
  else if (iType = 2) or (iType = 21) then
  begin
    Result := TImage.Create(nil);
  end;
  if Assigned(Result) then
    with Result do
    begin
      Parent := CtrlParent;
      Visible := False;
      // CDS.FieldByName('iPageName').AsString +
      Name := CDS.FieldByName('iname').AsString;
      Left := CDS.FieldByName('ileft').AsInteger;
      Top := CDS.FieldByName('iTop').AsInteger;
      Width := CDS.FieldByName('iWidth').AsInteger;
      Height := CDS.FieldByName('iHeight').AsInteger;
      Tag := 99;
    end;
end;

function BeginDesign(Form: TCustomForm): TDesignerHook;
begin
  Result := BeginDesign(Form, Form);
end;

function BeginDesign(Form: TCustomForm; Root: TWinControl): TDesignerHook;
var
  Designer: TDesignerHook;
begin
  Designer := TDesignerHook.Create();
  Designer.Form := Form;
  Designer.Root := Root;

  Result := Designer;

  Form.Designer := Result;
  // TCrackComponent(Form).SetDesigning(True, False);
  // TCrackComponent(Root).SetDesigning(True, True);

end;

procedure EndDesign(Form: TCustomForm);
begin
  TCrackComponent(Form).SetDesigning(False, True);
  Form.Designer := nil;
end;

{ TDesignerHook }

function TDesignerHook.Add(AControl: TControl): TControl;
var
  D: TGrabHandleDirect;
  designControl: TDesignControl;
begin
  Result := AControl;
  designControl := TDesignControl.Create(AControl);
  designControls.Add(AControl, designControl);
end;

procedure TDesignerHook.AddSelectRectControls(Parent: TWinControl; Rect: TRect);
  function InRect(R1, R2: TRect): Boolean;
  begin
    Result := False;
    if not IntersectRect(R1, R1, R2) then
      Exit;
    Result := not IsRectEmpty(R1);
  end;

var
  I: Integer;
  iRect: TRect;
  iL, iR, iB, iT: Integer;
  iType: Integer;
  cName: string;
begin
  ClearSelect();
  for I := 0 to Parent.ControlCount - 1 do
    if (Parent.Controls[I].Tag <> 1000) and InRect(Rect,
      Parent.Controls[I].BoundsRect) and OwnerCheck(Parent.Controls[I], FRoot)
      then
    begin
      AddSelect(Parent.Controls[I]);
    end;
end;

function TDesignerHook.AddSelect(AControl: TControl): TControl;
begin
  FDraggingControls.Add(AControl);
  ShowGrabHandle(AControl, True);
end;

procedure TDesignerHook.AlignBottom;
var
  iLastBottom, I: Integer;
  draggingControl: TControl;
begin
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if I <> 0 then
    begin
      draggingControl.Top := iLastBottom - draggingControl.Height;
      posGrabHandle(draggingControl);
    end
    else
    begin
      iLastBottom := draggingControl.Top + draggingControl.Height;
    end;
    inc(I);
  end;
  SynchroTop;
end;

procedure TDesignerHook.AlignCenterH;
var
  iMidRight, I: Integer;
  draggingControl: TControl;
begin
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if I <> 0 then
    begin
      draggingControl.Left := iMidRight - draggingControl.Width div 2;
      posGrabHandle(draggingControl);
    end
    else
    begin
      iMidRight := draggingControl.Left + draggingControl.Width div 2;
    end;
    inc(I);
  end;
  SynChroLeft;
end;

procedure TDesignerHook.AlignCenterV;
var
  iMidBottom, I: Integer;
  draggingControl: TControl;
begin
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if I <> 0 then
    begin
      draggingControl.Top := iMidBottom - draggingControl.Height div 2;
      posGrabHandle(draggingControl);
    end
    else
    begin
      iMidBottom := draggingControl.Top + draggingControl.Height div 2;
    end;
    inc(I);
  end;
  SynchroTop;
end;

procedure TDesignerHook.AlignLeft;
var
  iLeft, I: Integer;
  draggingControl: TControl;
begin
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if I <> 0 then
    begin
      draggingControl.Left := iLeft;
      posGrabHandle(draggingControl);
    end
    else
    begin
      iLeft := draggingControl.Left;
    end;
    inc(I);
  end;
  SynChroLeft;
end;

procedure TDesignerHook.AlignRight;
var
  iRight, I: Integer;
  draggingControl: TControl;
begin
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if I <> 0 then
    begin
      draggingControl.Left := iRight - draggingControl.Width;
      posGrabHandle(draggingControl);
    end
    else
    begin
      iRight := draggingControl.Left + draggingControl.Width;
    end;
    inc(I);
  end;
  SynChroLeft;
end;

procedure TDesignerHook.AlignTop;
var
  iTop, I: Integer;
  draggingControl: TControl;
begin
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if I <> 0 then
    begin
      draggingControl.Top := iTop;
      posGrabHandle(draggingControl);
    end
    else
    begin
      iTop := draggingControl.Top;
    end;
    inc(I);
  end;
  SynchroTop;
end;

procedure TDesignerHook.Clear;
begin
  while designControls.Keys.GetEnumerator.MoveNext do
  begin
    Remove(designControls.Keys.GetEnumerator.Current);
  end;
end;

procedure TDesignerHook.ClearSelect;
var
  AControl: TControl;
begin
  for AControl in FDraggingControls do
  begin
    ShowGrabHandle(AControl, False);
  end;
  FDraggingControls.Clear;
end;

constructor TDesignerHook.Create;
begin
  designControls := TDictionary<TControl, TDesignControl>.Create;
  FDraggingControls := TList<TControl>.Create
end;

destructor TDesignerHook.Destroy;
begin
  if FForm <> nil then
    TCrackComponent(FForm).SetDesigning(False, True);

  // FGrabHandleManager.Free;
  // FControls.Free;
  inherited Destroy;
end;

procedure TDesignerHook.DoKeyDown(Sender: TControl; var Key: Word;
  Shift: TShiftState);
begin
  KeyDown(Sender, Key, Shift);
end;

procedure TDesignerHook.DoMouseDown(Sender: TControl; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseDown(Sender, Button, Shift, X, Y);
end;

procedure TDesignerHook.DoMouseMove(Sender: TControl; Shift: TShiftState;
  X, Y: Integer);
begin
  MouseMove(Sender, Shift, X, Y);
end;

procedure TDesignerHook.DoMouseUp(Sender: TControl; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  MouseUp(Sender, Button, Shift, X, Y);
end;

function TDesignerHook.GetControlCount: Integer;
begin
  Result := designControls.Count;
end;

function TDesignerHook.GetControls(Index: Integer): TControl;
var
  I: Integer;
begin
  I := 0;
  Result := nil;
  while designControls.Keys.GetEnumerator.MoveNext do
  begin
    if index = I then
    begin
      Result := designControls.Keys.GetEnumerator.Current;
      break;
    end;
    inc(I);
  end;
end;

function TDesignerHook.GetCustomForm: TCustomForm;
begin
  Result := FForm;
end;

function TDesignerHook.GetIsControl: Boolean;
begin
  Result := TCrackControl(FForm).IsControl;
end;

function TDesignerHook.GetRoot: TComponent;
begin
  Result := FForm;
end;

procedure TDesignerHook.HeightCut;
var
  IMinH: Integer;
  draggingControl: TControl;
begin
  if FDraggingControls.Count < 2 then
    Exit;
  IMinH := MaxInt;
  for draggingControl in FDraggingControls do
  begin
    if draggingControl.Height < IMinH then
    begin
      IMinH := draggingControl.Height;
    end;
  end;
  for draggingControl in FDraggingControls do
  begin
    draggingControl.Height := IMinH;
      posGrabHandle(draggingControl);
  end;
  SynChroHeight;
end;

procedure TDesignerHook.HeightGrow;
var
  IMaxH: Integer;
  draggingControl: TControl;
begin
  if FDraggingControls.Count < 2 then
    Exit;
  IMaxH := -MaxInt;
  for draggingControl in FDraggingControls do
  begin
    if draggingControl.Height > IMaxH then
    begin
      IMaxH := draggingControl.Height;
    end;
  end;
  for draggingControl in FDraggingControls do
  begin
    draggingControl.Height := IMaxH;
      posGrabHandle(draggingControl);
  end;
  SynChroHeight;
end;

function TDesignerHook.OnMessage(Sender: TControl;
  var Message: TMessage): Boolean;
var
  I: Integer;
begin
  Result := ((Message.Msg >= WM_MOUSEFIRST) and (Message.Msg <= WM_MOUSELAST))
    or ((Message.Msg >= WM_KEYFIRST) and (Message.Msg <= WM_KEYLAST));

  case Message.Msg of
    WM_LBUTTONDOWN:
      MouseDown(Sender, mbLeft, KeysToShiftState(TWMMouse(Message).Keys),
        TWMMouse(Message).XPos, TWMMouse(Message).YPos);
    WM_MOUSEMOVE:
      begin
        MouseMove(Sender, KeysToShiftState(TWMMouse(Message).Keys),
          TWMMouse(Message).XPos, TWMMouse(Message).YPos);

      end;
    WM_LBUTTONUP:
      begin
        MouseUp(Sender, mbLeft, KeysToShiftState(TWMMouse(Message).Keys),
          TWMMouse(Message).XPos, TWMMouse(Message).YPos);
      end;
    WM_KEYDOWN:
      begin
        KeyDown(Sender, TWMKey(Message).CharCode,
          KeyDataToShiftState(TWMKey(Message).KeyData));
      end;
  end;
  if Sender = FForm then
    Result := False;

end;

procedure TDesignerHook.InputHeight;
var
  str: string;
  I, iHeight: Integer;
  draggingControl: TControl;
begin
  str := Dialogs.InputBox('高度调整', '请输入高度', '');
  iHeight := StrToIntDef(str, 0);
  if iHeight > 0 then
  begin
    for draggingControl in FDraggingControls do
    begin
      draggingControl.Width := iHeight;
      posGrabHandle(draggingControl);
    end;
  end;
  SynChroHeight;
end;

procedure TDesignerHook.InputWidth;
var
  str: string;
  iWidth: Integer;
  draggingControl: TControl;
begin
  if FDraggingControls.Count <= 0 then
    Exit;
  str := Dialogs.InputBox('宽度调整', '请输入宽度', '');
  iWidth := StrToIntDef(str, 0);
  if iWidth > 0 then
  begin
    for draggingControl in FDraggingControls do
    begin
      draggingControl.Width := iWidth;
      posGrabHandle(draggingControl);
    end;
  end;
  SynchroWidth;
end;

function TDesignerHook.IsDesignMsg(Sender: TControl;
  var Message: TMessage): Boolean;
begin
  Result := False;
  if (Sender is TGrabHandle) then
    Exit;

  case Message.Msg of
    WM_MOUSEFIRST .. WM_MOUSELAST, WM_KEYFIRST .. WM_KEYLAST:
      Result := OnMessage(Sender, Message);
  end;
end;

procedure TDesignerHook.KeyDown(Sender: TControl; var Key: Word;
  Shift: TShiftState);
var
  I: Integer;
begin
  if (ControlCount = 0) or ((not(ssShift in Shift)) and (not(ssCtrl in Shift)))
    or (Key in [VK_CONTROL, VK_SHIFT]) then
    Exit;
  if (ControlCount = 1) and (Controls[0] = FForm) then
    Exit;

  if ssCtrl in Shift then
  begin
    case Key of
      VK_UP:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              Controls[I].Top := Controls[I].Top - 1;
              // EditFieldValue(CDS, 'iname', 'iTop', Controls[i].Name, Controls[I].Top);
              if Assigned(FOnPaintForm) then
                FOnPaintForm(FForm);
              Form.Repaint;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
      VK_DOWN:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              Controls[I].Top := Controls[I].Top + 1;
              // EditFieldValue(CDS, 'iname', 'iTop', Controls[i].Name, Controls[I].Top);
              if Assigned(FOnPaintForm) then
                FOnPaintForm(FForm);
              Form.Invalidate;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
      VK_LEFT:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              Controls[I].Left := Controls[I].Left - 1;
              // EditFieldValue(CDS, 'iname', 'iLeft', Controls[i].Name, Controls[I].Left);
              if Assigned(FOnPaintForm) then
                FOnPaintForm(FForm);
              Form.Invalidate;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
      VK_RIGHT:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              Controls[I].Left := Controls[I].Left + 1;
              // EditFieldValue(CDS, 'iname', 'iLeft', Controls[i].Name, Controls[I].Left);
              if Assigned(FOnPaintForm) then
                FOnPaintForm(FForm);
              Form.Invalidate;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
    end;
  end
  else
  begin
    case Key of
      VK_UP:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              if Controls[I].Height - 1 > 1 then
              begin
                Controls[I].Height := Controls[I].Height - 1;
                // EditFieldValue(CDS, 'iname', 'iHeight', Controls[i].Name, Controls[I].Height);
                if Assigned(FOnPaintForm) then
                  FOnPaintForm(FForm);
                Form.Invalidate;
              end;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
      VK_DOWN:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              if Controls[I].Height + 1 > 1 then
              begin
                Controls[I].Height := Controls[I].Height + 1;
                // EditFieldValue(CDS, 'iname', 'iHeight', Controls[i].Name, Controls[I].Height);
                if Assigned(FOnPaintForm) then
                  FOnPaintForm(FForm);
                Form.Invalidate;
              end;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
      VK_LEFT:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              if Controls[I].Width - 1 > 1 then
              begin
                Controls[I].Width := Controls[I].Width - 1;
                // EditFieldValue(CDS, 'iname', 'iWidth', Controls[i].Name, Controls[I].Width);
                if Assigned(FOnPaintForm) then
                  FOnPaintForm(FForm);
                Form.Invalidate;
              end;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
      VK_RIGHT:
        begin
//          ShowGrabHandle(False);
          try
            for I := 0 to ControlCount - 1 do
            begin
              if Controls[I].Width + 1 > 1 then
              begin
                Controls[I].Width := Controls[I].Width + 1;
                // EditFieldValue(CDS, 'iname', 'iWidth', Controls[i].Name, Controls[I].Width);
                if Assigned(FOnPaintForm) then
                  FOnPaintForm(FForm);
                Form.Invalidate;
              end;
            end;
          finally
//            ShowGrabHandle(True);
          end;
        end;
    end;
  end;
end;

procedure TDesignerHook.Modified;
begin
end;

procedure TDesignerHook.MouseDown(Sender: TControl; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  iPoint: TPoint;
  iRect: TRect;
  iL, iR, iB, iT: Integer;
  iType: Integer;
  // cName: string;
  selected: Boolean;
begin
  Dragging := designControls.ContainsKey(Sender);
  selected := FDraggingControls.Contains(Sender);
  if (ssShift in Shift) then // 按Shift多选
  begin
    if (not selected) and Dragging then
    begin
      AddSelect(Sender);
    end
    else if selected and Dragging then
    begin
      FDraggingControls.Remove(Sender);
    end;
  end
  else if (ssCtrl in Shift) then
  begin
    ClearSelect();
    if (Sender is TWinControl) then
    begin
      if (TWinControl(Sender).ControlCount = 0) then
      begin
        if (not selected) and Dragging then
        begin
          AddSelect(Sender);
        end;
      end
      else
      begin
        FPointStart := Sender.ClientToScreen(Point(X, Y));
        FOldRect := Rect(X, Y, X + 1, Y + 1);
        FSelecting := True;
        SetCaptureControl(Sender);
      end;
      Exit;
    end;
  end
  else // 没按Shift也没按Ctrl点击.那就添加自己到选择的控件组中 .Root和Form不能和别的控件同时在组中
  begin
    if not Dragging then
    begin
      ClearSelect();
    end;
    if (not selected) and Dragging then
    begin
      ClearSelect();
      AddSelect(Sender);
    end;
    FDraggingControl := Sender;
    MouseLock(Sender);
  end;
  FBeforDragPos := Sender.ClientToScreen(Point(X, Y));
end;

procedure TDesignerHook.MouseFree;
begin
  SetCaptureControl(nil);
  ClipCursor(@FMouseRect);
end;

procedure TDesignerHook.MouseLock(Sender: TControl);
var
  R: TRect;
begin
  SetCaptureControl(Sender);
  GetClipCursor(FMouseRect);

  if Sender.Parent = nil then
    Exit;

  R := Sender.Parent.ClientRect;
  R.TopLeft := Sender.Parent.ClientToScreen(R.TopLeft);
  R.BottomRight := Sender.Parent.ClientToScreen(R.BottomRight);
  ClipCursor(@R); // 把鼠标锁定在固定区域
end;

procedure TDesignerHook.MouseMove(Sender: TControl; Shift: TShiftState;
  X, Y: Integer);
var
  I: Integer;
  CPos: TPoint;
  DC: HDC;
  AControl: TControl;
begin
  if Dragging then
  begin
    CPos := Mouse.CursorPos;
    if (FBeforDragPos.X <> CPos.X) or (FBeforDragPos.Y <> CPos.Y) then
      for AControl in FDraggingControls do
      begin
        AControl.Left := AControl.Left - (FBeforDragPos.X - CPos.X);
        AControl.Top := AControl.Top - (FBeforDragPos.Y - CPos.Y);
        posGrabHandle(AControl);
      end;
    FBeforDragPos := CPos;
  end
  else if FSelecting then
  begin
    FPointEnd := Sender.ClientToScreen(Point(X, Y));
    FNewRect := PointToRect(FPointStart, FPointEnd);
    DC := GetDC(0);
    DrawFocusRect(DC, FOldRect);
    DrawFocusRect(DC, FNewRect);
    ReleaseDC(0, DC);
    FOldRect := FNewRect;
  end;
end;

procedure TDesignerHook.MouseUp(Sender: TControl; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  DC: HDC;
begin
  if Dragging then
  begin
    MouseFree();
    Dragging := False;
  end;
  if FSelecting then
  begin
    DC := GetDC(0);
    DrawFocusRect(DC, FOldRect);
    ReleaseDC(0, DC);
    FSelecting := False;
    SetCaptureControl(nil);
    if Sender is TWinControl then
    begin
      FOldRect.TopLeft := Sender.ScreenToClient(FOldRect.TopLeft);
      FOldRect.BottomRight := Sender.ScreenToClient(FOldRect.BottomRight);
      FOldRect := PointToRect(FOldRect.TopLeft, FOldRect.BottomRight);
      AddSelectRectControls(TWinControl(Sender), FOldRect);
    end;
  end;
end;

procedure TDesignerHook.Notification(AnObject: TPersistent;
  Operation: TOperation);
begin
  case Operation of
    opRemove:
      begin
        if AnObject is TControl then
        begin
          Remove(TControl(AnObject));
        end;
        if AnObject = FForm then
        begin
          TCrackComponent(FForm).SetDesigning(False, True);
          FForm := nil;
        end;
      end;
    opInsert:
      begin
      end;
  end;

end;

procedure TDesignerHook.PaintGrid;
begin

end;

procedure TDesignerHook.PaintMenu;
begin

end;

procedure TDesignerHook.posGrabHandle(AControl: TControl);
var
  designControl: TDesignControl;
  values: TDictionary<TGrabHandleDirect, TGrabHandle>.TValueEnumerator;
begin
  inherited;
  designControl := designControls.Items[AControl];
  if designControl <> nil then
  begin
    values := designControl.grabHandles.values.GetEnumerator;
    while values.MoveNext do
    begin
      values.Current.Pos;
    end;
  end;
end;

function TDesignerHook.OwnerCheck(Sender: TControl;
  CheckOnwer: TComponent): Boolean;
var
  W: TComponent;
begin
  Result := False;
  W := Sender.Owner;
  while W <> nil do
  begin
    if W = CheckOnwer then
    begin
      Result := True;
      Exit;
    end;
    W := W.Owner;
  end;
end;

procedure TDesignerHook.Remove(AControl: TControl);
var
  designControl: TDesignControl;
begin
  if designControls.ContainsKey(AControl) then
  begin
    designControl := designControls.Items[AControl];
    designControls.Remove(AControl);
    designControl.Free;
  end;
end;

procedure TDesignerHook.RemoveSelect(AControl: TControl);
begin
  FDraggingControls.Remove(AControl);
  ShowGrabHandle(AControl, False);
end;

procedure TDesignerHook.SetCustomForm(Value: TCustomForm);
begin
FForm:=Value;
TCrackComponent(FForm).SetDesigning(true, false);

end;

procedure TDesignerHook.SetDragging(const Value: Boolean);
var
  I: Integer;
begin
  FDragging := Value;
end;

procedure TDesignerHook.SetIsControl(Value: Boolean);
begin
  if FForm is TControl then
    TCrackControl(FForm).IsControl := Value;
end;

procedure TDesignerHook.setRoot(const Value: TWinControl);
var
  I: Integer;
begin
  FRoot := Value;
  for I := 0 to Value.ControlCount - 1 do
    if Value.Controls[I] is TLabel then
    begin
      Self.Add(Value.Controls[I]);
    end;
end;

procedure TDesignerHook.ShowGrabHandle(AControl: TControl; const Show: Boolean);
var
  designControl: TDesignControl;
  values: TDictionary<TGrabHandleDirect, TGrabHandle>.TValueEnumerator;
begin
  inherited;
  designControl := designControls.Items[AControl];
  if designControl <> nil then
  begin
    values := designControl.grabHandles.values.GetEnumerator;
    while values.MoveNext do
    begin
      values.Current.Visible := Show;
    end;
  end;
end;

procedure TDesignerHook.SpaceEquallyH;
var
  I: Integer;
  draggingControl: TControl;
  wSpace, iMax, iMin, totalwidth: Integer;
begin
  if FDraggingControls.Count < 3 then
    Exit;
  FDraggingControls.Sort(TControlLeftComparer<TControl>.Create);
  iMax := FDraggingControls.Last.Left + FDraggingControls.Last.Width;
  iMin := FDraggingControls.First.Left;
  totalwidth := 0;
  for draggingControl in FDraggingControls do
  begin
    totalwidth := totalwidth + draggingControl.Width;
  end;
  wSpace := (iMax - iMin - totalwidth) div (FDraggingControls.Count - 1);
  totalwidth := 0;
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if (I >= 1) and (I <= FDraggingControls.Count - 2) then
    begin
      draggingControl.Left := iMin+ totalwidth + I * wSpace;
      posGrabHandle(draggingControl);
    end;
    totalwidth := totalwidth + draggingControl.Width;
    inc(I);
  end;
  SynChroLeft;
end;

procedure TDesignerHook.SpaceEquallyV;
var
  I: Integer;
  draggingControl: TControl;
  wSpace, iMax, iMin, totalheight: Integer;
begin
  if FDraggingControls.Count < 3 then
    Exit;
  FDraggingControls.Sort(TControlTopComparer<TControl>.Create);
  iMax := FDraggingControls.Last.Top + FDraggingControls.Last.Height;
  iMin := FDraggingControls.First.Top;
  totalheight := 0;
  for draggingControl in FDraggingControls do
  begin
    totalheight := totalheight + draggingControl.Height;
  end;
  wSpace := (iMax - iMin - totalheight) div (FDraggingControls.Count - 1);
  totalheight := 0;
  I := 0;
  for draggingControl in FDraggingControls do
  begin
    if (I >= 1) and (I <= FDraggingControls.Count - 2) then
    begin
      draggingControl.Top := iMin+totalheight + I * wSpace;
      posGrabHandle(draggingControl);
    end;
    totalheight := totalheight + draggingControl.Height;
    inc(I);
  end;
  SynchroTop;
end;

procedure TDesignerHook.SynChroHeight;
var
  I: Integer;
begin
  // for I := 0 to FControls.Count - 1 do
  // begin
  // EditFieldValue(FCDS, 'iName', 'iHeight', TControl(FControls[I]).Name,
  // TControl(FControls[I]).Height);
  // end;
//  ShowGrabHandle(False);
  if Assigned(FOnPaintForm) then
    FOnPaintForm(FForm);
  FForm.Invalidate;
//  ShowGrabHandle(True);
end;

procedure TDesignerHook.SynChroLeft;
var
  I: Integer;
begin
  // for I := 0 to FControls.Count - 1 do
  // begin
  // EditFieldValue(FCDS, 'iName', 'iLeft', TControl(FControls[I]).Name,
  // TControl(FControls[I]).Left);
  // end;
//  ShowGrabHandle(False);
  if Assigned(FOnPaintForm) then
    FOnPaintForm(FForm);
  FForm.Invalidate;
//  ShowGrabHandle(True);
end;

procedure TDesignerHook.SynchroTop;
var
  I: Integer;
begin
  // for I := 0 to FControls.Count - 1 do
  // begin
  // EditFieldValue(FCDS, 'iName', 'iTop', TControl(FControls[I]).Name,
  // TControl(FControls[I]).Top);
  // end;
//  ShowGrabHandle(False);
  if Assigned(FOnPaintForm) then
    FOnPaintForm(FForm);
  FForm.Invalidate;
//  ShowGrabHandle(True);
end;

procedure TDesignerHook.SynchroWidth;
var
  I: Integer;
begin
  // for I := 0 to FControls.Count - 1 do
  // begin
  // EditFieldValue(FCDS, 'iName', 'iWidth', TControl(FControls[I]).Name,
  // TControl(FControls[I]).Width);
  // end;
//  ShowGrabHandle(False);
  if Assigned(FOnPaintForm) then
    FOnPaintForm(FForm);
  FForm.Invalidate;
//  ShowGrabHandle(True);
end;

function TDesignerHook.UniqueName(const BaseName: string): string;
var
  guid: TGuid;
  s: string;
begin
  OleCheck(CoCreateGuid(guid));
  s := GuidToString(guid);
  s := Copy(s, 2, Length(s) - 2); //
  s := StringReplace(s, '-', '', []);
  Result := BaseName + s;
end;

procedure TDesignerHook.ValidateRename(AComponent: TComponent;
  const CurName, NewName: string);
begin

end;

procedure TDesignerHook.WidthCut;
var
  IMinW: Integer;
  draggingControl: TControl;
begin
  if FDraggingControls.Count < 2 then
    Exit;
  IMinW := MaxInt;
  for draggingControl in FDraggingControls do
  begin
    if draggingControl.Width < IMinW then
    begin
      IMinW := draggingControl.Width;
    end;
  end;
  for draggingControl in FDraggingControls do
  begin
    draggingControl.Width := IMinW;
      posGrabHandle(draggingControl);
  end;
  SynchroWidth;
end;

procedure TDesignerHook.WidthGrow;
var
  IMaxW: Integer;
  draggingControl: TControl;
begin
  if FDraggingControls.Count < 2 then
    Exit;
  IMaxW := -MaxInt;
  for draggingControl in FDraggingControls do
  begin
    if draggingControl.Width > IMaxW then
    begin
      IMaxW := draggingControl.Width;
    end;
  end;
  for draggingControl in FDraggingControls do
  begin
    draggingControl.Width := IMaxW;
      posGrabHandle(draggingControl);
  end;
  SynchroWidth;
end;

{ TGrabHandle }

constructor TGrabHandle.Create(designControl: TDesignControl;
  ADirect: TGrabHandleDirect);
begin
  inherited Create(designControl);
  Color := clBlack;
  FDirect := ADirect;
  FDesignControl := designControl;
  FControl := designControl.FControl;
  Visible := False;
  Parent := designControl.FControl.Parent;
  Pos();
end;

destructor TGrabHandle.Destroy;
begin
  inherited Destroy;
end;

procedure TGrabHandle.MouseDown(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  // if Designer.ControlCount > 1 then
  // Exit;
  // Designer.Dragging := True;
  // Designer.FBeforDragPos := ClientToScreen(Point(X, Y));
  // MouseCapture := True;

  FDesignControl.Dragging := True;
  FDesignControl.FBeforDragPos := ClientToScreen(Point(X, Y));
  MouseCapture := True;
end;

procedure TGrabHandle.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  CPos: TPoint;
  cX, cY: Integer;
begin
  inherited MouseMove(Shift, X, Y);
  // if not Designer.Dragging then
  if not FDesignControl.Dragging then
    Exit;
  CPos := ClientToScreen(Point(X, Y));
  {
    for I := 0 to Designer.ControlCount - 1 do
    begin
    Designer.Controls[I].Left := Designer.Controls[I].Left + (X - Designer.FBeforDragPos.X);
    Designer.Controls[I].Top := Designer.Controls[I].Top + (Y - Designer.FBeforDragPos.Y);
    end;
    }
  cX := FDesignControl.FBeforDragPos.X - CPos.X;
  cY := FDesignControl.FBeforDragPos.Y - CPos.Y;
  if (Abs(cX) < 2) and (Abs(cY) < 2) then
    Exit;

  case FDirect of
    fdLeftUp:
      begin
        if FControl.Width + cX > 1 then
        begin
          FControl.Left := FControl.Left - cX;
          FControl.Width := FControl.Width + cX;
          FDesignControl.FBeforDragPos.X := CPos.X;
        end;
        if FControl.Height + cY > 1 then
        begin
          FControl.Top := FControl.Top - cY;
          FControl.Height := FControl.Height + cY;
          FDesignControl.FBeforDragPos.Y := CPos.Y;
        end;
      end;
    fdUp:
      begin
        if FControl.Height + cY > 1 then
        begin
          FControl.Top := FControl.Top - cY;
          FControl.Height := FControl.Height + cY;
          FDesignControl.FBeforDragPos.Y := CPos.Y;
        end;
      end;
    fdRightUp:
      begin
        if FControl.Width - cX > 1 then
        begin
          FControl.Width := FControl.Width - cX;
          FDesignControl.FBeforDragPos.X := CPos.X;
        end;
        if FControl.Height + cY > 1 then
        begin
          FControl.Top := FControl.Top - cY;
          FControl.Height := FControl.Height + cY;
          FDesignControl.FBeforDragPos.Y := CPos.Y;
        end;
      end;
    fdRight:
      begin
        if FControl.Width - cX > 1 then
        begin
          FControl.Width := FControl.Width - cX;
          FDesignControl.FBeforDragPos.X := CPos.X;
        end;
      end;
    fdRightDown:
      begin
        if FControl.Width - cX > 1 then
        begin
          FControl.Width := FControl.Width - cX;
          FDesignControl.FBeforDragPos.X := CPos.X;
        end;
        if FControl.Height - cY > 1 then
        begin
          FControl.Height := FControl.Height - cY;
          FDesignControl.FBeforDragPos.Y := CPos.Y;
        end;
      end;
    fdDown:
      begin
        if FControl.Height - cY > 1 then
        begin
          FControl.Height := FControl.Height - cY;
          FDesignControl.FBeforDragPos.Y := CPos.Y;
        end;
      end;
    fdLeftDown:
      begin
        if FControl.Width + cX > 1 then
        begin
          FControl.Left := FControl.Left - cX;
          FControl.Width := FControl.Width + cX;
          FDesignControl.FBeforDragPos.X := CPos.X;
        end;
        if FControl.Height - cY > 1 then
        begin
          FControl.Height := FControl.Height - cY;
          FDesignControl.FBeforDragPos.Y := CPos.Y;
        end;
      end;
    fdLeft:
      begin
        if FControl.Width + cX > 1 then
        begin
          FControl.Left := FControl.Left - cX;
          FControl.Width := FControl.Width + cX;
          FDesignControl.FBeforDragPos.X := CPos.X;
        end;
      end;
  end;
end;

procedure TGrabHandle.MouseUp(Button: TMouseButton; Shift: TShiftState;
  X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  MouseCapture := False;
  FDesignControl.Dragging := False;
end;

procedure TGrabHandle.Pos();
var
  X: array [0 .. 2] of Integer;
  Y: array [0 .. 2] of Integer;
begin
  X[0] := FControl.Left - GrabHandleSize div 2;
  X[1] := FControl.Left + (FControl.Width - GrabHandleSize) div 2;
  X[2] := FControl.Left + FControl.Width - GrabHandleSize div 2;
  Y[0] := FControl.Top - GrabHandleSize div 2;
  Y[1] := FControl.Top + (FControl.Height - GrabHandleSize) div 2;
  Y[2] := FControl.Top + FControl.Height - GrabHandleSize div 2;
  case FDirect of
    fdLeftUp:
      begin
        Cursor := crSizeNWSE;
        SetBounds(X[0], Y[0], GrabHandleSize, GrabHandleSize);
      end;
    fdUp:
      begin
        Cursor := crSizeNS;
        SetBounds(X[1], Y[0], GrabHandleSize, GrabHandleSize);
      end;
    fdRightUp:
      begin
        Cursor := crSizeNESW;
        SetBounds(X[2], Y[0], GrabHandleSize, GrabHandleSize);
      end;
    fdRight:
      begin
        Cursor := crSizeWE;
        SetBounds(X[2], Y[1], GrabHandleSize, GrabHandleSize);
      end;
    fdRightDown:
      begin
        Cursor := crSizeNWSE;
        SetBounds(X[2], Y[2], GrabHandleSize, GrabHandleSize);
      end;
    fdDown:
      begin
        Cursor := crSizeNS;
        SetBounds(X[1], Y[2], GrabHandleSize, GrabHandleSize);
      end;
    fdLeftDown:
      begin
        Cursor := crSizeNESW;
        SetBounds(X[0], Y[2], GrabHandleSize, GrabHandleSize);
      end;
    fdLeft:
      begin
        Cursor := crSizeWE;
        SetBounds(X[0], Y[1], GrabHandleSize, GrabHandleSize);
      end;
  end;
  // if FDesigner.ControlCount > 1 then
  // Cursor := crDefault;
  BringToFront;
end;

{ TControlTopComparer<TControl> }

function TControlTopComparer<TControl>.Compare(const Left, Right: TControl)
  : Integer;
begin
  Result := TControl(Left).Top - TControl(Right).Top;
end;

{ TControlLeftComparer<TControl> }

function TControlLeftComparer<TControl>.Compare(const Left, Right: TControl)
  : Integer;
begin
  Result := TControl(Left).Left - TControl(Right).Left;
end;

end.

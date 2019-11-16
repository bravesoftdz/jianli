unit NovaListView;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, Variants, Dialogs, DB,
  jsonConnection, jsonClientDataSet, Forms,  ComCtrls, ImgList,Menus,WinSkinData;

type

  THelpOptions = class(TPersistent)
  private
    FDataSourceName: String;
    FQueryAddress: String;
    FJSONConnection: TJSONConnection;
    FFieldNames: TStrings;
    FSkinData: TSkinData;
    procedure SetDataSourceName(const Value: String);
    procedure SetJSONConnection(const Value: TJSONConnection);
    procedure SetQueryAddress(const Value: String);
    procedure SetFieldNames(const Value: TStrings);
    procedure SetSkinData(const Value: TSkinData);

  public
    constructor Create(AOwner: TComponent); overload; // virtual;
    destructor Destroy; override;
  published
    Property HJSONConnection: TJSONConnection read FJSONConnection write
      SetJSONConnection;
    Property HDataSourceName
      : String read FDataSourceName write SetDataSourceName;
    Property HQueryAddress: String read FQueryAddress write SetQueryAddress;
    property FieldNames: TStrings read FFieldNames write SetFieldNames;
    Property HSkinData: TSkinData read FSkinData write SetSkinData;
  end;

type
  TNovaListView = class(TCustomListView)
  private
    FJsonClientDataSet: TJsonClientDataSet;
    FHelpOptions: THelpOptions;
    FActive: boolean;
    FOnMenuPopup: TNotifyEvent;
    procedure SetHelpOptions(const Value: THelpOptions);
    procedure SetActive(const Value: boolean);
    function GetParams: TParams;
    procedure SetParams(const Value: TParams);
    function GetCheckedCount: Integer;
    procedure initParamter;
    Procedure OnMenuPopup(Sender: Tobject);
    procedure SetSelectAll(Sender: Tobject);
    procedure SetSelectNotAll(Sender: Tobject);
    procedure SetReserve(Sender: Tobject);
    function GetPerentForm(Sender: TwinControl): TForm;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    // 根据数据集把存在该数据集中的行选中
    procedure SetCheck(jcdsresult: TJsonClientDataSet; fieldName: String);
    procedure CheckAll(checked: boolean); // 全选或者全不选
    procedure CheckReverse(); // 反选
    function GetSelected(): String; // 返回选中的相应字段的值格式为'(12,10)'
    property CheckedCount: Integer read GetCheckedCount;
  published
    property Action;
    property Align;
    property AllocBy;
    property Anchors;
    property BevelEdges;
    property BevelInner;
    property BevelOuter;
    property BevelKind default bkNone;
    property BevelWidth;
    property BiDiMode;
    property BorderStyle;
    property BorderWidth;
    property Checkboxes;
    property Color;
    property Columns;
    property ColumnClick;
    property Constraints;
    property Ctl3D;
    property DoubleBuffered;
    property DragCursor;
    property DragKind;
    property DragMode;
    property Enabled;
    property Font;
    property FlatScrollBars;
    property FullDrag;
    property GridLines;
    property Groups;
    property HideSelection;
    property HotTrack;
    property HotTrackStyles;
    property HoverTime;
    property IconOptions;
    property Items;
    property LargeImages;
    property MultiSelect;
    property OwnerData;
    property OwnerDraw;
    property GroupHeaderImages;
    property GroupView default False;
    property ReadOnly default False;
    property RowSelect;
    property ParentBiDiMode;
    property ParentColor default False;
    property ParentDoubleBuffered;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowColumnHeaders;
    property ShowWorkAreas;
    property ShowHint;
    property SmallImages;
    property SortType;
    property StateImages;
    property TabOrder;
    property TabStop default True;
    property Touch;
    property ViewStyle;
    property Visible;
    property OnAdvancedCustomDraw;
    property OnAdvancedCustomDrawItem;
    property OnAdvancedCustomDrawSubItem;
    property OnChange;
    property OnChanging;
    property OnClick;
    property OnColumnClick;
    property OnColumnDragged;
    property OnColumnRightClick;
    property OnCompare;
    property OnContextPopup;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnCustomDrawSubItem;
    property OnCreateItemClass;
    property OnData;
    property OnDataFind;
    property OnDataHint;
    property OnDataStateChange;
    property OnDblClick;
    property OnDeletion;
    property OnDrawItem;
    property OnEdited;
    property OnEditing;
    property OnEndDock;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnGesture;
    property OnGetImageIndex;
    property OnGetSubItemImage;
    property OnDragDrop;
    property OnDragOver;
    property OnInfoTip;
    property OnInsert;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseActivate;
    property OnMouseDown;
    property OnMouseEnter;
    property OnMouseLeave;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnSelectItem;
    property OnItemChecked;
    property OnStartDock;
    property OnStartDrag;
    Property HelpOptions: THelpOptions read FHelpOptions write SetHelpOptions;
    property Active: boolean read FActive write SetActive default False;
    property Params: TParams read GetParams write SetParams;

  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Nova', [TNovaListView]);
end;

{ TNovaListView }

procedure TNovaListView.CheckAll(checked: boolean);
var
  i: Integer;
begin
  if checked then
  begin
    for i := 0 to Items.Count - 1 do
      Items.Item[i].checked := True
  end
  else
  begin
    for i := 0 to Items.Count - 1 do
      Items.Item[i].checked := False
  end;
end;

procedure TNovaListView.CheckReverse;
var
  i: Integer;
begin
  for i := 0 to Items.Count - 1 do
    if Items.Item[i].checked then
      Items.Item[i].checked := False
    else
      Items.Item[i].checked := True;
end;

constructor TNovaListView.Create(AOwner: TComponent);
begin

  FHelpOptions := THelpOptions.Create(self);
  // FFieldNames := TStringList.Create;
  // FFieldNames.Add('id');
  FJsonClientDataSet := TJsonClientDataSet.Create(self);

  if PopupMenu = nil then
  begin
    PopupMenu := TPopupMenu.Create(self.Parent);
  end;
  if assigned(PopupMenu) then
  begin
    if assigned(PopupMenu.OnPopup) then
    begin
      FOnMenuPopup := PopupMenu.OnPopup;
      PopupMenu.OnPopup := nil;
    end;
  end
  else
  begin
    //
  end;
  PopupMenu.OnPopup := OnMenuPopup;


  inherited Create(AOwner);
end;

destructor TNovaListView.Destroy;
begin
  FHelpOptions.Free;
  FJsonClientDataSet.Free;
  inherited;
end;

function TNovaListView.GetCheckedCount: Integer;
var
  Count, i: Integer;
begin
  Count := 0;
  for i := 0 to Items.Count - 1 do
    if Items.Item[i].checked then
      Count := Count + 1;
  result := Count;
end;

function TNovaListView.GetParams: TParams;
begin
  result := FJsonClientDataSet.Params;
end;

function TNovaListView.GetPerentForm(Sender: TwinControl): TForm;
begin
  if Sender is TForm then
  begin
   // Sender := Self;
     result :=  TForm(Sender);
  end
  else
  begin
    result := GetPerentForm(Sender.Parent);
  end;
end;

function TNovaListView.GetSelected: String;
var
  i: Integer;
  res: string;
begin
  res := '';
  for i := 0 to Items.Count - 1 do
    if Items.Item[i].checked then
      res := res + ',' + Items.Item[i].Caption;
  if res <> '' then
    res := copy(res, 2, length(res));
  result := res;
end;

procedure TNovaListView.initParamter;
begin
  if (FJsonClientDataSet.RemoteServer = nil) then
  begin
    FJsonClientDataSet.RemoteServer := HelpOptions.FJSONConnection;
    if HelpOptions.FQueryAddress = '' then
      FJsonClientDataSet.QueryAddress := 'system/help'
    else
      FJsonClientDataSet.QueryAddress := HelpOptions.FQueryAddress;
    if HelpOptions.FDataSourceName = '' then
      FJsonClientDataSet.DataSourceName := 'helpmap'
    else
      FJsonClientDataSet.DataSourceName := HelpOptions.FDataSourceName;
  end;
end;

procedure TNovaListView.OnMenuPopup(Sender: Tobject);
var
  MenuItem: TMenuItem;
  i: Integer;
  b_exist: boolean;
begin
  // 调用原过程
  if assigned(FOnMenuPopup) then
  begin
    try
      FOnMenuPopup(Sender);
    except
    end;
  end;
  if not Parent.Visible then
    Exit;



  try

    for i := 0 to PopupMenu.Items.Count - 1 do
    begin
      if Pos('全选', PopupMenu.Items.Items[i].Caption) > 0 then
      begin
        b_exist := True;
        break;
      end;
    end;
    if b_exist then
      Exit;
    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '-';
    self.PopupMenu.Items.Add(MenuItem);
    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '全选';
    MenuItem.OnClick := SetSelectAll;
    MenuItem.Name := self.Name + 'N_1';
    self.PopupMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '全不选';
    MenuItem.OnClick := SetSelectNotAll;
    MenuItem.Name := self.Name + 'N_2';
    self.PopupMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(self.PopupMenu);
    MenuItem.Caption := '反选';
    MenuItem.OnClick := SetReserve;
    MenuItem.Name := self.Name + 'N_3';
    self.PopupMenu.Items.Add(MenuItem);
    HelpOptions.FSkinData.UpdateSkinControl(GetPerentForm(self));
  finally

  end;

end;

procedure TNovaListView.SetActive(const Value: boolean);
var
  n_Index: Integer;
  O_Item: TlistItem;
  i: Integer;
begin
  if FHelpOptions.FFieldNames.Count < 0 then
  begin
    ShowMessage('请在FieldNames属性中设置要显示的字段信息');
    Exit;
  end;
  if FActive <> Value then
  begin
    FActive := Value;
    if FActive then
    begin
      With FJsonClientDataSet do
      begin
        Active := False;
        try
          initParamter;
          Active := True;
          if RecordCount > 0 then
          begin
            self.Items.clear;
            While not eof do
            begin
              O_Item := TlistItem.Create(Items);
              O_Item := Items.Add;
              O_Item.Caption := FieldByName(FHelpOptions.FFieldNames[0]).ASstring;
              for i := 1 to FHelpOptions.FFieldNames.Count - 1 do
              begin
                O_Item.SubItems.Add(FieldByName(FHelpOptions.FFieldNames[i]).AsString);
              end;
              if RecordCount = 1 then
              begin
                O_Item.checked := True;
              end;
              Next;
            end;
          end;
        except
          on E: Exception do
          begin
            FActive := False;
            ShowMessage('控件信息错误' + E.message);
          end;
        end;
      end;
    end;
  end;

end;

procedure TNovaListView.SetCheck(jcdsresult: TJsonClientDataSet;
  fieldName: String);
var
  i: Integer;
begin
  if not jcdsresult.Active then
    Exit;
  if jcdsresult.RecordCount < 0 then
    Exit;
  with jcdsresult do
  begin
    first;
    while (not jcdsresult.eof) do
    begin
      for i := 0 to self.Items.Count - 1 do
      begin
        if Items.Item[i].Caption = FieldValues[fieldName] then
          Items.Item[i].checked := True
      end;
      Next;
    end;
  end;
end;

{
  procedure TNovaListView.SetFieldNames(const Value: TStrings);
  begin
  // FFieldNames := Value;
  FFieldNames.Assign(Value);
  end; }

procedure TNovaListView.SetHelpOptions(const Value: THelpOptions);
begin
  FHelpOptions.Assign(Value);
end;

procedure TNovaListView.SetParams(const Value: TParams);
begin
  FJsonClientDataSet.Params.Assign(Value);
end;

procedure TNovaListView.SetReserve(Sender: Tobject);
begin
  CheckReverse;
end;

procedure TNovaListView.SetSelectAll(Sender: Tobject);
begin
   CheckAll(true);
end;

procedure TNovaListView.SetSelectNotAll(Sender: Tobject);
begin
  CheckAll(false);
end;

{ THelpOptions }

constructor THelpOptions.Create(AOwner: TComponent);
begin
  FQueryAddress := 'system/help';
  FDataSourceName := 'helpmap';
  FFieldNames := TStringList.Create;
  FFieldNames.Add('id');
  inherited Create; ;

end;

destructor THelpOptions.Destroy;
begin
  FFieldNames.Free;
  inherited;
end;

procedure THelpOptions.SetDataSourceName(const Value: String);
begin
  FDataSourceName := Value;
end;

procedure THelpOptions.SetFieldNames(const Value: TStrings);
begin
  FFieldNames.Assign(Value);
end;

procedure THelpOptions.SetJSONConnection(const Value: TJSONConnection);
begin
  FJSONConnection := Value;
end;

procedure THelpOptions.SetQueryAddress(const Value: String);
begin
  FQueryAddress := Value;
end;

procedure THelpOptions.SetSkinData(const Value: TSkinData);
begin
  FSkinData := Value;
end;

end.

unit UFrmVehicleRunPlan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, Grids,
  DateUtils, NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, ComCtrls,
  Generics.Collections;

type
    TStringGrid = class(Grids.TStringGrid)
  private
    FOnPaint: TNotifyEvent;
  protected
    procedure Paint; override;
  public
    iYear, iMonth: Integer; //传入的年月
    iCol: Integer; //计算出该月1号所在的列，既星期几，设置标志开始位置用
    iDay: Integer; //该月有多少天
    tLabel1, tLabel2, tLabel3, tLabel4, tLabel5: array[0..41] of TLabel;
    procedure CreateCompent;
    procedure Init; //初始化
    property OnPaint: TNotifyEvent read FOnPaint write FOnPaint;
  end;

  TFrmVehicleRunPlan = class(TSimpleEditForm)
    StringGrid1: TStringGrid;
    lbl1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    jcdsResult: TjsonClientDataSet;
    dsResult: TDataSource;
    DpDepartdate: TDateTimePicker;
    lbl2: TLabel;
    BitBtn1: TBitBtn;
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure lbl1Click(Sender: TObject);
    procedure Label3Click(Sender: TObject);
    procedure NovaHelpVehiclenoHelpIdChange(Sender: TObject);
    procedure DpDepartdateChange(Sender: TObject);
  private
    { Private declarations }
    // isreflash:boolean;
     runinfo:TDictionary<Integer,String>;
  public
    { Public declarations }
    departdate : TDate;
    vehicleid : Int64;
    procedure click1(Sender: TObject);
    procedure query(Sender: Integer; depart: TDate);
    procedure replace(Sender : Integer; depart: TDate);
  end;

var
  FrmVehicleRunPlan: TFrmVehicleRunPlan;

implementation

{$R *.dfm}
{ TStringGrid }

procedure TStringGrid.CreateCompent;
var
  i: Integer;
begin
  //创建label
  for i := 0 to 41 do
  begin
    tLabel1[i] := TLabel.Create(Self);
    tLabel1[i].Parent := Self;
    tLabel1[i].Visible := False;
    tLabel1[i].Tag := -1;
    tLabel1[i].AutoSize := True;
    tLabel1[i].Transparent := True;

    tLabel2[i] := TLabel.Create(Self);
    tLabel2[i].Parent := Self;
    tLabel2[i].Visible := False;
    tLabel2[i].Tag := -1;
    tLabel2[i].AutoSize := True;
    tLabel2[i].Transparent := True;

    tLabel3[i] := TLabel.Create(Self);
    tLabel3[i].Parent := Self;
    tLabel3[i].Visible := False;
    tLabel3[i].Tag := -1;
    tLabel3[i].AutoSize := True;
    tLabel3[i].Transparent := True;

    tLabel4[i] := TLabel.Create(Self);
    tLabel4[i].Parent := Self;
    tLabel4[i].Visible := False;
    tLabel4[i].Tag := -1;
    tLabel4[i].AutoSize := True;
    tLabel4[i].Transparent := True;

    tLabel5[i] := TLabel.Create(Self);
    tLabel5[i].Parent := Self;
    tLabel5[i].Visible := False;
    tLabel5[i].Tag := -1;
    tLabel5[i].AutoSize := True;
    tLabel5[i].Transparent := True;
  end;
end;

procedure TStringGrid.Init;
var
  time: TDateTime;
  i: Integer;
begin
  //获取天数
  iDay := DaysInAMonth(iYear, iMonth);
  //    days[1]   :=   '日 ';
  //    days[2]   :=   '一 ';
  //    days[3]   :=   '二 ';
  //    days[4]   :=   '三 ';
  //    days[5]   :=   '四 ';
  //    days[6]   :=   '五 ';
  //    days[7]   :=   '六 ';
  //获取星期
  time := EncodeDateTime(iYear, iMonth, 1, 0, 0, 0, 0);
  iCol := DayOfWeek(time) - 1; //因为格子从0开始的，返回的星期是以1开始的

  //清空Label
  for i := 0 to 41 do
  begin
    tLabel1[i].Visible := False;
    tLabel1[i].Tag := -1;

    tLabel2[i].Visible := False;
    tLabel2[i].Tag := -1;

    tLabel3[i].Visible := False;
    tLabel3[i].Tag := -1;

    tLabel4[i].Visible := False;
    tLabel4[i].Tag := -1;

    tLabel5[i].Visible := False;
    tLabel5[i].Tag := -1;
  end;

  //设置Label标志，根据标志来drawcell
  for i := 0 to iDay - 1 do
  begin
    tLabel1[iCol + i].Tag := i + 1;
    tLabel2[iCol + i].Tag := i + 1;
    tLabel3[iCol + i].Tag := i + 1;
    tLabel4[iCol + i].Tag := i + 1;
    tLabel5[iCol + i].Tag := i + 1;
  end;
end;

procedure TStringGrid.Paint;
begin
  //重绘StringGrid，被挡住后消失
  inherited;
end;

const
  aText: array[0..6] of string = ('星期日', '星期一', '星期二', '星期三', '星期四', '星期五', '星期六');

procedure TFrmVehicleRunPlan.click1(Sender: TObject);
begin
  ShowMessage((Sender as TLabel).caption);
end;

procedure TFrmVehicleRunPlan.DpDepartdateChange(Sender: TObject);
begin
  inherited;
  if (StrToInt(FormatdateTime('yyyy',departdate)) <>
  StrToInt(FormatdateTime('yyyy',DpDepartdate.Date))) or
   (StrToInt(FormatdateTime('mm',departdate)) <>
  StrToInt(FormatdateTime('mm',DpDepartdate.Date))) then
  begin
    replace(0,DpDepartdate.Date);

    departdate := DpDepartdate.Date;
    replace(NovaHelpVehiclenoHelp.Id, DpDepartdate.Date);
  end;
end;

procedure TFrmVehicleRunPlan.FormShow(Sender: TObject);
var
  i : Integer;
begin
  inherited;
  runinfo:=TDictionary<Integer, String>.Create();
  StringGrid1.Ctl3D := False;
  StringGrid1.ColCount := 7;
  StringGrid1.RowCount := 7;
  StringGrid1.FixedCols := 0;
  StringGrid1.FixedRows := 0;
  StringGrid1.RowHeights[0] := 30;
  for i := 1 to 6 do
  begin
    StringGrid1.RowHeights[i] := 65;
  end;
  for i := 0 to 6 do
  begin
    StringGrid1.ColWidths[i] := 107;
  end;
  StringGrid1.iYear := StrToInt(FormatdateTime('yyyy',departdate));
  StringGrid1.iMonth := StrToInt(FormatdateTime('mm',departdate));
  StringGrid1.CreateCompent;
  StringGrid1.Init;
  DpDepartdate.DateTime := departdate;
  NovaHelpVehiclenoHelp.Id := vehicleid;
  //query(vehicleid, departdate);
end;

procedure TFrmVehicleRunPlan.Label3Click(Sender: TObject);
begin
  inherited;
  replace(0, DpDepartdate.Date);

  DpDepartdate.Date := IncMonth(DpDepartdate.Date, 1);
  departdate := DpDepartdate.Date;
  replace(NovaHelpVehiclenoHelp.Id, DpDepartdate.Date);
end;

procedure TFrmVehicleRunPlan.lbl1Click(Sender: TObject);
begin
  inherited;
  replace(0, DpDepartdate.Date);

  DpDepartdate.Date := IncMonth(DpDepartdate.Date,-1);
  departdate := DpDepartdate.Date;
  replace(NovaHelpVehiclenoHelp.Id, DpDepartdate.Date);
end;

procedure TFrmVehicleRunPlan.NovaHelpVehiclenoHelpIdChange(Sender: TObject);
begin
  inherited;
    replace(NovaHelpVehiclenoHelp.Id, DpDepartdate.Date);
    NovaHelpVehiclenoHelp.SetFocus;
end;

procedure TFrmVehicleRunPlan.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
var
  Canvas: TCanvas;
  Area:TRect;
  s: string;
begin
  inherited;
  Canvas := StringGrid1.Canvas;
  //星期日和星期六两列都变灰色   and ((ACol = 0) or (ACol = 6))
  if (ARow = 0) then
  begin
    Canvas.Brush.Color := clInactiveCaptionText;
    Canvas.FillRect(Rect);
  end;
  if ARow <> 0 then
  begin
    //如果不是第一行标题，并且是日期时选择时变颜色
    if (ARow = StringGrid1.Row) and (ACol = StringGrid1.Col) and (StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Tag > 0) then
    begin
      Canvas.Brush.Color := clYellow;
      Canvas.FillRect(Rect);
    end
    else
    begin
      if (ACol = 0) or (ACol = 6) then
      begin
       //Canvas.Brush.Color := clInactiveCaptionText;
       //Canvas.FillRect(Rect);
      end
      else
      begin
        Canvas.Brush.Color := clWindow;
        Canvas.FillRect(Rect);
      end;
    end;
  end;
  //写标题
  if ARow = 0 then
  begin
    Canvas.Font.Size := 11;
    Canvas.Font.Color := clBlack;
    Canvas.TextOut(Rect.Left + 30, Rect.Top + 6, aText[ACol]);
  end;
  //非标题
  if ARow <> 0 then
  begin
    //判断是否是日期，如果不是Tag为-1
  if StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Tag > 0 then
  begin

      StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Visible := True;
      StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Caption := IntToStr(StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Tag);
      StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
      StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Top := Rect.Top + 4;
      StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Font.Color := clBlack;
//      StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].OnClick := click1;

      if  runinfo.Count> 0 then
      begin
            if runinfo.ContainsKey(StrToInt(StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Caption)) then
            begin
              StringGrid1.tLabel2[(ARow - 1) * 7 + ACol].Caption := runinfo.Items[StrToInt(StringGrid1.tLabel1[(ARow - 1) * 7 + ACol].Caption)];
            end;
      end
      else
      begin
        StringGrid1.tLabel2[(ARow - 1) * 7 + ACol].Caption := '';
      end;

      with StringGrid1 do
      begin
        s:=StringGrid1.tLabel2[(ARow - 1) * 7+ ACol].Caption ;
        if length(s)>10 then
        begin
//          canvas.Rectangle(rect);
//          canvas.TextOut(rect.Left+4 ,rect.Top+18,copy(s,1,10));
//          canvas.TextOut(rect.Left+4 ,rect.Top+32,copy(s,11,length(s)-10));
//          Canvas.TextOut(rect.Left+4 ,Rect.Top+46,Copy(s,21,Length(s)-20));
          tLabel2[(ARow - 1) * 7 + ACol].Visible := False;

          tLabel5[(ARow - 1) * 7 + ACol].Visible := True;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Width := 98;//Length(StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Caption) * 7;
          tLabel5[(ARow - 1) * 7 + ACol].Caption := copy(s,1,length(s));
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Top := Rect.Top + 18;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].ShowHint := True;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Hint := s;

          tLabel3[(ARow - 1) * 7 + ACol].Visible := True;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Width := 98;
          tLabel3[(ARow - 1) * 7 + ACol].Caption := copy(s,11,length(s)-10);
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Top := Rect.Top + 32;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].ShowHint := True;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Hint := s;

          tLabel4[(ARow - 1) * 7 + ACol].Visible := True;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Width := 98;
          tLabel4[(ARow - 1) * 7 + ACol].Caption := copy(s,21,length(s)-20);
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Top := Rect.Top + 46;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].ShowHint := True;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Hint := s;


        end
        else
        begin
          tLabel2[(ARow - 1) * 7 + ACol].Visible := False;
          tLabel3[(ARow - 1) * 7 + ACol].Visible := True;
          tLabel4[(ARow - 1) * 7 + ACol].Visible := True;
          tLabel5[(ARow - 1) * 7 + ACol].Visible := True;
          tLabel5[(ARow - 1) * 7 + ACol].Caption := s;
          tLabel3[(ARow - 1) * 7 + ACol].Caption := '';
          tLabel4[(ARow - 1) * 7 + ACol].Caption := '';
//          StringGrid1.tLabel2[(ARow - 1) * 7 + ACol].Width := 100;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Width := 98;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Width := 98;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Width := 98;
//          StringGrid1.tLabel2[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
//          StringGrid1.tLabel2[(ARow - 1) * 7 + ACol].Top := Rect.Top + 18;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
          StringGrid1.tLabel3[(ARow - 1) * 7 + ACol].Top := Rect.Top + 32;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
          StringGrid1.tLabel4[(ARow - 1) * 7 + ACol].Top := Rect.Top + 46;

          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Left := Rect.Left + 4;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Top := Rect.Top + 18;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].ShowHint := True;
          StringGrid1.tLabel5[(ARow - 1) * 7 + ACol].Hint := s;
        end;
      end;
  end;
end;
end;

procedure TFrmVehicleRunPlan.query(Sender: Integer; depart: TDate);
begin
  runinfo.Clear;
  if Sender=0 then exit;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['vehicleid'] := Sender;
      Params.ParamValues['departdate'] := FormatDateTime('yyyy-mm-dd', depart);
    Active := True;
    if recordcount>0 then
    begin
      first;
      while (not eof) do
      begin
        runinfo.Add(FieldByName('day').AsInteger,FieldByName('name').AsString);
        next;
      end;
    end;
  end;
end;

//重新布局，重新加载数据源
procedure TFrmVehicleRunPlan.replace(Sender: Integer; depart: TDate);
begin
  StringGrid1.iYear := StrToInt(FormatDateTime('yyyy',depart));
  StringGrid1.iMonth := StrToInt(FormatDateTime('mm',depart));
  StringGrid1.Init;
  StringGrid1.Paint;
  query(Sender, depart);
  StringGrid1.SetFocus;
end;

end.

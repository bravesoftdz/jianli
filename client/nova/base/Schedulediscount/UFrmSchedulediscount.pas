unit UFrmSchedulediscount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit, UFrmSchedulediscountEdit, NvPrnDbgeh, NvDbgridEh, NovaHelp,
  UFrmSchedulevipdiscountEdit, NovaCheckedComboBox;

type
  TFrmSchedulediscount = class(TSimpleCRUDForm)
    Labeledtorgid: TLabel;
    Label3: TLabel;
    jsonCDSDelSch: TjsonClientDataSet;
    edtissellreturnticket: TNovaHelp;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    jcdsResult1: TjsonClientDataSet;
    dataSource: TDataSource;
    prntdbgrdh1: TNvPrintDBGridEh;
    jsonDelvipdiscount: TjsonClientDataSet;
    ImageList1: TImageList;
    ImageList2: TImageList;
    ImageList3: TImageList;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    btnInsertDep: TToolButton;
    ToolButton3: TToolButton;
    btnUpdateDep: TToolButton;
    ToolButton5: TToolButton;
    btndelDep: TToolButton;
    jcdstypename: TjsonClientDataSet;
    wdstrngfldResult1schedulename: TWideStringField;
    wdstrngfldResult1vipgrade: TWideStringField;
    wdstrngfldResult1createname: TWideStringField;
    wdstrngfldResult1updatename: TWideStringField;
    wdstrngfldResult1gradename: TWideStringField;
    lrgntfldResult1id: TLargeintField;
    lrgntfldResult1createby: TLargeintField;
    lrgntfldResult1updateby: TLargeintField;
    lrgntfldResult1schedulediscountid: TLargeintField;
    fltfldResult1defaultdiscountrate: TFloatField;
    dtmfldResult1createtime: TDateTimeField;
    dtmfldResult1updatetime: TDateTimeField;
    sellOrgid: TNovaCheckedComboBox;
    Label2: TLabel;
    edtrouteid: TNovaHelp;
    Label4: TLabel;
    edthelpcode: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure btnUpdateDepClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure btnInsertDepClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure btndelDepClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSchedulediscount: TFrmSchedulediscount;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmSchedulediscount.btndelDepClick(Sender: TObject);
var nResult,discountid : Integer;
    sResult : string;
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jsonDelvipdiscount do
  try
    close;
    log := '删除班次折扣信息：班次='+jcdsResult1.FieldByName('schedulename').AsString+
    'VIP等级='+jcdsResult1.FieldByName('gradename').AsString+',折扣率='+
    jcdsResult1.FieldByName('defaultdiscountrate').AsString;
    discountid := jcdsResult.FieldByName('id').AsInteger;
    Params.ParamByName('schedulevipdiscount.id').Value :=jcdsResult1.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除班次贵宾卡折扣信息','删除',log);
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', discountid,[] );
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('班次贵宾卡折扣信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmSchedulediscount.btnInsertDepClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmschedulevipdiscountEdit do
  begin
    FrmschedulevipdiscountEdit := TFrmschedulevipdiscountEdit.Create(Self);
    Caption := '添加班次贵宾折扣信息';
    defaultdiscountrate := jcdsResult.FieldByName('mindiscountrate').AsString;
    schedulediscountid :=  jcdsResult.FieldByName('id').AsString;
    cbbhelpcode.Text := jcdsResult.FieldByName('helpcode').AsString;
    cbbhelpcode.Enabled := false;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
    end;
  end;
end;

procedure TFrmSchedulediscount.btnUpdateDepClick(Sender: TObject);
var i,id : Integer;
begin
  inherited;
  if not dataSource.DataSet.Active then
    exit;
  if dataSource.DataSet.RecordCount < 1 then
    exit;
  with FrmschedulevipdiscountEdit do
  begin
    FrmschedulevipdiscountEdit := TFrmschedulevipdiscountEdit.Create(Self);
    Caption := '修改班次贵宾卡折扣信息';
    edittype:=Tedittype.update;
    id := jcdsResult1.FieldByName('id').AsString;
    schedulediscountid :=  jcdsResult1.FieldByName('schedulediscountid').AsString;
    cbbhelpcode.Text := jcdsResult1.FieldByName('schedulename').AsString;
    edtdefaultdiscount.Text := FloatToStr(jcdsResult1.FieldByName('defaultdiscountrate').AsFloat*100);//对应折扣率defaultdiscountrate
    createby := jcdsResult1.FieldByName('createby').AsString;
    createtime := jcdsResult1.FieldByName('createtime').AsDateTime;
    for i := 0 to cbbvipgrade.Items.Count - 1 do
    begin
      try
        if TCommInfo(cbbvipgrade.Items.Objects[i]).Value= jcdsResult1.FieldByName('vipgrade').AsString then
        begin
          cbbvipgrade.ItemIndex:= i;
          break;
        end;
      except

      end;
    end;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',jcdsResult.FieldByName('id').AsString,[] );
    end;
  end;
end;

procedure TFrmSchedulediscount.FormShow(Sender: TObject);
begin
  inherited;
  sellOrgid.Active := False;
  sellOrgid.Active := True;
end;

procedure TFrmSchedulediscount.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    jcdsResult1.Close;
  end;
end;

procedure TFrmSchedulediscount.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jcdsResult1 do
  begin
    Active:=false;
    Params.ParamByName('filter_LIKEL_s!id').Value:=jcdsResult.FieldByName('id').AsInteger;
    Active:=true;
  end;
end;

procedure TFrmSchedulediscount.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jsonCDSDelSch do
  try
    close;
    log := '删除班次折扣信息：线路='+jcdsResult.FieldByName('name').AsString+',班次='
    +jcdsResult.FieldByName('helpcode').AsString;
    Params.ParamByName('schedulediscount.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除班次折扣信息','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('班次折扣信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmSchedulediscount.tbtnEditClick(Sender: TObject);
var i,id:integer;
begin
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmSchedulediscountEdit do
  begin
    FrmSchedulediscountEdit := TFrmSchedulediscountEdit.Create(self);
    Caption := '修改班次折扣信息';
    flag:=false;
    id :=  jcdsResult.FieldByName('id').AsLargeInt;
    orgid := jcdsResult.FieldByName('orgid').AsString;
    nvhelproute.Text := jcdsResult.FieldByName('name').AsString;
    nvhelproute.Id := jcdsResult.FieldByName('routeid').AsInteger;
    //cbbhelpcode := jcdsResult.FieldByName('helpcode').AsString;
    //cbbhelpcode.GetSelectID := jcdsResult.FieldByName('scheduleid').AsString;
    edtschedule.Text := jcdsResult.FieldByName('helpcode').AsString;
    scheduleid := jcdsResult.FieldByName('scheduleid').AsString;

    cbbstartdate.DateTime := jcdsResult.FieldByName('startdate').AsDateTime;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    cbbenddate.DateTime := jcdsResult.FieldByName('enddate').AsDateTime;
    edtfromnum.Text := jcdsResult.FieldByName('fromnum').AsString;
    edtendnum.Text := jcdsResult.FieldByName('endnum').AsString;
    edtdefaultdiscountrate.Text := FloatToStr(jcdsResult.FieldByName('defaultdiscountrate').AsFloat*100);
    edtmindiscountrate.Text := FloatToStr(jcdsResult.FieldByName('mindiscountrate').AsFloat*100);
    nvhelproute.Enabled := false;
    cbbhelpcode.Visible := False;
    edtschedule.Visible := True;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
      FreeAndNil(FrmSchedulediscountEdit);
    end;
  end;
end;

procedure TFrmSchedulediscount.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    jcdsResult.Params.ParamValues['filter_INS_t!orgid'] := sellOrgid.GetSelectID;
    if(trim(edtrouteid.Text) = '')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKEL_r!id'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKEL_r!id'] := edtrouteid.Id;
    end;
    if(trim(edtissellreturnticket.Text) = '')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKEL_r!endstationid'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKEL_r!endstationid'] := edtissellreturnticket.Id;
    end;
    if(trim(edthelpcode.Text) = '')then
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_s!helpcode'] := '';
    end else
    begin
      jcdsResult.Params.ParamValues['filter_LIKES_s!helpcode'] := trim(edthelpcode.Text);
    end;
    jcdsResult.AfterScroll:=nil;
    try      Active:=true;      if recordcount>0 then      begin        jcdsResultAfterScroll(nil);      end;    finally      jcdsResult.AfterScroll:=jcdsResultAfterScroll;    end;
    Active := true;
  end;
end;

procedure TFrmSchedulediscount.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmSchedulediscountEdit do
  begin
    FrmSchedulediscountEdit := TFrmSchedulediscountEdit.Create(Self);
    Caption := '添加班次折扣信息';
    flag := true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      FreeAndNil(FrmSchedulediscountEdit);
    end;
  end;
end;

end.

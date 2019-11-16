unit UFrmScheduleDiscountPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmScheduleDiscountPrice = class(TSimpleCRUDForm)
    GroupBox2: TGroupBox;
    dbDiscountPrice: TNvDbgridEh;
    Splitter1: TSplitter;
    dsSchDiscountPriceResult: TDataSource;
    jcdsScheduleDiscountPrice: TjsonClientDataSet;
    Label1: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    Label8: TLabel;
    NHelpRoute: TNovaHelp;
    Label2: TLabel;
    NEdtScheduleHelpCode: TNovaEdit;
    jcdsResultroutename: TWideStringField;
    jcdsResultorgname: TWideStringField;
    jcdsResultcode: TWideStringField;
    jcdsScheduleDiscountPricestartdate: TDateField;
    jcdsScheduleDiscountPriceenddate: TDateField;
    jcdsScheduleDiscountPriceprice: TFloatField;
    jcdsScheduleDiscountPricecreatetime: TTimeField;
    jcdsScheduleDiscountPriceupdatetime: TTimeField;
    jcdsScheduleDiscountPriceid: TLargeintField;
    jcdsScheduleDiscountPricescheduleid: TLargeintField;
    jcdsScheduleDiscountPriceorgid: TLargeintField;
    jcdsScheduleDiscountPricecreateby: TLargeintField;
    jcdsScheduleDiscountPriceupdateby: TLargeintField;
    jcdsScheduleDiscountPricedepartstationid: TLargeintField;
    jcdsScheduleDiscountPricereachstationid: TLargeintField;
    jcdsScheduleDiscountPricesalenum: TIntegerField;
    jcdsQryStation: TjsonClientDataSet;
    jcdsScheduleDiscountPricedepartstation: TWideStringField;
    jcdsScheduleDiscountPricereachstation: TWideStringField;
    jcdsDelSchDiscountPrice: TjsonClientDataSet;
    jcdsResultWORKTYPE: TWideStringField;
    jcdsResultWORKWAYS: TWideStringField;
    jcdsResultDISTRICTTYPE: TWideStringField;
    jcdsResultTYPE: TWideStringField;
    jcdsResultSTARTTIME: TWideStringField;
    jcdsResultRUNTIME: TFloatField;
    jcdsResultISPROPRIETARY: TBooleanField;
    jcdsResultISOVERTIME: TBooleanField;
    jcdsResultISSELLRETURNTICKET: TBooleanField;
    jcdsResultISLINEWORK: TBooleanField;
    jcdsResultISORIGINATOR: TBooleanField;
    jcdsResultISCANMIXCHECK: TBooleanField;
    jcdsResultPLANSEATNUM: TIntegerField;
    jcdsResultVIASTATION: TWideStringField;
    jcdsResultPRINTINFO: TWideStringField;
    jcdsResultREMARKS: TWideStringField;
    jcdsResultISAUDITED: TBooleanField;
    jcdsResultISAUDITPASS: TBooleanField;
    jcdsResultISACTIVE: TBooleanField;
    jcdsResultticketentrance: TWideStringField;
    jcdsResultvehcilepark: TWideStringField;
    jcdsResultid: TLargeintField;
    jcdsResultORGID: TLargeintField;
    jcdsResultROUTEID: TLargeintField;
    jcdsResultstartstationid: TLargeintField;
    jcdsResultendstationid: TLargeintField;
    jcdsResultCREATEBY: TLargeintField;
    jcdsResultUPDATEBY: TLargeintField;
    jcdsResultCREATETIME: TDateTimeField;
    jcdsResultUPDATETIME: TDateTimeField;
    jcdsScheduleDiscountPricereferenceprice: TFloatField;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
    procedure qrySchDiscountPrice(scheduleid: integer);
  public
    { Public declarations }
    isusemoreprice: boolean;
  end;

var
  FrmScheduleDiscountPrice: TFrmScheduleDiscountPrice;

implementation

uses UFrmScheduleDiscountPriceEdt,UFrmScheduleDiscountPriceAdd, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleDiscountPrice.FormCreate(Sender: TObject);
begin
  inherited;
  tbtnSave.Visible:=false;
  tbtnCancel.Visible:=false;
  NovaCkbOrg.Active := false;
  NovaCkbOrg.Active := true;
end;

procedure TFrmScheduleDiscountPrice.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  qrySchDiscountPrice(jcdsResult.FieldByName('id').AsLargeInt);
end;

procedure TFrmScheduleDiscountPrice.qrySchDiscountPrice(scheduleid: integer);
begin
  with jcdsQryStation do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := scheduleid;
    Active := true;
  end;
  with jcdsScheduleDiscountPrice do
  begin
    Active := false;
    Params.ParamValues['scheduleid'] := scheduleid;
    Active := true;
  end;
end;

procedure TFrmScheduleDiscountPrice.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult, log: string;
begin
  inherited;
  if SysDialogs.Confirm('删除操作', '确认要删除对应车次优惠票价信息吗？') then
    with jcdsDelSchDiscountPrice do
    begin
      Active := false;
      Params.ParamValues['scheduleid'] := jcdsResult.FieldByName('id')
        .AsLargeInt;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        log := '删除优惠票价设置：线路=' + jcdsResult.FieldByName('routename')
          .AsString + ',班次号=' + jcdsResult.FieldByName('code').AsString;
        SysLog.WriteLog('票价管理——>优惠票价设置', '删除', log);
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
      end
      else
        SysDialogs.Warning(sResult);
    end;
end;

procedure TFrmScheduleDiscountPrice.tbtnEditClick(Sender: TObject);
var
  curscheduleid, curid: int64;
begin
  inherited;
  FrmScheduleDiscountPriceEdt := TFrmScheduleDiscountPriceEdt.Create(self);
  try
    with FrmScheduleDiscountPriceEdt do
    begin
      Caption := '修改折扣票价信息';
      createby := SysInfo.LoginUserInfo.UserID;
      NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
      NovaEdtRoute.Enabled := false;
      NovaEditSchedule.Text := jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id := jcdsResult.FieldByName('id').AsLargeInt;
      NovaEditSchedule.Enabled := false;
      curscheduleid := jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmScheduleDiscountPriceEdt, false)
        = mrok then
      begin
        // curid:=id;
        qrySchDiscountPrice(curscheduleid);
        // jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmScheduleDiscountPriceEdt);
  end;

end;

procedure TFrmScheduleDiscountPrice.tbtnFilterClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if (jcdsResult.Active) and (jcdsResult.RecordCount > 0) then
  begin
    curid := jcdsResult.FieldByName('id').AsLargeInt;
  end;
  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    if (NHelpRoute.Text <> '') and (NHelpRoute.Id > 0) then
      Params.ParamValues['filter_EQL_r!id'] := NHelpRoute.Id
    else
      Params.ParamValues['filter_EQL_r!id'] := null;

    Params.ParamValues['filter_LIKES_s!code'] := UpperCase
      (trim(NEdtScheduleHelpCode.Text));
    Active := true;
    if RecordCount <= 0 then
    begin
      // jcdsScheduleStop.Close;
      // jcdsScheduleLong.Close;
    end
    else
    begin
      if curid > 0 then
      begin
        jcdsResult.Locate('id', curid, []);
      end;
      qrySchDiscountPrice(jcdsResult.FieldByName('id').AsLargeInt);
    end;
  end;
  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TFrmScheduleDiscountPrice.tbtnInsertClick(Sender: TObject);
var
  id: int64;
begin
  inherited;
 {
  FrmScheduleDiscountPriceEdt := TFrmScheduleDiscountPriceEdt.Create(self);
  try
    with FrmScheduleDiscountPriceEdt do
    begin
      Caption := '添加优惠票价信息';
      createby := SysInfo.LoginUserInfo.UserID;
      // if isusemoreprice then
      // FrmScheduleDiscountPriceEdt.NvDbgridEh1.Columns[7].Visible := true
      // else
      // FrmScheduleDiscountPriceEdt.NvDbgridEh1.Columns[7].Visible := false;
      NovaEdtRoute.Text := jcdsResult.FieldByName('routename').AsString;
      NovaEdtRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
      NovaEdtRoute.Enabled := false;
      NovaEditSchedule.Text := jcdsResult.FieldByName('code').AsString;
      NovaEditSchedule.Id := jcdsResult.FieldByName('id').AsLargeInt;
      NovaEditSchedule.Enabled := false;
      curscheduleid := jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmScheduleDiscountPriceEdt, false)
        = mrok then
      begin
        // curid:=id;
        qrySchDiscountPrice(curscheduleid);
        // jcdsResult.Locate('id',curid,[]);
      end;
    end;
  finally
    FreeAndNil(FrmScheduleDiscountPriceEdt);
  end; }
  FrmScheduleDiscountPriceAdd := TFrmScheduleDiscountPriceAdd.Create(self);
  try
    with FrmScheduleDiscountPriceAdd do
    begin
      Caption := '添加折扣票价信息';
      routeid := jcdsResult.FieldByName('routeid').AsLargeInt;
      scheduleid := jcdsResult.FieldByName('id').AsLargeInt;
      if SysMainForm.showFormModal(FrmScheduleDiscountPriceAdd, false) = mrok then
      begin
        id:=curid;
        jcdsResultAfterScroll(nil);
//        qrySchDiscountPrice.Locate('id',id,[]);
      end;
    end;
  finally
    FreeAndNil(FrmScheduleDiscountPriceAdd);
  end;

end;

end.

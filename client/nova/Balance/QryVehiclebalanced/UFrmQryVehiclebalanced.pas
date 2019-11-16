unit UFrmQryVehiclebalanced;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  Services,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox, UDMPublic;

type
  TFrmQryVehiclebalanced = class(TSimpleCRUDForm)
    lbl1: TLabel;
    nvcbbNovaCkbOrg: TNovaCheckedComboBox;
    lbl2: TLabel;
    dtpBalancedStart: TDateTimePicker;
    lbl3: TLabel;
    dtpBalancedEnd: TDateTimePicker;
    NovaHelpUnit: TNovaHelp;
    lbl5: TLabel;
    Label8: TLabel;
    NovaHelpVehicle: TNovaHelp;
    NvDbgridEh1: TNvDbgridEh;
    NvDbgridEh2: TNvDbgridEh;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure GridLoad();
  public
    { Public declarations }
  end;

var
  FrmQryVehiclebalanced: TFrmQryVehiclebalanced;

implementation

uses SystemInstance, SysInfoIntf, PubFn;
{$R *.dfm}

procedure TFrmQryVehiclebalanced.FormShow(Sender: TObject);
begin
  inherited;
  nvcbbNovaCkbOrg.Active := False;
  nvcbbNovaCkbOrg.Active := True;
  dtpBalancedStart.Date := Now;
  dtpBalancedEnd.Date := Now;
end;

procedure TFrmQryVehiclebalanced.GridLoad();
var
  Columninfo: array of TColumninfo;
  i, j, idx: integer;
  Columns, Columns2: TDBGridColumnsEh;
  DataSet: TDataSet;
  tempFieldname: string;
  Column_n: TColumnEh;
begin
  DataSet := dsResult.DataSet;
  // jcdsResult.Fields[0].FieldName;
  //jcdsResult.FieldCount;
  //showmessage(inttostr(jcdsResult.FieldCount));

  if (DataSet.Active) and (DataSet.RecordCount > 0) then
  begin
    SetLength(Columninfo, 0);
    Columns := NvDbgridEh2.Columns;
    dbgrdhResult.Columns.Clear;
    dbgrdhResult.DataSource:=nil;
    Columns2 := dbgrdhResult.Columns;
    Columns2.BeginUpdate;
    Columns2.Clear;
    SetLength(Columninfo, Columns.Count);
   // showmessage(inttostr(Columns.Count));

    for i := 0 to Columns.Count - 1 do
    begin
      // Columninfo[i].isactive := Columns.Items[i].Visible;
      Columninfo[i].width := 80; // Columns.Items[i].width;

      idx := DataSet.FieldByName(jcdsResult.Fields[i].FieldName).AsInteger;
      Columninfo[i].field_index := idx;
      //Columns2.a
      Columninfo[i].FieldName := Columns.Items[i].FieldName;
      Columninfo[i].Caption := Columns.Items[i].Title.Caption;
      // Columninfo[i].footer_Value := Columns.Items[i].Footer.Value;
      // Columninfo[i].footer_Valuetype := Columns.Items[i].Footer.ValueType;
      // Columninfo[i].ISAppend := False;
    end;

    // Columns2.Count;
   //showmessage(inttostr(Columns2.Count));
    try

      // 查找当前列中的项目
      //Columns2.BeginUpdate;
      //Columns2.Clear;
      for i := 0 to Length(Columninfo) - 1 do
      begin
        try
          for j := 0 to Length(Columninfo) - 1 do
          begin
            if (i = Columninfo[j].field_index) then
            begin

              Column_n := Columns2.Add;
             { if i >= 16 then
                //Column_n.Index := i
              else
                Column_n.Index := i;
              }
              Column_n.FieldName := Columninfo[j].FieldName;
              Column_n.Title.Caption := Columninfo[j].Caption;
              break;
            end;
          end;

        except
          Columns2.Clear;
        end;
      end;

      DataSet.Delete;
      dbgrdhResult.DataSource := dsResult;
      dbgrdhResult.Columns.Items[0].width := 140;
      dbgrdhResult.Columns.Items[1].width := 100;
      dbgrdhResult.Columns.Items[2].width := 140;
      dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtStaticText;
      dbgrdhResult.Columns.Items[0].Footer.value := '合计';
      dbgrdhResult.Columns.Items[1].Footer.ValueType := fvtCount;

      for i := 3 to DataSet.Fields.Count - 1 do
      begin
        dbgrdhResult.Columns.Items[i].Footer.ValueType := fvtSum;
      end;
    finally
      Columns2.EndUpdate;
    end;
  end;
end;

procedure TFrmQryVehiclebalanced.jcdsResultAfterOpen(DataSet: TDataSet);
var
  i, j: integer;
begin
  inherited;

  { if (DataSet.Active) and (DataSet.RecordCount > 0) then
    begin
    DataSet.First;
    for j := 0 to DataSet.Fields.Count - 1 do
    for I := 0 to DataSet.Fields.Count - 1 do
    begin
    dbgrdhResult.Columns.Items[i].Index:=
    DataSet.FieldByName(dbgrdhResult.Columns.Items[i].FieldName).AsInteger;
    dbgrdhResult.Columns.Items[i].Width := 70;
    end;
    DataSet.Delete;
    dbgrdhResult.Columns.Items[0].Width := 140;
    dbgrdhResult.Columns.Items[2].Width := 140;
    dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtStaticText;
    dbgrdhResult.Columns.Items[0].Footer.value := '合计';
    dbgrdhResult.Columns.Items[1].Footer.ValueType := fvtCount;
    for I := 3 to DataSet.Fields.Count-1 do
    begin
    dbgrdhResult.Columns.Items[i].Footer.ValueType := fvtSum;
    end;
    end; }
end;

procedure TFrmQryVehiclebalanced.tbtnFilterClick(Sender: TObject);
var
  log: string;
begin
  inherited;
  dbgrdhResult.Columns.Clear;
  with jcdsResult do
  begin
    Active := False;
    if nvcbbNovaCkbOrg.CheckedCount = 0 then
      Params.ParamValues['orgids'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['orgids'] := nvcbbNovaCkbOrg.GetSelectID;
    Params.ParamValues['fromdepart'] := formatdatetime('yyyy-mm-dd',
      dtpBalancedStart.DateTime);
    Params.ParamValues['todepart'] := formatdatetime('yyyy-mm-dd',
      dtpBalancedEnd.DateTime);

    if (NovaHelpUnit.Text <> '') and (NovaHelpUnit.Id > 0) then
      Params.ParamValues['balanceunitid'] := NovaHelpUnit.Id
    else
      Params.ParamValues['balanceunitid'] := null;

    if (NovaHelpVehicle.Text <> '') and (NovaHelpVehicle.Id > 0) then
      Params.ParamValues['vehicleid'] := NovaHelpVehicle.Id
    else
      Params.ParamValues['vehicleid'] := null;
    Active := True;
    GridLoad;
    log := '查询条件有：[结账日期]从 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedStart.Date) + ' 至 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedEnd.Date);
    if trim(nvcbbNovaCkbOrg.Text) <> '' then
      log := log + ',[所属机构]：' + nvcbbNovaCkbOrg.Text;
    if trim(NovaHelpUnit.Text) <> '' then
      log := log + ',[车属单位]：' + NovaHelpUnit.Text;
    if trim(NovaHelpVehicle.Text) <> '' then
      log := log + ',[车牌号]：' + NovaHelpVehicle.Text;

    log := log + '。[查询结果]:返回 ' + inttostr(RecordCount) + ' 条记录！';
    SysLog.WriteLog('结算管理->单车已结算查询', '查询', log);
  end;
end;

end.

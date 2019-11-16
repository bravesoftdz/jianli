unit UFrmDeductTypes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet;

type
  TFrmDeductTypes = class(TSimpleEditForm)
    lblroute: TLabel;
    nvhlproute: TNovaHelp;
    GroupBox1: TGroupBox;
    dbgrdhResult: TNvDbgridEh;
    jscdQryDeducts: TjsonClientDataSet;
    DataSource1: TDataSource;
    jscdSaveDeducts: TjsonClientDataSet;
    procedure nvhlprouteIdChange(Sender: TObject);
    procedure jscdQryDeductsAfterOpen(DataSet: TDataSet);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDeductTypes: TFrmDeductTypes;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmDeductTypes.bbtnSaveClick(Sender: TObject);
var
  I, j, indx,nResult: Integer;
  filedname,sResult: String;
  routeid, stationid,createby: int64;
  deductmoney: double;
  deductname: String;
begin
  inherited;

  jscdSaveDeducts.FieldDefs.Clear;
  with jscdSaveDeducts.FieldDefs.AddFieldDef do
  begin
    Name:='id';
    DataType:=ftInteger;
  end;
  with jscdSaveDeducts.FieldDefs.AddFieldDef do
  begin
    Name:='routeid';
    DataType:=ftInteger;
  end;
  with jscdSaveDeducts.FieldDefs.AddFieldDef do
  begin
     Name:='stationid';
     DataType:=ftInteger;
  end;
  with jscdSaveDeducts.FieldDefs.AddFieldDef do
  begin
     Name:='deductmoney';
     DataType:=ftFloat;

  end;
  with jscdSaveDeducts.FieldDefs.AddFieldDef do
  begin
    Name:='deductname';
    DataType:=ftString;
  end;
  with jscdSaveDeducts.FieldDefs.AddFieldDef do
  begin
    Name:='createby';
    DataType:=ftInteger;
  end;
  createby:=SysInfo.LoginUserInfo.UserID;
  jscdSaveDeducts.CreateDataSet;
  with jscdQryDeducts do
  begin
    first;
    while not eof do
    begin
      stationid := fieldbyname('stationid').AsLargeInt;
      for j := 2 to DataSource1.DataSet.Fields.Count - 1 do
      begin
        routeid := nvhlproute.Id;
        deductname := dbgrdhResult.Columns.Items[j].FieldName;
        deductmoney := DataSource1.DataSet.fieldbyname(deductname).AsFloat;
        jscdSaveDeducts.AppendRecord([0,routeid, stationid, deductmoney,
          deductname,createby]);
      end;
      next;
    end;
  end;
  try
     with jscdSaveDeducts do
     begin
        jscdSaveDeducts.ApplyUpdates(-1);
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        if True then
        begin
          SysDialogs.ShowMessage(sResult);
          ModalResult := mrok;
        end
        else
        begin
          SysDialogs.Warning(sResult);
        end;
     end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存站点扣费信息失败：' + E.Message);
    end;
  end;
end;

procedure TFrmDeductTypes.jscdQryDeductsAfterOpen(DataSet: TDataSet);
var
  I, j, indx: Integer;
  filedname: String;
begin
  inherited;
  if DataSet.RecordCount > 0 then
  begin
    DataSet.Last;
    for j := 0 to DataSet.Fields.Count - 1 do
      for I := 1 to DataSet.Fields.Count - 1 do
      begin
        filedname := dbgrdhResult.Columns.Items[I].FieldName;
        indx := DataSet.fieldbyname(filedname).AsInteger;
        dbgrdhResult.Columns.Items[I].Index := indx;
        dbgrdhResult.Columns.Items[I].Width := length(filedname) * 16;
      end;
    DataSet.Delete;
    // DataSet.Delete;
    dbgrdhResult.Columns.Items[0].Visible := false;
    dbgrdhResult.Columns.Items[0].ReadOnly := True;
    dbgrdhResult.Columns.Items[1].Width := 100;
    dbgrdhResult.Columns.Items[1].ReadOnly := True;
    { dbgrdhResult.Columns.Items[0].Width := 100;
      dbgrdhResult.Columns.Items[0].Footer.DisplayFormat := '合计';
      dbgrdhResult.Columns.Items[0].Footer.ValueType := fvtCount;
      dbgrdhResult.Columns.Items[1].Width := 80;
      dbgrdhResult.Columns.Items[1].Footer.ValueType := fvtCount;
      dbgrdhResult.Columns.Items[DataSet.Fields.Count - 1].Width := 100;
      dbgrdhResult.Columns.Items[2].Width := 150;
      dbgrdhResult.Columns.Items[3].Width := 150;
      for I := 2 to DataSet.Fields.Count - 2 do
      begin
      dbgrdhResult.Columns.Items[I].Footer.ValueType := fvtSum;
      end; }
  end;
end;

procedure TFrmDeductTypes.nvhlprouteIdChange(Sender: TObject);
begin
  inherited;
  if (nvhlproute.Id > 0) then
  begin
    with jscdQryDeducts do
    begin
      active := false;
      Params.ParamValues['routeid'] := nvhlproute.Id;
      active := True;
    end;
  end;
end;

end.

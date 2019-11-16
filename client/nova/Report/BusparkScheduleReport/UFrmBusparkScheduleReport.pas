unit UFrmBusparkScheduleReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox,DateUtils, NovaHComboBox
  ,Generics.Collections,Generics.Defaults;

type
  TCrackNvDbgridEh = class(TNvDbgridEh);
  TFrmBusparkScheduleReport = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbldate: TLabel;
    dtpdepartdate: TDateTimePicker;
    NovaCbbOrg: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmBusparkScheduleReport: TFrmBusparkScheduleReport;

implementation
 uses   PubFn,Services;
{$R *.dfm}

procedure QuickSort(columns:TDBGridColumnsEh;L, R: Integer);
var
  I, J: Integer;
  pivot, temp: TColumnEh;
  function Compare(columnA,columnB:TColumnEh):Integer;
  var partindexA,partindexB:Integer;
      colnameA,colnameB:String;
  begin
      if Pos('buspark',ColumnA.FieldName)>0  then
      begin
        partindexA:=strtoint(Copy(ColumnA.FieldName,Length('buspark')+1));
        colnameA:=Copy(ColumnA.FieldName,1,Length('buspark'));
      end
      else if Pos('time',ColumnA.FieldName)>0  then
      begin
        partindexA:=strtoint(Copy(ColumnA.FieldName,Length('time')+1));
        colnameA:=Copy(ColumnA.FieldName,1,Length('time'));
      end
      else
      begin
        partindexA:=strtoint(Copy(ColumnA.FieldName,Length('endstationname')+1));
        colnameA:=Copy(ColumnA.FieldName,1,Length('endstationname'));
      end;
      if Pos('buspark',ColumnB.FieldName)>0  then
      begin
        partindexB:=strtoint(Copy(ColumnB.FieldName,Length('buspark')+1));
        colnameB:=Copy(ColumnB.FieldName,1,Length('buspark'));
      end
      else if Pos('time',ColumnB.FieldName)>0  then
      begin
        partindexB:=strtoint(Copy(ColumnB.FieldName,Length('time')+1));
        colnameB:=Copy(ColumnB.FieldName,1,Length('time'));
      end
      else
      begin
        partindexB:=strtoint(Copy(ColumnB.FieldName,Length('endstationname')+1));
        colnameB:=Copy(ColumnB.FieldName,1,Length('endstationname'));
      end;
      if partindexA-partindexB=0 then
      begin
        if colnameA=colnameB then
        begin
          result:=0;
        end
        else
        begin
          if colnameA='buspark' then
          begin
            Result := -1;
          end
          else if colnameA='time' then
          begin
            if colnameB='buspark' then
            begin
              Result := 1;
            end
            else
            begin
              Result := -1;
            end;
          end
          else
          begin
            Result := 1;
          end;
        end;
      end
      else
      begin
        Result := partindexA-partindexB;
      end;
  end;
begin
  if (columns.Count = 0) or ((R - L) <= 0) then
    Exit;
  repeat
    I := L;
    J := R;
    pivot := columns.Items[L + (R - L) shr 1];
    repeat
      while Compare(columns.Items[I], pivot) < 0 do
        Inc(I);
      while Compare(columns.Items[J], pivot) > 0 do
        Dec(J);
      if I <= J then
      begin
        if I <> J then
        begin
//          temp := columns.Items[I];
//          columns.Items[I] := columns.Items[J];
//          columns.Items[J] := temp;
          columns.Items[I].Index:=J;
          columns.Items[J-1].Index:=I;
        end;
        Inc(I);
        Dec(J);
      end;
    until I > J;
    if L < J then
      QuickSort(columns, L, J);
    L := I;
  until I >= R;
end;


procedure TFrmBusparkScheduleReport.FormShow(Sender: TObject);
var
 i:integer ;
begin
  inherited;
  with NovaCbbOrg do
  begin
    Active := False;
    Params.ParamValues['filter_INS_t!id'] :=SysInfo.LoginUserInfo.OrgIDs;
    Params.ParamValues['filter_INS_t!type'] :='(1,2)'; //车站、配客点
    Active := True;
  end;
  dtpdepartdate.Date := Now;
  for I := 0 to dbgrdhResult.Columns.Count - 1 do
  begin
    dbgrdhResult.Columns.Items[I].Visible := false;
  end;
end;

procedure TFrmBusparkScheduleReport.jcdsResultAfterOpen(DataSet: TDataSet);
var i,j:Integer;
    busparks:TDictionary<Integer,String>;
    partindex:Integer;
    curcolumn:TColumnEh;
begin
  inherited;
  partindex:=-1;
  if DataSet.RecordCount>0 then
  begin
    TCrackNvDbgridEh(dbgrdhResult).BeginLayout;
    dbgrdhResult.Columns.AddAllColumns(True);
    busparks:=TDictionary<Integer,String>.Create();
    for I := 0 to dbgrdhResult.Columns.Count-1 do
    begin
      curcolumn:=dbgrdhResult.Columns.Items[i];
      if Pos('buspark',curcolumn.FieldName)>0  then
      begin
        partindex:=strtoint(Copy(curcolumn.FieldName,Length('buspark')+1));
        busparks.add(partindex,DataSet.FieldByName(curcolumn.FieldName).AsString);
        curcolumn.Visible:=false;
      end;
    end;
    for I := 0 to dbgrdhResult.Columns.Count-1 do
    begin
      curcolumn:=dbgrdhResult.Columns.Items[i];
      if not curcolumn.Visible then
      begin
        Continue;
      end;
      if Pos('time',curcolumn.FieldName)>0  then
      begin
        partindex:=strtoint(Copy(curcolumn.FieldName,Length('time')+1));
        curcolumn.Title.Caption:=busparks.Items[partindex]+'|'+'发车时间';
        curcolumn.Width:=50;
      end
      else
      begin
        partindex:=strtoint(Copy(curcolumn.FieldName,Length('endstationname')+1));
        curcolumn.Title.Caption:=busparks.Items[partindex]+'|'+'终点站';
        curcolumn.Width:=80;
      end;
    end;
    QuickSort(dbgrdhResult.Columns,0,dbgrdhResult.Columns.Count-1);
    TCrackNvDbgridEh(dbgrdhResult).EndLayout;
    busparks.Free;
  end;
end;

procedure TFrmBusparkScheduleReport.tbtnFilterClick(Sender: TObject);
var
  log: string;
  I: Integer;
begin
  inherited;
  if NovaCbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    NovaCbbOrg.SetFocus;
    exit;
  end;
  for I := 0 to dbgrdhResult.Columns.Count - 1 do
  begin
    dbgrdhResult.Columns.Items[I].Visible := false;
  end;
  dbgrdhResult.Columns.Clear;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['orgid'] := NovaCbbOrg.HelpFieldValue['id'];
    Params.ParamValues['departdate'] := DateToStr(dtpdepartdate.Date);
    Active := True;

    log :='[发车日期]：'+ formatdatetime('yyyy-mm-dd',dtpdepartdate.Date);
    if Trim(NovaCbbOrg.Text) <>'' then
      log := log +',[机构]：'+NovaCbbOrg.Text;
    log := log+'。[查询结果]:返回 '+ inttostr(RecordCount) +' 条记录！';
    SysLog.WriteLog('报表统计->车库发班表','查询',log);
  end;

end;

end.

unit UFrmOrgdayneedBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls;

type
  TFrmOrgdayneedBalance = class(TSimpleCRUDForm)
    grp1: TGroupBox;
    dbgrdh1: TDBGridEh;
    DataSource1: TDataSource;
    jsonClientDataSet1: TjsonClientDataSet;
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmOrgdayneedBalance: TFrmOrgdayneedBalance;

implementation

{$R *.dfm}

procedure TFrmOrgdayneedBalance.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if dsResult.DataSet.RecordCount < 1 then
  begin
    jsonClientDataSet1.Close;
  end;
end;

procedure TFrmOrgdayneedBalance.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with jsonClientDataSet1 do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_t!orgdayneedbalanceid'] := jcdsResult.FieldByName('id').Value;
    Active := True;
  end;
end;

end.

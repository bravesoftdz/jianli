unit UFrmQryBalanceMonth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls;

type
  TFrmQryBalanceMonth = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lbl3: TLabel;
    dtpBalancedStart: TDateTimePicker;
    dtpBalancedEnd: TDateTimePicker;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryBalanceMonth: TFrmQryBalanceMonth;

implementation

uses SystemInstance, SysInfoIntf, PubFn, UDMPublic, Services;
{$R *.dfm}

procedure TFrmQryBalanceMonth.FormShow(Sender: TObject);
begin
  inherited;
  dtpBalancedStart.Date := Now;
  dtpBalancedEnd.Date := Now;
end;

procedure TFrmQryBalanceMonth.tbtnFilterClick(Sender: TObject);
var
  log: string;
  i: Integer;
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['fromdepart'] := formatdatetime('yyyy-mm-dd',
      dtpBalancedStart.DateTime);
    Params.ParamValues['todepart'] := formatdatetime('yyyy-mm-dd',
      dtpBalancedEnd.DateTime);
    Active := true;

    log := '查询条件有：[结账日期]从 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedStart.Date) + ' 至 ' + formatdatetime('yyyy-mm-dd',
      dtpBalancedEnd.Date);

    log := log + '。[查询结果]:返回 ' + inttostr(RecordCount) + ' 条记录！';
    SysLog.WriteLog('结算管理->单车已结算查询', '查询', log);

    DisableControls;
    try
      First;
      i := 0;

      while not eof do
      begin
        if (FieldByName('totalamount').AsInteger = 0) and (RecordCount>1) then
        begin
          Delete;
        end;
        Next;
      end;
    finally
      EnableControls;

    end;
  end;
end;

end.

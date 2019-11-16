unit UFrmDeductRoutestop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaHComboBox, NovaEdit;

type
  TFrmDeductRoutestop = class(TSimpleCRUDForm)
    jscddelDeductroutestop: TjsonClientDataSet;
    Label6: TLabel;
    Label1: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    lblroute: TLabel;
    nvhRoute: TNovaHelp;
    NovahItem: TNovaHelp;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDeductRoutestop: TFrmDeductRoutestop;

implementation

uses UFrmDeductRoutestopEdt, PubFn, Services, UDMPublic, UFrmDeductTypes;
{$R *.dfm}

procedure TFrmDeductRoutestop.FormShow(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active := false;
  NovaHCbbOrg.Active := true;
end;

procedure TFrmDeductRoutestop.tbtnDeleteClick(Sender: TObject);
var
  sResult, log: string;
  nResult: Integer;
  id: int64;
begin
  inherited;
  if not jcdsResult.Active then
    Exit;
  if jcdsResult.RecordCount <= 0 then
    Exit;
  id := jcdsResult.FieldByName('id').AsLargeInt;
  if SysDialogs.Confirm('删除操作', '确认要删除该线路停靠点扣费信息吗？') then
    try
      with jscddelDeductroutestop do
      begin
        Active := false;
        Params.ParamValues['deductroutestop.id'] := id;
        execute;
        sResult := Params.ParamByName('msg').Value;
        nResult := Params.ParamByName('flag').Value;
        if (nResult = 1) then
        begin
          log := '删除线路站点扣费项目：扣费项目=' + jcdsResult.FieldByName('itemname')
            .AsString + ',线路名称=' + jcdsResult.FieldByName('routename')
            .AsString + ',站点名称=' + jcdsResult.FieldByName('stationname')
            .AsString + ',扣费金额=' + jcdsResult.FieldByName('deductmoney').AsString;
          SysLog.WriteLog('结算管理—>线路停靠点扣费', '删除', log);
          SysDialogs.ShowMessage(sResult);
          tbtnFilterClick(nil);
        end
        else
          SysDialogs.Warning(sResult);
      end;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('删除线路停靠点扣费操作失败：' + e.Message);
      end;
    end;

end;

procedure TFrmDeductRoutestop.tbtnFilterClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;
  if jcdsResult.Active and (jcdsResult.RecordCount > 0) then
    curid := jcdsResult.FieldByName('id').AsInteger;
  if NovaHCbbOrg.Text = '' then
  begin
    SysDialogs.Warning('请选择机构！');
    Exit;
  end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_EQL_r!orgid'] := NovaHCbbOrg.HelpFieldValue
      ['id'];
    if (NovahItem.Text <> '') and (NovahItem.id > 0) then
      Params.ParamValues['filter_EQL_b!id'] := NovahItem.id
    else
      Params.ParamValues['filter_EQL_b!id'] := null;
    if (nvhRoute.Text <> '') and (nvhRoute.id > 0) then
      Params.ParamValues['filter_EQL_r!id'] := nvhRoute.id
    else
      Params.ParamValues['filter_EQL_r!id'] := null;
    Active := true;
    if (RecordCount > 0) and (curid > 0) then
    begin
      jcdsResult.Locate('id', curid, []);
    end;
  end;
end;

procedure TFrmDeductRoutestop.tbtnInsertClick(Sender: TObject);
var
  curid: int64;
begin
  inherited;

  try
    FrmDeductTypes := TFrmDeductTypes.Create(self);
    with FrmDeductTypes do
    begin
      caption := '批量设置站点扣费信息';
      if jcdsResult.Active and (jcdsResult.RecordCount > 0) then
      begin
        nvhlproute.Text := jcdsResult.FieldByName('routename').AsString;
        curid := jcdsResult.FieldByName('routeid').AsLargeInt;
        nvhlproute.id := curid;
      end;
      if SysMainForm.showFormModal(FrmDeductTypes, false) = mrok then
      begin
        curid := nvhlproute.id;
        tbtnFilterClick(nil);
        jcdsResult.Locate('routeid', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmDeductTypes);
  end;
end;

end.

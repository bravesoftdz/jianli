unit UFrmAboutRoute;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaEdit, NovaHComboBox, DBGridEhGrouping, GridsEh,
  DBGridEh, NvDbgridEh, Menus, ComCtrls, NovaListView, NovaHelp, ImgList;

type
  TFrmAboutRoute = class(TSimpleEditForm)
    Label3: TLabel;
    NovaEdtName: TNovaEdit;
    jcdsSaveAboutRoute: TjsonClientDataSet;
    Label1: TLabel;
    Label2: TLabel;
    NovaEdtValue: TNovaEdit;
    NovaHelpRoute: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype,createtime, item: String;
    ticketpriceformulaitemid, createby,id: integer;
  end;

var
  FrmAboutRoute: TFrmAboutRoute;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutRoute.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult,result: string;
begin
  if NovaHelpRoute.id < 0 then
  begin
    NovaHelpRoute.SetFocus;
    SysDialogs.Warning('请选择相关线路！');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('请输入计算值！');
    exit;
  end;

  with jcdsSaveAboutRoute do
  begin
    close;
    Params.ParamByName('formulaitemroute.id').Value :=id;
    Params.ParamByName('formulaitemroute.routeid').Value := NovaHelpRoute.id;
    Params.ParamByName('formulaitemroute.value').Value := trim(NovaEdtValue.text);
    Params.ParamByName('formulaitemroute.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemroute.createby').Value := createby;
    Params.ParamByName('formulaitemroute.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHelpRoute.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '票价公式组成项明细：项目名称='+NovaEdtName.Text+',线路名称='+
        NovaHelpRoute.Text+',计算值='+NovaEdtValue.Text;
        SysLog.WriteLog('票价管理——>票价公式组成项',result,log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票价公式组成项增加失败：' + E.Message);
      end;
    end;
  end;
end;

end.

unit UFrmPrintItemSetEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet;

type
  TFrmPrintItemSetEdt = class(TSimpleEditForm)
    lbl3: TLabel;
    NovaHelpVehicleno: TNovaHelp;
    Label1: TLabel;
    NovaHCbbType: TNovaHComboBox;
    Label2: TLabel;
    NovaHCbbTypeItem: TNovaHComboBox;
    jscdsavePrintItemSet: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure NovaHCbbTypeChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
        id, createby,orgid: int64;
    createtime:string;
  end;

var
  FrmPrintItemSetEdt: TFrmPrintItemSetEdt;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmPrintItemSetEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;

  if NovaHCbbType.ItemIndex<0 then
  begin
    NovaHCbbType.SetFocus;
    SysDialogs.Warning('请选择打印票据！');
    exit;
  end;
  if NovaHCbbTypeItem.ItemIndex<0 then
  begin
    NovaHCbbTypeItem.SetFocus;
    SysDialogs.Warning('请选择打印项目！');
    exit;
  end;
  if (trim(NovaHelpVehicleno.Text)='') or (NovaHelpVehicleno.Id=0)
  then
  begin
    NovaHelpVehicleno.SetFocus;
    SysDialogs.Warning('请输入营运车辆！');
    exit;
  end;

   with jscdsavePrintItemSet do
  begin
    close;
    Params.ParamByName('printtemplateitemset.id').Value := id;
    Params.ParamByName('printtemplateitemset.createby').Value := createby;
    Params.ParamByName('printtemplateitemset.createtime').Value := createtime;
    Params.ParamByName('printtemplateitemset.isprint').Value := false;
    Params.ParamByName('printtemplateitemset.orgid').Value := SysInfo.LoginUserInfo.OrgID;
    Params.ParamByName('printtemplateitemset.printtemplatetypeitemid').Value := NovaHCbbTypeItem.HelpFieldValue['id'];
    Params.ParamByName('printtemplateitemset.vehicleid').Value := NovaHelpVehicleno.Id;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHelpVehicleno.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '修改不打印项目设置：打印票据='+NovaHCbbType.Text+',打印项目='+
          NovaHCbbTypeItem.Text+',营运车牌='+NovaHelpVehicleno.Text;;
          SysLog.WriteLog('综合检票——>不打印项目设置','修改',log);
        end else
        begin
          log := '添加不打印项目设置：打印票据='+NovaHCbbType.Text+',打印项目='+
          NovaHCbbTypeItem.Text+',营运车牌='+NovaHelpVehicleno.Text;
          SysLog.WriteLog('综合检票——>不打印项目设置','添加',log);
        end;
        id:=Params.ParamByName('operationid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('不打印项目信息增加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmPrintItemSetEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaHCbbType.Active:=false;
  NovaHCbbType.Active:=true;
end;

procedure TFrmPrintItemSetEdt.NovaHCbbTypeChange(Sender: TObject);
begin
  inherited;
  if (NovaHCbbType.Active) and (NovaHCbbType.ItemIndex>=0) then
  begin
     NovaHCbbTypeItem.Active:=false;
     NovaHCbbTypeItem.Params.ParamValues['filter_EQL_t!printtemplatetype.id']:=NovaHCbbType.HelpFieldValue['id'];
     NovaHCbbTypeItem.Active:=true;
  end;
end;

end.

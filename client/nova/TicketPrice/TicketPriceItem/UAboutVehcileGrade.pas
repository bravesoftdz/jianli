unit UAboutVehcileGrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaComboBox, NovaEdit, NovaHComboBox, ImgList;

type
  TFrmAboutVehcilGrade = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaHcbbVehcile: TNovaHComboBox;
    NovaEdtValue: TNovaEdit;
    NovaEdtName: TNovaEdit;
    Label4: TLabel;
    NovaCbbRoadGrade: TNovaComboBox;
    jcdsSaveItemAboutVchileRoad: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype:String;
    createtime,vchcilename,roadgradename: string;
    id,ticketpriceformulaitemid,createby:integer;
  end;

var
  FrmAboutVehcilGrade: TFrmAboutVehcilGrade;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutVehcilGrade.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result: string;
begin
  inherited;
  if NovaHcbbVehcile.ItemIndex<0 then
  begin
    NovaHcbbVehcile.SetFocus;
    SysDialogs.Warning('请选择车型！');
    exit;
  end;
  if NovaCbbRoadGrade.ItemIndex<0 then
  begin
    NovaCbbRoadGrade.SetFocus;
    SysDialogs.Warning('请选择公路等级！');
    exit;
  end;
  if trim(NovaEdtValue.Text) = '' then
  begin
    NovaEdtValue.SetFocus;
    SysDialogs.Warning('请输入计算值！');
    exit;
  end;

  with jcdsSaveItemAboutVchileRoad do
  begin
    close;
    Params.ParamByName('formulaitemvehcileroadgrad.id').Value := id;
    Params.ParamByName('formulaitemvehcileroadgrad.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemvehcileroadgrad.value').Value := strtofloat(NovaEdtValue.Text);
    Params.ParamByName('formulaitemvehcileroadgrad.roadgrade').Value :=  NovaCbbRoadGrade.GetSelectCode;
    Params.ParamByName('formulaitemvehcileroadgrad.vehciletypeid').Value :=  NovaHcbbVehcile.HelpFieldValue['id'];
    Params.ParamByName('formulaitemvehcileroadgrad.createby').Value := createby;
    Params.ParamByName('formulaitemvehcileroadgrad.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaEdtValue.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '票价公式组成项明细：项目名称='+NovaEdtName.Text+',车型='+
        NovaHcbbVehcile.Text+',公路等级='+NovaCbbRoadGrade.Text+',计算值='+
        NovaEdtValue.Text;
        SysLog.WriteLog('票价管理——>票价公式组成项',result,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('车型公路等级相关票价公式组成项信息增加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmAboutVehcilGrade.FormShow(Sender: TObject);
begin
  inherited;
  NovaHcbbVehcile.Active:=false;
  NovaHcbbVehcile.Active:=true;
  NovaCbbRoadGrade.Active:=false;
  NovaCbbRoadGrade.Active:=true;
  if self.edittype=Tedittype.update then
  begin
   NovaCbbRoadGrade.ItemIndex:=NovaCbbRoadGrade.Items.IndexOf(roadgradename);
   NovaHcbbVehcile.ItemIndex:=NovaHcbbVehcile.Items.IndexOf(vchcilename);
  end;
end;

end.

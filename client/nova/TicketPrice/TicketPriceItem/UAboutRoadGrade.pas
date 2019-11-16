unit UAboutRoadGrade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, DB,
  DBClient, jsonClientDataSet, NovaEdit, ImgList;

type
  TFrmAboutRoadGrade = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtValue: TNovaEdit;
    NovaEdtName: TNovaEdit;
    jcdsSaveItemAboutRoadGrade: TjsonClientDataSet;
    NovaCbbRoadGrade: TNovaComboBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    relatetype,item:String;
    createtime,roadgradename: string;
    id,ticketpriceformulaitemid,createby:integer;
  end;

var
  FrmAboutRoadGrade: TFrmAboutRoadGrade;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmAboutRoadGrade.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,result: string;
begin
  inherited;
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

  with jcdsSaveItemAboutRoadGrade do
  begin
    close;
    Params.ParamByName('formulaitemroadgrade.id').Value := id;
    Params.ParamByName('formulaitemroadgrade.ticketpriceformulaitem.id').Value := ticketpriceformulaitemid;
    Params.ParamByName('formulaitemroadgrade.value').Value := strtofloat(NovaEdtValue.Text);
    Params.ParamByName('formulaitemroadgrade.roadgrade').Value :=  NovaCbbRoadGrade.GetSelectCode;
    Params.ParamByName('formulaitemroadgrade.createby').Value := createby;
    Params.ParamByName('formulaitemroadgrade.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaCbbRoadGrade.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := result + '票价公式组成项明细：项目名称='+NovaEdtName.Text+',公路等级='+
        NovaCbbRoadGrade.Text+',计算值='+NovaEdtValue.Text;
        SysLog.WriteLog('票价管理——>票价公式组成项',result,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('公路等级相关票价公式组成项信息增加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmAboutRoadGrade.FormShow(Sender: TObject);
begin
  inherited;
  NovaCbbRoadGrade.Active:=false;
  NovaCbbRoadGrade.Active:=true;
  if self.edittype=Tedittype.update then
  begin
   NovaCbbRoadGrade.ItemIndex:=NovaCbbRoadGrade.Items.IndexOf(roadgradename);
  end;

end;

end.

unit UFrmPCticketentrnaceEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
  DB, DBClient, jsonClientDataSet,USimpleEditForm,
  ToolWin,Generics.Collections,FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaListView, NovaHComboBox;
type
  TfrmPCticketentrnceEdit = class(TSimpleEditForm)
    lblIP: TLabel;
    lblOrgid: TLabel;
    nvedtIP: TNovaEdit;
    jcdsSaveEntrance: TjsonClientDataSet;
    nvlvEntrance: TNovaListView;
    nvhcbbOrg: TNovaHComboBox;
    lbl28: TLabel;
    lbl1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhcbbOrgChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag,isedt:Boolean;
    isupdate :Boolean;
    id:integer;
    createtime,createby:String;
     class function getSubFunctionList:TList<TSubfunction>;
  end;

var
  frmPCentranceEdit: TfrmPCticketentrnceEdit;

implementation
 uses PubFn,Services;
 var FSubFunctionList:TList<TSubfunction>;

{$R *.dfm}

procedure TfrmPCticketentrnceEdit.FormCreate(Sender: TObject);
begin
  inherited;
//  if isupdate then
//  begin
//     nvhcbbOrg.Enabled := False;
//     nvedtIP.Enabled := False;
//  end
//  else
//  begin
    nvhcbbOrg.Active := False;
    nvhcbbOrg.Active := True;
//  end;

end;
procedure TfrmPCticketentrnceEdit.bbtnSaveClick(Sender: TObject);
var MResult:string;FResult:Integer;
begin
    inherited;
  with jcdsSaveEntrance do
  begin
    Close;
    if nvhcbbOrg.ItemIndex<0 then
      begin
        SysDialogs.Warning('机构不能为空');
        nvhcbbOrg.SetFocus;
        exit;
      end
    else
      begin
         Params.ParamByName('pcticketentrance.orgid').Value := nvhcbbOrg.HelpFieldValue['id'];
      end;

     if Trim(nvedtIP.Text) =''then
      begin
        SysDialogs.Warning('机器IP不能为空');
        nvedtIP.SetFocus;
        exit;
      end ;
      if not checkip(nvedtIP.Text) then
      begin
        SysDialogs.Warning('你输入的机器IP不对！');
        if (nvedtIP.Enabled) then
        nvedtIP.SetFocus;
        exit;
      end
      else
      begin
      Params.ParamByName('pcticketentrance.ip').Value := nvedtIP.Text;
      end;
     if nvlvEntrance.GetSelected='' then
      begin
          SysDialogs.Warning('请选择要控制的检票口');
          nvlvEntrance.SetFocus;
          exit;
      end;
      Params.ParamByName('ticketentranceids').Value := nvlvEntrance.GetSelected;
      if isedt then
      begin
        if createtime<>'' then
          Params.ParamByName('pcticketentrance.createtime').Value := createtime;
        Params.ParamByName('pcticketentrance.createby').Value := createby;
        Params.ParamByName('isupdate').Value := 'true';
      end;
     try
      Execute;
      FResult := Params.ParamByName('flag').Value;
      MResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(MResult);
      if (FResult <= 0) then
      begin
        nvhcbbOrg.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('操作失败：' + E.Message);
      end;
    end;
  end;
end;


class function TfrmPCticketentrnceEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;
procedure TfrmPCticketentrnceEdit.nvhcbbOrgChange(Sender: TObject);
begin
  inherited;
  if nvhcbbOrg.ItemIndex>=0 then
  begin
      nvlvEntrance.Items.Clear;
      nvlvEntrance.Params[0].Value := nvhcbbOrg.HelpFieldValue['id'];
      nvlvEntrance.Active :=False;
      nvlvEntrance.Active :=True;
  end;
end;

end.

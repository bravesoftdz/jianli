unit UFrmParameterAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
   DB, DBClient, jsonClientDataSet,USimpleEditForm,
  ToolWin,Generics.Collections,FunctionItemIntf, UDMPublic,
  jsonConnection, NovaComboBox, NovaEdit, NovaHelp, NovaHComboBox;
type
  TFrmParameterAdd = class(TSimpleEditForm)
    lblcode: TLabel;
    lblCodeType: TLabel;
    lblorgid: TLabel;
    lblremark: TLabel;
    lblparamvalue: TLabel;
    mmoDeseription: TMemo;
    jcdsSaveparamd: TjsonClientDataSet;
    nvcbbtype: TNovaComboBox;
    nvedtCode: TNovaEdit;
    nvedtValue: TNovaEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl5: TLabel;
    nvhcbbOrg: TNovaHComboBox;
    procedure bbtnCloseClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
 protected
 public
    { Public declarations }
    class function getSubFunctionList:TList<TSubfunction>;
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;

 public
  id,orgid,parameterid,detailid,createby:integer;
   flag,isedt:boolean;
   orgname,unitname :string;

  end;

var
  FrmParameterAdd: TFrmParameterAdd;

implementation
 uses PubFn,Services;
 var FSubFunctionList:TList<TSubfunction>;
{$R *.dfm}

 procedure TFrmParameterAdd.bbtnCloseClick(Sender: TObject);
begin
   if  SysDialogs.Confirm('信息提示','确认要删除该记录吗!') then
      exit;
end;

  {$R *.dfm}
procedure TFrmParameterAdd.bbtnSaveClick(Sender: TObject);
var isaction,iseditable,MResult:String;FResult: integer ;
begin
 with jcdsSaveparamd do
  begin
     if (Trim(nvedtValue.Text)='') then
       begin
        SysDialogs.Warning('请输入参数值');
        nvedtValue.SetFocus;
        exit;
      end
      else
        Params.ParamByName('paramorgdetail.value').Value := nvedtValue.Text;

     Params.ParamByName('paramorgdetail.orgid').Value := orgid;
     Params.ParamByName('paramorgdetail.parameterid').Value := parameterid;
     Params.ParamByName('paramorgdetail.id').Value := detailid;

     try
      Execute;
      FResult := Params.ParamByName('flag').Value;
      MResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(MResult);
      if (FResult <= 0) then
      begin
        nvedtValue.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('detailid').AsInteger;
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

procedure TFrmParameterAdd.FormShow(Sender: TObject);
begin
  inherited;
  nvhcbbOrg.Active := False;
  nvhcbbOrg.Active := True;
  if isedt then
  begin
      nvhcbbOrg.ItemIndex := nvhcbbOrg.Items.IndexOf(orgname);
  end;
  if (unitname = '天') or
     (unitname = '小时') or
     (unitname = '时') or
     (unitname = '月')  then
  begin
     nvedtValue.MaxLength:=4;
  end else if   (unitname = '分钟') or
     (unitname = '分') or
     (unitname = '秒')   then
  begin
     nvedtValue.MaxLength:=5;
  end
  else
  begin
    nvedtValue.MaxLength := 9;
  end;
end;

class function TFrmParameterAdd.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

procedure TFrmParameterAdd.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
 // inherited;

end;

initialization
  FSubFunctionList:=TList<TSubfunction>.Create;
  FSubFunctionList.Add(TSubfunction.Create('{30518B3F-F389-43C9-84EC-7A82C83543F6}','添加'));
finalization
  FSubFunctionList.Free;
end.






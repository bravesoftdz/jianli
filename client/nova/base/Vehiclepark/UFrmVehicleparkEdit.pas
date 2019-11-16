{ ------------------------------------
  功能说明：上车卡位窗口
  创建日期：2011/1
  作者：haunghz
  版权：nova
  ------------------------------------- }
unit UFrmVehicleparkEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
   DB, DBClient, jsonClientDataSet,USimpleEditForm,
  ToolWin,Generics.Collections,FunctionItemIntf,
  jsonConnection, NovaEdit, NovaHelp, NovaCheckedComboBox, NovaHComboBox;

type
  TfrmVehicleparkEdit = class(TSimpleEditForm)
    lblName: TLabel;
    lblOrgid: TLabel;
    lbl1: TLabel;
    mmoDeseription: TMemo;
    lblremark: TLabel;
    jsnclntdtstInitCDSsave: TjsonClientDataSet;
    lblStar2: TLabel;
    lblstar1: TLabel;
    lblstar3: TLabel;
    nvedtPrintname: TNovaEdit;
    nvedtname: TNovaEdit;
    nvhcbbOrg: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     isedt,flag:boolean;
    id,orgid:Integer;
    createtime,createby,tname,printname,orgname,remarks:string;
    class function getSubFunctionList:TList<TSubfunction>;
  end;

var
  frmVehicleparkEdit: TfrmVehicleparkEdit;

implementation
 uses PubFn,Services,UDMPublic;
 var FSubFunctionList:TList<TSubfunction>;

{$R *.dfm}





procedure TfrmVehicleparkEdit.bbtnSaveClick(Sender: TObject);
var isactive:Boolean;MResult,log,optype,orname:string;orgid,FResult:Integer;
begin
  inherited;
  with jsnclntdtstInitCDSsave do
  begin
    Close;
     if nvhcbbOrg.ItemIndex <0 then
          begin
          SysDialogs.Warning('请选择所属机构');
          nvHcbbOrg.SetFocus;
          exit;
         end
      else
      begin
          Params.ParamByName('park.orgid').Value := nvhcbbOrg.HelpFieldValue['id'];
          orname := nvhcbbOrg.TextHint;
      end;
     if (Trim(nvedtname.Text)='') then
       begin
        SysDialogs.Warning('请填写上车卡位');
        nvedtname.SetFocus;
        exit;
      end
      else
       Params.ParamByName('park.name').Value := nvedtname.Text;

      if (Trim(nvedtPrintname.Text)='') then
       begin
        SysDialogs.Warning('请填写打印名称');
        nvedtPrintname.SetFocus;
        exit;
      end
      else
       Params.ParamByName('park.printname').Value := nvedtPrintname.Text;

     Params.ParamByName('park.remarks').Value := mmoDeseription.Text;
     Params.ParamByName('park.id').Value := id;
     Params.ParamByName('park.createby').Value := createby;
     Params.ParamByName('park.createtime').Value := createtime;
     Params.ParamByName('oldname').Value := tname;

    try
      Execute;
      FResult := Params.ParamByName('flag').Value;
      MResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(MResult);
      if (FResult <= 0) then
      begin
        nvedtname.SetFocus;
      end
      else
      begin
       if id>0 then
        begin
           optype:='修改';
            if orgname <> nvhcbbOrg.Text then
           begin
              log := ' [机构名称]由 '+orgname+ ' 改成 ' +nvhcbbOrg.Text+'’, ';
           end;
            if tname <> nvedtname.Text then
           begin
              log := log+' [乘车库名称] 由 '+tname+' 改成 '+nvedtname.Text+'’, ';
           end;
           if printname <> nvedtPrintname.Text then
           begin
              log := log+' [打印名称] 由 '+printname+' 改成 '+nvedtPrintname.Text+'’, ';
           end;
           if remarks <> mmoDeseription.Text then
           begin
               log := log+ '[描述] 由 '+remarks+' 改成 '+mmoDeseription.Text+'’, ';
           end;
        end
        else
        begin
           optype:='添加';
            log := '[所属机构]:'
            + nvhcbbOrg.HelpFieldValue['name']
            +', [乘车库名称]:'+nvedtname.Text+', [打印名称]:'+
                nvedtPrintname.Text+', [描述]:'+mmoDeseription.Text;
        end;
        SysLog.WriteLog('业务管理->上车卡位管理', optype, log);
        log:='';
        optype:='';
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

procedure TfrmVehicleparkEdit.FormCreate(Sender: TObject);
begin
  inherited;
   nvhcbbOrg.Active := True;
end;

class function TfrmVehicleparkEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;
end.

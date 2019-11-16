unit UFrmTicketentranceEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs ,StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, Menus,
   DB, DBClient, jsonClientDataSet,USimpleEditForm,
  ToolWin,Generics.Collections,FunctionItemIntf,
  jsonConnection, NovaEdit, NovaHelp, NovaHComboBox;

type
  TFrmTicketentranceEdit = class(TSimpleEditForm)
    lblName: TLabel;
    lblOrgid: TLabel;
    lblremark: TLabel;
    mmoDeseription: TMemo;
    jsnclntdtstInitCDSInit: TjsonClientDataSet;
    jsnclntdtstInitCDSsave: TjsonClientDataSet;
    lbl1: TLabel;
    nvedtPrintname: TNovaEdit;
    nvedtname: TNovaEdit;
    nvhcbbOrg: TNovaHComboBox;
    rbN: TRadioButton;
    lbl2: TLabel;
    rbY: TRadioButton;
    lbl15: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure bbtnCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    log:string;
  public
    { Public declarations }
     flag,isedt:boolean;
    id:integer;
    createtime,createby,orgname,tname,printname:string;
    class function getSubFunctionList:TList<TSubfunction>;
  end;

var
  FrmTicketentranceEdit: TFrmTicketentranceEdit;


implementation
 uses PubFn,Services,UDMPublic;
 var FSubFunctionList:TList<TSubfunction>;

{$R *.dfm}
procedure TFrmTicketentranceEdit.bbtnCloseClick(Sender: TObject);
begin
  inherited;
  SysDialogs.ShowError('确定要关闭吗？');
end;

procedure TFrmTicketentranceEdit.bbtnSaveClick(Sender: TObject);
 var isactive:Boolean;MResult,optype:string;orgid,FResult:Integer;
begin
  inherited;
  with jsnclntdtstInitCDSsave do
  begin
    Close;
     if nvhcbbOrg.ItemIndex < 0 then
          begin
          SysDialogs.Warning('请选择所属机构');
          nvhcbbOrg.SetFocus;
          exit;
         end
      else
      begin
          //orgid:=TCommInfo(cbbOrgid.Items.Objects[cbbOrgid.ItemIndex]).ID;
          Params.ParamByName('ticketentrance.orgid').Value := nvhcbbOrg.HelpFieldValue['id'];
      end;
     if (Trim(nvedtname.Text)='') then
       begin
        SysDialogs.Warning('请填写检票口');
        nvedtname.SetFocus;
        exit;
      end
      else
       Params.ParamByName('ticketentrance.name').Value := nvedtname.Text;

      if (Trim(nvedtPrintname.Text)='') then
       begin
        SysDialogs.Warning('请填写打印名称');
        nvedtPrintname.SetFocus;
        exit;
      end
      else
       Params.ParamByName('ticketentrance.printname').Value := nvedtPrintname.Text;

     Params.ParamByName('ticketentrance.remarks').Value := mmoDeseription.Text;
     Params.ParamByName('ticketentrance.id').Value := id;
     Params.ParamByName('ticketentrance.createby').Value := createby;
     Params.ParamByName('ticketentrance.createtime').Value := createtime;
    try
      Execute;
      FResult := Params.ParamByName('flag').Value;
      MResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(MResult);
      if (FResult <= 0) then
      begin
        nvedtname.SetFocus
      end
      else
      begin
        if id>0 then
        begin
           optype:='修改';
           log := '修改内容：';
            if orgname <> nvhcbbOrg.Text then
           begin
              log := ' 机构名称由'+orgname+'改成'+nvhcbbOrg.Text;
           end;
            if tname <> nvedtname.Text then
           begin
              log := log+' 检票口名称由'+tname+'改成'+nvedtname.Text;
           end;
           if printname <> nvedtPrintname.Text then
           begin
              log := log+' 打印名称由'+printname+'改成'+nvedtPrintname.Text;
           end;
        end
        else
        begin
           optype:='添加';
            log := '所属机构:'+ nvhcbbOrg.Text +', 检票口名称:'+nvedtname.Text+', 打印名称:'+
                nvedtPrintname.Text+', 描述:'+mmoDeseription.Text;
        end;
        SysLog.WriteLog('检票口管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
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

procedure TFrmTicketentranceEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvhcbbOrg.Active := True;
end;

class function TFrmTicketentranceEdit.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;
end.

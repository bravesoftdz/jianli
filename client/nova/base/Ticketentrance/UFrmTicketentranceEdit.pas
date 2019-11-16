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
  SysDialogs.ShowError('ȷ��Ҫ�ر���');
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
          SysDialogs.Warning('��ѡ����������');
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
        SysDialogs.Warning('����д��Ʊ��');
        nvedtname.SetFocus;
        exit;
      end
      else
       Params.ParamByName('ticketentrance.name').Value := nvedtname.Text;

      if (Trim(nvedtPrintname.Text)='') then
       begin
        SysDialogs.Warning('����д��ӡ����');
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
           optype:='�޸�';
           log := '�޸����ݣ�';
            if orgname <> nvhcbbOrg.Text then
           begin
              log := ' ����������'+orgname+'�ĳ�'+nvhcbbOrg.Text;
           end;
            if tname <> nvedtname.Text then
           begin
              log := log+' ��Ʊ��������'+tname+'�ĳ�'+nvedtname.Text;
           end;
           if printname <> nvedtPrintname.Text then
           begin
              log := log+' ��ӡ������'+printname+'�ĳ�'+nvedtPrintname.Text;
           end;
        end
        else
        begin
           optype:='���';
            log := '��������:'+ nvhcbbOrg.Text +', ��Ʊ������:'+nvedtname.Text+', ��ӡ����:'+
                nvedtPrintname.Text+', ����:'+mmoDeseription.Text;
        end;
        SysLog.WriteLog('��Ʊ�ڹ���', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����ʧ�ܣ�' + E.Message);
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

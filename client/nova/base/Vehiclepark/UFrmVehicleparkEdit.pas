{ ------------------------------------
  ����˵�����ϳ���λ����
  �������ڣ�2011/1
  ���ߣ�haunghz
  ��Ȩ��nova
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
          SysDialogs.Warning('��ѡ����������');
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
        SysDialogs.Warning('����д�ϳ���λ');
        nvedtname.SetFocus;
        exit;
      end
      else
       Params.ParamByName('park.name').Value := nvedtname.Text;

      if (Trim(nvedtPrintname.Text)='') then
       begin
        SysDialogs.Warning('����д��ӡ����');
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
           optype:='�޸�';
            if orgname <> nvhcbbOrg.Text then
           begin
              log := ' [��������]�� '+orgname+ ' �ĳ� ' +nvhcbbOrg.Text+'��, ';
           end;
            if tname <> nvedtname.Text then
           begin
              log := log+' [�˳�������] �� '+tname+' �ĳ� '+nvedtname.Text+'��, ';
           end;
           if printname <> nvedtPrintname.Text then
           begin
              log := log+' [��ӡ����] �� '+printname+' �ĳ� '+nvedtPrintname.Text+'��, ';
           end;
           if remarks <> mmoDeseription.Text then
           begin
               log := log+ '[����] �� '+remarks+' �ĳ� '+mmoDeseription.Text+'��, ';
           end;
        end
        else
        begin
           optype:='���';
            log := '[��������]:'
            + nvhcbbOrg.HelpFieldValue['name']
            +', [�˳�������]:'+nvedtname.Text+', [��ӡ����]:'+
                nvedtPrintname.Text+', [����]:'+mmoDeseription.Text;
        end;
        SysLog.WriteLog('ҵ�����->�ϳ���λ����', optype, log);
        log:='';
        optype:='';
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

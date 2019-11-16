unit UFrmPackTransfer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaHelp,
  NovaEdit, DB, DBClient, jsonClientDataSet,Services;

type
  TFrmPackTransfer = class(TSimpleEditForm)
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEditPackno: TNovaEdit;
    NovaEditTakename: TNovaEdit;
    nvhelptostation: TNovaHelp;
    jcdspacktransfersave: TjsonClientDataSet;
    nvedttransitfee: TNovaEdit;
    Label20: TLabel;
    Label4: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
//    Foperationid: Integer;
    log : String;
  public
    { Public declarations }
//    property operationid: Integer read Foperationid;
    packid : Integer;
  end;

var
  FrmPackTransfer: TFrmPackTransfer;

implementation

{$R *.dfm}

procedure TFrmPackTransfer.bbtnSaveClick(Sender: TObject);
var nResult: integer;
    sResult:string;
begin
  inherited;
  if NovaEditTakename.Text = '' then
  begin
    SysDialogs.Warning('�����������������');
    exit;
  end;
  if ((nvhelptostation.Text='') or (nvhelptostation.Id<0)) then
  begin
    SysDialogs.Warning('������Ŀ�ĵأ�');
    exit;
  end;


  with jcdspacktransfersave do
  begin
    Close;
    Params.ParamByName('pack.id').Value := packid; // �а�id
    Params.ParamByName('pack.packno').Value := NovaEditPackno.Text;
    Params.ParamByName('pack.consignee').Value := NovaEditTakename.Text;
    Params.ParamByName('pack.zhuanyuntostationid').Value := nvhelptostation.Id;
    Params.ParamByName('pack.transitfee').Value := nvedttransitfee.Text;
    Params.ParamByName('pack.updateby').Value :=  Sysinfo.LoginUserInfo.UserID;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaEditTakename.SetFocus;
      end
      else
      begin
        if packid > 0 then
        begin
          log := '�а�id='+inttostr(packid)+',�а�����='+NovaEditPackno.Text+',����������='
          +NovaEditTakename.Text+',Ŀ�ĵ�='+nvhelptostation.Text+',��ת��='+nvedttransitfee.Text;
          SysLog.WriteLog('�а�������>����ת��','����ת��',log);
        end else
        begin
          log := '�а�id='+inttostr(packid)+',�а�����='+NovaEditPackno.Text+',����������='
          +NovaEditTakename.Text+',Ŀ�ĵ�='+nvhelptostation.Text+',��ת��='+nvedttransitfee.Text;
          SysLog.WriteLog('�а�������>����ת��','����ת��',log);
        end;
        packid := Params.ParamByName('pack.id').Value;
        ModalResult := mrok;
      end;
     except
      on E: Exception do
      begin
        SysLog.WriteErr('�а�ת�Ʋ���ʧ�ܣ�' + E.Message);
      end;
    end;

  end;
end;

end.

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
    SysDialogs.Warning('请输入代理人姓名！');
    exit;
  end;
  if ((nvhelptostation.Text='') or (nvhelptostation.Id<0)) then
  begin
    SysDialogs.Warning('请输入目的地！');
    exit;
  end;


  with jcdspacktransfersave do
  begin
    Close;
    Params.ParamByName('pack.id').Value := packid; // 行包id
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
          log := '行包id='+inttostr(packid)+',行包单号='+NovaEditPackno.Text+',代理人姓名='
          +NovaEditTakename.Text+',目的地='+nvhelptostation.Text+',中转费='+nvedttransitfee.Text;
          SysLog.WriteLog('行包受理——>货物转移','货物转移',log);
        end else
        begin
          log := '行包id='+inttostr(packid)+',行包单号='+NovaEditPackno.Text+',代理人姓名='
          +NovaEditTakename.Text+',目的地='+nvhelptostation.Text+',中转费='+nvedttransitfee.Text;
          SysLog.WriteLog('行包受理——>货物转移','货物转移',log);
        end;
        packid := Params.ParamByName('pack.id').Value;
        ModalResult := mrok;
      end;
     except
      on E: Exception do
      begin
        SysLog.WriteErr('行包转移操作失败：' + E.Message);
      end;
    end;

  end;
end;

end.

unit UFrmCardActive;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet, ComCtrls;

type
  TFrmCardActive = class(TSimpleEditForm)
    lbl4: TLabel;
    nvhlptypename: TNovaHelp;
    jcdsCardactive: TjsonClientDataSet;
    lbl7: TLabel;
    lbl13: TLabel;
    dtpvaliddate: TDateTimePicker;
    nvhlpname: TNovaHelp;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl8: TLabel;
    nvhlpcardno: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,olddate: String;
  end;

var
  FrmCardActive: TFrmCardActive;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmCardActive.bbtnSaveClick(Sender: TObject);
var sResult,log : string;
    nResult : Integer;
begin
 // inherited;
  if dtpvaliddate.Date < Now then
  begin
    SysDialogs.ShowMessage('激活的有效期不能小于当前日期！');
    dtpvaliddate.SetFocus;
    Exit;
  end;
  with jcdsCardactive do
  begin
    Params.ParamValues['cardissue.id'] := id;
    Params.ParamValues['cardissue.validdate']
        := formatdatetime('yyyy-mm-dd', dtpvaliddate.Date);
    Params.ParamValues['cardissue.updateby'] := SysInfo.LoginUserInfo.UserID;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if nResult>0 then
      begin
        id := Params.ParamByName('id').Value;
        log := '发卡对象：'+nvhlptypename.Text+',名称：'+nvhlpname.Text+',卡号：'+
          nvhlpcardno.Text+' 的有效期 由 '+olddate
          +' 激活到 '+formatdatetime('yyyy-mm-dd', dtpvaliddate.Date);
        SysLog.WriteLog('业务管理->智能卡管理','激活卡有效期',log);
        ModalResult := mrok;
      end
      else
         dtpvaliddate.SetFocus;
    except
       on E: Exception do
      begin
        SysLog.WriteErr('激活失败：' + E.Message);
      end;
    end;
  end;

end;

end.

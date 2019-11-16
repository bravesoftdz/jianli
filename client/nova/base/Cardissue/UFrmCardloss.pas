unit UFrmCardloss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet;

type
  TFrmCardloss = class(TSimpleEditForm)
    lbl4: TLabel;
    lbl2: TLabel;
    nvhlptypename: TNovaHelp;
    nvhlpcardno: TNovaHelp;
    lbl16: TLabel;
    mmoremark: TMemo;
    jcdsCardcancel: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    functiontype, id, vipid  : Integer;
  end;

var
  FrmCardloss: TFrmCardloss;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmCardloss.bbtnSaveClick(Sender: TObject);
var sResult : string;
    nResult : Integer;
begin
  inherited;
  if Trim(mmoremark.Text) = '' then
  begin
    if functiontype = 1 then
      SysDialogs.ShowMessage('请填写挂失的原因！')
    else
      SysDialogs.ShowMessage('请填写恢复的原因！');
    Exit;
  end;
  with jcdsCardcancel do
  begin
    Close;
    Params.ParamValues['cardissue.id'] := id;
    params.ParamValues['vip.id'] := vipid;
    Params.ParamValues['vip.remarks'] := mmoremark.Text;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        mmoremark.SetFocus;
      end
      else
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('智能卡管理修改失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmCardloss.FormShow(Sender: TObject);
begin
  inherited;
  if functiontype = 1 then
  begin
    jcdsCardcancel.SaveAddress := 'base/cancelcardissue';
  end else
  begin
    jcdsCardcancel.SaveAddress := 'base/recovercardissue';
  end;
end;

end.

unit UFrmUseronlineEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaComboBox,
  DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmUseronlineEdit = class(TSimpleEditForm)
    idusername: TLabel;
    Labusercode: TLabel;
    Laborgname: TLabel;
    Labdepname: TLabel;
    nvedtusercode: TNovaEdit;
    nvedtusername: TNovaEdit;
    nvedtorgname: TNovaEdit;
    nvedtdepname: TNovaEdit;
    jsonCDSUseronlineSave: TjsonClientDataSet;
    Labip: TLabel;
    nvedtip: TNovaEdit;
    radioisonline: TRadioGroup;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    mark: boolean;
    userid: LongWord;
    sessionid: string;
    logintime, lastlogintime : TDatetime;
  end;

var
  FrmUseronlineEdit: TFrmUseronlineEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmUseronlineEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  with jsonCDSUseronlineSave do
  begin
    Close;
    Params.ParamByName('useronline.userid').Value := userid;
    Params.ParamByName('useronline.ip').Value := nvedtip.Text;
    Params.ParamByName('useronline.sessionid').Value := sessionid;
    Params.ParamByName('useronline.logintime').Value := DateTimeToStr(logintime);
    Params.ParamByName('useronline.lastlogintime').Value := DateTimeToStr(lastlogintime);
    //Params.ParamByName('useronline.isonline').Value := radioisonline.ItemIndex;
    if radioisonline.ItemIndex = 0 then
    begin
      Params.ParamByName('useronline.isonline').Value := true;
    end else
    begin
      Params.ParamByName('useronline.isonline').Value := false;
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        radioisonline.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('ÓÃ»§×´Ì¬ÐÞ¸ÄÊ§°Ü£º' + E.Message);
      end;
    end;
  end;
end;

end.

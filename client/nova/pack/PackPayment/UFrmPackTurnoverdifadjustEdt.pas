unit UFrmPackTurnoverdifadjustEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet;

type
  TFrmPackTurnoverdifadjustEdt = class(TSimpleEditForm)
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl1: TLabel;
    nvhlpseller: TNovaHelp;
    lbl3: TLabel;
    NovaEdtMoney: TNovaEdit;
    Label1: TLabel;
    MeRemark: TMemo;
    jscdsavedifmoney: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id,createby :int64;
    createbytime:string;
  end;

var
  FrmPackTurnoverdifadjustEdt: TFrmPackTurnoverdifadjustEdt;

implementation
uses Services,PubFn;
{$R *.dfm}

procedure TFrmPackTurnoverdifadjustEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,log,optype,msg: string;
begin
  inherited;
  if nvhlpseller.Id=0 then
  begin
    SysDialogs.Warning('请输入办理员！');
    exit;
  end;
   if NovaEdtMoney.text='' then
  begin
    SysDialogs.Warning('请输入调整金额！');
    exit;
  end;
  with jscdsavedifmoney do
  begin
    Close;
    Params.ParamValues['tdifadjusts.id']:= id;
    Params.ParamValues['tdifadjusts.moneydate']:=formatdatetime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['tdifadjusts.seller']:= nvhlpseller.id;
    Params.ParamValues['tdifadjusts.difmoney']:=NovaEdtMoney.text;
    Params.ParamValues['tdifadjusts.remark']:=MeRemark.Text;
    Params.ParamValues['tdifadjusts.orgid']:=SysInfo.LoginUserInfo.OrgID;
    Params.ParamValues['tdifadjusts.createby']:=createby;
    Params.ParamValues['createtime']:=createbytime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if nResult=1 then
      begin
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('差错调整设置失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmPackTurnoverdifadjustEdt.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime:=now;
end;

end.

unit UFrmRoutePriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, DBGridEhGrouping, DB, DBClient, jsonClientDataSet, GridsEh,
  DBGridEh, NvDbgridEh;

type
  TFrmRoutePriceEdt = class(TSimpleEditForm)
    Label1: TLabel;
    NovaEdtRoute: TNovaEdit;
    GroupBox1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    dsSchDiscountPrice: TDataSource;
    jcsdQrySchDiscountPrice: TjsonClientDataSet;
    ChkISSavetoStand: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    createby: int64;
  end;

var
  FrmRoutePriceEdt: TFrmRoutePriceEdt;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmRoutePriceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult, flag, i: integer;
  sResult, result, log, temp, title: string;
begin
  inherited;
  try
    with jcsdQrySchDiscountPrice do
    begin
      Params.ParamByName('savestandprice').Value :=ChkISSavetoStand.Checked;
      nResult := ApplyUpdates(-1);
      sResult := Params.ParamValues['msg'];
      flag := Params.ParamValues['flag'];

      if flag <= 0 then
      begin
        SysDialogs.ShowMessage(sResult);
        exit;
      end
      else
      begin
        SysDialogs.ShowMessage('保存成功！');
        ModalResult := mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存线路票价信息失败：' + E.Message);
    end;
  end;

end;

procedure TFrmRoutePriceEdt.FormShow(Sender: TObject);
begin
  inherited;
  with jcsdQrySchDiscountPrice do
  begin
    active := false;
    Params.ParamValues['routeid'] := NovaEdtRoute.Id;
    active := true;
  end;
end;

end.

unit UFrmScheduleDiscountPriceAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHComboBox, DB, DBClient, jsonClientDataSet;

type
  TFrmScheduleDiscountPriceAdd = class(TSimpleEditForm)
    lbl5: TLabel;
    NovaChOrgStation: TNovaHComboBox;
    lbl6: TLabel;
    lbl1: TLabel;
    NcbbReach: TNovaHComboBox;
    lbl3: TLabel;
    lbl2: TLabel;
    NovaEdtFullprice: TNovaEdit;
    lbl4: TLabel;
    lbl7: TLabel;
    NovaEdtBalancePrice: TNovaEdit;
    lbl8: TLabel;
    jscdSaveScheduleDisPrice: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure NovaEdtFullpriceChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    routeid,scheduleid,curid:Int64;
  end;

var
  FrmScheduleDiscountPriceAdd: TFrmScheduleDiscountPriceAdd;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleDiscountPriceAdd.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if NovaChOrgStation.ItemIndex<0 then
  begin
    SysDialogs.Warning('请选择发车站！');
    NovaChOrgStation.SetFocus;
    exit;
  end;
  if NcbbReach.ItemIndex<0 then
  begin
    SysDialogs.Warning('请选择到达站！');
    NcbbReach.SetFocus;
    exit;
  end;
  with jscdSaveScheduleDisPrice do
  begin
    Close;
    Params.ParamByName('schedulediscountprice.scheduleid').Value :=scheduleid;
    Params.ParamByName('schedulediscountprice.referenceprice').Value :=NovaEdtFullprice.Text ;
    Params.ParamByName('schedulediscountprice.price').Value := NovaEdtBalancePrice.Text;
    Params.ParamByName('schedulediscountprice.orgid').Value := SysInfo.LoginUserInfo.OrgID;
    Params.ParamByName('schedulediscountprice.departstationid').Value := NovaChOrgStation.HelpFieldValue['id'];
    Params.ParamByName('schedulediscountprice.reachstationid').Value :=NcbbReach.HelpFieldValue['id'];

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;

      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NcbbReach.SetFocus;
      end
      else
      begin
        SysDialogs.ShowMessage(sResult);
        curid := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('折扣票价添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmScheduleDiscountPriceAdd.FormShow(Sender: TObject);
begin
  inherited;
  NovaChOrgStation.Active:=false;
  NovaChOrgStation.Params.ParamValues['routeid']:= routeid;
  NovaChOrgStation.Params.ParamValues['isdepart']:= True;
  NovaChOrgStation.Active:=true;

  NcbbReach.Active:=false;
  NcbbReach.Params.ParamValues['routeid']:= routeid;
  NcbbReach.Params.ParamValues['isdepart']:= false;
  NcbbReach.Active:=true;
end;

procedure TFrmScheduleDiscountPriceAdd.NovaEdtFullpriceChange(Sender: TObject);
begin
  inherited;
   NovaEdtBalancePrice.Text:=   NovaEdtFullprice.Text;
end;

end.

unit UFrmRoutepriceAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  NovaCheckedComboBox, NovaEdit, DB, DBClient, jsonClientDataSet, NovaComboBox,
  NovaHComboBox, ComCtrls;

type
  TFrmRoutepriceAdd = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    NovaEdtFullprice: TNovaEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    NovaEdtBalancePrice: TNovaEdit;
    NovaChOrgStation: TNovaHComboBox;
    NcbbReach: TNovaHComboBox;
    ChkISbase: TCheckBox;
    DpFromDate: TDateTimePicker;
    Label3: TLabel;
    Label4: TLabel;
    DpEndDate: TDateTimePicker;
    jscdSavesRouteprice: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaEdtFullpriceChange(Sender: TObject);
    procedure ChkISbaseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    routeid ,curid:Int64;
  end;

var
  FrmRoutepriceAdd: TFrmRoutepriceAdd;

implementation
 uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmRoutepriceAdd.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
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
  with jscdSavesRouteprice do
  begin
    Close;
    Params.ParamByName('routeprice.routeid').Value :=routeid;
    Params.ParamByName('routeprice.price').Value :=NovaEdtFullprice.Text ;
    Params.ParamByName('routeprice.balanceprice').Value := NovaEdtBalancePrice.Text;
    Params.ParamByName('routeprice.orgid').Value := SysInfo.LoginUserInfo.OrgID;
    Params.ParamByName('routeprice.fromstationid').Value := NovaChOrgStation.HelpFieldValue['id'];
    Params.ParamByName('routeprice.reachstationid').Value :=NcbbReach.HelpFieldValue['id'];
    Params.ParamByName('routeprice.isbaseprice').Value :=ChkISbase.Checked;
    Params.ParamByName('routeprice.fromdate').Value :=formatdatetime('yyyy-mm-dd',DpFromDate.DateTime);
    Params.ParamByName('routeprice.todate').Value :=formatdatetime('yyyy-mm-dd',DpEndDate.DateTime);

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
        SysLog.WriteErr('线路票价添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmRoutepriceAdd.ChkISbaseClick(Sender: TObject);
begin
  inherited;
  if self.ChkISbase.Checked then
  begin
      DpFromDate.Enabled:=false;
      DpEndDate.Enabled:=false;
  end
  else
  begin
      DpFromDate.Enabled:=true;
      DpEndDate.Enabled:=true;
  end;
end;

procedure TFrmRoutepriceAdd.FormShow(Sender: TObject);
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
  DpFromDate.Date:=now;
  DpEndDate.Date:=now;
end;

procedure TFrmRoutepriceAdd.NovaEdtFullpriceChange(Sender: TObject);
begin
   inherited;
   NovaEdtBalancePrice.Text:=   NovaEdtFullprice.Text;
end;

end.

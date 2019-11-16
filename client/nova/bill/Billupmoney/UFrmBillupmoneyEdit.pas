unit UFrmBillupmoneyEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Services, Buttons, ExtCtrls, NovaEdit,USimpleEditForm, Mask, DB,
  DBClient, NovaHComboBox, ImgList, jsonClientDataSet, NovaHelp, ComCtrls;

type
  TFrmBillupmoneyEdit = class(TSimpleEditForm)
    jsonBillupmoneySave: TjsonClientDataSet;
    cbbbilltypeid: TNovaHComboBox;
    lblbilltype: TLabel;
    lblupuser: TLabel;
    lblprice: TLabel;
    edtprice: TNovaEdit;
    lblupmoneydate: TLabel;
    Dateupmoney: TDateTimePicker;
    lbl8: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    nvhlpupuser: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
     public
      id,billtypeid,upuserid,orgid,createby : Int64;
      createtime:String;
  end;

var
  FrmBillupmoneyEdit: TFrmBillupmoneyEdit;

implementation

 uses PubFn;
{$R *.dfm}

procedure TFrmBillupmoneyEdit.bbtnSaveClick(Sender: TObject);
  var nResult: integer;
  sResult:string;
begin
  inherited;
  if cbbbilltypeid.Text = '' then
    begin
      SysDialogs.ShowMessage('请选择票据类型');
      cbbbilltypeid.SetFocus;
      exit;
    end;
  if nvhlpupuser.Text='' then
    begin
      SysDialogs.ShowMessage('缴款人不能为空');
      nvhlpupuser.SetFocus;
      exit;
    end;
    if edtprice.Text='' then
    begin
      SysDialogs.ShowMessage('缴款金额不能为空');
      edtprice.SetFocus;
       exit;
    end;

    with jsonBillupmoneySave do
     begin
     if cbbbilltypeid.ItemIndex = -1 then
    begin
      billtypeid := billtypeid;
    end else
    begin
      billtypeid := cbbbilltypeid.HelpFieldValue['id'];
    end;
    if nvhlpupuser.id = 0 then
    begin
      upuserid := upuserid;
    end else
    begin
      upuserid := nvhlpupuser.id;
    end;
    Params.ParamByName('billupmoney.id').Value :=id ;
    Params.ParamByName('billupmoney.billtypeid').Value := billtypeid;
    Params.ParamByName('billupmoney.upuserid').Value := upuserid;
    Params.ParamByName('billupmoney.price').Value :=edtprice.Text ;
    Params.ParamByName('billupmoney.upmoneydate').Value := FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
    Params.ParamByName('billupmoney.orgid').Value := orgid;
    Params.ParamByName('billupmoney.createby').Value := createby;
    Params.ParamByName('billupmoney.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
       SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpupuser.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '修改定额票缴款：票据类型='+cbbbilltypeid.Text+',缴款人='+nvhlpupuser.Text+
          ',缴款金额='+edtprice.Text+',缴款日期='+FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
          SysLog.WriteLog('票据管理——>定额票缴款','修改',log);
        end else
        begin
          log := '添加定额票缴款：票据类型='+cbbbilltypeid.Text+',缴款人='+nvhlpupuser.Text+
          ',缴款金额='+edtprice.Text+',缴款日期='+FormatDateTime('yyyy-mm-dd',Dateupmoney.DateTime);
          SysLog.WriteLog('票据管理——>定额票缴款','添加',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('定额票缴款增加失败：' + E.Message);
      end;


     end;

    end

end;

procedure TFrmBillupmoneyEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbbilltypeid.Active:=false;
  cbbbilltypeid.Active:=True;
  Dateupmoney.Date:=now;
end;

end.

unit UFrmsignticket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls,UDMPublic, DB,
  DBClient, jsonClientDataSet,services, ImgList;

type
  TFrmsignticket = class(TSimpleEditForm)
    lblreason: TLabel;
    rbrate: TRadioButton;
    rbfix: TRadioButton;
    nvedtrate: TNovaEdit;
    nvedtfix: TNovaEdit;
    lblrateflag: TLabel;
    mmoreason: TMemo;
    jsoncdsticketsign: TjsonClientDataSet;
    jsoncdsticketsignid: TLargeintField;
    jsoncdsticketsigncharges: TFloatField;
    jsoncdsticketsignisselfschedule: TBooleanField;
    jsoncdsticketsignsellid: TLargeintField;
    jsoncdsticketsignsignby: TLargeintField;
    jsoncdsticketsignsignreason: TWideStringField;
    jsoncdsticketsignsigntime: TDateTimeField;
    jsoncdsticketsignticketprice: TFloatField;
    procedure rbrateClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frmsignticket: TFrmsignticket;

implementation

uses PubFn, UFrmTicketReturn,UFrmTicketRetrunRe;

{$R *.dfm}

procedure TFrmsignticket.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if rbrate.Checked then
  begin
    if StrToCurrDef(nvedtrate.Text,-1)<0 then
    begin
      SysDialogs.ShowInfo('请输入正确的手续费率！');
      nvedtrate.SetFocus;
      exit;
    end;
  end
  else if rbfix.Checked then
  begin
    if StrToCurrDef(nvedtfix.Text,-1)<0 then
    begin
      SysDialogs.ShowInfo('请输入正确的手续费！');
      nvedtfix.SetFocus;
      exit;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请选择一种手续费计算方式！');
    rbrate.SetFocus;
    exit;
  end;
  with jsoncdsticketsign do
  begin
    DisableControls;
    first;
    while not eof do
    begin
      edit;
      if rbrate.Checked then
        FieldValues['charges']:=FrmTicketRetrunRe.carry(StrToCurr(nvedtrate.Text)/100*FieldByName('ticketprice').AsCurrency)
      else
        FieldValues['charges']:=StrToCurr(nvedtfix.Text);
      FieldValues['signreason']:=mmoreason.Text;
      next;
    end;
    EnableControls;
    try
      if (ApplyUpdates(-1) <> 0) then
      begin
        SysDialogs.Warning('签退票手续费失败:未知错误！');
      end;
      if Params.ParamValues['flag']=1 then
      begin
        SysDialogs.ShowMessage('保存成功!');
        //保存到公共变量
        self.ModalResult:=mrok;
      end
      else
      begin
        if Params.ParamByName('msg').IsNull then
          SysDialogs.Warning('签退票手续费失败:未知错误！')
        else
          SysDialogs.Warning(Params.ParamValues['msg']);
      end;
    except on E: Exception do
      SysDialogs.Warning('签退票手续费失败:'+e.Message);
    end;
  end;
end;

procedure TFrmsignticket.rbrateClick(Sender: TObject);
begin
  inherited;
  if sender=rbrate then
  begin
    nvedtrate.Enabled:=true;
    nvedtrate.SetFocus;
    lblrateflag.Enabled:=true;
    nvedtfix.Enabled:=false;
  end
  else
  begin
    nvedtfix.Enabled:=true;
    nvedtfix.SetFocus;
    nvedtrate.Enabled:=false;
    lblrateflag.Enabled:=false;
  end;
end;

procedure TFrmsignticket.FormShow(Sender: TObject);
begin
  inherited;
  rbrate.Checked:=true;
end;

end.

unit UFrmInitRoadBill;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, NovaEdit, Buttons, ExtCtrls;

type
  TFrmInitRoadBill = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    nvedtbillNo: TNovaEdit;
    nvedtBillNoRepeat: TNovaEdit;
    Label1: TLabel;
    Label2: TLabel;
    NovaEdtEndNo: TNovaEdit;
    Label3: TLabel;
    NovaEdtCount: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaEdtEndNoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmInitRoadBill: TFrmInitRoadBill;

implementation
uses PubFn, Services,  UDMPublic;
{$R *.dfm}

procedure TFrmInitRoadBill.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if trim(nvedtbillNo.Text)='' then
  begin
    SysDialogs.ShowError('请输入当前号码');
    nvedtbillNo.SetFocus;
    exit;
  end;
  if trim(nvedtBillNoRepeat.Text)='' then
  begin
    SysDialogs.ShowError('请再次输入当前号码');
    nvedtBillNoRepeat.SetFocus;
    exit;
  end;
  if not SameText(trim(nvedtbillNo.Text),Trim(nvedtBillNoRepeat.Text)) then
  begin
    SysDialogs.ShowError('两次输入的号码不一致');
    nvedtbillNo.SetFocus;
    exit;
  end;
  if strtoint64(NovaEdtEndNo.Text)< strtoint64(nvedtbillNo.Text)  then
  begin
    SysDialogs.ShowError('开始号码不能大于结束号码');
    nvedtbillNo.SetFocus;
    exit;
  end;
  NovaEdtCount.Text:=inttostr(strtoint64(NovaEdtEndNo.Text)-strtoint64(nvedtbillNo.Text)+1);
  ModalResult := mrok;
end;

procedure TFrmInitRoadBill.NovaEdtEndNoExit(Sender: TObject);
begin
  inherited;
  if (trim(NovaEdtEndNo.Text)<>'') and (trim(nvedtbillNo.Text)<>'')  then
  begin
    if strtoint64(NovaEdtEndNo.Text)>=strtoint64(nvedtbillNo.Text)  then
    begin
      NovaEdtCount.Text:=inttostr(strtoint64(NovaEdtEndNo.Text)-strtoint64(nvedtbillNo.Text)+1);
    end;
  end;

end;

end.

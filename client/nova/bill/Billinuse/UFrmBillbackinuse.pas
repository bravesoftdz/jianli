unit UFrmBillbackinuse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,NovaEdit,NovaComboBox,USimpleEditForm,
  NovaHelp, DB, DBClient, Services,jsonClientDataSet, NovaHComboBox, ImgList;


type
  TFrmBillbackinuse = class(TSimpleEditForm)
    lbl12: TLabel;
    lbl13: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    edtbilltypename: TNovaEdit;
    jsonBillinuesSave: TjsonClientDataSet;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    edtstartnum: TNovaEdit;
    edtendnum: TNovaEdit;
    edtendno: TNovaEdit;
    edtstartno: TNovaEdit;
    edtticketcount: TNovaEdit;
    Label1: TLabel;
    edtavailablecount: TNovaEdit;
    Label2: TLabel;
    edtstoragename: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtstartnoChange(Sender: TObject);
    procedure edtticketcountChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   availablecount,billinuseid,billtypeid,availablestartno,availableenno:Int64;
   storagename : string;
  end;

var
  FrmBillbackinuse: TFrmBillbackinuse;

implementation

{$R *.dfm}

procedure TFrmBillbackinuse.bbtnSaveClick(Sender: TObject);
 var nResult: integer;
  sResult:string;
begin
  inherited;
  if StrToInt64(edtticketcount.Text)<1   then
  begin
    SysDialogs.ShowMessage('票数不能小于1');
    edtticketcount.SetFocus;
    exit;
  end;
  if edtstartno.Text='' then
  begin
    SysDialogs.ShowMessage('退领开始号不能为空');
    edtstartno.SetFocus;
    exit;
  end
  else
  begin
    if StrToInt64(edtstartno.Text)<availablestartno  then
    begin
      SysDialogs.ShowMessage('退领起始号不能小于可用起始号');
      edtstartno.SetFocus;
      exit;
    end;
    if  StrToInt64(edtstartno.Text)>availableenno then
    begin
      SysDialogs.ShowMessage('退领起始号不能大于可用结束号');
      edtstartno.SetFocus;
      exit;
    end;

  end;
  if edtendno.Text='' then
    begin
      SysDialogs.ShowMessage('领用结束号不能为空');
      edtstartno.SetFocus;
      exit;
    end
  else
  begin
    if StrToInt64(edtendno.Text)<StrToInt64(edtstartno.Text)  then
    begin
      SysDialogs.ShowMessage('领用结束号不能小于起始号');
      edtticketcount.SetFocus;
      exit;
    end;
    if  StrToInt64(edtendno.Text)>availableenno then
    begin
      SysDialogs.ShowMessage('领用结束号不能大于可用结束号');
      edtticketcount.SetFocus;
      exit;
    end;

  end;
  with jsonBillinuesSave do
  begin
    Params.ParamByName('billinuse.id').Value := billinuseid;
    Params.ParamByName('backstartno').Value :=edtstartno.Text;
    Params.ParamByName('backendno').Value :=edtendno.Text ;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <> 1) then
      begin
        edtstartno.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据退领失败：' + E.Message);
      end;
    end;
  end;

end;
procedure TFrmBillbackinuse.edtstartnoChange(Sender: TObject);
begin
  inherited;
  edtendno.Text:= IntToStr(StrToInt64(edtticketcount.Text)+StrToInt64(edtstartno.Text)-1) ;
end;


procedure TFrmBillbackinuse.edtticketcountChange(Sender: TObject);
begin
  inherited;
  edtendno.Text:= IntToStr(StrToInt64(edtticketcount.Text)+StrToInt64(edtstartno.Text)-1) ;
end;

end.

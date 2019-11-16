unit UFrmBillinventoryout;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,NovaEdit,NovaComboBox,USimpleEditForm,
  NovaHelp, DB, DBClient, Services,jsonClientDataSet, NovaHComboBox, ImgList;


type
  TFrmBillinventoryout = class(TSimpleEditForm)
    lbl11: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    edtbillstorage: TNovaEdit;
    edtbilltypename: TNovaEdit;
    lbl1: TLabel;
    lbl3: TLabel;
    jsonBillinventoryOut: TjsonClientDataSet;
    lbl5: TLabel;
    edtstartnum: TNovaEdit;
    edtendnum: TNovaEdit;
    edtstartno: TNovaEdit;
    edtticketcount: TNovaEdit;
    edtendno: TNovaEdit;
    Label1: TLabel;
    edtavailablecount: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtstartnoChange(Sender: TObject);
    procedure edtticketcountChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
   id,storageid,billtypeid,availablestartno,availableenno:Int64;
  end;

var
  FrmBillinventoryout: TFrmBillinventoryout;

implementation

{$R *.dfm}

procedure TFrmBillinventoryout.bbtnSaveClick(Sender: TObject);
 var nResult: integer;
  sResult,log:string;
begin
  inherited;
  if StrToInt(edtticketcount.Text) = 0then
  begin
    SysDialogs.ShowMessage('出库数量不能小于1，请重新输入！');
    edtticketcount.SetFocus;
    Exit;
  end;
  if edtstartno.Text='' then
  begin
    SysDialogs.ShowMessage('出库开始号不能为空');
    edtstartno.SetFocus;
    exit;
  end;
  if StrToInt64(edtstartno.Text)<availablestartno  then
  begin
    SysDialogs.ShowMessage('出库起始号不能小于可用起始号');
    edtstartno.SetFocus;
    exit;
  end;
  if  StrToInt64(edtstartno.Text)>availableenno then
  begin
    SysDialogs.ShowMessage('出库起始号不能大于可用结束号');
    edtstartno.SetFocus;
    exit;
  end;
  if edtendno.Text='' then
  begin
    SysDialogs.ShowMessage('出库结束号不能为空');
    edtstartno.SetFocus;
     exit;
  end;
  if StrToInt64(edtendno.Text)<StrToInt64(edtstartno.Text)  then
  begin
    SysDialogs.ShowMessage('出库结束号不能小于起始号');
    edtendno.SetFocus     ;
    exit;
  end;
  if  StrToInt64(edtendno.Text)>availableenno then
  begin
    SysDialogs.ShowMessage('出库结束号不能大于可用结束号,请重新输入出库的票数');
    edtticketcount.SetFocus;
    exit;
  end;
  if StrToInt(edtticketcount.Text)<1   then
  begin
    SysDialogs.ShowMessage('票数不能小于1');
    edtticketcount.SetFocus;
    exit;
  end;
  with jsonBillinventoryOut do
  begin
    Params.ParamByName('billinventory.id').Value :=id ;
    Params.ParamByName('outstartno').Value :=edtstartno.Text ;
    Params.ParamByName('outendno').Value :=edtendno.Text ;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
       SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtstartno.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
        log:='[票库名称]:'+ edtbillstorage.Text+',[票据类型]:'+edtbilltypename.Text
        +',[出库起始号码]:'+edtstartno.Text+'[结束号码]:'+edtendno.Text
        +',[出库票数]:'+edtticketcount.Text ;
        SysLog.WriteLog('票据管理-票据出库','出库',log);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据出库失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmBillinventoryout.edtstartnoChange(Sender: TObject);
begin
  inherited;
    edtendno.Text:= IntToStr(StrToInt64(edtticketcount.Text)+StrToInt64(edtstartno.Text)-1);
end;

procedure TFrmBillinventoryout.edtticketcountChange(Sender: TObject);
begin
  inherited;
  edtendno.Text:= IntToStr(StrToInt64(edtticketcount.Text)+StrToInt64(edtstartno.Text)-1) ;
end;

end.

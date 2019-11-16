unit UFrmBilldamagedEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox, NovaEdit,
  DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmBilldamagedEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl6: TLabel;
    edtstartno: TNovaEdit;
    edtendno: TNovaEdit;
    jcdsResultSavebilldamaged: TjsonClientDataSet;
    edtbilltype: TNovaEdit;
    lbl5: TLabel;
    edtamount: TNovaEdit;
    edtavailablecount: TNovaEdit;
    lbl7: TLabel;
    nvHcbbRemark: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtstartnoChange(Sender: TObject);
    procedure edtamountChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtendnoChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    sign : Boolean;
    id, createby, billinuseid, billtypeid : Int64;
    createtime, recipients : string;
    insureendno : LongWord;
  end;

var
  FrmBilldamagedEdit: TFrmBilldamagedEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmBilldamagedEdit.bbtnSaveClick(Sender: TObject);
var endno : LongWord;
    nResult : Integer;
    sResult : string;
begin
  inherited;
  if Trim(edtamount.Text) = '0' then
  begin
    SysDialogs.ShowMessage('坏票登记的票数不能为0，请重新输入！');
    edtamount.SetFocus;
    Exit;
  end;

  if Trim(nvHcbbRemark.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入坏票登记的描述信息!');
    nvHcbbRemark.SetFocus;
    Exit;
  end;
  if StrToInt64(edtamount.Text) > StrToInt64(edtavailablecount.Text) then
  begin
    SysDialogs.ShowMessage('输入的数量大于剩余的数量。请核对！');
    edtamount.SetFocus;
    Exit;
  end;
  endno := StrToInt64Def(edtendno.Text, 64);
  if endno > insureendno then
  begin
    SysDialogs.ShowMessage('输入的数量大于领用的数量。请核对！');
    edtamount.SetFocus;
    Exit;
  end;
  with jcdsResultSavebilldamaged do
  begin
    Close;
    Params.ParamValues['billdamaged.id'] := id;
    Params.ParamValues['billdamaged.billtypeid'] := billtypeid;//edtbilltype.Text;
    Params.ParamValues['billdamaged.startno'] := edtstartno.Text;
    Params.ParamValues['billdamaged.endno'] := edtendno.Text;
    Params.ParamValues['billdamaged.amount'] := edtamount.Text;
    Params.ParamValues['billdamaged.billinuseid'] := billinuseid;
    Params.ParamValues['billdamaged.damageddscribe'] := nvHcbbRemark.Text;
    Params.ParamValues['billdamaged.createby'] := createby;
    Params.ParamValues['billdamaged.createtime'] := createtime;
    Params.ParamValues['recipients'] := recipients;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtendno.SetFocus;
      end
      else
      begin
        log := '登记人:'+SysInfo.LoginUserInfo.UserName+',票据类型:'+
        edtbilltype.Text+',使用票号:'+edtstartno.Text+',结束票号:'+edtendno.Text+
        ',登记数量:'+edtamount.Text+',剩余票数:'+edtavailablecount.Text+',损坏描述:'+
        nvHcbbRemark.Text;
        SysLog.WriteLog('售票管理—>坏票登记','坏票登记',log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('坏票登记添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmBilldamagedEdit.edtamountChange(Sender: TObject);
var  startno, amount : Largeint;
    I : LongInt;
    no : string;
begin
  inherited;
  edtendno.OnChange:=nil;
//  startno := StrToInt64(edtstartno.Text);
  startno := StrToInt64(edtstartno.Text);
  amount := StrToInt64(edtamount.Text);
  edtendno.Text := inttostr(startno + amount - 1);

  no := edtendno.Text;
  if Length(edtendno.Text) < Length(edtstartno.Text) then
  begin
    for I := 0 to (Length(edtstartno.Text) - Length(edtendno.Text) - 1) do
    no := '0' + no;
  end;
  edtendno.Text := no;
  edtendno.OnChange:=edtendnoChange;
end;

procedure TFrmBilldamagedEdit.edtendnoChange(Sender: TObject);
var I, startno, endno : LongInt;
    no : string;
begin
  inherited;
  edtamount.OnChange:=nil;

  startno := StrToInt64(edtstartno.Text);
  endno := StrToInt64(edtendno.Text);
  if (endno - startno + 1)>0 then
    edtamount.Text := inttostr(endno - startno + 1)
  else
    edtamount.Text := '0';
  edtamount.OnChange:=edtamountChange;

end;

procedure TFrmBilldamagedEdit.edtstartnoChange(Sender: TObject);
begin
  inherited;
  edtendno.OnChange:=nil;
  edtendno.Text := edtstartno.Text;
  edtendno.OnChange:=edtendnoChange;
end;

procedure TFrmBilldamagedEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvHcbbRemark.Active := False;
  nvHcbbRemark.Active := True;
end;

end.


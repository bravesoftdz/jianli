unit UFrmVipGiftput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox;

type
  TfrmVipGiftput = class(TSimpleEditForm)
    jcdsSave: TjsonClientDataSet;
    lbl1: TLabel;
    nvedtName: TNovaEdit;
    lbl5: TLabel;
    mmoRemark: TMemo;
    lblNum: TLabel;
    lbl8: TLabel;
    edtNum: TNovaEdit;
    edtLeaveNum: TNovaEdit;
    lbl10: TLabel;
    edtAfter: TNovaEdit;
    lbl3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtNumChange(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
   isoutput:boolean;
   id,vipgiftid,afternum :integer;
   quantity,operation: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmVipGiftput: TfrmVipGiftput;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmVipGiftput.bbtnSaveClick(Sender: TObject);
 var  msg: String;
  nResult,afterstoragequantity: integer;
  sResult,log,optype: String;
begin
  inherited;
   if (Trim(edtNum.Text)='') or (StrToInt(edtNum.Text)<=0) then
  begin
    SysDialogs.ShowMessage( '请正确输入'+lblNum.Caption+'!');
    edtNum.SetFocus;
    Exit;
  end;
   if afternum < 0 then
  begin
    SysDialogs.ShowMessage('已超出库存量，请重新输入!');
    edtNum.SetFocus;
    Exit;
  end;

  with jcdsSave do
  begin
    close;
     Params.ParamByName('storage.vipgiftid').Value := vipgiftid;

    Params.ParamByName('storage.beforestoragequantity').Value := edtLeaveNum.Text;
    Params.ParamByName('storage.operation').Value := operation;
    Params.ParamByName('storage.quantity').Value := edtNum.Text;
    if operation='0' then //入库
    begin
      optype :='礼品入库';
    end
    else
    begin
      optype:='礼品出库';
    end;


    Params.ParamByName('storage.afterstoragequantity').Value :=afternum;
    Params.ParamByName('storage.remarks').Value :=  mmoRemark.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage('保存'+sResult);
      if (nResult <= 0) then
      begin
        nvedtName.SetFocus;
      end
      else
      begin
          log := ' 礼品名称:'+nvedtname.Text+', 操作前库存 '+ edtLeaveNum.Text
              +', '+optype+'数量 '+ edtNum.Text
              + ', 操作后库存 '+ inttostr(afternum)
              +', 备注;'+mmoRemark.Text ;
        SysLog.WriteLog('礼品库存管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('vipgiftid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保存失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TfrmVipGiftput.edtNumChange(Sender: TObject);

begin
  inherited;
   if operation='0' then //入库
    begin
      afternum :=  StrToInt(edtLeaveNum.Text) + StrToInt(edtNum.Text);
      edtAfter.Text := IntToStr(afternum);
    end
    else
    begin
      afternum :=  StrToInt(edtLeaveNum.Text) - StrToInt(edtNum.Text);
      if StrToInt(edtNum.Text) < StrToInt(edtLeaveNum.Text) then
        edtAfter.Text := IntToStr(afternum)
      else
      edtAfter.Text := IntToStr(afternum);
    end;

end;

end.

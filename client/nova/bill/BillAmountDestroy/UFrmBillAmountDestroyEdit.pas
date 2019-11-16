unit UFrmBillAmountDestroyEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Services, Buttons, ExtCtrls, NovaEdit, USimpleEditForm,
  Mask, DB,
  DBClient, jsonClientDataSet, NovaComboBox, ImgList, ComCtrls, NovaHelp,
  NovaCheckedComboBox, NovaHComboBox;

type
  TFrmBillAmountDestroyEdit = class(TSimpleEditForm)
    lbl2: TLabel;
    Label1: TLabel;
    nvhlpUserid: TNovaHelp;
    Label3: TLabel;
    dtpDdate: TDateTimePicker;
    edtparvalue: TNovaEdit;
    lblparvalue: TLabel;
    lbl7: TLabel;
    Label2: TLabel;
    jsonBillAmountDestroySave: TjsonClientDataSet;
    nvcbbOrgid: TNovaHComboBox;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    log: String;
    { Private declarations }
  public
    { Public declarations }
  public
    id, createby, orgid: Int64;
    createtime: String;
  end;

var
  FrmBillAmountDestroyEdit: TFrmBillAmountDestroyEdit;

implementation

{$R *.dfm}

procedure TFrmBillAmountDestroyEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: String;
begin
  inherited;

  if ((Trim(nvhlpUserid.Text) = '') or (nvhlpUserid.id <= 0)) then // 核销人
  begin
    ShowMessage(nvhlpUserid.Text+'   '+IntToStr(nvhlpUserid.id));
    SysDialogs.ShowMessage('请输入核销人！');
    nvhlpUserid.SetFocus;
    Exit;
  end;

  if (nvcbbOrgid.Text = '') then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    nvcbbOrgid.SetFocus;
    Exit;
  end;

  if (Trim(edtparvalue.Text) = '') then
  begin
    SysDialogs.ShowMessage('核销金额不能为空!');
    edtparvalue.SetFocus;
    Exit;
  end;

   if nvcbbOrgid.ItemIndex = -1 then
    begin
      orgid := orgid;
    end
   else
    begin
      orgid := nvcbbOrgid.HelpFieldValue['id'];
    end;

  with jsonBillAmountDestroySave do
  begin
    Params.ParamByName('billAmountDestroy.id').Value := id;
    Params.ParamByName('billAmountDestroy.billcanceler').Value := nvhlpUserid.id;
    Params.ParamByName('billAmountDestroy.orgid').Value := orgid;
    Params.ParamByName('billAmountDestroy.cancelprice').Value := edtparvalue.Text;
    Params.ParamByName('billAmountDestroy.canceldate').Value := formatdatetime('c',dtpDdate.Date);
    Params.ParamByName('billAmountDestroy.createby').Value :=  createby;
    Params.ParamByName('billAmountDestroy.createtime').Value :=  createtime;
    try

      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpUserid.SetFocus;
      end
      else
      begin

        if id > 0 then
        begin
          log := '修改票据金额核销：核销人=' + nvhlpUserid.Text + ',机构=' +
            nvcbbOrgid.Text + ',核销金额=' + edtparvalue.Text + ',核销日期=' +
            DateToStr(dtpDdate.DateTime);
          SysLog.WriteLog('票据管理——>票据金额核销', '修改', log);
        end
        else
        begin
          log := '修改票据金额核销：核销人=' + nvhlpUserid.Text + ',机构=' +
            nvcbbOrgid.Text + ',核销金额=' + edtparvalue.Text + ',核销日期=' +
            DateToStr(dtpDdate.DateTime);
          SysLog.WriteLog('票据管理——>票据金额核销', '添加', log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('票据金额核销增加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmBillAmountDestroyEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpDdate.Date := Now();
  nvcbbOrgid.Active := False;
  nvcbbOrgid.Active := True;
end;

end.

unit UFrmTicketoutletStrEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, Services, DB, DBClient, jsonClientDataSet;

type
  TFrmTicketoutletStrEdit = class(TSimpleEditForm)
    lblticketoutlet: TLabel;
    nvhlpticketoutlet: TNovaHelp;
    nvhlpnvedtreceipt: TNovaEdit;
    nvhlp1: TNovaEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    jsnclntdtstResult: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    nResult: integer;
    sResult: string;
    { Private declarations }
  public
    id, ticketoutletsid: integer;
    carrychildrate, maxsellmoney, optype, log: string;
    { Public declarations }
  end;

var
  FrmTicketoutletStrEdit: TFrmTicketoutletStrEdit;

implementation

{$R *.dfm}

procedure TFrmTicketoutletStrEdit.bbtnSaveClick(Sender: TObject);

begin
  inherited;
  if nvhlpticketoutlet.Text = '' then
  begin
    SysDialogs.ShowMessage('售票点地址不能为空');
    exit;
  end;
  if nvhlpnvedtreceipt.Text = '' then
  begin
    SysDialogs.ShowMessage('免票儿童比例');
    exit;
  end;
  if nvhlp1.Text = '' then
  begin
    SysDialogs.ShowMessage('最大售票金额');
    exit;
  end;
  if StrToInt(nvhlpnvedtreceipt.Text) > 100 then
  begin
    SysDialogs.ShowMessage('免票儿童比例格式有误');
    exit;
  end;

  with jsnclntdtstResult do
  begin
    Close;
    Params.ParamByName('ticketoutletctr.ticketoutletsid').Value :=
      nvhlpticketoutlet.id;
    Params.ParamByName('ticketoutletctr.carrychildrate').Value :=
      nvhlpnvedtreceipt.Text;
    Params.ParamByName('ticketoutletctr.maxsellmoney').Value := nvhlp1.Text;
    if id = 0 then
    begin
      Params.ParamByName('ticketoutletctr.id').Value := -1;
    end
    else
    begin
      Params.ParamByName('ticketoutletctr.id').Value := id;
    end;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      if nResult = 1 then
      begin
        sResult := Params.ParamByName('msg').Value;
        SysDialogs.ShowMessage(sResult);
        if id > 0 then
        begin
          optype := '修改售票点'+nvhlpticketoutlet.Text;
          if carrychildrate <> nvhlpnvedtreceipt.Text then
          begin
            log := '免票儿童比例由' + carrychildrate + '改成' + nvhlpnvedtreceipt.Text;
          end;
          if maxsellmoney <> nvhlp1.Text then
          begin
            log := log + ', 最大售票金额由' + maxsellmoney + '改成' + nvhlp1.Text;
          end;
        end;
        SysLog.WriteErr(optype+log);
        log := '';
        optype := '';
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('保存售票点售票控制信息失败：' + E.Message);
      end;
    end;
  end;

end;

end.

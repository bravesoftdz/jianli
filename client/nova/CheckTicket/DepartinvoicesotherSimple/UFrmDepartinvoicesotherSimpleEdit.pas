unit UFrmDepartinvoicesotherSimpleEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet, Services, UDMPublic;

type
  TFrmDepartinvoicesotherSimpleEdit = class(TSimpleEditForm)
    lbl6: TLabel;
    dtpdepartdate: TDateTimePicker;
    lbl2: TLabel;
    nvhlpvehicle: TNovaHelp;
    lbl1: TLabel;
    nvhlpNHelpRoute: TNovaHelp;
    nvedtno: TNovaEdit;
    lbl5: TLabel;
    lbl3: TLabel;
    nvhlptime: TNovaEdit;
    lbl4: TLabel;
    nvedtTicketnum: TNovaEdit;
    lbl7: TLabel;
    nvedtPieces: TNovaEdit;
    edttotalmoney: TNovaEdit;
    lbl8: TLabel;
    lbl9: TLabel;
    nvhlpUserid: TNovaHelp;
    jcdsSave: TjsonClientDataSet;
    lbl11: TLabel;
    lbl10: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    vehicleid,
    routeid,
    sellerid,
    departinvoicesotherid : Integer; //补录单id
    { Public declarations }
  end;

var
  FrmDepartinvoicesotherSimpleEdit: TFrmDepartinvoicesotherSimpleEdit;

implementation

{$R *.dfm}

procedure TFrmDepartinvoicesotherSimpleEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult, log: string;
begin
  inherited;

  if (nvhlpvehicle.id <= 0) or (Trim(nvhlpvehicle.Text) = '') then
  begin
    SysDialogs.ShowMessage('请输入车牌号！');
    nvhlpvehicle.SetFocus;
    exit;
  end;

  if (nvhlpNHelpRoute.id <= 0) or (Trim(nvhlpNHelpRoute.Text) = '') then
  begin
    SysDialogs.ShowMessage('请输入营运线路！');
    nvhlpNHelpRoute.SetFocus;
    exit;
  end;

  if Trim(nvedtno.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入单号！');
    nvedtno.SetFocus;
    Exit;
  end;

   if Trim(nvhlptime.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入发车时间！');
    nvhlptime.SetFocus;
    Exit;
  end;

  if Trim(edttotalmoney.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入票款！');
    edttotalmoney.SetFocus;
    Exit;
  end;

  if (nvhlpUserid.id < 0) or (Trim(nvhlpUserid.Text) = '') then
  begin
    SysDialogs.ShowMessage('请输入售票员！');
    nvhlpUserid.SetFocus;
    exit;
  end;

  with jcdsSave do
  begin
    close;

    Params.ParamValues['departinvoicesother.id'] := IntToStr(departinvoicesotherid);
    Params.ParamValues['departinvoicesother.departdate'] := FormatDateTime('yyyy-mm-dd', dtpdepartdate.DateTime);
    Params.ParamValues['departinvoicesother.vehicleid'] := nvhlpvehicle.Id;
    Params.ParamValues['routeid'] := nvhlpNHelpRoute.Id;
    Params.ParamValues['departinvoicesother.departinvoicesno'] := Trim(nvedtno.Text);
    Params.ParamValues['departinvoicesother.departtime'] := Trim(nvhlptime.Text);
    Params.ParamValues['departinvoicesother.ticketnum'] := Trim(nvedtTicketnum.Text);
    Params.ParamValues['departinvoicesother.pieces'] := Trim(nvedtPieces.Text);
    Params.ParamValues['departinvoicesother.totalmoney'] := Trim(edttotalmoney.Text);
    Params.ParamValues['departinvoicesother.seller'] := nvhlpUserid.Id;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;

      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpvehicle.SetFocus;
      end
      else
      begin
        if departinvoicesotherid > 0 then
        begin
           log := '修改补录结算单：发车日期=' + FormatDateTime('yyyy-mm-dd', dtpdepartdate.DateTime)
            +', 车牌号=' + nvhlpvehicle.Text + ', 营运线路=' + nvhlpNHelpRoute.Text + ', 单号=' + nvedtno.Text
            + ', 发车时间=' + nvhlptime.Text + ', 人数=' + nvedtTicketnum.Text + ', 件数=' + nvedtPieces.Text
            + ', 票款=' + edttotalmoney.Text + ', 售票员=' +  nvhlpUserid.Text;
           SysLog.WriteLog('检票管理——>结算单补录(精简版)','修改',log);
        end
        else
        begin
          log := '添加补录结算单：发车日期=' + FormatDateTime('yyyy-mm-dd', dtpdepartdate.DateTime)
            +', 车牌号=' + nvhlpvehicle.Text + ', 营运线路=' + nvhlpNHelpRoute.Text + ', 单号=' + nvedtno.Text
            + ', 发车时间=' + nvhlptime.Text + ', 人数=' + nvedtTicketnum.Text + ', 件数=' + nvedtPieces.Text
            + ', 票款=' + edttotalmoney.Text + ', 售票员=' +  nvhlpUserid.Text;
           SysLog.WriteLog('检票管理——>结算单补录(精简版)','添加',log);
        end;
        departinvoicesotherid := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录添加失败：' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmDepartinvoicesotherSimpleEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpdepartdate.DateTime := Now;
end;

procedure TFrmDepartinvoicesotherSimpleEdit.FormShow(Sender: TObject);
begin
  inherited;
  if self.edittype = Tedittype.add then
  begin
    departinvoicesotherid := 0;
  end
  else
  begin
    nvhlpvehicle.Id := vehicleid;
    nvhlpNHelpRoute.Id := routeid;
    nvhlpUserid.Id := sellerid;
  end;
end;

end.

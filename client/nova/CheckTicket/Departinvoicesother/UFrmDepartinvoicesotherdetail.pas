unit UFrmDepartinvoicesotherdetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet, ImgList, ComCtrls, NovaHComboBox;

type
  TFrmDepartinvoicesotherdetail = class(TSimpleEditForm)
    lbl3: TLabel;
    nvhlpdepartstation: TNovaHelp;
    lbl4: TLabel;
    nvhlpendstation: TNovaHelp;
    lbl9: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl1: TLabel;
    lbl6: TLabel;
    lbl10: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    jcdsResultSavedepartinvoicesotherdetail: TjsonClientDataSet;
    lbl20: TLabel;
    lbl21: TLabel;
    cbbtickettype: TNovaHComboBox;
    edtdistance: TNovaEdit;
    lbl5: TLabel;
    lbl2: TLabel;
    lbl11: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    lbl19: TLabel;
    edtticketprice: TNovaEdit;
    edtnum: TNovaEdit;
    edtstationservicefree: TNovaEdit;
    edtotherfee: TNovaEdit;
    edtagentfee: TNovaEdit;
    edtbalanceamount: TNovaEdit;
    edtdeparttime: TDateTimePicker;
    Label1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtticketpriceChange(Sender: TObject);
    procedure edtnumChange(Sender: TObject);
    procedure edtstationservicefreeChange(Sender: TObject);
    procedure edtotherfeeChange(Sender: TObject);
    procedure edtagentfeeChange(Sender: TObject);
    procedure edtbalanceamountChange(Sender: TObject);
    procedure edtnumKeyPress(Sender: TObject; var Key: Char);
    procedure edtstationservicefreeExit(Sender: TObject);
    procedure edtagentfeeExit(Sender: TObject);
    procedure edtotherfeeExit(Sender: TObject);
    procedure edtticketpriceExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    departinvoicesotherid, id, createby, createtime,
    departtime, scheduleid, departdate,
    departinvoicesno,tickettype,distance,price,
    ticketnum,stationfee,otherfee,agentfee,balancefee,
    departstation,reachestation: string;
    sign : Boolean;
    cbbtickettypeid : string;
  end;

var
  FrmDepartinvoicesotherdetail: TFrmDepartinvoicesotherdetail;

implementation

uses Services;
{$R *.dfm}

procedure TFrmDepartinvoicesotherdetail.bbtnSaveClick(Sender: TObject);
var nResult : Integer;
    sResult,log : string;
begin
  inherited;
  if ((Trim(nvhlpdepartstation.Text) = '') or (Trim(nvhlpendstation.Text) = '') or
    (Trim(cbbtickettype.Text) = '') or (Trim(edtdistance.Text) = '') or
    (Trim(edtticketprice.Text) = '') or (Trim(edtnum.Text) = '') or (Trim(edtotherfee.Text) = '') or
     (Trim(edtstationservicefree.Text) = '') or (Trim(edtagentfee.Text) = '') or
     (Trim(edtbalanceamount.Text) = '')) then
  begin
    SysDialogs.Warning('请将信息填写完整！');
    Exit;
  end;
  if nvhlpdepartstation.Id = nvhlpendstation.Id then
  begin
    SysDialogs.ShowMessage('上车站点与到达站不能相同！');
    nvhlpendstation.SetFocus;
    Exit;
  end;
  if cbbtickettype.ItemIndex < 0 then
    cbbtickettypeid := cbbtickettypeid
  else
    cbbtickettypeid := cbbtickettype.HelpFieldValue['id'];
  if StrToFloat(edtotherfee.Text) < 0 then
  begin
    SysDialogs.ShowMessage('其它金额不能为负，请重新输入！');
    Exit;
  end;
  with jcdsResultSavedepartinvoicesotherdetail do
  begin
    Close;
    Params.ParamValues['departinvoicesotherdetail.id'] := id;
    Params.ParamValues['departinvoicesotherdetail.createby'] := createby;
    Params.ParamValues['departinvoicesotherdetail.createtime'] := createtime;
    Params.ParamValues['departinvoicesotherdetail.departinvoicesotherid'] := departinvoicesotherid;
    Params.ParamValues['departinvoicesotherdetail.fromstationid'] := nvhlpdepartstation.Id;
    Params.ParamValues['departinvoicesotherdetail.reachstationid'] := nvhlpendstation.Id;
    Params.ParamValues['departinvoicesotherdetail.tickettypeid'] := cbbtickettypeid;
    Params.ParamValues['departinvoicesotherdetail.distance'] := edtdistance.Text;
    Params.ParamValues['departinvoicesotherdetail.price'] := formatfloat('0.00',StrToFloat(edtticketprice.Text));
    Params.ParamValues['departinvoicesotherdetail.ticketnum'] := edtnum.Text;
    Params.ParamValues['departinvoicesotherdetail.stationservicefee'] := formatfloat('0.00',StrToFloat(edtstationservicefree.Text));
    Params.ParamValues['departinvoicesotherdetail.othterfee'] := formatfloat('0.00',StrToFloat(edtotherfee.Text));
    Params.ParamValues['departinvoicesotherdetail.agentfee'] := formatfloat('0.00',StrToFloat(edtagentfee.Text));
    Params.ParamValues['departinvoicesotherdetail.balanceamount'] := formatfloat('0.00',StrToFloat(edtbalanceamount.Text));
    Params.ParamValues['departinvoicesotherdetail.schedule.id'] := scheduleid;
    Params.ParamValues['departinvoicesotherdetail.departtime'] := FormatDateTime('hh:mm', edtdeparttime.Time);
    Params.ParamValues['departinvoicesotherdetail.departdate'] := departdate;
    Params.ParamValues['departinvoicesotherdetail.totalamount'] := (StrToFloat(edtticketprice.Text) * StrToInt(edtnum.Text));
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpdepartstation.SetFocus;
      end
      else
      begin
        log := '[单号]:'+departinvoicesno+'[发车时间]'+departdate+':'+departtime+',';
        if departstation <> nvhlpdepartstation.Text then
          log := log+' [上车站] 由'+departstation+' 改成 '+ nvhlpdepartstation.Text +','
        else
          log := log+' [上车站]：'+departstation+'.';
        if reachestation <> nvhlpendstation.Text then
          log := log+' [到达站] 由'+reachestation+' 改成 '+ nvhlpendstation.Text +','
        else
          log := log +' [到达站]：'+reachestation+'.';
         if tickettype <> cbbtickettype.Text then
          log := log+' [票种] 由'+tickettype+'改成'+cbbtickettype.Text+',' ;
        if distance <> edtdistance.Text  then
          log := log+' [里程] 由 '+distance+'改成'+edtdistance.Text +',';
        if price <> edtticketprice.Text  then
          log := log+' [票价] 由'+price+' 改成'+edtticketprice.Text +',';
        if ticketnum <> edtnum.Text then
          log := log +' [检票数] 由 '+ticketnum +'改成'+ edtnum.Text+',';
        if  stationfee <> edtstationservicefree.Text then
          log := log+' [站务费] 由'+stationfee+'改成'+edtstationservicefree.Text  +',';
        if otherfee <> edtotherfee.Text then
          log := log+' [其他金额] 由'+otherfee+' 改成 '+ edtotherfee.Text +',';
        if agentfee <> edtagentfee.Text then
          log := log+' [客运代理费] 由'+agentfee+' 改成 '+ edtagentfee.Text +',';
        if balancefee <> edtbalanceamount.Text then
          log := log+' [结算金额] 由'+balancefee+' 改成 '+ edtbalanceamount.Text +',';

        SysLog.WriteLog('检票管理->结算单补录','修改补录明细',log);

        departinvoicesotherid := departinvoicesotherid;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('结算单补录明细添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesotherdetail.edtagentfeeChange(Sender: TObject);
begin
  inherited;
  edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoicesotherdetail.edtagentfeeExit(Sender: TObject);
begin
  inherited;
  edtagentfee.Text := formatfloat('0.00', StrToFloat(edtagentfee.Text));
  if Length(Trim(edtagentfee.Text)) > 11 then
  begin
    SysDialogs.ShowMessage('客运代理费只能输入8位整数,请重新输入！');
    edtagentfee.SetFocus;
    Exit;
  end;
end;

procedure TFrmDepartinvoicesotherdetail.edtbalanceamountChange(Sender: TObject);
begin
  inherited;
  edtotherfee.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtbalanceamount.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoicesotherdetail.edtnumChange(Sender: TObject);
begin
  inherited;
  edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoicesotherdetail.edtnumKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  case Key of
    '0'..'9', #8, #13, #27 : ;
  else
    begin
      MessageBox(Handle, '请输入数字', PChar('输入错误'), MB_OK + MB_ICONINFORMATION);
      Key := #0;
    end;
  end;
end;

procedure TFrmDepartinvoicesotherdetail.edtotherfeeChange(Sender: TObject);
begin
  inherited;
  //edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  //StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoicesotherdetail.edtotherfeeExit(Sender: TObject);
begin
  inherited;
  edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
  if Length(Trim(edtotherfee.Text)) > 11 then
  begin
    SysDialogs.ShowMessage('其他金额只能输入8位整数！');
    edtotherfee.SetFocus;
    Exit;
  end;
end;

procedure TFrmDepartinvoicesotherdetail.edtstationservicefreeChange(
  Sender: TObject);
begin
  inherited;
  edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));

end;

procedure TFrmDepartinvoicesotherdetail.edtstationservicefreeExit(
  Sender: TObject);
begin
  inherited;
  edtstationservicefree.Text := formatfloat('0.00', StrToFloat(edtstationservicefree.Text));
  if Length(Trim(edtstationservicefree.Text)) > 11 then
  begin
    SysDialogs.ShowMessage('站务费只能输入8位整数！');
    edtstationservicefree.SetFocus;
    Exit;
  end;
end;

procedure TFrmDepartinvoicesotherdetail.edtticketpriceChange(Sender: TObject);
begin
  inherited;
  edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
end;

procedure TFrmDepartinvoicesotherdetail.edtticketpriceExit(Sender: TObject);
begin
  inherited;
  edtticketprice.Text := formatfloat('0.00', StrToFloat(edtticketprice.Text));
end;

procedure TFrmDepartinvoicesotherdetail.FormCreate(Sender: TObject);
begin
  inherited;
  cbbtickettype.Active := False;
  cbbtickettype.Active := True;
  edtdeparttime.Enabled := False;
end;

end.

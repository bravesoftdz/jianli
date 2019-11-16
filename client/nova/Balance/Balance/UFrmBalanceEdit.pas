unit UFrmBalanceEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  ComCtrls, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, ToolWin, DB,
  DBClient, jsonClientDataSet, Services, UDMPublic, PubFn, NovaCheckedComboBox,
  NovaComboBox;

type
  TFrmBalanceEdit = class(TSimpleEditForm)
    lbl6: TLabel;
    dtpdepartdate: TDateTimePicker;
    Label1: TLabel;
    nvedtdepartinvoicesno: TNovaEdit;
    nvedtschedulecode: TNovaEdit;
    nvedtdeparttime: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    nvedtbalanceunit: TNovaEdit;
    nvedtworkunit: TNovaEdit;
    nvedtvehiclename: TNovaEdit;
    nvedtticketnum: TNovaEdit;
    nvedttotalamount: TNovaEdit;
    nvedtbalanceamount: TNovaEdit;
    nvedtstationservicefee: TNovaEdit;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    nvedtagentfee: TNovaEdit;
    nvedtfueladditionfee: TNovaEdit;
    nvedtothterfee: TNovaEdit;
    grp1: TGroupBox;
    nvdbgrdhdbgrdh1: TNvDbgridEh;
    mmo: TMemo;
    tlb1: TToolBar;
    btnInsertDep: TToolButton;
    jcdsQrydepartinvoicesdetail: TjsonClientDataSet;
    DataSource2: TDataSource;
    jcdsSavedepartinvoicesdetail: TjsonClientDataSet;
    Label14: TLabel;
    NovaEdit1: TNovaEdit;
    packno1: TjsonClientDataSet;
    lbl1: TLabel;
    cbborgNovachkStatus: TNovaComboBox;
    procedure btnInsertDepClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvedtticketnumChange(Sender: TObject);
    procedure nvedtstationservicefeeChange(Sender: TObject);
    procedure NovaEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, departinvoicesid, departinvoicesdetailid: int64;
    detailcreateby, detailcreatetime, detailscheduleid, detaildepartdate,
      detaildeparttime, detailfromstatioinid, detailreachstatioinid,
      detailtickettype, detaildistance, detailissupply,formula,agentfee: string;
    detailticketnum, detailprice, detailstationservicefee, detailotherfee,
      detailagentfee, detailfueladditionfee,detailbalanceprice: Double;

  end;

var
  FrmBalanceEdit: TFrmBalanceEdit;

implementation

{$R *.dfm}

procedure TFrmBalanceEdit.bbtnSaveClick(Sender: TObject);
var
log,optype: string;
begin

  inherited;
  with packno1 do
  begin
      close;

      Params.ParamValues['deductmoney'] := nvedtagentfee.text;
      Params.ParamValues['departinvoicesid'] := departinvoicesid;
      Params.ParamValues['balanceamount'] :=nvedtbalanceamount.text;
      Execute;
      SysDialogs.ShowMessage(Params.ParamByName('msg').Value);
      optype := '�ӽ��㵥���޸Ŀ��˴����';
      log := log + ',[���㵥Id]=' + IntToStr(departinvoicesid) +  ',[�����û�]=' +
            sysinfo.LoginUserInfo.UserName + ',[ԭ���˴����]=' + agentfee +
            ',��Ϊ=' + nvedtagentfee.text+ ',[����ʱ��]=' + FormatDateTime('yyyy-mm-dd', now()) ;
      SysLog.WriteLog('�������->���㵥����->�޸Ľ��㵥����', optype, log);
  end;

  ModalResult := mrok;
end;

procedure TFrmBalanceEdit.btnInsertDepClick(Sender: TObject);
var
  nResult: integer;
  sResult,log,optype: string;
begin
  inherited;
  if not DataSource2.DataSet.Active then
    Exit;
  if DataSource2.DataSet.RecordCount < 1 then
    Exit;
 if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ��ѡ����Ʊ��Ϣ��?') then
    exit;

    with jcdsSavedepartinvoicesdetail do
    begin
      close;
      Params.ParamValues['ticketsellid'] := jcdsQrydepartinvoicesdetail.FieldByName('id').AsString;
      Params.ParamValues['departinvoicesid'] := jcdsQrydepartinvoicesdetail.FieldByName('departinvoicesid').AsString;
      Params.ParamValues['fromstationid'] := jcdsQrydepartinvoicesdetail.FieldByName('fromstationid').AsString;
      Params.ParamValues['reachstationid'] := jcdsQrydepartinvoicesdetail.FieldByName('reachstationid').AsString;
      Params.ParamValues['tickettype'] := jcdsQrydepartinvoicesdetail.FieldByName('tickettype').AsString;
      Params.ParamValues['price'] := jcdsQrydepartinvoicesdetail.FieldByName('price').AsString;

      Execute;

      nvedtticketnum.Text := Params.ParamByName('ticketnum').Value;
      nvedttotalamount.Text := Params.ParamByName('totalamount').Value;
      nvedtbalanceamount.Text := Params.ParamByName('balanceamount').Value;
      nvedtagentfee.Text := Params.ParamByName('agentfee').Value;
      nvedtstationservicefee.Text := Params.ParamByName('stationservicefee').Value;
      nvedtothterfee.Text := Params.ParamByName('othterfee').Value;
      nvedtfueladditionfee.Text := Params.ParamByName('fueladditionfee').Value;

      optype := '�ӽ��㵥��ɾ��һ����Ʊ��ϸ';
      log := log + ',[��Ʊ��ϸID]=' + jcdsQrydepartinvoicesdetail.FieldByName('id').AsString + ',[���㵥Id]=' +
            jcdsQrydepartinvoicesdetail.FieldByName('departinvoicesid').AsString + ',[�����û�]=' +
            sysinfo.LoginUserInfo.UserName + ',[����վ]=' + jcdsQrydepartinvoicesdetail.FieldByName('fromstationname').AsString +
            ',[����վ]=' + jcdsQrydepartinvoicesdetail.FieldByName('reachstationname').AsString
            + ',[����ʱ��]=' + FormatDateTime('yyyy-mm-dd', now()) ;
        SysLog.WriteLog('�������->���㵥����->�޸Ľ��㵥����', optype, log);
    end;

    with jcdsQrydepartinvoicesdetail do
    begin
      Active := false;
      Params.ParamValues['departinvoicesid'] := departinvoicesid;
      Active := True;
    end;
  end;

procedure TFrmBalanceEdit.FormCreate(Sender: TObject);
begin
  inherited;
  agentfee:=nvedtagentfee.Text;
end;

procedure TFrmBalanceEdit.NovaEdit1Change(Sender: TObject);
begin
  inherited;
   if trim(NovaEdit1.text) = '' then exit;
   if (cbborgNovachkStatus.Itemindex=-1) or (cbborgNovachkStatus.Itemindex=0) then
   begin
      nvedtagentfee.Text := floattostr((strtofloat(nvedttotalamount.Text)
           - strtofloat(nvedtothterfee.Text)- strtofloat(nvedtstationservicefee.Text)
           -- strtofloat(nvedtfueladditionfee.Text))*strtofloat(NovaEdit1.Text));
   end;
   if cbborgNovachkStatus.Itemindex=1 then
   begin
      nvedtagentfee.Text := floattostr((strtofloat(nvedttotalamount.Text)
           - strtofloat(nvedtothterfee.Text))*strtofloat(NovaEdit1.Text));
   end;
   if cbborgNovachkStatus.Itemindex=2 then
   begin
      nvedtagentfee.Text := floattostr((strtofloat(nvedttotalamount.Text)
           - strtofloat(nvedtstationservicefee.Text))*strtofloat(NovaEdit1.Text));

   end;
   if cbborgNovachkStatus.Itemindex=3 then
   begin
        nvedtagentfee.Text := floattostr((strtofloat(nvedttotalamount.Text)
           - strtofloat(nvedtfueladditionfee.Text))*strtofloat(NovaEdit1.Text));
   end;

end;

procedure TFrmBalanceEdit.nvedtstationservicefeeChange(Sender: TObject);
  begin
    inherited;
    if (Trim(nvedtstationservicefee.Text) <> '') and
      (Trim(nvedtagentfee.Text) <> '') and (Trim(nvedtothterfee.Text) <> '')
      and (Trim(nvedttotalamount.Text) <> '') then
    begin
      nvedtbalanceamount.Text := floattostr(strtofloat(nvedttotalamount.Text)
          - strtofloat(nvedtstationservicefee.Text) - strtofloat
          (nvedtagentfee.Text) - strtofloat(nvedtothterfee.Text));
    end;

  end;

  procedure TFrmBalanceEdit.nvedtticketnumChange(Sender: TObject);
  begin
    inherited;
    if Trim(nvedtticketnum.Text) <> '' then
    begin
      nvedttotalamount.Text := floattostr
        (strtofloat('0') * strtofloat(nvedtticketnum.Text));
    end;
  end;

end.

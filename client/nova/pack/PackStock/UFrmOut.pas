unit UFrmOut;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, Services,
  NovaPrint, Generics.Collections,
  DBGridEhGrouping, ComCtrls, NovaEdit, NovaHelp, GridsEh, DBGridEh, NvDbgridEh,
  DB, DBClient, jsonClientDataSet;

type
  TFrmOutEdit = class(TSimpleEditForm)
    nvOutDbgridEh: TNvDbgridEh;
    Label4: TLabel;
    nvedtoutbound: TNovaHelp;
    Label16: TLabel;
    Label6: TLabel;
    nvedtdiliver: TNovaHelp;
    Label12: TLabel;
    lbl4: TLabel;
    outdate: TDateTimePicker;
    Label1: TLabel;
    dilivedate: TDateTimePicker;
    Label32: TLabel;
    nvedtDiliveryFee: TNovaEdit;
    dsResult: TDataSource;
    packdiliverydetaillist: TjsonClientDataSet;
    packdiliverydetaillistid: TLargeintField;
    packdiliverydetaillistpackid: TLargeintField;
    packdiliverydetaillistweight: TFloatField;
    packdiliverydetaillistdeliveryfee: TFloatField;
    packdiliverydetaillistpackno: TWideStringField;
    nvedtDiliveno: TNovaEdit;
    Label2: TLabel;
    bbtnPrint: TBitBtn;
    jcdsExistdiliveno: TjsonClientDataSet;
    Label3: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvOutDbgridEhOnCellClick(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure bbtnPrintClick(Sender: TObject);
    procedure packdiliverydetaillistdeliveryfeeChange(Sender: TField);
  private
    { Private declarations }
    id: integer;
    billPrint: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
    multiplelist: TList < TDictionary < String, String >> ; // ������ݼ�
  public
    { Public declarations }
    curpackids: String;
  end;

var
  FrmOutEdit: TFrmOutEdit;

implementation

{$R *.dfm}

procedure TFrmOutEdit.bbtnPrintClick(Sender: TObject);
var
  templtename: string;
  multipleValueValue: TDictionary<String, String>;
begin
  inherited;

  if ((Trim(nvedtoutbound.Text) = '') or (nvedtoutbound.id <= 0)) then // ������
  begin
    SysDialogs.ShowMessage('����������ˣ�');
    nvedtoutbound.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtdiliver.Text) = '') or (nvedtdiliver.id <= 0)) then // �ͻ���
  begin
    SysDialogs.ShowMessage('�������ͻ��ˣ�');
    nvedtdiliver.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtDiliveno.Text) = '') or (StrtoInt(Trim(nvedtDiliveno.Text)) <= 0)) then // �ͻ�����
  begin
    SysDialogs.ShowMessage('�������ͻ����ţ�');
    nvedtDiliveno.SetFocus;
    Exit;
  end;

  try
    if not Assigned(billPrint) then
    begin
      billPrint := TNovaPrint.Create(self,TNovaPrint.GetTicketModelName('ͬ���ͻ�', 'ͬ���ͻ�'));
    end;
    if billPrint = nil then
    begin
      SysDialogs.ShowError('��ʼ��ͬ���ͻ�ģ��ʧ�ܣ�δ֪����');
    end;
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
    begin
      printValue.Clear;
    end;
  except
    on E: Exception do
      SysDialogs.ShowError('��ʼ��ͬ���ͻ�ģ��ʧ�ܣ�' + E.Message);
  end;
  // ���õ�������
  billPrint.SingleValue.AddOrSetValue('outboundname', nvedtoutbound.Text);
  billPrint.SingleValue.AddOrSetValue('outdate',
    FormatDateTime('yyyy-mm-dd', outdate.Date));
  billPrint.SingleValue.AddOrSetValue('dilivername', nvedtdiliver.Text);
  billPrint.SingleValue.AddOrSetValue('dilivedate',
    FormatDateTime('yyyy-mm-dd', dilivedate.Date));
  billPrint.SingleValue.AddOrSetValue('diliveno', nvedtdiliver.Text);
  billPrint.SingleValue.AddOrSetValue('deliveryfee', nvedtDiliveryFee.Text);

  // ��ȡ������ݼ�����
  if not Assigned(multiplelist) then
    multiplelist := TList < TDictionary < String, String >> .Create
  else
    multiplelist.Clear;
  try
    with packdiliverydetaillist do
    begin
      if RecordCount > 0 then
      begin
        first;
        while (not Eof) do
        begin
          multipleValueValue := TDictionary<String, String>.Create;

          multipleValueValue.Add('packno', FieldByName('packno').AsString);
          multipleValueValue.Add('weight', FieldByName('weight').AsString);
          multipleValueValue.Add('deliveryfeedetail',
            FieldByName('deliveryfee').AsString);

          multiplelist.Add(multipleValueValue);
          next;
        end;
      end;
    end;

    billPrint.MultipleValue := multiplelist;
    billPrint.Print;
  except
    on E: Exception do
      showMessage(E.tostring());

  end;

end;

procedure TFrmOutEdit.bbtnSaveClick(Sender: TObject);
var
  result, log: String;
begin
  inherited;

  if ((Trim(nvedtoutbound.Text) = '') or (nvedtoutbound.id <= 0)) then // ������
  begin
    SysDialogs.ShowMessage('����������ˣ�');
    nvedtoutbound.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtdiliver.Text) = '') or (nvedtdiliver.id <= 0)) then // �ͻ���
  begin
    SysDialogs.ShowMessage('�������ͻ��ˣ�');
    nvedtdiliver.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtDiliveno.Text) = '') or (StrtoInt(Trim(nvedtDiliveno.Text)) <= 0)) then // �ͻ�����
  begin
    SysDialogs.ShowMessage('�������ͻ����ţ�');
    nvedtDiliveno.SetFocus;
    Exit;
  end;

  with jcdsExistdiliveno do
  begin
    try
      Active := false;
      Params.ParamValues['packdilivery.diliveno'] := trim(nvedtDiliveno.Text);
      Execute;
//      showMessage(Params.ParamValues['flag']);
      if Params.ParamValues['flag'] < 0 then
      begin
       SysDialogs.showMessage(Params.ParamValues['msg']);
       nvedtDiliveno.setFocus;
       exit;
      end;
     except
      on E: Exception do
        showMessage(E.tostring);
    end;

  end;


  with packdiliverydetaillist do
  begin
    try
      Params.ParamValues['packdilivery.outbound'] := nvedtoutbound.id;
      Params.ParamValues['packdilivery.diliver'] := nvedtdiliver.id;
      Params.ParamValues['packdilivery.dilivedate'] := FormatDateTime('yyyy-mm-dd', dilivedate.Date);
      Params.ParamValues['packdilivery.outdate'] := FormatDateTime('yyyy-mm-dd', outdate.Date);
      Params.ParamValues['packdilivery.deliveryfee'] := trim(nvedtDiliveryFee.Text);
      Params.ParamValues['packdilivery.diliveno'] := trim(nvedtDiliveno.Text);

      ApplyUpdates(-1);
      SysDialogs.showMessage(Params.ParamValues['msg']);
//      SysDialogs.showMessage(inttostr(Params.ParamValues['flag']));
      if Params.ParamValues['flag'] < 0 then
      begin
        nvedtDiliveno.SetFocus;
      end
      else
      begin
        bbtnSave.Enabled := false;
        result := '���';
        log := result + ' ������=' + VarToStr
          (Params.ParamValues['packdilivery.outbound']) + ',�ͻ���=' + VarToStr
          (Params.ParamValues['packdilivery.diliver'])
          + ',' + '��������=' + Params.ParamValues['packdilivery.outdate']
          + ',�ͻ�����=' + VarToStr(Params.ParamValues['packdilivery.dilivedate'])
          + ',�ͻ���=' + nvedtDiliveryFee.Text;
        SysLog.WriteLog('�а�����->�а����', result, log);

        self.ModalResult := mrOk;
      end;
    except
      on E: Exception do
        showMessage(E.tostring);
    end;
  end;
end;

procedure TFrmOutEdit.FormCreate(Sender: TObject);
begin
  inherited;
  try
    outdate.DateTime := Now();
    dilivedate.DateTime := Now();
  except
    on E: Exception do
      SysDialogs.showMessage(E.tostring);
  end;
end;

procedure TFrmOutEdit.FormShow(Sender: TObject);
begin
  inherited;
  with packdiliverydetaillist do

  begin
    try
      Active := false;
      Params.ParamByName('packids').Value := curpackids;
      Active := true;
    except
      on E: Exception do
        SysDialogs.showMessage(E.tostring);
    end;
    nvedtDiliveryFee.Text := currtostr
      (nvOutDbgridEh.SumList.SumCollection.Items[2].SumValue);
  end;
  nvedtoutbound.SetFocus;
  // ��������keyup�¼�
  //nvOutDbgridEh.OnKeyUp := nvOutDbgridEhOnCellClick;
end;

procedure TFrmOutEdit.nvOutDbgridEhOnCellClick(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  totalfee: integer;
begin
  inherited;
 { totalfee := 0;
  with packdiliverydetaillist do
  begin
    first;
    while (not Eof) do
    begin
      totalfee := totalfee + FieldByName('deliveryfee').AsInteger;
      next;
    end;
  end;
  nvedtDiliveryFee.Text := inttostr(totalfee); }
end;

procedure TFrmOutEdit.packdiliverydetaillistdeliveryfeeChange(Sender: TField);
begin
  inherited;
  packdiliverydetaillist.Post;
  nvedtDiliveryFee.Text := CurrToStr
    (nvOutDbgridEh.SumList.SumCollection.Items[2].SumValue);
end;

end.

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
    printValue: TDictionary<String, String>; // 输出单变量
    multiplelist: TList < TDictionary < String, String >> ; // 输出数据集
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

  if ((Trim(nvedtoutbound.Text) = '') or (nvedtoutbound.id <= 0)) then // 出库人
  begin
    SysDialogs.ShowMessage('请输入出库人！');
    nvedtoutbound.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtdiliver.Text) = '') or (nvedtdiliver.id <= 0)) then // 送货人
  begin
    SysDialogs.ShowMessage('请输入送货人！');
    nvedtdiliver.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtDiliveno.Text) = '') or (StrtoInt(Trim(nvedtDiliveno.Text)) <= 0)) then // 送货单号
  begin
    SysDialogs.ShowMessage('请输入送货单号！');
    nvedtDiliveno.SetFocus;
    Exit;
  end;

  try
    if not Assigned(billPrint) then
    begin
      billPrint := TNovaPrint.Create(self,TNovaPrint.GetTicketModelName('同城送货', '同城送货'));
    end;
    if billPrint = nil then
    begin
      SysDialogs.ShowError('初始化同城送货模板失败，未知错误');
    end;
    if not Assigned(printValue) then
      printValue := TDictionary<String, String>.Create
    else
    begin
      printValue.Clear;
    end;
  except
    on E: Exception do
      SysDialogs.ShowError('初始化同城送货模板失败：' + E.Message);
  end;
  // 设置单个数据
  billPrint.SingleValue.AddOrSetValue('outboundname', nvedtoutbound.Text);
  billPrint.SingleValue.AddOrSetValue('outdate',
    FormatDateTime('yyyy-mm-dd', outdate.Date));
  billPrint.SingleValue.AddOrSetValue('dilivername', nvedtdiliver.Text);
  billPrint.SingleValue.AddOrSetValue('dilivedate',
    FormatDateTime('yyyy-mm-dd', dilivedate.Date));
  billPrint.SingleValue.AddOrSetValue('diliveno', nvedtdiliver.Text);
  billPrint.SingleValue.AddOrSetValue('deliveryfee', nvedtDiliveryFee.Text);

  // 获取表格数据集数据
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

  if ((Trim(nvedtoutbound.Text) = '') or (nvedtoutbound.id <= 0)) then // 出库人
  begin
    SysDialogs.ShowMessage('请输入出库人！');
    nvedtoutbound.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtdiliver.Text) = '') or (nvedtdiliver.id <= 0)) then // 送货人
  begin
    SysDialogs.ShowMessage('请输入送货人！');
    nvedtdiliver.SetFocus;
    Exit;
  end;
  if ((Trim(nvedtDiliveno.Text) = '') or (StrtoInt(Trim(nvedtDiliveno.Text)) <= 0)) then // 送货单号
  begin
    SysDialogs.ShowMessage('请输入送货单号！');
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
        result := '添加';
        log := result + ' 出库人=' + VarToStr
          (Params.ParamValues['packdilivery.outbound']) + ',送货人=' + VarToStr
          (Params.ParamValues['packdilivery.diliver'])
          + ',' + '出库日期=' + Params.ParamValues['packdilivery.outdate']
          + ',送货日期=' + VarToStr(Params.ParamValues['packdilivery.dilivedate'])
          + ',送货费=' + nvedtDiliveryFee.Text;
        SysLog.WriteLog('行包管理->行包库存', result, log);

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
  // 给表格添加keyup事件
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

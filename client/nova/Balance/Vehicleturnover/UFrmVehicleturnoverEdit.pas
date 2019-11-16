unit UFrmVehicleturnoverEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp, DB,
  DBClient, jsonClientDataSet, ImgList;

type
  TFrmVehicleturnoverEdit = class(TSimpleEditForm)
    lblvehicleno: TLabel;
    lblmoney: TLabel;
    lblremarks: TLabel;
    nvhlpvehicleno: TNovaHelp;
    edtmoney: TNovaEdit;
    mmoremarks: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    jsonCDSVehicleturnoverSave: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : string;
  public
    { Public declarations }
    sign : boolean;
    id, orgid, createby: LongWord;
    createtime: TDateTime;
  end;

var
  FrmVehicleturnoverEdit: TFrmVehicleturnoverEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmVehicleturnoverEdit.bbtnSaveClick(Sender: TObject);
var nResult : Integer ;
    sResult : string;
begin
  inherited;
  with jsonCDSVehicleturnoverSave do
  begin
    Close;
    if Trim(edtmoney.Text) = '' then
    begin
      SysDialogs.ShowMessage('������ɿ��');
      edtmoney.SetFocus;
      Exit;
    end;
    if nvhlpvehicleno.Id=0 then
    begin
      SysDialogs.ShowMessage('�����복�ƺţ�');
      nvhlpvehicleno.SetFocus;
      Exit;
    end;
    Params.ParamByName('vehicleturnover.id').Value :=id ;
    Params.ParamByName('vehicleturnover.receiptorgid').Value := orgid;
    Params.ParamByName('vehicleturnover.money').Value := edtmoney.Text;
    Params.ParamByName('vehicleturnover.vehicleid').Value := nvhlpvehicleno.Id;
    Params.ParamByName('vehicleturnover.remarks').Value := mmoremarks.Text;
    Params.ParamByName('vehicleturnover.createby').Value := createby;
    Params.ParamByName('vehicleturnover.createtime').Value := DateTimeToStr(createtime);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpvehicleno.SetFocus;
        Exit;
      end else
      begin
        log := '��ӳ���Ԥ�ɿ������='+nvhlpvehicleno.Text+',�ɿ���='+
        edtmoney.Text+',��ע='+mmoremarks.Text;
        SysLog.WriteLog('���������>����Ԥ�ɿ�','���',log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�����ɿ���Ϣ���ʧ�ܣ�' + E.Message);
        Exit;
      end;
    end;
  end;

end;

end.

unit UFrmHandpriceItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping, DB,
  DBClient, jsonClientDataSet, GridsEh, DBGridEh, NvDbgridEh, ImgList;

type
  TFrmHandpriceItem = class(TSimpleEditForm)
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    jscdqryTicketPriceItem: TjsonClientDataSet;
    Label1: TLabel;
    chkCopyOtherSch: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure jscdqryTicketPriceItemAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    baseprice:double;
  public
    { Public declarations }
    handpriceid: int64;
    tickettype: string;
  end;

var
  FrmHandpriceItem: TFrmHandpriceItem;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmHandpriceItem.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sresult:String;
begin
  inherited;
  try
     with jscdqryTicketPriceItem do
     begin
        first;
        while(not eof)do
        begin
          if(jscdqryTicketPriceItem.FieldByName('price').AsFloat<0)then
          begin
            SysDialogs.Warning(jscdqryTicketPriceItem.FieldByName('name').AsString+'不允许为负数！');
            exit;
          end;
          next;
        end;
     end;
      jscdqryTicketPriceItem.Params.ParamValues['iscopyothersch'] := chkCopyOtherSch.Checked;
      jscdqryTicketPriceItem.ApplyUpdates(-1);
      nResult:= jscdqryTicketPriceItem.Params.ParamByName('flag').Value;
      if (nResult =1 ) then
      begin
        SysDialogs.ShowMessage('保存成功！');
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.ShowMessage(jscdqryTicketPriceItem.Params.ParamByName('msg').Value);
      end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存平时票价分项信息失败：' + E.Message);
    end;
  end;
end;

procedure TFrmHandpriceItem.FormShow(Sender: TObject);
begin
  inherited;
  with jscdqryTicketPriceItem do
  begin
    Active := false;
    Params.ParamValues['handpriceid'] := handpriceid;
    Params.ParamValues['tickettype'] := tickettype;
    Active := true;
    if recordcount>0 then
    begin
      baseprice:=jscdqryTicketPriceItem.FieldByName('price').AsFloat;
    end;
  end;
end;

procedure TFrmHandpriceItem.jscdqryTicketPriceItemAfterScroll(
  DataSet: TDataSet);
begin
  inherited;
   if jscdqryTicketPriceItem.FieldByName('code').AsString='F' then
   begin
      jscdqryTicketPriceItem.CanEdit:=false;
   end
   else
   begin
      jscdqryTicketPriceItem.CanEdit:=true;
   end;
end;

end.

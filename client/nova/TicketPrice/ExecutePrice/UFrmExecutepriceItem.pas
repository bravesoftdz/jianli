unit UFrmExecutepriceItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping, DB,
  DBClient, jsonClientDataSet, GridsEh, DBGridEh, NvDbgridEh, ImgList;

type
  TFrmExecutepriceItem = class(TSimpleEditForm)
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    jscdqryTicketPriceItem: TjsonClientDataSet;
    chkCopyOtherSch: TCheckBox;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ticketpriceid:int64;
    tickettype:string;
  end;

var
  FrmExecutepriceItem: TFrmExecutepriceItem;

implementation
 uses PubFn, Services,UDMPublic;
{$R *.dfm}

procedure TFrmExecutepriceItem.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sresult:String;
begin
  inherited;
  try
      jscdqryTicketPriceItem.Params.ParamValues['iscopyothersch'] := chkCopyOtherSch.Checked;
      nResult := jscdqryTicketPriceItem.ApplyUpdates(-1);
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
      SysLog.WriteErr('保存执行票价分项信息失败：' + E.Message);
    end;
  end;

end;

procedure TFrmExecutepriceItem.FormShow(Sender: TObject);
begin
  inherited;
    with jscdqryTicketPriceItem do
  begin
    Active := false;
    Params.ParamValues['ticketpriceid'] := ticketpriceid;
    Params.ParamValues['tickettype'] := tickettype;
    Active := true;
  end;
end;

end.

unit UFrmStatiionPriceItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB, DBClient,
  jsonClientDataSet;

type
  TFrmStatiionPriceItem = class(TSimpleEditForm)
    Label1: TLabel;
    NvDbgridEh1: TNvDbgridEh;
    chkCopyOtherSch: TCheckBox;
    jscdqryTicketPriceItem: TjsonClientDataSet;
    DataSource1: TDataSource;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ticketpriceid:int64;
    tickettype:string;
  end;

var
  FrmStatiionPriceItem: TFrmStatiionPriceItem;

implementation
 uses PubFn, Services,UDMPublic;
{$R *.dfm}

procedure TFrmStatiionPriceItem.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
begin
  inherited;
  try
      jscdqryTicketPriceItem.Params.ParamValues['iscopyothersch'] := chkCopyOtherSch.Checked;
      nResult := jscdqryTicketPriceItem.ApplyUpdates(-1);
      if (nResult <> 0) then
      begin
        SysDialogs.Warning('保存失败！');
      end
      else
      begin
        SysDialogs.ShowMessage('保存成功！');
        ModalResult := mrok;
      end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('保存执行票价分项信息失败：' + E.Message);
    end;
  end;
end;

procedure TFrmStatiionPriceItem.FormShow(Sender: TObject);
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

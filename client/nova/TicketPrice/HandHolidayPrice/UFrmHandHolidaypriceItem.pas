unit UFrmHandHolidaypriceItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping, DB,
  DBClient, jsonClientDataSet, GridsEh, DBGridEh, NvDbgridEh, ImgList;

type
  TFrmHandHolidaypriceItem = class(TSimpleEditForm)
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    jscdqryTicketPriceItem: TjsonClientDataSet;
    chkCopyOtherSch: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    handholidaypriceid:int64;
    tickettype:string;
  end;

var
  FrmHandHolidaypriceItem: TFrmHandHolidaypriceItem;

implementation
 uses PubFn, Services,UDMPublic;
{$R *.dfm}

procedure TFrmHandHolidaypriceItem.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
begin
  inherited;
  try
      jscdqryTicketPriceItem.Params.ParamValues['iscopyothersch']:=chkCopyOtherSch.Checked;
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
      SysLog.WriteErr('保存节日票价分项信息失败：' + E.Message);
    end;
  end;

end;

procedure TFrmHandHolidaypriceItem.FormShow(Sender: TObject);
begin
  inherited;
    with jscdqryTicketPriceItem do
  begin
    Active := false;
    Params.ParamValues['handholidaypriceid'] := handholidaypriceid;
    Params.ParamValues['tickettype'] := tickettype;
    Active := true;
  end;
end;

end.

unit UFrmQryTakeTicketLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, NovaHComboBox;

type
  TFrmQryTakeTicketLog = class(TSimpleCRUDForm)
    nvcbbOrgid: TNovaCheckedComboBox;
    lbl1: TLabel;
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    Label2: TLabel;
    dtpenddate: TDateTimePicker;
    Nvtaketicketplace: TNovaCheckedComboBox;
    Label3: TLabel;
    lbl6: TLabel;
    NovaHCbbOrg: TNovaCheckedComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryTakeTicketLog: TFrmQryTakeTicketLog;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmQryTakeTicketLog.FormShow(Sender: TObject);
begin
  inherited;
  NovaHCbbOrg.Active:= False;
  NovaHCbbOrg.Active:= True;
  NovaHCbbOrg.SelectAll;
  nvcbbOrgid.Active:=False;
  nvcbbOrgid.Active:=True;
  Nvtaketicketplace.Active:=False;
  Nvtaketicketplace.Active:=True;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
end;

procedure TFrmQryTakeTicketLog.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= False;
    Params.ParamValues['operatorgname'] := NovaHCbbOrg.GetSelectID;
    Params.ParamValues['sellticketorgid'] := nvcbbOrgid.GetSelectID;
    Params.ParamValues['ticketoutletsid'] := Nvtaketicketplace.GetSelectID;
    Params.ParamValues['dtpstartdate'] := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamValues['dtpenddate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.Date+0.99999);

    try
      Active := True;
    except
      on E: Exception do
      begin
      SysLog.WriteErr('1111111£º' + E.Message);
      end;
    end;


  end;
end;

end.

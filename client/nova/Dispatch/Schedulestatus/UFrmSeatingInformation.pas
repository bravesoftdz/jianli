unit UFrmSeatingInformation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, DB, DBClient,
  jsonClientDataSet, NovaHelp, ComCtrls, NovaEdit, DBGridEhGrouping, GridsEh,
  DBGridEh, NvDbgridEh, Math;

type
  TFrmSeatingInformation = class(TSimpleEditForm)
    lbldate: TLabel;
    lblschedule: TLabel;
    Label1: TLabel;
    NovaEdtDepartTime: TNovaEdit;
    dtpstartdate: TDateTimePicker;
    edtroute: TNovaHelp;
    lblroute: TLabel;
    edtschedule: TNovaHelp;
    jcdsQrySeatstatusdetail: TjsonClientDataSet;
    dsResult: TDataSource;
    GroupBox1: TGroupBox;
    pnlpicture: TPanel;
    dbgrdhResult: TNvDbgridEh;
    NvDbgridEh1: TNvDbgridEh;
    DataSource1: TDataSource;
    jcdsQrySeatstatusdetailend: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure dbgrdhResultGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure NvDbgridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    // procedure edtrouteIdChange(Sender: TObject);
    // procedure edtrouteChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    routeid: Integer;
    districttype, id, OrgID, departstationid, scheduleid, scheduleplanid,
      brandModelid: LargeInt;
    departdate: TDateTime;
    departtime: string;
  end;

var
  FrmSeatingInformation: TFrmSeatingInformation;

implementation

{$R *.dfm}

procedure TFrmSeatingInformation.dbgrdhResultGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if (jcdsQrySeatstatusdetail.FieldByName('status').AsString = '已售') then
  begin
    Background := clWebPaleTurquoise; // clYellow;

  end;

        if (jcdsQrySeatstatusdetail.FieldByName('status').AsString = '留位') then
  begin
    Background := clWebNavajoWhite; // clYellow;

  end;


end;

procedure TFrmSeatingInformation.FormShow(Sender: TObject);
begin
  inherited;

  bbtnClose.Left := Ceil((Self.Width/7)*3);

  with jcdsQrySeatstatusdetail do

  begin
    Active := false;

    Params.ParamValues['filter_EQD_ss!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_EQL_ss!scheduleplanid'] := scheduleplanid;
    Active := True;
  end;

  with jcdsQrySeatstatusdetailend do
  begin
    Active := false;

    Params.ParamValues['filter_EQD_ss!departdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_EQL_ss!scheduleid'] := scheduleid;
    Active := True;
  end;

end;

procedure TFrmSeatingInformation.NvDbgridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;



  if (jcdsQrySeatstatusdetailend.FieldByName('status').AsString = '留位') then
  begin
    Background := clWebNavajoWhite; // clYellow;

  end;
    if (jcdsQrySeatstatusdetailend.FieldByName('status').AsString = '已售') then
  begin
    Background := clWebPaleTurquoise; // clYellow;

  end;
end;

end.

unit UFrmTicketQueryDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB, DBClient,
  jsonClientDataSet,UFrmTicketQuery,PubFn;

type
  TFrmTicketQueryDetail = class(TSimpleEditForm)
    Label4: TLabel;
    lbl3: TLabel;
    lbl12: TLabel;
    lbl5: TLabel;
    lbl13: TLabel;
    Label7: TLabel;
    lbl14: TLabel;
    Label8: TLabel;
    lbl15: TLabel;
    nvdbgrdhschedule: TNvDbgridEh;
    NvDbgridEh1: TNvDbgridEh;
    dsSchedule: TDataSource;
    jcdsAskScheduleDetail: TjsonClientDataSet;
    jcdsAskDetail: TjsonClientDataSet;
    dsDcheduleDetail: TDataSource;
    lbl101: TLabel;
    pnlQuery: TPanel;
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketQueryDetail: TFrmTicketQueryDetail;

implementation

{$R *.dfm}

procedure TFrmTicketQueryDetail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=VK_ESCAPE then
  begin
    self.Close;
  end;
end;

end.

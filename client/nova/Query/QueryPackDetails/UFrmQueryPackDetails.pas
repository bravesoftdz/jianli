unit UFrmQueryPackDetails;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp,Services;

type
  TfrmQueryPackDetails = class(TSimpleCRUDForm)
    lbl4: TLabel;
    sendstartdate: TDateTimePicker;
    Label1: TLabel;
    sendenddate: TDateTimePicker;
    nvhelptostation: TNovaHelp;
    Label2: TLabel;
    Label3: TLabel;
    NvDbgridEh1: TNvDbgridEh;
    NvDbgridEh2: TNvDbgridEh;
    NvDbgridEh3: TNvDbgridEh;
    NvDbgridEh4: TNvDbgridEh;
    NvDbgridEh5: TNvDbgridEh;
    NvDbgridEh6: TNvDbgridEh;
    nvhelpuser: TNovaHelp;
    jcdsstatusname: TjsonClientDataSet;
    jcdsResultdepartdate: TDateField;
    jcdsResultpackno: TWideStringField;
    jcdsResultsingbillno: TWideStringField;
    jcdsResultname1: TWideStringField;
    jcdsResultpieces: TWideStringField;
    jcdsResultshipprice: TFloatField;
    jcdsResulthandfee: TFloatField;
    jcdsResulttransitfee: TFloatField;
    jcdsResultotherfee: TFloatField;
    jcdsResulttotalfee: TFloatField;
    jcdsResultshishoujine: TFloatField;
    jcdsResultjiesuanjine: TFloatField;
    jcdsResultname2: TWideStringField;
    jcdsResultchepaihao: TWideStringField;
    jcdsResultstatus: TWideStringField;
    jcdsResultstatusname: TWideStringField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQueryPackDetails: TfrmQueryPackDetails;

implementation

{$R *.dfm}

procedure TfrmQueryPackDetails.FormShow(Sender: TObject);
begin
  inherited;
   sendstartdate.DateTime := now();
   sendenddate.DateTime := now();
end;

procedure TfrmQueryPackDetails.tbtnFilterClick(Sender: TObject);
begin
  inherited;
   with jcdsResult do
  begin
    Active := false;
     if FormatDateTime('yyyymmdd', sendstartdate.Date) > FormatDateTime
      ('yyyymmdd', sendenddate.Date) then
    begin
      SysDialogs.ShowMessage('开始日期不能大于结束日期！');
      exit;
    end;

    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendstartdate.DateTime);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendenddate.DateTime+1);
    Params.ParamValues['filter_EQS_s!id'] := nvhelptostation.id;
    Params.ParamValues['filter_EQS_u!id'] := nvhelpuser.Id;
     if nvhelptostation.id<=0 then
      Params.ParamValues['filter_EQS_s!id'] := ''
    else
      Params.ParamValues['filter_EQS_s!id'] := nvhelptostation.id;

      if nvhelpuser.id<=0 then
      Params.ParamValues['filter_EQS_u!id'] := ''
    else
      Params.ParamValues['filter_EQS_u!id'] := nvhelpuser.id;
    Active := true;


  end;


end;

end.

unit UFrmAuditlog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaEdit, NovaHelp, NovaComboBox, NvPrnDbgeh, NvDbgridEh, NovaCheckedComboBox;

type
  TFrmAuditlog = class(TSimpleCRUDForm)
    lblOrg: TLabel;
    lblUserIp: TLabel;
    lblUserId: TLabel;
    lblBegintimes: TLabel;
    lblEndtimes: TLabel;
    lblType: TLabel;
    edtIp: TNovaEdit;
    dtpBegindate: TDateTimePicker;
    dtpBegintime: TDateTimePicker;
    dtpEnddate: TDateTimePicker;
    dtpEndtime: TDateTimePicker;
    lblTableName: TLabel;
    edtTabalename: TNovaEdit;
    nvcbbtype: TNovaComboBox;
    jcdsOperation: TjsonClientDataSet;
    nvckbOrg: TNovaCheckedComboBox;
    lrgntfldResultid: TLargeintField;
    wdstrngfldResultcontent: TWideStringField;
    wdstrngfldResultip: TWideStringField;
    wdstrngfldResultsessionid: TWideStringField;
    wdstrngfldResulttablename: TWideStringField;
    lrgntfldResultuserid: TLargeintField;
    wdstrngfldResultusername: TWideStringField;
    wdstrngfldResultorgname: TWideStringField;
    wdstrngfldResultoperation: TWideStringField;
    wdstrngfldResultoperationname: TWideStringField;
    dtmfldResultoccurtime: TDateTimeField;
    nvhelpUserid: TNovaHelp;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAuditlog: TFrmAuditlog;

implementation
  uses UDMPublic,Services,PubFn;
{$R *.dfm}



procedure TFrmAuditlog.FormCreate(Sender: TObject);
var
  DateTime:TDateTime;
  i:string;
begin
  inherited;
  dtpBegindate.Date :=Now;
  dtpEnddate.Date :=Now;
  nvckbOrg.Active := False;
  nvckbOrg.Active := True;
  nvcbbtype.Active:=false;
  nvcbbtype.Active:=True;
  jcdsOperation.Active:=false;
  jcdsOperation.Active:=True;
 end;

procedure TFrmAuditlog.tbtnFilterClick(Sender: TObject);
var endtime,begintime:String;orgid:Integer;
begin
  inherited;
    with jcdsResult do
     begin
     Active := false;
      if nvcbbtype.GetSelectID > 0 then
        begin
         Params.ParamByName('operation').Value := nvcbbtype.GetSelectCode;
        end
      else
        begin
         Params.ParamByName('operation').Value := '';
        end;
        //nvhlpOrg.HelpFieldValue['id']
      Params.ParamByName('orgid').Value := nvckbOrg.GetSelectID;

        if (not (Trim(nvhelpUserid.Text) = '')) and (nvhelpUserid.Id>0) then //ÓÃ»§Ãû
        begin
          Params.ParamValues['username']:= nvhelpUserid.Text;
        end
        else
        begin
          Params.ParamValues['username']:= '';
        end;
      Params.ParamByName('tablename').Value := edtTabalename.Text;
      Params.ParamByName('ip').Value := edtIp.Text;
      Params.ParamByName('begintime').Value :=
          formatdatetime('c',dtpBegindate.Date)+' '+ formatdatetime('tt',dtpBegintime.Time);
      Params.ParamByName('endtime').Value :=
          formatdatetime('c',dtpEnddate.Date)+' '+formatdatetime('tt',dtpEndtime.Time);
      Active := true;
     end;
end;

end.

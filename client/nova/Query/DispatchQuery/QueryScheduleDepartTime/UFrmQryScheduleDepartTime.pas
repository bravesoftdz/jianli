unit UFrmQryScheduleDepartTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,Services,
  ToolWin, ExtCtrls, Mask, NovaComboBox, NovaCheckedComboBox, NovaEdit, NovaHelp,UDMPublic,
  NovaHComboBox;

type
  TfrmQryScheduleDepartTime  = class(TSimpleCRUDForm)
    jcdsReturnwayname: TjsonClientDataSet;
    lbl1: TLabel;
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl3: TLabel;
    nvhelpRoute: TNovaHelp;
    intgrfldResultdistance: TIntegerField;
    fltfldResultruntime: TFloatField;
    wdstrngfldResultendstationname: TWideStringField;
    wdstrngfldResultreachstationname: TWideStringField;
    wdstrngfldResultstarttime: TWideStringField;
    wdstrngfldResultroutename: TWideStringField;
    nvHcbbOrgNovaCbbOrg: TNovaHComboBox;
    jcdsResultdepartdate: TDateField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQryScheduleDepartTime: TfrmQryScheduleDepartTime;
implementation
    uses SystemInstance,SysInfoIntf,PubFn;
{$R *.dfm}



procedure TfrmQryScheduleDepartTime.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBdepartdate.Date:=Now;
  nvHcbbOrgNovaCbbOrg.Active:= False;
  nvHcbbOrgNovaCbbOrg.Active := True;
  jcdsReturnwayname.Active := False;
  jcdsReturnwayname.Active := True;
end;

procedure TfrmQryScheduleDepartTime.tbtnFilterClick(Sender: TObject);
var log :string;
begin
  inherited;
with jcdsResult do
  begin
    Active:=False;
    Params.ParamValues['filter_EQL_s!orgid']:= nvHcbbOrgNovaCbbOrg.HelpFieldValue['id'];

    Params.ParamValues['filter_EQD_sts!departdate'] := formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);  //��Ʊ����

    if (not (Trim(nvhelpRoute.Text) = '')) and (nvhelpRoute.Id>0) then  //��·
      begin
        Params.ParamValues['filter_EQL_s!routeid']:= nvhelpRoute.HelpFieldValue['id'];
      end
    else
      begin
        Params.ParamValues['filter_EQL_s!routeid']:= '';
      end;
    Active:=true;
    dbgrdhResult.PrintInfo.PageTopLeft:='�Ʊ������'+sysinfo.LoginUserInfo.OrgName;
    dbgrdhResult.PrintInfo.PageTopRight:='�������ڣ�'+
      formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);

    log := '��ѯ�����У�[��������] '+ formatdatetime('yyyy-mm-dd',dtpBdepartdate.Date);
    if Trim(nvHcbbOrgNovaCbbOrg.HelpFieldValue['id']) <>'' then
      log := log +',[��������]��'+nvHcbbOrgNovaCbbOrg.Text;
    if nvhelpRoute.Id <>0 then
      log  := log +',[��·]:'+nvhelpRoute.Text;
    log := log+'��[��ѯ���]:���� '+ inttostr(RecordCount) +' ����¼��';
    SysLog.WriteLog('�ۺϲ�ѯ->���˰��߷���ʱ�̱�','��ѯ',log);
  end
end;

end.


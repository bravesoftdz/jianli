unit UFrmSellReturnTicket;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox,NovaHComboBox,
  NovaComboBox;

type
  TFrmSellReturnTicket = class(TSimpleCRUDForm)
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvcbbOrgid: TNovaCheckedComboBox;
    rb1: TRadioButton;
    rb2: TRadioButton;
    lbl4: TLabel;
    nvcbbticketsellway: TNovaComboBox;
    cbbSellway: TNovaCheckedComboBox;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSellReturnTicket: TFrmSellReturnTicket;

implementation

uses Services,PubFn;
{$R *.dfm}

procedure TFrmSellReturnTicket.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvcbbOrgid.Active := False;
  
  nvcbbOrgid.Active := True;
  nvcbbOrgid.CheckById(true,TCommInfo(nvcbbOrgid.Items.Objects[0]).ID);

  nvcbbticketsellway.active:=false;
//  nvcbbticketsellway.SetItemIndexByCode('10');
  nvcbbticketsellway.active:=true;

//  tablename
  cbbSellway.Active := False;  //��Ʊ��ʽ��Ϊ������ѡ��
  cbbSellway.Active := True;
  cbbSellway.SetCheck(7, true); //Ĭ��ѡ��7��������Ʊ
end;

procedure TFrmSellReturnTicket.jcdsResultAfterOpen(DataSet: TDataSet);
begin
 { inherited;
  if chkIsCheck.Checked then
      dbgrdhResult.Columns[2].Visible :=True
  else
      dbgrdhResult.Columns[2].Visible :=false;
      }
end;

procedure TFrmSellReturnTicket.tbtnFilterClick(Sender: TObject);
var log:string;
begin
  inherited;
//  if rb1.Checked then
//  begin
      if ((nvcbbOrgid.GetCount = 0) or (nvcbbOrgid.Text = '')) then
      begin
         SysDialogs.ShowMessage('��ѡ����Ʊ������');
         exit;
      end;
//  end
//  else if rb2.Checked then
//  begin
      if FormatDateTime('yyyy-mm-dd', dtpstartdate.Date) > FormatDateTime('yyyy-mm-dd',dtpenddate.Date) then
      begin
         SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
         exit;
      end;
      if IncMonth(Trunc(dtpstartdate.Date),6)<= Trunc(dtpenddate.Date) then
      begin
         SysDialogs.Warning('ѡ������ڲ������,������ѡ��');
         exit;
       end;
//  end;
//      if(nvcbbticketsellway.GetCount =0 ) or(nvcbbticketsellway.Text='') then
//      begin
//          SysDialogs.ShowMessage('��ѡ����Ʊ��ʽ��');
//          exit;
//      end;
  if (cbbSellway.GetSelectID = '') then
  begin
      SysDialogs.ShowMessage('��ѡ����Ʊ��ʽ��');
      exit;
  end;

  with jcdsResult do
  begin
    Active := False;
//        Params.ParamValues['sellway'] :=nvcbbticketsellway.GetSelectCode;
    Params.ParamValues['sellway'] := cbbSellway.GetSelectID;  //��Ʊ��ʽ��Ϊ������ѡ��
    if rb1.Checked then
    begin
        Params.ParamValues['orgid']:= nvcbbOrgid.GetSelectID;
        Params.ParamValues['startdate'] := Formatdatetime('yyyy-mm-dd',dtpstartdate.Date)+' 00:00:00';
        FormatDateTime('yyyy-mm-dd',dtpstartdate.DateTime);
        Params.ParamValues['enddate'] :=  FormatDateTime('yyyy-mm-dd',dtpenddate.Date)+' 23:59:59';
        Params.ParamValues['orgordate']:='0';
        dbgrdhResult.Columns[0].Visible :=True ;
        dbgrdhResult.Columns[1].Visible :=False;
    end
    else
    begin
        dbgrdhResult.Columns[0].Visible :=False;
        dbgrdhResult.Columns[1].Visible :=True;
        Params.ParamValues['orgid']:= nvcbbOrgid.GetSelectID;
        Params.ParamValues['startdate'] := Formatdatetime('yyyy-mm-dd',dtpstartdate.Date)+' 00:00:00';
        FormatDateTime('yyyy-mm-dd',dtpstartdate.DateTime);
        Params.ParamValues['enddate'] :=  FormatDateTime('yyyy-mm-dd',dtpenddate.Date)+' 23:59:59';
        Params.ParamValues['orgordate']:='1';
    end;

    Active := True;

  end;
end;

end.

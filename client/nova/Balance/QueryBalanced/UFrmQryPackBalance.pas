unit UFrmQryPackBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit,Services, NovaComboBox,
  NovaHelp;

type
  TFrmQryPackBalance = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    NovaPackBalanceno: TNovaEdit;
    NovaArriverStartdate: TDateTimePicker;
    NovaArriverEnddate: TDateTimePicker;
    NvPackbalanceStatus: TNovaCheckedComboBox;
    Label5: TLabel;
    novabalancetype: TNovaComboBox;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    NvDbgridEh1: TNvDbgridEh;
    ds: TDataSource;
    jcdsdetail: TjsonClientDataSet;
    Label7: TLabel;
    NovaHelpUnit: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    //procedure nvarrivercheckClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure qryDetails(id: Largeint);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryPackBalance: TFrmQryPackBalance;

implementation
uses SystemInstance, SysInfoIntf, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmQryPackBalance.FormCreate(Sender: TObject);
begin
  inherited;
  NvPackbalanceStatus.Active := False;
  NvPackbalanceStatus.Active := True;
  NovaArriverStartdate.Date := Now;
  NovaArriverEnddate.Date := Now;
  novabalancetype.ItemIndex := 0 ;
  NovaPackBalanceno.SetFocus;
end;

//procedure TFrmQryPackBalance.nvarrivercheckClick(Sender: TObject);
//begin
//  inherited;
//  if nvarrivercheck.Checked then
//  begin
//    nvdepartinvoicecheck.Checked:= False;
//    NvPackbalanceStatus.Active := False;
//    NvPackbalanceStatus.Params.ParamValues['tablename'] := 'packarriver';
//    NvPackbalanceStatus.Active := True;
//    TabSheet2.Visible := False;
//  end;
//end;

procedure TFrmQryPackBalance.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if jcdsResult.RecordCount = 0 then
  Exit;
  qryDetails(jcdsResult.FieldByName('id').AsLargeInt);
end;

procedure TFrmQryPackBalance.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
     Active := False;
     Params.ParamValues['senddepartdate'] := FormatDateTime('yyyy-mm-dd', NovaArriverStartdate.Date);
     Params.ParamValues['sendenddate'] := FormatDateTime('yyyy-mm-dd', NovaArriverEnddate.Date+0.99999);
     Params.ParamValues['status'] := NvPackbalanceStatus.GetSelectID;
     Params.ParamValues['unitname'] := NovaHelpUnit.text;
     Params.ParamValues['packbalanceno'] := NovaPackBalanceno.Text;
     if novabalancetype.Text = '全部' then
      Params.ParamValues['datatype'] := ''
     else if novabalancetype.Text = '出库结算' then
      Params.ParamValues['datatype'] := 0
     else
      Params.ParamValues['datatype'] := 1;
     Active := True;
  end;
end;

procedure TFrmQryPackBalance.tbtnInsertClick(Sender: TObject);
var
  paid : Largeint;
  nResult : Integer;
  sResult : string;
begin
  inherited;
  if jcdsResult.RecordCount=0 then
  Exit;
  if not jcdsResult.Active then
  Exit;
  if not SysDialogs.Confirm('信息提示', '确认要注销该记录吗!') then
  Exit;
  paid := jcdsResult.FieldByName('id').AsLargeInt;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['packbalanceid'] := paid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      tbtnFilterClick(Sender);
    except
       on E: exception do
        begin
          SysLog.WriteErr(E.Message);
        end;
    end;

  end;

end;

procedure TFrmQryPackBalance.qryDetails(id: Int64);
begin
  with jcdsdetail do
  begin
    Active := False;
    Params.ParamValues['packbalanceid'] := id;
    Active := True;
  end;
end;
end.

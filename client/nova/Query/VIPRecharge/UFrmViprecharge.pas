unit UFrmViprecharge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, FunctionItemIntf;

type
  TFrmVipRecharge = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvhlpcardno: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    functiontype : string;//功能参数：0、充值明细查询，1、查询充值人的充值记录
    vipcardno : string;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); override;

  end;

var
  FrmVipRecharge: TFrmVipRecharge;

implementation

{$R *.dfm}

constructor TFrmVipRecharge.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;
  checkpermission: boolean);
begin
  inherited;
  functiontype:=parameter.strings[0];
  if functiontype = '1' then
  begin
    vipcardno := parameter.Strings[1];
    tlbShortCut.Visible := False;
    pnlQuery.Visible := False;
  end;
end;

procedure TFrmVipRecharge.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
end;

procedure TFrmVipRecharge.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (Key=VK_ESCAPE) and (functiontype='1') then
  begin
    Self.Close;
  end;
end;

procedure TFrmVipRecharge.FormShow(Sender: TObject);
begin
  inherited;
  if functiontype='1' then
  begin
    WindowState:=wsNormal;
    with jcdsResult do
    begin
      Active := False;
        Params.ParamValues['filter_EQS_v!vipcardno'] := vipcardno;
      Active := True;
    end;
  end;
end;

procedure TFrmVipRecharge.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_vr!rechargetime'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime) + ' 00:00:01';
      Params.ParamValues['filter_LED_vr!rechargetime'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime) + ' 23:59:59';
      Params.ParamValues['filter_EQS_v!vipcardno'] := nvhlpcardno.Text;
    Active := True;
  end;
end;

end.

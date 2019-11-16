unit UFrmTicketturnoverRevenue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, NovaHComboBox, DBGridEhGrouping, NovaEdit, NovaHelp;

type
  TFrmTicketturnoverRevenue = class(TSimpleCRUDForm)
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl5: TLabel;
    cbbuser: TNovaCheckedComboBox;
    NovaBillType: TNovaHComboBox;
    Label1: TLabel;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvhlpseller: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketturnoverRevenue: TFrmTicketturnoverRevenue;

implementation

uses Services;
{$R *.dfm}

procedure TFrmTicketturnoverRevenue.FormCreate(Sender: TObject);
begin
  inherited;
  cbbuser.Active:=true;
  NovaBillType.Active:=true;
  dtpstartdate.DateTime:=Now();
  dtpenddate.DateTime:=Now();
end;

procedure TFrmTicketturnoverRevenue.tbtnCloseClick(Sender: TObject);
begin
    Self.Close;
end;

procedure TFrmTicketturnoverRevenue.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd',dtpstartdate.Date) > FormatDateTime('yyyymmdd',
     dtpenddate.Date) then
     begin
       SysDialogs.ShowMessage('开始日期不能大于结束日期!');
       exit;
     end;

    try
    with jcdsResult do
    begin
      Active := false;
      Params.ParamValues['filter_GED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);

      if cbbuser.Visible then
      begin
        if Trim(cbbuser.Text) <> '' then
          Params.ParamValues['filter_INS_tt!userid'] := cbbuser.GetSelectId
        else
          Params.ParamValues['filter_INS_tt!userid'] :='';
      end
      else
      begin
          Params.ParamValues['filter_INS_tt!userid'] := nvhlpseller.HelpFieldValue['id'];
      end;

      Params.ParamValues['billtypeid'] := NovaBillType.HelpFieldValue['id'];

      Active := true;
       dbgrdhResult.PrintInfo.Title:='日  营  收  单';
            dbgrdhResult.PrintInfo.PageTopRight :='('+NovaBillType.HelpFieldValue['name']+')               '+'票款日期:'+FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime)+' 至 '+FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
        dbgrdhResult.PrintInfo.PageFooterRight:='审核人:'+SysInfo.LoginUserInfo.UserName;

      //jcdsResult.AfterScroll := jcdsResultAfterScroll;
    end;
  except
    on E: exception do
    begin
      SysLog.WriteErr('处理失败：' + E.Message);
    end;
  end;
end;

end.

unit UFrmPackpaymentRevenue;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox,Services;

type
  TFrmPackpaymentRevenue = class(TSimpleCRUDForm)
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lblreason: TLabel;
    Cobdatafrom: TComboBox;
    Label1: TLabel;
    cbbuser: TNovaCheckedComboBox;
    procedure tbtnCloseClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure CobdatafromChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPackpaymentRevenue: TFrmPackpaymentRevenue;

implementation

{$R *.dfm}

procedure TFrmPackpaymentRevenue.CobdatafromChange(Sender: TObject);
begin
  inherited;
  tbtnFilterClick(sender);
end;

procedure TFrmPackpaymentRevenue.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  cbbuser.Active:=true;
  if Cobdatafrom.ItemIndex = 0 then  //发货
    begin
        dbgrdhResult.Columns.Items[3].Visible := true;
        dbgrdhResult.Columns.Items[4].Visible := true;
        dbgrdhResult.Columns.Items[5].Visible := false;
        dbgrdhResult.Columns.Items[6].Visible := false;
    end
    else
    begin
        if Cobdatafrom.ItemIndex = 1 then  //到货
        begin
            dbgrdhResult.Columns.Items[3].Visible := false;
            dbgrdhResult.Columns.Items[4].Visible := false;
            dbgrdhResult.Columns.Items[5].Visible := true;
            dbgrdhResult.Columns.Items[6].Visible := true;
        end;
    end;
end;

procedure TFrmPackpaymentRevenue.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmPackpaymentRevenue.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_GED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_tt!moneydate'] := FormatDateTime
        ('yyyy-mm-dd', dtpenddate.DateTime);
    if Trim(cbbuser.Text) <> '' then
        Params.ParamValues['filter_INS_tt!userid'] := cbbuser.GetSelectId
      else
        Params.ParamValues['filter_INS_tt!userid'] :='';
    if Cobdatafrom.ItemIndex >= 0 then
    begin
      Params.ParamValues['packdatafrom'] := Cobdatafrom.ItemIndex;
    end
    else
    begin
//      Params.ParamValues['packdatafrom'] := '5';
        SysDialogs.ShowMessage('请选择数据来源！');
      exit;
    end;

    if Cobdatafrom.ItemIndex = 0 then  //发货
    begin
        dbgrdhResult.Columns.Items[3].Visible := true;
        dbgrdhResult.Columns.Items[4].Visible := true;
        dbgrdhResult.Columns.Items[5].Visible := false;
        dbgrdhResult.Columns.Items[6].Visible := false;
    end
    else
      if Cobdatafrom.ItemIndex = 1 then  //到货
          begin
              dbgrdhResult.Columns.Items[3].Visible := false;
              dbgrdhResult.Columns.Items[4].Visible := false;
              dbgrdhResult.Columns.Items[5].Visible := true;
              dbgrdhResult.Columns.Items[6].Visible := true;
          end
      else
      begin
         dbgrdhResult.Columns.Items[3].Visible := false;
              dbgrdhResult.Columns.Items[4].Visible := false;
              dbgrdhResult.Columns.Items[5].Visible := true;
              dbgrdhResult.Columns.Items[6].Visible := true;
         dbgrdhResult.Columns[5].Title.caption := '小件营收|件数';
        dbgrdhResult.Columns[6].Title.caption := '小件营收|金额';
      end;




    Active := true;
  end;
end;

end.

unit UFrmTicketsellDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ComCtrls, DB,
  DBClient, jsonClientDataSet, NovaComboBox,Services, NovaHComboBox, NovaHelp,
  ImgList, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh;

type
  TFrmTicketsellDetail = class(TSimpleEditForm)
    lbl3: TLabel;
    mmoContent: TMemo;
    GroupBox1: TGroupBox;
    dbgrdhResult: TNvDbgridEh;
    jsonDetail: TjsonClientDataSet;
    DataSource1: TDataSource;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:Integer;createby,createtime:string;
    column1, column2, column3,returnticketno,ticketstatus,
    sellstartdatetime,sellenddatetime,depstartdate,dependdate,sellorgid : string;
    ischangeticket:boolean;
    sellerid,reportnum1: Int64;
  end;

var
  FrmTicketsellDetail: TFrmTicketsellDetail;

implementation

{$R *.dfm}



procedure TFrmTicketsellDetail.FormShow(Sender: TObject);
begin
  inherited;
  with jsonDetail do
  begin
  Active:=False;


   Params.ParamValues['column1']:= column1;
   Params.ParamValues['column2']:= column2;
   Params.ParamValues['column3']:= column3;
   Params.ParamValues['sellorgid']:= sellorgid;
    Params.ParamValues['sellerid']:= sellerid;
    Params.ParamValues['ticketstatus']:= ticketstatus;
    Params.ParamValues['returnticketno']  := returnticketno;
  Params.ParamValues['ischangeticket'] := ischangeticket;

    Params.ParamValues['reportnum'] := reportnum1;

    Params.ParamValues['sellstartdatetime'] := sellstartdatetime;;
    Params.ParamValues['sellenddatetime'] :=  sellenddatetime;
    Params.ParamValues['departstartdate'] := depstartdate;
    Params.ParamValues['departenddate'] := dependdate;
   //SysDialogs.ShowMessage(Params.ParamByName('cancel_returnTicketno').Value);
  //execute;
   Active:=true;
//  cancel_returnno := Params.ParamByName('cancel_returnTicketno').AsString;
  end;
end;

end.

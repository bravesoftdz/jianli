unit UFrmSchedulepeikeReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmSchedulepeikeReport = class(TSimpleCRUDForm)
    lbldate: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl2: TLabel;
    nvhlpschedule: TNovaHelp;
    jcdsCount: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    aa,cc:String;
    bb:integer;
  public
    { Public declarations }
  end;

var
  FrmSchedulepeikeReport: TFrmSchedulepeikeReport;

implementation
 uses Services,PubFn;
{$R *.dfm}

procedure TFrmSchedulepeikeReport.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date:=Now;
end;

procedure TFrmSchedulepeikeReport.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    if  (not (Trim(nvhlpSchedule.Text) = '')) and  (nvhlpSchedule.Id>0) then      //���
      begin
        Params.ParamValues['filter_LIKES_s!code']:= nvhlpSchedule.Text;
        Params.ParamValues['schedulecode']:= nvhlpSchedule.Text;
        dbgrdhResult.PrintInfo.Title:=FormatDateTime('yyyy-mm-dd', Now)+'  '+nvhlpSchedule.Text+FrmSchedulepeikeReport.Caption;
      end
    else
      begin
        SysDialogs.ShowMessage('��κŲ�����Ϊ��');
        exit;
      end;
    Params.ParamValues['filter_EQD_sp!departdate'] :=
                  FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['oldstartdepartdate'] :=
                  FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);

    Active := True;
  end;

  with jcdsCount do
  begin
      Active := False;
      Params.ParamValues['filter_LIKES_s!code']:= nvhlpSchedule.Text;
      Params.ParamValues['countschedulecode']:= nvhlpSchedule.Text;
      Params.ParamValues['filter_EQD_sp!departdate'] :=
                  FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['countdepartdate'] :=
                  FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Active := True;
      first;
      while not eof do
      begin

          aa:=jcdsCount.FieldValues['ticketoutcode'];
          bb:=jcdsCount.FieldValues['countticket'];
          if not ( (bb=0)  and (aa='������') )then
           begin
              if aa='������' then
               begin
                 cc:=cc+' '+aa+inttostr(bb)+'��';
               end
               else
               begin
                  cc:=cc+' '+aa+inttostr(bb)+'��';
               end;

           end;
        next;
      end;

      dbgrdhResult.PrintInfo.PageTopLeft :='��վ����Ʊ��' + cc;
      cc:='';

  end;


end;

end.

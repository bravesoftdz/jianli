unit UFrmTicketLossForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  Services,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaComboBox, NovaHComboBox;

type
  TFrmTicketLoss = class(TSimpleCRUDForm)
    nvhlpLossReporter: TNovaHelp;
    Label1: TLabel;
    lbl4: TLabel;
    lossdate: TDateTimePicker;
    Label2: TLabel;
    lossstatus: TNovaComboBox;
    jcdsCancelLoss: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketLoss: TFrmTicketLoss;

implementation

uses UFrmTicketLossAdd;

{$R *.dfm}

procedure TFrmTicketLoss.FormCreate(Sender: TObject);
begin
  inherited;
  lossdate.DateTime := Now();
  lossstatus.Active := true; ;
end;

procedure TFrmTicketLoss.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not SysDialogs.Confirm('提示', '确定要取消挂失此车票吗？') then
    begin
      Exit;
    end;
  if (jcdsResult.Active = true) and (jcdsResult.RecNo > 0) then
  begin
    try
      with jcdsCancelLoss do
      begin
         Active := false;
         Params.ParamValues['tl.id'] := jcdsResult.FieldByName('id').AsString;
         try
            Active := true;
         except on E: exception do
            SysDialogs.ShowMessage(E.tostring());
         end;
         tbtnFilter.Click;
         if Params.ParamValues['msg'] <> '' then
          begin
            SysDialogs.ShowMessage(Params.ParamValues['msg']);
          end;
          if Params.ParamValues['flag'] = 1 then
          begin
            tbtnFilter.Click;
          end;
      end;

    except on E: exception do
      SysDialogs.ShowMessage(E.ToString);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要取消挂失的记录！');
  end;
end;

procedure TFrmTicketLoss.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    try
      Active := false;
      Params.ParamValues['tl.lossby'] := nvhlpLossReporter.Id;
      Params.ParamValues['tl.losstime'] := FormatDateTime
        ('yyyy-mm-dd', lossdate.DateTime);
      Params.ParamValues['tl.status'] := lossstatus.GetSelectCode;
      Active := true;
    except
      on E: exception do
        SysDialogs.ShowMessage(E.tostring());
    end;
  end;
end;

procedure TFrmTicketLoss.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmTicketLossAdd := TFrmTicketLossAdd.Create(self);
  try
    with FrmTicketLossAdd do
    begin
      if SysMainForm.showFormModal(FrmTicketLossAdd, false) = mrOk then
      begin
      tbtnFilter.Click;
      end;
    end;
  finally
    FreeAndNil(FrmTicketLossAdd);
  end;
end;

end.

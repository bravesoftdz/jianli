unit UFrmCheckticketInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, DB, DBClient, jsonClientDataSet, GridsEh, DBGridEh,
  NvDbgridEh, NovaEdit;

type
  TFrmCheckticketInfo = class(TSimpleEditForm)
    lbl1: TLabel;
    NovaEdtRoute: TNovaEdit;
    NovaEdtCode: TNovaEdit;
    lbl2: TLabel;
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    ds1: TDataSource;
    jscdqueryCheckedticket: TjsonClientDataSet;
    chkChecked: TCheckBox;
    chkNotChecked: TCheckBox;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure chkCheckedClick(Sender: TObject);
    procedure chkNotCheckedClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure qryTicketinfo();
  public
    { Public declarations }
    scheduleplanid, vehiclereportid: Int64;
    isworkline,isshowticketnos: boolean;
  end;

var
  FrmCheckticketInfo: TFrmCheckticketInfo;

implementation

uses PubFn, Services, UDMPublic,UFrmNoTicketCheck;
{$R *.dfm}

procedure TFrmCheckticketInfo.bbtnSaveClick(Sender: TObject);
var
  ticketids:String;
  ticketnum:integer;
begin
  inherited;
  if not jscdqueryCheckedticket.Active then exit;
  if jscdqueryCheckedticket.RecordCount=0 then exit;
  ticketids:='';
  ticketnum:=0;
  with jscdqueryCheckedticket do
  begin
    DisableControls;
    first;
    while not eof do
    begin
      if (not jscdqueryCheckedticket.FieldByName('ischecked').AsBoolean)
         and (jscdqueryCheckedticket.FieldByName('selected').AsBoolean) then
      begin
         ticketids:=ticketids+','+jscdqueryCheckedticket.FieldByName('id').AsString;
         ticketnum:=ticketnum+1;
      end;
      next;
    end;
    EnableControls;
  end;
  if ticketnum=0 then
     exit;
  FrmNoTicketCheck := TFrmNoTicketCheck.Create(self);
  with FrmNoTicketCheck do
  begin
    Caption := '无票根检票信息';
    curscheduleplanid:=scheduleplanid;
    curticketids:= ticketids;
    NovaEdtTickets.Text:=inttostr(ticketnum);
    if SysMainForm.showFormModal(FrmNoTicketCheck, false) = mrok then
    begin
       qryTicketinfo();
    end;
  end;

end;

procedure TFrmCheckticketInfo.chkCheckedClick(Sender: TObject);
begin
  inherited;
  qryTicketinfo;
end;

procedure TFrmCheckticketInfo.chkNotCheckedClick(Sender: TObject);
begin
  inherited;
  qryTicketinfo;
end;

procedure TFrmCheckticketInfo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key = VK_F2 then
  begin
    if chkChecked.Checked then
    begin
      chkChecked.Checked := False;
    end
    else
      chkChecked.Checked := true;
    chkCheckedClick(Sender);
  end
  else if (chkNotChecked.Visible) and  (Key = VK_F3) then
  begin

    if chkNotChecked.Checked then
    begin
      chkNotChecked.Checked := False;
    end
    else
      chkNotChecked.Checked := true;
    chkNotCheckedClick(Sender);
  end;

  if (Key = vk_escape) then
    Close;
end;

procedure TFrmCheckticketInfo.FormShow(Sender: TObject);
var 
  i:Integer;
begin
  inherited;
  if isshowticketnos  then
  begin    //防止列顺序改变隐藏错误的列
    for i:=0 to nvdbgrdh1.Columns.Count-1 do
    if nvdbgrdh1.Columns[i].FieldName='ticketno' then nvdbgrdh1.Columns[i].Visible:=True;
//       nvdbgrdh1.Columns[1].Visible := True;
  end
  else
  begin
    for i:=0 to nvdbgrdh1.Columns.Count-1 do
    if nvdbgrdh1.Columns[i].FieldName='ticketno' then nvdbgrdh1.Columns[i].Visible:=False;
//       nvdbgrdh1.Columns[1].Visible := false;
  end;

  qryTicketinfo;
end;

procedure TFrmCheckticketInfo.qryTicketinfo();
begin
  with jscdqueryCheckedticket do
  begin
    Active := False;
    if isworkline then
    begin
      Params.ParamValues['filter_EQL_t!scheduleplanid'] := scheduleplanid;
      if self.chkChecked.Checked then
      begin
        Params.ParamValues['filter_EQB_t!ischecked'] := true;
        Params.ParamValues['filter_EQL_t!vehiclereportid'] := vehiclereportid;
      end
      else if  (chkNotChecked.Visible)  then
      begin
        Params.ParamValues['filter_EQB_t!ischecked'] := False;
        Params.ParamValues['filter_EQL_t!vehiclereportid'] := null;
      end
      else
      begin
        Params.ParamValues['filter_EQB_t!ischecked'] := true;
      end;
    end
    else
    begin
      Params.ParamValues['filter_EQL_t!vehiclereportid'] := null;
      Params.ParamValues['filter_EQL_t!scheduleplanid'] := scheduleplanid;
      if ((self.chkChecked.Checked) and (chkNotChecked.Visible)  and (not self.chkNotChecked.Checked)) then
        Params.ParamValues['filter_EQB_t!ischecked'] := true
      else if ((not self.chkChecked.Checked) and  (chkNotChecked.Visible)  and  (self.chkNotChecked.Checked))
        then
        Params.ParamValues['filter_EQB_t!ischecked'] := False
      else  if ((self.chkChecked.Checked) and  (chkNotChecked.Visible)  and  (self.chkNotChecked.Checked)) then
        Params.ParamValues['filter_EQB_t!ischecked'] := null
      else
         Params.ParamValues['filter_EQB_t!ischecked'] := true
        //Params.ParamValues['filter_EQB_t!ischecked'] := null;
    end;

    Active := true;
  end;
end;

end.

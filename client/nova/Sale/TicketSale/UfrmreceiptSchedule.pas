unit UfrmreceiptSchedule;

interface

uses
  Windows, Messages, SysUtils,Services, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB, DBClient,StdCtrls,Spin,StrUtils;

type
  TfrmreceiptSchedule = class(TFrame)
    dsTicketBuffer: TDataSource;
    nvdbgrdhticketbuffer: TNvDbgridEh;
    dsreceipschedule: TClientDataSet;
    dsreceipscheduledepartdate: TDateField;
    dsreceipscheduledeparttime: TStringField;
    dsreceipscheduleschedulecode: TStringField;
    dsreceipscheduledepartstationname: TStringField;
    dsreceipschedulereachstationname: TStringField;
    dsreceipscheduleprice: TCurrencyField;
    dsreceipscheduleticketnum: TStringField;
    dsreceipscheduletickettype: TStringField;
    dsreceipscheduletickettypename: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
    procedure setSchedule(curschedule:TDataSet;buffschedule:TDataSet;gbamount: TGroupBox;strsellway: string);
  end;

implementation

{$R *.dfm}

constructor TfrmreceiptSchedule.Create(AOwner: TComponent);
begin
  inherited;
//  nvdbgrdhticketbuffer.DataSource:=dsTicketBuffer;
end;

procedure TfrmreceiptSchedule.setSchedule(curschedule,
  buffschedule: TDataSet;gbamount: TGroupBox;strsellway: string);
var
  bookmark: TBookmark;
  j,result: Integer;
begin
  try
  dsreceipschedule.Close;
  dsreceipschedule.CreateDataSet;
  dsreceipschedule.Open;
  except
      on E: Exception do
        SysLog.WriteErr(E.Message);
    end;
//  dsreceipschedule.EmptyDataSet;

  if (buffschedule<>nil) and buffschedule.Active then
  begin
    buffschedule.DisableControls;
    bookmark:=buffschedule.GetBookmark;

    buffschedule.First;
    while not buffschedule.Eof do
    begin

      if dsreceipschedule.RecordCount>0 then
           begin
            result := 0;
            dsreceipschedule.First;
            while not dsreceipschedule.Eof do
            begin
               if (buffschedule.FieldValues['departdate'] = dsreceipschedule.FieldValues['departdate'])
                  and (buffschedule.FieldValues['schedulecode'] = dsreceipschedule.FieldValues['schedulecode'])
                  and (buffschedule.FieldValues['reachstationname'] = dsreceipschedule.FieldValues['reachstationname'])
                  and (buffschedule.FieldValues['tickettype'] = dsreceipschedule.FieldValues['tickettype']) then
               begin
                  result := 1;
                  Break;
               end;
              dsreceipschedule.Next;
            end;
            if result = 1 then
            begin
                  dsreceipschedule.Edit;
                  dsreceipschedule.FieldValues['ticketnum']:=dsreceipschedule.FieldValues['ticketnum'] + 1;
                  dsreceipschedule.Post;
            end
            else
            begin
                  dsreceipschedule.Append;
                  dsreceipschedule.FieldValues['departdate']:=buffschedule.FieldValues['departdate'];
                  dsreceipschedule.FieldValues['departtime']:=buffschedule.FieldValues['departtime'];
                  dsreceipschedule.FieldValues['schedulecode']:=buffschedule.FieldValues['schedulecode'];
                  dsreceipschedule.FieldValues['departstationname']:=buffschedule.FieldValues['departstationname'];
                  dsreceipschedule.FieldValues['reachstationname']:=buffschedule.FieldValues['reachstationname'];
                  dsreceipschedule.FieldValues['price']:=buffschedule.FieldValues['price'];
                  dsreceipschedule.FieldValues['tickettype']:=buffschedule.FieldValues['tickettype'];
                  dsreceipschedule.FieldValues['tickettypename']:=buffschedule.FieldValues['tickettypeprintname'] + '票';
                  if buffschedule.FieldValues['tickettype']='X' then
                  begin
                     dsreceipschedule.FieldValues['tickettypename']:=buffschedule.FieldValues['tickettypeprintname']+'生票';
                  end;

                  dsreceipschedule.FieldValues['ticketnum']:=1;
                  dsreceipschedule.Post;
            end;
           end
           else
           begin
                  dsreceipschedule.Append;
                  dsreceipschedule.FieldValues['departdate']:=buffschedule.FieldValues['departdate'];
                  dsreceipschedule.FieldValues['departtime']:=buffschedule.FieldValues['departtime'];
                  dsreceipschedule.FieldValues['schedulecode']:=buffschedule.FieldValues['schedulecode'];
                  dsreceipschedule.FieldValues['departstationname']:=buffschedule.FieldValues['departstationname'];
                  dsreceipschedule.FieldValues['reachstationname']:=buffschedule.FieldValues['reachstationname'];

                  dsreceipschedule.FieldValues['price']:=buffschedule.FieldValues['price'];
                  dsreceipschedule.FieldValues['tickettype']:=buffschedule.FieldValues['tickettype'];
                  dsreceipschedule.FieldValues['tickettypename']:=buffschedule.FieldValues['tickettypeprintname'] + '票';
                  if buffschedule.FieldValues['tickettype']='X' then
                  begin
                     dsreceipschedule.FieldValues['tickettypename']:=buffschedule.FieldValues['tickettypeprintname']+'生票';
                  end;

                  dsreceipschedule.FieldValues['ticketnum']:=1;
                  dsreceipschedule.Post;
           end;
      buffschedule.Next;
    end;
    buffschedule.GotoBookmark(bookmark);
    buffschedule.EnableControls;
  end;
  if (curschedule<>nil) and curschedule.Active then
  begin
    if strsellway='6' then //订票销售
    begin
       curschedule.First;
       while not curschedule.Eof do
       begin
         if curschedule.FieldValues['sellstate']='R' then  //留票
         begin
           if dsreceipschedule.RecordCount>0 then
           begin
            result := 0;
            dsreceipschedule.First;
            while not dsreceipschedule.Eof do
            begin
               if (curschedule.FieldValues['departdate'] = dsreceipschedule.FieldValues['departdate'])
                  and (curschedule.FieldValues['schedulecode'] = dsreceipschedule.FieldValues['schedulecode'])
                  and (curschedule.FieldValues['reachstationname'] = dsreceipschedule.FieldValues['reachstationname'])
                  and (curschedule.FieldValues['tickettype'] = dsreceipschedule.FieldValues['tickettype']) then
               begin
                  result := 1;
                  Break;
               end;
              dsreceipschedule.Next;
            end;
            if result = 1 then
            begin
                  dsreceipschedule.Edit;
                  dsreceipschedule.FieldValues['ticketnum']:=dsreceipschedule.FieldValues['ticketnum'] + 1;
                  dsreceipschedule.Post;
            end
            else
            begin
                  dsreceipschedule.Append;
                  dsreceipschedule.FieldValues['departdate']:=curschedule.FieldValues['departdate'];
                  dsreceipschedule.FieldValues['departtime']:=curschedule.FieldValues['departtime'];
                  dsreceipschedule.FieldValues['schedulecode']:=curschedule.FieldValues['schedulecode'];
                  dsreceipschedule.FieldValues['departstationname']:=curschedule.FieldValues['departstationname'];
                  dsreceipschedule.FieldValues['reachstationname']:=curschedule.FieldValues['reachstationname'];
                  dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                  dsreceipschedule.FieldValues['tickettype']:=curschedule.FieldValues['tickettype'];
                  dsreceipschedule.FieldValues['tickettypename']:='全票';
                  if curschedule.FieldValues['tickettype']='B' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['halfprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='半票';
                  end;
                  if curschedule.FieldValues['tickettype']='X' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['studentprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='学生票';
                  end;
                  if curschedule.FieldValues['tickettype']='Z' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='打折票';
                  end;
                  if curschedule.FieldValues['tickettype']='T' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='团体票';
                  end;
                  dsreceipschedule.FieldValues['ticketnum']:=1;
                  dsreceipschedule.Post;
            end;
           end
           else
           begin
                  dsreceipschedule.Append;
                  dsreceipschedule.FieldValues['departdate']:=curschedule.FieldValues['departdate'];
                  dsreceipschedule.FieldValues['departtime']:=curschedule.FieldValues['departtime'];
                  dsreceipschedule.FieldValues['schedulecode']:=curschedule.FieldValues['schedulecode'];
                  dsreceipschedule.FieldValues['departstationname']:=curschedule.FieldValues['departstationname'];
                  dsreceipschedule.FieldValues['reachstationname']:=curschedule.FieldValues['reachstationname'];

                  dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                  dsreceipschedule.FieldValues['tickettype']:=curschedule.FieldValues['tickettype'];
                  dsreceipschedule.FieldValues['tickettypename']:='全票';

                  if curschedule.FieldValues['tickettype']='B' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['halfprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='半票';
                  end;
                  if curschedule.FieldValues['tickettype']='X' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['studentprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='学生票';
                  end;
                  if curschedule.FieldValues['tickettype']='Z' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='打折票';
                  end;
                  if curschedule.FieldValues['tickettype']='T' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='团体票';
                  end;

                  dsreceipschedule.FieldValues['ticketnum']:=1;
                  dsreceipschedule.Post;
           end;
         end;
         curschedule.Next;
       end;
    end
    else
    begin
    for j := 0 to gbamount.ControlCount - 1 do
    begin
      if (gbamount.Controls[j] is TSpinEdit) then
      begin
//        if (rightstr(gbamount.Controls[j].Name, 1) = 'Q') and
        if (gbamount.Controls[j] as TSpinEdit).Value > 0 then
        begin
           if dsreceipschedule.RecordCount>0 then
           begin
            result := 0;
            dsreceipschedule.First;
            while not dsreceipschedule.Eof do
            begin
               if (curschedule.FieldValues['departdate'] = dsreceipschedule.FieldValues['departdate'])
                  and (curschedule.FieldValues['schedulecode'] = dsreceipschedule.FieldValues['schedulecode'])
                  and (curschedule.FieldValues['reachstationname'] = dsreceipschedule.FieldValues['reachstationname'])
                  and (rightstr(gbamount.Controls[j].Name, 1) = dsreceipschedule.FieldValues['tickettype']) then
               begin
                  result := 1;
                  Break;
               end;
              dsreceipschedule.Next;
            end;
            if result = 1 then
            begin
                  dsreceipschedule.Edit;
                  dsreceipschedule.FieldValues['ticketnum']:=dsreceipschedule.FieldValues['ticketnum'] + (gbamount.Controls[j] as TSpinEdit).Value;
                  dsreceipschedule.Post;
            end
            else
            begin
                  dsreceipschedule.Append;
                  dsreceipschedule.FieldValues['departdate']:=curschedule.FieldValues['departdate'];
                  dsreceipschedule.FieldValues['departtime']:=curschedule.FieldValues['departtime'];
                  dsreceipschedule.FieldValues['schedulecode']:=curschedule.FieldValues['schedulecode'];
                  dsreceipschedule.FieldValues['departstationname']:=curschedule.FieldValues['departstationname'];
                  dsreceipschedule.FieldValues['reachstationname']:=curschedule.FieldValues['reachstationname'];
                  dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                  dsreceipschedule.FieldValues['tickettype']:=rightstr(gbamount.Controls[j].Name, 1);
                  dsreceipschedule.FieldValues['tickettypename']:='全票';

                  if rightstr(gbamount.Controls[j].Name, 1)='B' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['halfprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='半票';
                  end;
                  if rightstr(gbamount.Controls[j].Name, 1)='X' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['studentprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='学生票';
                  end;
                  if rightstr(gbamount.Controls[j].Name, 1)='Z' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='打折票';
                  end;
                  if rightstr(gbamount.Controls[j].Name, 1)='T' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='团体票';
                  end;
                  dsreceipschedule.FieldValues['ticketnum']:=(gbamount.Controls[j] as TSpinEdit).Value;
                  dsreceipschedule.Post;
            end;
           end
           else
           begin
                  dsreceipschedule.Append;
                  dsreceipschedule.FieldValues['departdate']:=curschedule.FieldValues['departdate'];
                  dsreceipschedule.FieldValues['departtime']:=curschedule.FieldValues['departtime'];
                  dsreceipschedule.FieldValues['schedulecode']:=curschedule.FieldValues['schedulecode'];
                  dsreceipschedule.FieldValues['departstationname']:=curschedule.FieldValues['departstationname'];
                  dsreceipschedule.FieldValues['reachstationname']:=curschedule.FieldValues['reachstationname'];

                  dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                  dsreceipschedule.FieldValues['tickettype']:=rightstr(gbamount.Controls[j].Name, 1);
                  dsreceipschedule.FieldValues['tickettypename']:='全票';

                  if rightstr(gbamount.Controls[j].Name, 1)='B' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['halfprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='半票';
                  end;
                  if rightstr(gbamount.Controls[j].Name, 1)='X' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['studentprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='学生票';
                  end;
                  if rightstr(gbamount.Controls[j].Name, 1)='Z' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='打折票';
                  end;
                  if rightstr(gbamount.Controls[j].Name, 1)='T' then
                  begin
                     dsreceipschedule.FieldValues['price']:=curschedule.FieldValues['fullprice'];
                     dsreceipschedule.FieldValues['tickettypename']:='团体票';
                  end;

                  dsreceipschedule.FieldValues['ticketnum']:=(gbamount.Controls[j] as TSpinEdit).Value;
                  dsreceipschedule.Post;
           end;
        end;
      end;
    end;
    end;

  end;
//  dsreceipschedule.ReadOnly:=true;
end;

end.

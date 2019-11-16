unit UFrmVipturnover;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmVipturnover = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl5: TLabel;
    nvhlpuserid: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    hasselect:boolean;
    sellername : string;
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmVipturnover: TFrmVipturnover;

implementation

uses Services, PubFn, UFrmVipturnoverEdit, UFrmVipTurnoverprint;
{$R *.dfm}

procedure TFrmVipturnover.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
end;

procedure TFrmVipturnover.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{56B70C97-D288-4C7B-96B5-40DBD5368439}' then //查询其它售票员的应缴款
  begin
    nvhlpuserid.Enabled:=aEnable;
    if not aEnable then
    begin
      nvhlpuserid.Text:=SysInfo.LoginUserInfo.UserName;
      nvhlpuserid.Id:=SysInfo.LoginUserInfo.UserID;
    end;
  end
end;

procedure TFrmVipturnover.tbtnEditClick(Sender: TObject);
begin
  inherited;
  with FrmVipTurnoverprint do
  begin
    FrmVipTurnoverprint := TFrmVipTurnoverprint.Create(Self);
    Caption := '重打VIP缴款单';
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Self);
    end;
  end;
end;

procedure TFrmVipturnover.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['startdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime) + ' 00:00:00';
      Params.ParamValues['enddate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime)+ ' 23:59:59';
      if Trim(nvhlpuserid.Text) = '' then
        Params.ParamValues['userid'] := ''
      else
        Params.ParamValues['userid'] := nvhlpuserid.Id;
    Active := True;
  end;
end;

procedure TFrmVipturnover.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmVipturnoverEdit do
  begin
    FrmVipturnoverEdit := TFrmVipturnoverEdit.Create(Self);
    Caption := 'VIP缴款';
    if not dsResult.DataSet.Active then
      Exit;
    if dsResult.DataSet.RecordCount < 1 then
      Exit;
    with jcdsResult do
    begin
      try
      DisableControls;
      First;
      while not eof do
      begin
        if FieldByName('choose').AsBoolean then
        begin
          hasselect:=true;
          if sellername <> '' then
          begin
            if sellername <> FieldByName('name').AsString then
            begin
              SysDialogs.ShowMessage('你选择的不是同一个人的售票记录！');
              sellername := '';
              tbtnFilterClick(Self);
              Locate('sellid',FieldByName('sellid').AsString,[] );
              if not (State in [dsEdit,dsInsert]) then
              begin
                Edit;
              end;
              Exit;
            end;
          end
          else
          begin
            Caption := Caption + '('+FieldByName('name').AsString+')';
          end;
          if moneydate='' then
            moneydate:=FieldByName('moneydate').AsString
          else
            moneydate:=moneydate+','+FieldByName('moneydate').AsString;
          sellername := FieldByName('name').AsString;
          rechargenum := rechargenum + FieldByName('rechargenum').AsLargeInt;
          returnnum := returnnum + FieldByName('returnnum').AsLargeInt;
          issuenum := issuenum + FieldByName('issuenum').AsLargeInt;

          rechargemoney := rechargemoney + FieldByName('rechargemoney').AsCurrency;
          returnmoney := returnmoney + FieldByName('returnmoney').AsCurrency;
          returnhandcharge := returnhandcharge + FieldByName('cardcose').AsCurrency;
          issuemoney := issuemoney + FieldByName('issuemoney').AsCurrency;
          userid := FieldByName('sellid').AsInteger;
        end;
        Next;
      end;
      finally
        EnableControls;
      end;
    end;
    edtsellnum.Text := IntToStr(rechargenum);
    edtreturnnum.Text := IntToStr(returnnum);
    edtsellmoney.Text := CurrToStr(rechargemoney);
    edtreturnmoney.Text := CurrToStr(returnmoney);
    edtreturnhandcharge.Text := CurrToStr(returnhandcharge);
    edtcardcose.Text := CurrToStr(issuemoney);
    edtcardnum.Text := IntToStr(issuenum);
    moneypayable := rechargemoney + issuemoney - returnhandcharge - returnmoney;
    edtmoneypayable.Text := CurrToStr(moneypayable);
    edtpayable.Text := CurrToStr(moneypayable);
    startdate := dtpstartdate.DateTime;
    enddate := dtpenddate.DateTime;
    ShowModal;
    if ModalResult = mrOk then
    begin
      sellername := '';
      tbtnFilterClick(Self);
    end;
  end;
  
end;

end.

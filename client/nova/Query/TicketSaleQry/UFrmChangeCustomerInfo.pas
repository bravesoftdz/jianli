unit UFrmChangeCustomerInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB,
  DBClient, jsonClientDataSet,UIDCardReader;

type
  TFrmChangeCustomerInfo = class(TSimpleEditForm,IIDCardfound)
    nvedtName: TNovaEdit;
    lbl1: TLabel;
    nvedtIDcard: TNovaEdit;
    lbl14: TLabel;
    NovaDepartdate: TNovaEdit;
    Label1: TLabel;
    NovaDeparttime: TNovaEdit;
    Label2: TLabel;
    NovaSeatno: TNovaEdit;
    Label3: TLabel;
    NovaSelltime: TNovaEdit;
    Label4: TLabel;
    NovaResearchStation: TNovaEdit;
    Label5: TLabel;
    NovaSchCode: TNovaEdit;
    Label6: TLabel;
    jcdsSaveCustomerinfo: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  curidcard: TIDCard;
  procedure cardfound(idcard: TIDCard);
    { Private declarations }
  public
    customerid : Int64;
    ticketno : string;
    { Public declarations }
  end;

var
  FrmChangeCustomerInfo: TFrmChangeCustomerInfo;

implementation
uses UDMPublic,Services,PubFn;
{$R *.dfm}

procedure TFrmChangeCustomerInfo.bbtnSaveClick(Sender: TObject);
var
  msg,certificateno: String;
  nResult: Integer;
  sResult, log, optype: String;
begin
  inherited;
  if Trim(nvedtIDcard.Text)='' then
  begin
    SysDialogs.Warning('请填写身份证号!');
    Exit;
  end;
  if Trim(nvedtName.Text)='' then
  begin
    SysDialogs.Warning('请填写乘车人姓名!');
    Exit;
  end;
  if not (ValidatePID(nvedtIDcard.Text) ='') then
  begin
    SysDialogs.Warning(ValidatePID(nvedtIDcard.Text));
    nvedtIDcard.SetFocus;
    exit;
  end;
  certificateno := Trim(nvedtIDcard.Text);
  with jcdsSaveCustomerinfo do
  begin
    Active := False;
    Params.ParamValues['customerid'] := customerid;
    Params.ParamValues['certificateno'] := certificateno;
    Params.ParamValues['customername'] := nvedtName.Text;
    Params.ParamValues['ticketno'] := ticketno;
    if trim(ValidatePID(trim(nvedtIDcard.Text))) = '' then
    begin
      if length(certificateno) = 15 then
      begin
        Params.ParamValues['birthday'] := EncodeDate
          (strtoint('19' + copy(certificateno, 7, 2)),
          strtoint(copy(certificateno, 9, 2)),
          strtoint(copy(certificateno, 11, 2)));
        if odd(strtoint(copy(certificateno, 15, 1))) then
          Params.ParamValues['sex'] := '男'
        else
          Params.ParamValues['sex'] := '女';
      end
      else if length(certificateno) = 18 then
      begin
        Params.ParamValues['birthday'] := EncodeDate
          (strtoint(copy(certificateno, 7, 4)),
          strtoint(copy(certificateno, 11, 2)),
          strtoint(copy(certificateno, 13, 2)));
        if odd(strtoint(copy(certificateno, 17, 1))) then
          Params.ParamValues['sex'] := '男'
        else
          Params.ParamValues['sex'] := '女';
      end;
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      ModalResult := mrok;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('修改失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmChangeCustomerInfo.FormCreate(Sender: TObject);
begin
  inherited;
  TIDCardReader.GetInstance.addObserver(Self,False,True);
end;

procedure TFrmChangeCustomerInfo.FormDestroy(Sender: TObject);
begin
  inherited;
 try
    TIDCardReader.GetInstance.removeObserver(Self);
 except
 end;
end;

procedure TFrmChangeCustomerInfo.cardfound(idcard: TIDCard);
begin
  curidcard:=idcard;
  try
    if curidcard<>nil then
    begin
      nvedtName.Text:=curidcard.Name;  //姓名
      nvedtIDcard.Text:=curidcard.ID;           //身份证号码
    end;
  except

  end;
end;

end.

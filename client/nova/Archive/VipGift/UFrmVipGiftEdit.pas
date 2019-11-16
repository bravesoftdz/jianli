unit UFrmVipGiftEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox, DBGridEhGrouping, Menus, GridsEh,
  DBGridEh, NvDbgridEh;

type
  TfrmVipGiftEdit = class(TSimpleEditForm)
    jcdsSave: TjsonClientDataSet;
    lbl1: TLabel;
    nvedtName: TNovaEdit;
    lbl14: TLabel;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl5: TLabel;
    mmoRemark: TMemo;
    lbl2: TLabel;
    dtpenddate: TDateTimePicker;
    lbl10: TLabel;
    lbl8: TLabel;
    edtValuation: TNovaEdit;
    nvdbgrdh1: TNvDbgridEh;
    il1: TImageList;
    ds1: TDataSource;
    jcds1: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
   isedit,isontime:boolean;
   id:integer;
   createby,createtime,names,valuation, mount,quantity,
   types,remarks,startdate,enddate,oldvipgradename,oldamount: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmVipGiftEdit: TfrmVipGiftEdit;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmVipGiftEdit.FormCreate(Sender: TObject);
begin
  inherited;
//  jcds1.Active :=False;
//
//
//  jcds1.Active := True;
//
//   dtpstartdate.Date:= Now;
//   dtpenddate.Date:=Now;
end;

procedure TfrmVipGiftEdit.FormShow(Sender: TObject);
begin
  inherited;
  jcds1.Active :=False;
    jcds1.Params.ParamByName('vipgiftid').Value :=id;
  jcds1.Active := True;
   if id <=0 then
   begin
    dtpstartdate.Date:= Now;
    dtpenddate.Date:=Now;
   end;

end;

procedure TfrmVipGiftEdit.bbtnSaveClick(Sender: TObject);
 var  msg,amount,vipgrade,vipgradename: String;
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
   if Trim(nvedtName.Text) ='' then
  begin
    SysDialogs.ShowMessage('��Ʒ���Ʋ���Ϊ�գ�');
    nvedtName.SetFocus;
    exit;
  end;

  if Trim(edtValuation.Text)='' then
  begin
    SysDialogs.ShowMessage('��������Ʒ��ֵ!');
    edtValuation.SetFocus;
    Exit;
  end;

  amount := '';
  vipgrade :='';
  with jcds1 do
  begin
    if Active and (recordcount > 0) then
    begin
      DisableControls;
      First;
      while (not eof) do
      begin
        if FieldByName('ischecked').AsBoolean then
        begin
          amount := amount + FieldByName('needamount').AsString + ',';
          vipgrade := vipgrade + FieldByName('vipgrade').AsString + ',';
          vipgradename := vipgradename + FieldByName('gradename').AsString + ',';
        end  ;
        Next;
      end;
      EnableControls;
    end;
  end;

   if vipgradename = '' then
  begin
    SysDialogs.ShowMessage('��ѡ��ɲ��뿨����!');
    nvdbgrdh1.SetFocus;
    exit;
  end;

   if (FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) )then
  begin
    SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  with jcdsSave do
  begin
   try
    close;
     Params.ParamByName('vipgift.id').Value := id;
     if id=0 then
        Params.ParamByName('vipgift.quantity').Value := '0'
     else
        Params.ParamByName('vipgift.quantity').Value := quantity;

    Params.ParamByName('vipgift.createtime').Value := createtime;
    Params.ParamByName('vipgift.createby').Value := createby;
    Params.ParamByName('vipgift.name').Value := nvedtName.Text;
    Params.ParamByName('vipgift.valuation').Value := edtValuation.Text;
    Params.ParamByName('vipgift.startdate').Value
    := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamByName('vipgift.enddate').Value
    := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Params.ParamByName('vipgrade').Value :=vipgrade;//nvcbbvipgrade.GetSelectID;
    Params.ParamByName('vipgift.remarks').Value :=  mmoRemark.Text;

     Params.ParamByName('amount').Value := amount;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvedtName.SetFocus;
      end
      else
      begin
       if id>0 then
        begin
           optype:='�޸�';
            if names <> nvedtname.Text then
           begin
              log := log+' ��Ʒ���� ��'+names+' �ĳ�'+nvedtname.Text;
           end;
           if startdate <> DateToStr(dtpstartdate.Date )then
           begin
              log := log+' ��ʼ���� �� '+startdate+' �ĳ�'+DateToStr(dtpstartdate.Date);
           end;
            if enddate <> DateToStr(dtpenddate.Date) then
           begin
              log := log+' �������� �� '+enddate+' �ĳ�'+DateToStr(dtpenddate.Date);
           end;
           if  oldamount<>amount then
           begin
              log := log+' �һ�������� �� '+oldamount+' �ĳ�'+amount;
           end;
           if valuation <> edtValuation.Text then
           begin
              log := log+' ��Ʒ��ֵ ��'+valuation+' �ĳ�'+edtvaluation.Text;
           end;
           if vipgradename <> oldvipgradename then
            log:= log+' �һ����迨�ȼ� �� '+oldvipgradename+' �ĳ� '+ vipgradename;

        end
        else
        begin
           optype:='���';
            log := ' ��Ʒ����:'+nvedtname.Text+', ��ʼ����:'+
                DateToStr(dtpstartdate.Date)+', ��������:'+DateToStr(dtpenddate.Date )
                +', �һ����迨�ȼ�Ϊ '+ vipgradename
                + ', �һ��������Ϊ '+amount
                +', ��Ʒ��ֵΪ '+edtvaluation.Text
                +', ��ע;'+mmoRemark.Text
        end;
        SysLog.WriteLog('��Ա��Ʒ����', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���ʧ�ܣ�' + E.Message);
      end;
    end;
  end;



end;

end.

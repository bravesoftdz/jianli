unit UFrmDwardpenalizeEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ComCtrls, DB,
  DBClient, jsonClientDataSet, NovaComboBox,Services, NovaHComboBox, NovaHelp,
  ImgList;

type
  TfrmDriverrewardpenalize = class(TSimpleEditForm)
    nvedtResion: TNovaEdit;
    dtpRewarddate: TDateTimePicker;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    jcdsSave: TjsonClientDataSet;
    lblWorkstatus: TLabel;
    nvcbbType: TNovaComboBox;
    nvedtDeductdistance: TNovaEdit;
    lbl1: TLabel;
    lbl5: TLabel;
    nvedtScore: TNovaEdit;
    lbl6: TLabel;
    lbl11: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    nvhelpDriver: TNovaHelp;
    mmoContent: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvcbbTypeChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id:Integer;createby,createtime,
    tname,types,content,reason,redate,score,deductdistance:string;
  end;

var
  frmDriverrewardpenalize: TfrmDriverrewardpenalize;

implementation

{$R *.dfm}

procedure TfrmDriverrewardpenalize.bbtnSaveClick(Sender: TObject);
var
  msg,log,optype: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  with jcdsSave do
  begin
   if ((Trim(nvhelpDriver.Text) = '')) and (nvhelpDriver.Id<=0) then
      begin
          SysDialogs.ShowMessage('�������ʻԱ����');
          nvhelpDriver.SetFocus;
        exit;
      end;
    if nvcbbType.GetSelectID < 0 then
       begin
        SysDialogs.Warning('��ѡ�񽱳�����');
        nvcbbType.SetFocus;
        exit;
       end
    else
       Params.ParamByName('rewardpenalize.type').Value := nvcbbType.GetSelectCode;

    if Trim(nvedtResion.Text) ='' then
      begin
        SysDialogs.Warning('ԭ����Ϊ��');
        nvedtResion.SetFocus;
        exit;
      end
      else
         Params.ParamByName('rewardpenalize.reason').Value := nvedtResion.Text;

     if Trim(mmoContent.Text) ='' then
      begin
        SysDialogs.Warning('���ݲ���Ϊ��');
        mmoContent.SetFocus;
        exit;
      end
      else
         Params.ParamByName('rewardpenalize.content').Value := mmoContent.Text;
    Params.ParamByName('rewardpenalize.id').Value :=id;
    Params.ParamByName('rewardpenalize.createby').Value := createby;
    Params.ParamByName('rewardpenalize.createtime').Value := createtime;
    Params.ParamByName('rewardpenalize.driverid').Value := nvhelpDriver.Id;
    Params.ParamByName('rewardpenalize.rewarddate').Value := formatdatetime('yyyy-mm-dd',dtpRewarddate.Date);
    Params.ParamByName('rewardpenalize.deductdistance').Value := nvedtDeductdistance.Text;
    Params.ParamByName('rewardpenalize.deductscore').Value :=  nvedtScore.Text;
   try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvcbbType.SetFocus;
      end
      else
      begin
       if id>0 then
        begin
           optype:='�޸�';

           log := ' �޸ļ�ʻԱ'+tname+'�Ľ�����Ϣ��';

            if types <> nvcbbType.Text then
           begin
              log := log+' [��������]��'+types+'�ĳ�'+nvcbbType.Text;
           end;
           if content <> mmoContent.Text then
           begin
              log := log+' [����]�� '+content+'�ĳ�'+mmoContent.Text;
           end;
           if reason <> nvedtResion.Text then
           begin
              log := log+' [ԭ��]�� '+reason+'�ĳ�'+nvedtResion.Text;
           end;
           if redate <> DateToStr(dtpRewarddate.Date) then
           begin
              log := log+' [��������]�� '+redate+'�ĳ�'+DateToStr(dtpRewarddate.Date);
           end;
           if (nvedtScore.Text <>'') and  (score <> nvedtScore.Text) then
           begin
              log := log+' [�۳�����]�� '+score+'�ĳ�'+nvedtScore.Text;
           end;
           if (nvedtDeductdistance.Text<>'') and (deductdistance <> nvedtDeductdistance.Text) then
           begin
              log := log+' �۳��������� '+deductdistance+'�ĳ�'+nvedtDeductdistance.Text;
           end;

        end
       else
        begin
           optype:='���';
            log := ' [��ʻԱ����]'+nvhelpDriver.Text+' ,[��������]'+nvcbbType.Text
                  +' ,[����]'+mmoContent.Text+' ,[ԭ��]'+nvedtResion.Text
                   +',[��������]'+DateToStr(dtpRewarddate.Date);
         if nvedtScore.Text <>'' then
         begin
           log := log+' �۳�����'+nvedtScore.Text;
         end;
         if nvedtDeductdistance.Text<>'' then
         begin
           log := log+' �۳�������'+nvedtDeductdistance.Text;
         end;
        end;
        SysLog.WriteLog('��������->��ʻԱ���ͼ�¼����', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('drewardid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��Ӽ�ʻԱ���ͼ�¼ʧ�ܣ�' + E.Message);
      end;
    end;




  end;

end;

procedure TfrmDriverrewardpenalize.FormCreate(Sender: TObject);
begin
  inherited;
  dtpRewarddate.Date := Now;
  nvcbbType.Active :=False;
  nvcbbType.Active := True;
end;

procedure TfrmDriverrewardpenalize.nvcbbTypeChange(Sender: TObject);
begin
  inherited;
   if nvcbbType.GetSelectID >= 0 then
    begin
      if nvcbbType.GetSelectCode = '0' then
      begin
        nvedtDeductdistance.Text :='';
        nvedtScore.Text :='';
        nvedtDeductdistance.Enabled := False;
        nvedtScore.Enabled := False;
      end
     else
      begin
        nvedtDeductdistance.Enabled := True;
        nvedtScore.Enabled := True;
      end;
    end;

end;

end.

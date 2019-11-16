unit UFrmOutstationcheckEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet, OleCtrls,
  ZKFPEngXControl_TLB,mmsystem;

type
  TFrmOutstationcheckEdt = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    DpDepartdate: TDateTimePicker;
    Label1: TLabel;
    DpOuttime: TDateTimePicker;
    Label2: TLabel;
    nvhelpvehicleno: TNovaHelp;
    Label3: TLabel;
    EdtSeats: TNovaEdit;
    Label4: TLabel;
    EdtUnitname: TNovaEdit;
    Label5: TLabel;
    EdtEndstationname: TNovaEdit;
    Label6: TLabel;
    EdtReporttime: TNovaEdit;
    Label7: TLabel;
    EdtCARRYPEOPLE: TNovaEdit;
    Label8: TLabel;
    NovaEdtFACTPEOPLE: TNovaEdit;
    Label9: TLabel;
    NovaFILLPEOPLE: TNovaEdit;
    Label10: TLabel;
    Editchildnum: TNovaEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    Label11: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    CobRUNNOCHK: TComboBox;
    CobDRIVERLICENSECHK: TComboBox;
    CobROADNOCHK: TComboBox;
    CobMAINTAINCHK: TComboBox;
    CobBUSCHECKCHK: TComboBox;
    GroupBox3: TGroupBox;
    Label18: TLabel;
    Label19: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    CobDRIVINGLICENSE1CHK: TComboBox;
    CobQUALIFICATION1CHK: TComboBox;
    CobWORKNO1CHK: TComboBox;
    CobDRIVINGLICENSE2CHK: TComboBox;
    CobQUALIFICATION2CHK: TComboBox;
    CobWORKNO2CHK: TComboBox;
    GroupBox4: TGroupBox;
    imgImg_Picture1: TImage;
    GroupBox5: TGroupBox;
    imgImg_Picture2: TImage;
    EdtDriver1: TNovaHelp;
    EdtDriver2: TNovaHelp;
    jscdQryDepartinvoices: TjsonClientDataSet;
    EdtAddCardno: TEdit;
    jcdsFindPicture: TjsonClientDataSet;
    jscdsaveOutstationcheck: TjsonClientDataSet;
    jscdqryVehicledriverreport: TjsonClientDataSet;
    lbl1: TLabel;
    edt1: TNovaEdit;
    lbl2: TLabel;
    nvhlp1: TNovaHelp;
    nvhlpSteward: TNovaHelp;
    lbl3: TLabel;
    zkfpngx1: TZKFPEngX;
    jsnclntdtstSpcQry: TjsonClientDataSet;
    jsncArrivalStationCheck: TjsonClientDataSet;
    GroupBox6: TGroupBox;
    mmoReportInfo: TMemo;
    jsonSpcQry: TjsonClientDataSet;
    jsnclQrydriverByDriverid: TjsonClientDataSet;
    jsncQryStewardName: TjsonClientDataSet;
    jsncQryStwed: TjsonClientDataSet;
    procedure nvhelpvehiclenoIdChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhlp1Enter(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure zkfpngx1Capture(ASender: TObject; ActionResult: WordBool;
      ATemplate: OleVariant);
    procedure EdtDriver1Enter(Sender: TObject);
    procedure EdtDriver1Exit(Sender: TObject);
    procedure EdtDriver2Enter(Sender: TObject);
    procedure EdtDriver2Exit(Sender: TObject);
    procedure nvhlpStewardExit(Sender: TObject);
    procedure nvhlpStewardEnter(Sender: TObject);
 //   procedure zkfpngx1Capture(ASender: TObject; ActionResult: WordBool;
    //  ATemplate: OleVariant);
  private
    { Private declarations }
    lv_scheduleplanid, lv_scheduleid: int64;
    lv_departtime: string;
    sRegTemplate1: WideString;
     sRegTemplate:WideString;
     initsuccess,driver1flag,driver2flag,driver3flag,stewardflag:boolean;
  public
    { Public declarations }
    id ,fpcHandle,driverid:int64;
    stewardid ,driver2id,driver1id: int64;
    drivername,param_2033: string;
  end;

var
  FrmOutstationcheckEdt: TFrmOutstationcheckEdt;

implementation
uses Services, PubFn, UDMPublic, UFrmOutStationFinger;
{$R *.dfm}

procedure TFrmOutstationcheckEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  if nvhelpvehicleno.Id=0 then
  begin
    SysDialogs.Warning('请选择车牌号码');
    nvhelpvehicleno.SetFocus;
    exit;
  end;

  if EdtEndstationname.Text = '暂无' then
  begin
    SysDialogs.ShowMessage('该车辆未报到');
    nvhelpvehicleno.SetFocus;
    Exit;
  end;

  if EdtCARRYPEOPLE.Text='' then
     EdtCARRYPEOPLE.Text:='0';
  if NovaEdtFACTPEOPLE.Text='' then
     NovaEdtFACTPEOPLE.Text:='0';
  if NovaFILLPEOPLE.Text='' then
     NovaFILLPEOPLE.Text:='0';


  with jscdsaveOutstationcheck do
  begin
    Close;
    Params.ParamByName('ots.departdate').Value := formatdatetime('yyyy-mm-dd',
      DpDepartdate.DateTime);
    if (EdtReporttime.Text = '') or (lv_scheduleplanid = 0) then
    begin
      Params.ParamByName('ots.scheduleplanid').Value:= 0;
      Params.ParamByName('ots.reporttime').Value := null;
      Params.ParamByName('ots.departtime').Value := null;
      Params.ParamByName('ots.scheduleid').Value := null;
    end
    else
    begin
      Params.ParamByName('ots.scheduleplanid').Value := lv_scheduleplanid;
      Params.ParamByName('ots.reporttime').Value := EdtReporttime.Text;
      Params.ParamByName('ots.departtime').Value := lv_departtime;
      Params.ParamByName('ots.scheduleid').Value := lv_scheduleid;
    end;

    Params.ParamByName('ots.vehicleid').Value := nvhelpvehicleno.Id;
    Params.ParamByName('ots.outtime').Value := formatdatetime('yyyy-mm-dd',
      DpDepartdate.DateTime)+formatdatetime(' HH:mm:ss',
      DpOuttime.DateTime);
    Params.ParamByName('ots.seatnums').Value :=strtoint(EdtSeats.Text);
    Params.ParamByName('ots.carrypeople').Value := strtoint(EdtCARRYPEOPLE.Text);
    Params.ParamByName('ots.factpeople').Value := strtoint(NovaEdtFACTPEOPLE.Text);
    Params.ParamByName('ots.fillpeople').Value := strtoint(NovaFILLPEOPLE.Text);
    Params.ParamByName('ots.runnochk').Value := CobRUNNOCHK.Text;
    Params.ParamByName('ots.driverlicensechk').Value := CobDRIVERLICENSECHK.Text;
    Params.ParamByName('ots.buscheckchk').Value := CobBUSCHECKCHK.Text;
    Params.ParamByName('ots.maintainchk').Value := CobMAINTAINCHK.Text;
    Params.ParamByName('ots.roadnochk').Value := CobROADNOCHK.Text;
    //if(EdtDriver1.Id>0)then
   // begin
      Params.ParamByName('ots.driver1').Value := EdtDriver1.text;
      Params.ParamByName('ots.drivinglicense1chk').Value := CobDRIVINGLICENSE1CHK.Text;
      Params.ParamByName('ots.qualification1chk').Value :=CobQUALIFICATION1CHK.Text;
      Params.ParamByName('ots.workno1chk').Value := CobWORKNO1CHK.Text;
  // end;
   // if(EdtDriver2.Id>0)then
   // begin
      Params.ParamByName('ots.driver2').Value := EdtDriver2.text;
      Params.ParamByName('ots.drivinglicense2chk').Value := CobDRIVINGLICENSE2CHK.Text;
      Params.ParamByName('ots.qualification2chk').Value :=CobQUALIFICATION2CHK.Text;
      Params.ParamByName('ots.workno2chk').Value := CobWORKNO2CHK.Text;
   // end;
    Params.ParamByName('ots.checker').Value := SysInfo.LoginUserInfo.UserID;
   // Params.ParamByName('ots.remark').Value := createby;
    Params.ParamByName('ots.orgid').Value :=  SysInfo.LoginUserInfo.OrgID;



      if getParametervalue('2043', Sysinfo.LoginUserInfo.OrgID) = '0' then
    begin

      if driver1id<>EdtDriver1.Id  then
     begin
         SysDialogs.ShowMessage('出站驾驶员跟报到驾驶员不一致！');
         EdtDriver1.SetFocus;
          exit;
     end;

      if EdtDriver1.Id=EdtDriver2.Id  then
     begin
         SysDialogs.ShowMessage('正驾驶和副驾驶不能一致！');
         EdtDriver2.SetFocus;
          exit;
     end;

     if   (trim(EdtDriver1.Text)= '') then
     begin
         SysDialogs.ShowMessage('出站驾驶员不能为空！');
         EdtDriver1.SetFocus;
          exit;
     end;

     if EdtDriver2.Id<>null then
     begin
           if driver2id<>EdtDriver2.Id then
       begin
           SysDialogs.ShowMessage('出站副驾驶员跟报到副驾驶员不一致！');
           EdtDriver2.SetFocus;
            exit;
       end;

       if   (trim(EdtDriver2.Text)= '') then
       begin
           SysDialogs.ShowMessage('副驾驶需按指纹才能出站！');
           EdtDriver2.SetFocus;
            exit;
       end;
     end
     else
     begin
       SysDialogs.ShowMessage('请填写出站副驾驶！');
       EdtDriver2.SetFocus;
        exit;
     end;

    end;


     if getParametervalue('2044', Sysinfo.LoginUserInfo.OrgID) = '0' then
    begin
      if stewardid<>nvhlpSteward.Id then
      begin
         SysDialogs.ShowMessage('出站乘务员跟报到乘务员不一致！');
          nvhlpSteward.SetFocus;
            exit;
      end;

         if   (trim(nvhlpSteward.Text)= '') then
       begin
           SysDialogs.ShowMessage('出站乘务员不能为空！');
           nvhlpSteward.SetFocus;
            exit;
       end;
    end;


    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhelpvehicleno.SetFocus;
      end
      else
      begin
        EdtDriver1.Clear;
        EdtDriver2.Clear;
        nvhlpSteward.Clear;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin

        SysLog.WriteErr('稽查信息添加失败：' + E.Message);
      end;
    end;
  end;

end;




procedure TFrmOutstationcheckEdt.EdtDriver1Enter(Sender: TObject);
begin
  inherited;
  driver1flag := True;
end;

procedure TFrmOutstationcheckEdt.EdtDriver1Exit(Sender: TObject);
begin
  inherited;
  driver1flag := false;
end;

procedure TFrmOutstationcheckEdt.EdtDriver2Enter(Sender: TObject);
begin
  inherited;
  driver2flag := True;
end;

procedure TFrmOutstationcheckEdt.EdtDriver2Exit(Sender: TObject);
begin
  inherited;
  driver2flag := false;
end;

procedure TFrmOutstationcheckEdt.FormCreate(Sender: TObject);
begin
  inherited;


  param_2033 := getParametervalue('2033', Sysinfo.LoginUserInfo.OrgID);
  if param_2033='1' then
  begin

      fpcHandle := zkfpngx1.CreateFPCacheDB;
  end;
end;

procedure TFrmOutstationcheckEdt.FormShow(Sender: TObject);
var
  id:integer;
  sTemp:WideString;
begin
  inherited;
  nvhelpvehicleno.SetFocus;
  NovaFILLPEOPLE.Text:='0';
  jsonSpcQry.Active:=False;
  jsonSpcQry.Active:=true;
  if param_2033='1' then
   begin
      if zkfpngx1.InitEngine = 0 then
      begin
        mmoReportInfo.Lines.Insert(0, '指纹设备初始化成功！');
        initsuccess:=true;
        with jsonSpcQry do
        begin
           if active then
           begin
             first;
             while(not eof) do
             begin
               sTemp:= FieldByName('fingerstr').AsString;
               SysLog.WriteErr('sTemp='+sTemp);
               id:=FieldByName('id').AsInteger;
               try
                  zkfpngx1.AddRegTemplateStrToFPCacheDB(fpcHandle,id,sTemp);
               except
                  SysLog.WriteErr('id='+inttostr(id)+'指纹注册失败！');
               end;
               next;
             end;
           end;
        end ;
        zkfpngx1.BeginCapture;
        zkfpngx1.EnrollCount:=1;
        //ZKFPEngX1.BeginEnroll;
        if zkfpngx1.IsRegister then zkfpngx1.CancelEnroll;
        zkfpngx1.SetAutoIdentifyPara(true, fpcHandle, 8);
      end
      else
      begin
         mmoReportInfo.Lines.Insert(0, '指纹设备初始化失败！');
         initsuccess:=false;
      end;
   end;

end;


procedure TFrmOutstationcheckEdt.nvhelpvehiclenoIdChange(Sender: TObject);
var
  HexStr:String;
  reportid:int64;
begin
  inherited;
//  SysDialogs.ShowMessage(IntToStr(nvhelpvehicleno.id));
  if nvhelpvehicleno.id>0 then
  begin

     with jsncArrivalStationCheck do
     begin
      Active := False;
         //Params.ParamByName('cardno').Value := cardNO;
        Params.ParamByName('vehicleid').Value := nvhelpvehicleno.id;
        Params.ParamByName('departdate').Value :=formatdatetime('yyyy-MM-dd',DpDepartdate.Date);
        Active := True;
        if recordcount > 0 then
        begin
          stewardid := fieldByName('checkstewardid').AsLargeInt;
          driver1id := fieldByName('checkdriver1id').AsLargeInt;
          driver2id := fieldByName('checkdriver2id').AsLargeInt;
        end;
     end;








    with jscdQryDepartinvoices do
    begin
      Active := False;
      //Params.ParamByName('cardno').Value := cardNO;
      Params.ParamByName('vehicleid').Value := nvhelpvehicleno.id;
      Params.ParamByName('departdate').Value :=formatdatetime('yyyy-MM-dd',DpDepartdate.Date);
      Active := True;
      if recordcount > 0 then
      begin
        EdtEndstationname.Font.Color := clBlack;
        EdtEndstationname.Update;
        if trim(fieldbyname('reporttime').AsString)<>'' then
          EdtReporttime.Text := fieldbyname('reporttime').AsString
        else

        EdtReporttime.Clear;
        EdtCARRYPEOPLE.Text :=fieldbyname('ticketnum').AsString;
        lv_departtime := fieldbyname('departtime').AsString;
        lv_scheduleid := fieldbyname('scheduleid').AsInteger;
        EdtEndstationname.Text := fieldbyname('schinfo').AsString;
        lv_scheduleplanid := fieldbyname('scheduleplanid').AsLargeInt;
        reportid:=fieldbyname('id').AsLargeInt;
        EdtSeats.Text := fieldbyname('seatnum').AsString;
        EdtUnitname.Text := fieldbyname('unitname').AsString;
        NovaEdtFACTPEOPLE.Text := fieldbyname('ticketnum').AsString;
        Editchildnum.Text := fieldbyname('carrychildnum').AsString;



        with jscdqryVehicledriverreport do
        begin
          Active := False;
          Params.ParamByName('vehiclereportid').Value := reportid;
          Params.ParamByName('departdate').Value :=formatdatetime('yyyy-MM-dd',DpDepartdate.Date);
          Active := True;
          if jscdqryVehicledriverreport.recordcount > 0 then
          begin
             jscdqryVehicledriverreport.First;
             while(not eof) do
             begin
               CobRUNNOCHK.ItemIndex:=CobRUNNOCHK.Items.IndexOf(fieldbyname('vworknores').AsString);
               CobDRIVERLICENSECHK.ItemIndex:=CobDRIVERLICENSECHK.Items.IndexOf(fieldbyname('vdriverlicenseres').AsString);
               CobROADNOCHK.ItemIndex:=CobROADNOCHK.Items.IndexOf(fieldbyname('vroadnores').AsString);
               CobBUSCHECKCHK.ItemIndex:=CobBUSCHECKCHK.Items.IndexOf(fieldbyname('vnotenum').AsString);
               CobMAINTAINCHK.ItemIndex:=0;
               if(EdtDriver1.Text='') then
               begin
                    EdtDriver1.Text := fieldbyname('drivername').AsString;
                    EdtDriver1.id := fieldbyname('driverid').AsLargeInt;
                  CobDRIVERLICENSECHK.ItemIndex:=CobDRIVERLICENSECHK.Items.IndexOf(fieldbyname('ddrivinglicenseres').AsString);
                  CobQUALIFICATION1CHK.ItemIndex:=CobQUALIFICATION1CHK.Items.IndexOf(fieldbyname('dqualificationres').AsString);
                  CobWORKNO1CHK.ItemIndex:=CobDRIVERLICENSECHK.Items.IndexOf(fieldbyname('dworknores').AsString);
               end
               else
               begin
                    EdtDriver2.Text := fieldbyname('drivername').AsString;
                    EdtDriver2.id := fieldbyname('driverid').AsLargeInt;
                  CobDRIVINGLICENSE2CHK.ItemIndex:=CobDRIVINGLICENSE2CHK.Items.IndexOf(fieldbyname('ddrivinglicenseres').AsString);
                  CobQUALIFICATION2CHK.ItemIndex:=CobQUALIFICATION2CHK.Items.IndexOf(fieldbyname('dqualificationres').AsString);
                  CobWORKNO2CHK.ItemIndex:=CobWORKNO2CHK.Items.IndexOf(fieldbyname('dworknores').AsString);
               end;
               jscdqryVehicledriverreport.Next;
             end;

          end;
        end;


        {CobDRIVERLICENSECHK.ItemIndex := fieldbyname('driverlicensechk')
          .AsInteger;
        CobMAINTAINCHK.ItemIndex := fieldbyname('maintainchk').AsInteger;
        CobBUSCHECKCHK.ItemIndex := fieldbyname('checkresult').AsInteger;
        CobROADNOCHK.ItemIndex := fieldbyname('roadnochk').AsInteger;
        EdtDriver1.Text := fieldbyname('driver1name').AsString;
        EdtDriver1.id := fieldbyname('driver1id').AsLargeInt;
        EdtDriver2.id := fieldbyname('driver2id').AsLargeInt;}




        if EdtDriver1.Text <> '' then
        begin
          //CobDRIVINGLICENSE1CHK.ItemIndex := fieldbyname('drivinglicense1chk')
          //  .AsInteger;
          //CobQUALIFICATION1CHK.ItemIndex := fieldbyname('qualification1chk')
          //  .AsInteger;
         // CobWORKNO1CHK.ItemIndex := fieldbyname('workno1chk').AsInteger;

          with jcdsFindPicture do
          begin
            Active:=False;
            Params.ParamValues['filter_EQL_d!id']:=EdtDriver1.Id;
            Active := True;
           if recordcount > 0 then
            begin
              HexStr := FieldByName('picture').AsString;
              if (HexStr <> '') then
                imgImg_Picture1.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
            end;
          end;
        end
        else
        begin
          CobDRIVINGLICENSE1CHK.ItemIndex := -1;
          CobQUALIFICATION1CHK.ItemIndex := -1;
          CobWORKNO1CHK.ItemIndex := -1;
        end;
        //EdtDriver2.Text := fieldbyname('driver2name').AsString;
        if EdtDriver2.Text <> '' then
        begin
          //CobDRIVINGLICENSE2CHK.ItemIndex := fieldbyname('drivinglicense2chk')
          //  .AsInteger;
          //CobQUALIFICATION2CHK.ItemIndex := fieldbyname('qualification2chk')
          //  .AsInteger;
          //CobWORKNO2CHK.ItemIndex := fieldbyname('workno2chk').AsInteger;
          with jcdsFindPicture do
          begin
            Active:=False;
            Params.ParamValues['filter_EQL_d!id']:=EdtDriver2.Id;
            Active := True;
           if recordcount > 0 then
            begin
              HexStr := FieldByName('picture').AsString;
              if (HexStr <> '') then
                imgImg_Picture2.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
            end;
          end;
        end
        else
        begin
          CobDRIVINGLICENSE2CHK.ItemIndex := -1;
          CobQUALIFICATION2CHK.ItemIndex := -1;
          CobWORKNO2CHK.ItemIndex := -1;
        end;
        bbtnSave.SetFocus;
      end
      else
      begin
        lv_scheduleplanid := 0;
        EdtEndstationname.Font.Color := clRed;
        EdtEndstationname.Text := '暂无';
        EdtEndstationname.Update;
             EdtReporttime.Clear;
      end;
    end;
  end;
end;

procedure TFrmOutstationcheckEdt.nvhlp1Enter(Sender: TObject);
var
  did: int64;
  drivername: WideString;
begin
  inherited;
  {FrmOutStationFinger := TFrmOutStationFinger.Create(Self);
  try
    with FrmOutStationFinger do
    begin
      caption := '正驾驶员指纹确认';
      if SysMainForm.showFormModal(FrmOutStationFinger, false) = mrok then
      begin
        did := driverid;
        drivername := drivername;
        nvhlp1.Text := drivername;
        nvhlp1.Id := did;
      end;
    end;
  finally
    FreeAndNil(FrmOutStationFinger);
  end;  }
end;


procedure TFrmOutstationcheckEdt.nvhlpStewardEnter(Sender: TObject);
begin
  inherited;
      stewardflag := True;
end;

procedure TFrmOutstationcheckEdt.nvhlpStewardExit(Sender: TObject);
begin
  inherited;
    stewardflag := false;

end;

procedure TFrmOutstationcheckEdt.zkfpngx1Capture(ASender: TObject;
  ActionResult: WordBool; ATemplate: OleVariant);
var
  ID: Integer;
  isexist:boolean;
begin
    ID:= ATemplate[0];
    if ID = -1 then
    begin
         if sRegTemplate1='' then
         begin
           sRegTemplate:='';
           //employeeid1:=0;
           //image1.Picture.Graphic:=nil;
           //LabInfo.Caption:='系统中不存在该指纹信息！';
           mmoReportInfo.Lines.Insert(1, '系统中不存在该指纹信息！');
           //LabInfo.Font.Color:=clRed;
           //LabInfo.Refresh;
           //sleep(500);
           //LabInfo.Font.Color:=clblack;
           //LabInfo.Refresh;
           //sleep(500);
           //LabInfo.Caption:='请按指纹识别器……';
           mmoReportInfo.Lines.Insert(2, '请按指纹识别器……');
           //LabInfo.Font.Color:=clblue;
           //LabInfo.Refresh;
         end ;
//         PlaySound('Pressagain.wav',0,snd_async);
    end
    else
    begin
       with self.jsonSpcQry do
       begin
         if Active and (recordcount>0) then
         begin
            isexist:=false;
            first;
            while not eof do
            begin
              if FieldByName('id').AsLargeInt = ID then
              begin
                //  SysDialogs.ShowMessage(IntToStr(ID));
                    //写查询
                  if EdtDriver1.Text='' then
                  begin
                             with jsnclQrydriverByDriverid do
                    begin
                        Active:=False;
                        Params.ParamByName('driverid').Value := ID;
                        driverid := ID;
                        Active:=True;
                        if RecordCount > 0 then
                        begin
                          if jsnclQrydriverByDriverid.FieldByName('id').AsInteger>0 then
                          begin
                            EdtDriver1.Text :=jsnclQrydriverByDriverid.FieldByName('name').AsString;
                            EdtDriver1.Id:=jsnclQrydriverByDriverid.FieldByName('id').AsInteger;
                            //keybd_event(VK_RETURN,0,0,0); //模拟按键，按下enter键
                            //keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //按上来
                          end;
                        end
                        else
                        begin
                          mmoReportInfo.Lines.Insert(0, '没找到该驾驶员对应的指纹信息！');
                        end;
                    end;


                  end

                  else
                  begin
                             with jsnclQrydriverByDriverid do
                    begin
                        Active:=False;
                        Params.ParamByName('driverid').Value := ID;
                        driverid := ID;
                        Active:=True;
                        if RecordCount > 0 then
                        begin
                          if jsnclQrydriverByDriverid.FieldByName('id').AsInteger>0 then
                          begin
                            EdtDriver2.Text :=jsnclQrydriverByDriverid.FieldByName('name').AsString;
                            EdtDriver2.Id:=jsnclQrydriverByDriverid.FieldByName('id').AsInteger;
                            //keybd_event(VK_RETURN,0,0,0); //模拟按键，按下enter键
                            //keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //按上来
                          end;
                        end
                        else
                        begin
                          mmoReportInfo.Lines.Insert(0, '没找到该驾驶员对应的指纹信息！');
                        end;
                    end;


                  end;


                  if stewardflag then
                  begin

                    with jsncQryStewardName do
                    begin
                        Active:=False;
                        Params.ParamByName('stewardid').Value := ID;
                       // driverid := ID;
                        Active:=True;
                        if RecordCount > 0 then
                        begin
                          if jsncQryStewardName.FieldByName('id').AsInteger>0 then
                          begin
                            nvhlpSteward.Text :=jsncQryStewardName.FieldByName('name').AsString;
                            nvhlpSteward.Id:=jsncQryStewardName.FieldByName('id').AsInteger;
                            //keybd_event(VK_RETURN,0,0,0); //模拟按键，按下enter键
                            //keybd_event(VK_RETURN,0,KEYEVENTF_KEYUP,0); //按上来
                          end;
                        end
                        else
                        begin
                          mmoReportInfo.Lines.Insert(0, '没找到该乘务员对应的指纹信息！');
                        end;
                    end;


                  end;



                isexist:=true;
                exit;
              end;
              next;
            end;
            if not isexist then
            begin
              mmoReportInfo.Lines.Insert(3, '没有该指纹信息……');
            end;
         end;
       end;
    end;
end;

end.

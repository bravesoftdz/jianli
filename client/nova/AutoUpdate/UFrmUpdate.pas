Unit UFrmUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, inifiles, ScktComp, Gauges,
  ShellAPI, NativeXml, msxml,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Tlhelp32,
  WinSkinData, jpeg;

const
  applicationCfgName = 'App.ini';
  applicationName = 'NvBus.exe';
  xmltitle = '<?xml version="1.0" encoding="UTF-8"?>';

type
  TFrmUpdate = class(TForm)
    IdHTTPDownFile: TIdHTTP;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    SkinData1: TSkinData;
    mmo_Loading: TMemo;
    img1: TImage;
    Label1: TLabel;
    // ��Ҫ�ĸ��¹���
    Procedure MainDownProc;
    procedure IdHTTPDownFileWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetFileModifyDate(FileName: String): TDateTime;
    Function downloadFile(frompath, topath: string): boolean;
    procedure loading(const msg: String);
    // ���г���
    Procedure RunMainProc;
   // procedure ShowMsg(msg: String);
    procedure WriteLog(msg: String);
    { Private declarations }
  public
    { Public declarations }
    constructor Create();
  end;

var
  FrmUpdate: TFrmUpdate;
  LocalFilePath: String;
  LocalTempPath: string; // ������ʱ�ļ�����Ŀ¼
  // NowDownFile:String;
  // ConnInfo :TConnectStr;
  // UpdateURL: String; // ���ظ��³����URL
  // UpdateFileName: String;

implementation

// uses UntSetUpdate;
{$R *.dfm}

function FindProcess(AFileName: string): boolean;
var
  hSnapshot: THandle; // ���ڻ�ý����б�
  lppe: TProcessEntry32; // ���ڲ��ҽ���
  Found: boolean; // �����жϽ��̱����Ƿ����
  // KillHandle: THandle; // ����ɱ������
begin
  Result := False;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); // ���ϵͳ�����б�
  lppe.dwSize := SizeOf(TProcessEntry32); // �ڵ���Process32First API֮ǰ����Ҫ��ʼ��lppe��¼�Ĵ�С
  Found := Process32First(hSnapshot, lppe); // �������б�ĵ�һ��������Ϣ����ppe��¼��
  while Found do
  begin
    if ((UpperCase(ExtractFileName(lppe.szExeFile)) = UpperCase(AFileName)) or
        (UpperCase(lppe.szExeFile) = UpperCase(AFileName))) then
    begin
      Result := True;
      Break;
    end;
    Found := Process32Next(hSnapshot, lppe); // �������б����һ��������Ϣ����lppe��¼��
  end;
end;

procedure killApplication(ExeFileName: String);
const
  PROCESS_TERMINATE = $0001; // ���̵�PROCESS_TERMINATE����Ȩ��
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  // ��ȡϵͳ���н��̿���
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  // ����Process32Firstǰ��Sizeof(FProcessEntry32)���FProcessEntry32.dwSize
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  // ��ȡ�����е�һ��������Ϣ�����浽FProcessEntry32�ṹ����
  while integer(ContinueLoop) <> 0 do
  // ѭ��ö�ٿ��������н�����Ϣ
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase
          (ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
          (ExeFileName))) then
      // �ҵ�Ҫ��ֹ�Ľ�����
      TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
          FProcessEntry32.th32ProcessID), 0);
    //CloseHandle(FSnapshotHandle);
    // ��ֹ����
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    // ������һ��������������
  end;
end;

/// //////////////////////////////////////////////////////////////

procedure TFrmUpdate.MainDownProc;
var
  downUrl,updateurl: string;
  FileName,FileNameWin,FileNamesubstr,resultstr,ExecPath: string;
  LocalFileDatetime, lastModifyDatetime: TDateTime;
  topath,dirpath, frompath,topathbak: String;
  FXmlHttp: IXMLHTTPREQUEST;
  Ini: Tinifile;
  sResultJSON, resultXML: WideString;
  nodeList: TsdNodeList;
  node: TXmlNode;
  i,nCount: integer;
  xml: TNativeXml;
begin
  if FindProcess(applicationName) then
    killApplication(applicationName);
  sleep(500);
 //WriteLog('sleep500...');
  // ��Ҫ���¹���
  // ȡ�ø����ļ�
  ExecPath := ExtractFilePath(Application.ExeName);
  if FileExists(ExtractFilePath(Paramstr(0)) + applicationCfgName) then
  begin
    Ini := Tinifile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    try
      try
        downUrl := 'http://127.0.0.1:8080/download/';
        updateurl := 'http://127.0.0.1:8080/NvBusWeb/system/updatefile';
        updateurl:= Ini.ReadString('server', 'updateurl', updateurl);
        downUrl:= Ini.ReadString('server', 'download', downUrl);
        FXmlHttp := CoXMLHTTP.Create();
        // IdHTTPDownFile := TIdHTTP.Create(nil);
        FXmlHttp.open('POST', updateurl, False, '', '');
        FXmlHttp.setRequestHeader('Content-Type',
          'application/x-www-form-urlencoded;charset=utf-8');
        FXmlHttp.send('');
        sResultJSON := FXmlHttp.responseText;
        resultXML := Copy(sResultJSON, Pos('<', sResultJSON),
          Pos(',', sResultJSON) - 1 - Pos('<', sResultJSON));
        resultXML := StringReplace(resultXML, '#', '/', [rfReplaceAll]);
        resultXML := StringReplace(resultXML, '''', '"', [rfReplaceAll]);
        resultXML := xmltitle + resultXML;
        xml := TNativeXml.Create(nil);
        xml.XmlFormat := xfReadable;
        xml.ReadFromString(resultXML);
        node := xml.Root;
        nodeList := TsdNodeList.Create(False);
        node.FindNodes('file', nodeList);
        ProgressBar1.Max := nodeList.Count;
        for i := 0 to nodeList.Count - 1 do
        begin
          node := nodeList[i];
          ProgressBar1.Position := i + 1;
          FileName := node.AttributeByName['name'].Value;
          lastModifyDatetime := node.AttributeByName['lastmodify']
            .ValueAsDateTime;
          frompath := downUrl + FileName;
          if (pos('/',FileName)>0) then
          begin
             FileNameWin:=StringReplace(FileName,'/','\',[rfReplaceAll]);
             topath := ExecPath + FileNameWin;
             nCount:= pos('\',FileNameWin);
             FileNamesubstr := FileNameWin;
             dirpath := ExecPath;
             while nCount>0 do
             begin
                resultstr := Copy(FileNamesubstr,1,nCount);
                FileNamesubstr := Copy(FileNamesubstr,nCount+1,Length(FileNameWin));
                dirpath := dirpath + resultstr;
                nCount:=pos('\',FileNamesubstr);
             end;
             topathbak:= ExecPath + FileNameWin+'.bak';
             //�磺 filename=log.bpl   images/left.bmp  images/menu/right.bmp
             //����Ŀ¼
            if not (DirectoryExists(dirpath)) then
             begin
                ForceDirectories(dirpath);
             end;
          end
          else
          begin
             topath := ExecPath + FileName;
             topathbak:= ExecPath + FileName+'.bak';
          end;

          if FileExists(topath) then
          begin
            LocalFileDatetime := GetFileModifyDate(topath);
            if lastModifyDatetime > LocalFileDatetime then
            begin
              try
                 if downloadFile(frompath, topathbak) then
                  begin
                    loading(FileName + '�����سɹ�...');
                    WriteLog(FileName + '�����سɹ�...');
                    if deletefile(PChar(topath)) then
                    begin
                      if renamefile(FileName+'.bak',FileName) then
                      begin
                        loading(FileName + '.bak���������ɹ�...');
                        WriteLog(FileName + '.bak���������ɹ�...');
                      end
                      else
                      begin
                        loading(FileName + '.bak��������ʧ��...');
                        WriteLog(FileName + '.bak��������ʧ��...');
                      end;
                    end
                    else
                    begin
                      loading(FileName + '��ɾ��ʧ��...');
                      WriteLog(FileName + '��ɾ��ʧ��...');
                      {sleep(100);
                      killApplication(applicationName);
                      if deletefile(PChar(topath)) then
                      begin
                        loading(FileName + '��ɾ���ɹ�...');
                        WriteLog(FileName + '��ɾ���ɹ�...');
                      end; }
                    end;
                  end
                  else
                  begin
                    loading(FileName + '������ʧ��...');
                    WriteLog(FileName + '������ʧ��...');
                  end;
              except
                on E: Exception do
                begin
                  WriteLog('�����ļ���' + FileName + 'ʧ��...');
                end;
              end;
            end;
          end
          else
          begin
            loading('��������' + FileName + '�ļ�...');
            if downloadFile(frompath, topath) then
            begin
              loading(FileName + '�ļ����سɹ�...');
              WriteLog(FileName + '�ļ����سɹ�...');
            end
            else
            begin
              loading(FileName + '�ļ�����ʧ��...');
              WriteLog(FileName + '�ļ�����ʧ��...');
            end;
          end;
        end;
        nodeList.Free;
        xml.Free;
      except
        on E: Exception do
        begin
          WriteLog(FileName + '�ļ������쳣...'+E.Message);
        end;
      end;
    finally
      Ini.Free;
      IdHTTPDownFile.Free;
      ///showmessage('������ɣ������µ�¼ϵͳ��');
    end;
  end
  else
  begin
    WriteLog('�Ҳ���ϵͳ�����ļ���' + applicationCfgName);
    Application.Terminate;
  end;
  sleep(1000);
  RunMainProc;
  close;
end;

// ���г���
procedure TFrmUpdate.RunMainProc;
begin
  // �ȴ�ԭ���̽���
  while FindProcess(applicationName) do
  begin
    sleep(10);
  end;
  ShellExecute(Handle, nil, PChar(applicationName), nil, nil, SW_SHOWNORMAL)
end;

constructor TFrmUpdate.Create;
begin

end;



function TFrmUpdate.GetFileModifyDate(FileName: String): TDateTime;
var
  FileHandle: THandle;
  LocalFileTime: TFileTime;
  DosFileTime: DWORD;
  LastModifyTime: TDateTime;
  FindData: TWin32FindData;
  afile: Tinifile;
begin
  Result := Date;
  try
    FileHandle := FindFirstFile(PChar(FileName), FindData);
    if FileHandle <> INVALID_HANDLE_VALUE then
    begin
      Windows.FindClose(FileHandle);
      if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime);
        FileTimeToDosDateTime(LocalFileTime, LongRec(DosFileTime).Hi,
          LongRec(DosFileTime).Lo);
        LastModifyTime := FileDateToDateTime(DosFileTime);
        Result := LastModifyTime;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := Date - 365;
    end;
  end;

end;

function TFrmUpdate.downloadFile(frompath, topath: string): boolean;
var
  t: tmemorystream;
begin
  try
    t := tmemorystream.Create;
    IdHTTPDownFile.Get(frompath, t);
    t.SaveToFile(topath);
    t.Free;
    Result := True;
  except
    Result := False;
  end;

end;

procedure TFrmUpdate.FormShow(Sender: TObject);
begin
  WriteLog('��ʼ����^');
  //Timer1.Enabled := true;
  MainDownProc;
end;

procedure TFrmUpdate.IdHTTPDownFileWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  Label1.Caption := '���سɹ���';
end;

procedure TFrmUpdate.loading(const msg: String);
begin
  mmo_Loading.Lines.Add('   ' + msg);
  mmo_Loading.Update;
end;

procedure TFrmUpdate.Timer1Timer(Sender: TObject);
begin
  //WriteLog('Timer1Timer...');
  //MainDownProc;
  //Timer1.Enabled := False;
  //close;
end;

procedure TFrmUpdate.WriteLog(msg: String);
var
  FileName: String;
  FileHandle: TextFile;
begin
  FileName := ExtractFilePath(Application.ExeName) + 'error\' + FormatDateTime
    ('YYYY-MM-DD', Now) + '.txt';
  assignfile(FileHandle, FileName);
  try
    if FileExists(FileName) then
      append(FileHandle) // Reset(FileHandle)
    else
      ReWrite(FileHandle);
    WriteLn(FileHandle, FormatDateTime('[HH:MM:SS]', Now) + ' '+Application.ExeName + msg);
  finally
    CloseFile(FileHandle);
  end;
end;

end.

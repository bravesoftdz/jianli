{ ------------------------------------
  ����˵����ʵ��IUpdate�ӿ�
  ����˵����ʵ��ϵͳBPL����
  �������ڣ�2011/07/22
  ���ߣ�lck
  ��Ȩ��nova
  ------------------------------------- }
unit UpdatefileImpl;

interface

uses SysUtils, Controls, services, SysFactory, msxml,
  IniFiles, Windows, Forms, Classes, Winsock, NativeXml,
  Messages, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP;

const
  applicationCfgName = 'App.ini';
  xmltitle = '<?xml version="1.0" encoding="UTF-8"?>';

Type

  TUpdatefile = Class(TObject)
  private
    IdHTTPDownFile: TIdHTTP;
    // ��ȡ�ļ�����޸�����
    function GetFileModifyDate(FileName: String): TDateTime;
    function downloadUpdateFile(frompath, topath: string): boolean;
    procedure WriteLog(const log: String);
    procedure updateApp(Ini: Tinifile; topathbak: String);
  protected

  public
    procedure updatefile;
  End;

implementation

uses shellapi;

{ TUpdatefile }

function TUpdatefile.downloadUpdateFile(frompath, topath: string): boolean;
var
  t: tmemorystream;
begin
  try
    t := tmemorystream.Create;
    IdHTTPDownFile.Get(frompath, t);
    t.SaveToFile(topath);
    t.Free;
    result := true;
  except
    result := false;
  end;
end;

function TUpdatefile.GetFileModifyDate(FileName: String): TDateTime;
var
  FileHandle: THandle;
  LocalFileTime: TFileTime;
  DosFileTime: DWORD;
  LastModifyTime: TDateTime;
  FindData: TWin32FindData;
  afile: Tinifile;
begin
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
        result := LastModifyTime;
      end;
    end;
  except
    on E: Exception do
    begin
      result := Date - 365;
    end;
  end;
end;

procedure TUpdatefile.updateApp(Ini: Tinifile; topathbak: String);
var
  ExecPath: string;
  IniWrite, IniRead: Tinifile;
  sections: TStringList;
  keys: TStringList;
  i, j: integer;
  iscover, keyvalue: string;
begin
  sections := TStringList.Create;
  keys := TStringList.Create;
  IniWrite := Ini;
  IniRead := Tinifile.Create(topathbak);
  try

    IniRead.ReadSections(sections);
    for i := 0 to sections.Count - 1 do
    begin
      iscover := IniRead.ReadString(sections.Strings[i], 'iscover', 'false');
      if iscover = 'true' then
      begin
        IniRead.ReadSection(sections.Strings[i], keys);
        for j := 0 to keys.Count - 1 do
        begin
          keyvalue := IniRead.ReadString(sections.Strings[i], keys.Strings[j],
            '');
          IniWrite.WriteString(sections.Strings[i], keys.Strings[j], keyvalue);
        end;
      end;
    end;

  finally
    keys.Free;
    sections.Free;
    // IniWrite.Free;
    IniRead.Free;
  end;
end;

procedure TUpdatefile.updatefile;
var
  downUrl, updateurl,dirpath: string;
  FileName, ExecPath,FileNameWin,FileNamesubstr,resultstr: string;
  LocalFileDatetime, lastModifyDatetime: TDateTime;
  topath, frompath, topathbak: String;
  FXmlHttp: IXMLHTTPREQUEST;
  Ini: Tinifile;
  sResultJSON, resultXML: WideString;
  nodeList: TsdNodeList;
  node: TXmlNode;
  i,nCount, Count: integer;
  xml: TNativeXml;
  ip, port: string;
begin
  ExecPath := ExtractFilePath(Application.ExeName);
  if FileExists(ExtractFilePath(Paramstr(0)) + applicationCfgName) then
  begin
    Ini := Tinifile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    try
      try
        downUrl := 'http://127.0.0.1:8080/download/';
        updateurl := 'http://127.0.0.1:8080/NvBusWeb/system/updatefile';
        updateurl := Ini.ReadString('server', 'updateurl', updateurl);
        downUrl := Ini.ReadString('server', 'download', downUrl);

        FXmlHttp := CoXMLHTTP.Create();
        IdHTTPDownFile := TIdHTTP.Create(nil);
        FXmlHttp.open('POST', updateurl, false, '', '');
        FXmlHttp.setRequestHeader('Content-Type',
          'application/x-www-form-urlencoded;charset=utf-8');
        FXmlHttp.send('?filetype=bpl');
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
        nodeList := TsdNodeList.Create(false);
        node.FindNodes('file', nodeList);

        for i := 0 to nodeList.Count - 1 do
        begin
          node := nodeList[i];
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

          //topath := ExecPath + FileName;
          //topathbak := ExecPath + FileName + '.bak';
          if (FileName = 'tst') or (FileName = 'images') or
            (FileName = 'error') then
            continue;



          if FileExists(topath) then
          begin
            // showmessage(IntToStr(i)+topath);
            LocalFileDatetime := GetFileModifyDate(topath);
            if (lastModifyDatetime > LocalFileDatetime) then
            begin
              if (FileName = 'NovaJsonRpc.bpl') or (FileName = 'NvBUS.exe') or
                (FileName = 'login.bpl') or (FileName = 'Interfaces.bpl') or
                (FileName = 'ConnectCFG.bpl') or (FileName = 'Updatefile.bpl')
                or (FileName = 'Log.bpl') then
              begin
                //SysDialogs.ShowMessage(formatdatetime('yyyy-mm-dd hh:mm:ss',lastModifyDatetime));
                //SysDialogs.ShowMessage(formatdatetime('yyyy-mm-dd hh:mm:ss',LocalFileDatetime));
                SysDialogs.Warning(
                  'ϵͳ�йؼ�����Ҫ���£���رյ�ǰ����ϵͳ�Զ�������������AutoUpdate.exe����');
                ShellExecute(Application.Handle, nil, PChar('AutoUpdate.exe'),
                  nil, nil, SW_SHOWNORMAL);
                exit;
              end;
            end;
          end
          else
          begin

          end;
        end;

        for i := 0 to nodeList.Count - 1 do
        begin
          node := nodeList[i];
          FileName := node.AttributeByName['name'].Value;
          lastModifyDatetime := node.AttributeByName['lastmodify']
            .ValueAsDateTime;
          frompath := downUrl + FileName;
          topath := ExecPath + FileName;
          topathbak := ExecPath + FileName + '.bak';
          if (FileName = 'tst') or (FileName = 'images') or
            (FileName = 'error') then
            continue;
          if FileExists(topath) then
          begin
            // showmessage(IntToStr(i)+topath);
            LocalFileDatetime := GetFileModifyDate(topath);
            if (lastModifyDatetime > LocalFileDatetime) then
            begin
              try
                SysSplashForm.loading('��������' + FileName + '��...');
                if downloadUpdateFile(frompath, topathbak) then
                begin
                  SysSplashForm.loading(FileName + '�����سɹ�...');
                  WriteLog(FileName + '�����سɹ�...');
                  if (FileName = applicationCfgName) then
                  begin
                    updateApp(Ini, topathbak);
                    deletefile(PChar(topathbak));
                  end
                  else
                  begin
                    if deletefile(PChar(topath)) then
                    begin
                      if renamefile(FileName + '.bak', FileName) then
                      begin
                        SysSplashForm.loading(FileName + '.new���������ɹ�...');
                        WriteLog(FileName + '.bak���������ɹ�...');
                      end
                      else
                      begin
                        SysSplashForm.loading(FileName + '.new��������ʧ��...');
                        WriteLog(FileName + '.bak��������ʧ��...');
                      end;
                    end
                    else
                    begin
                      WriteLog(FileName + '��ɾ��ʧ�ܣ�.bak���޷�������...');
                      SysDialogs.Warning('ϵͳ�йؼ���' + FileName +
                          '��Ҫ���£��Զ��������رյ�ǰ�����Ա��Զ�������');
                      ShellExecute(Application.Handle, nil,
                        PChar('AutoUpdate.exe'), nil, nil, SW_SHOWNORMAL);
                      exit;
                    end;
                  end;
                end
                else
                begin
                  SysSplashForm.loading(FileName + '������ʧ��...');
                  WriteLog(FileName + '������ʧ��...');
                end;
              except
                on E: Exception do
                begin
                  // Syslog.WriteErr('ɾ������' + FileName + 'ʧ��...');
                  SysDialogs.Warning('3ϵͳ�йؼ�����Ҫ���£��Զ��������رյ�ǰ�����Ա��Զ�������');
                  ShellExecute(Application.Handle, nil,
                    PChar('AutoUpdate.exe'), nil, nil, SW_SHOWNORMAL);
                  Ini.Free;
                  IdHTTPDownFile.Free;
                  exit;
                end;
              end;
            end;
          end
          else
          begin
            SysSplashForm.loading('��������' + FileName + '��...');
            if downloadUpdateFile(frompath, topath) then
            begin
              SysSplashForm.loading(FileName + '�����سɹ�...');
              WriteLog(FileName + '�����سɹ�...');
            end
            else
            begin
              SysSplashForm.loading(FileName + '������ʧ��...');
              WriteLog(FileName + '������ʧ��...');
            end;
          end;
        end;
        nodeList.Free;
        xml.Free;
      except
        on E: Exception do
        begin
          WriteLog(FileName + '�������쳣...' + E.Message);
        end;
      end;
    finally
      WriteLog('Ini.Free');
      Ini.Free;
      IdHTTPDownFile.Free;
      //SysMainForm.ExitApplication;
    end;
  end
  else
  begin
    SysDialogs.ShowError('�Ҳ���ϵͳ�����ļ���' + applicationCfgName);
    SysMainForm.ExitApplication;
  end;

end;

procedure TUpdatefile.WriteLog(const log: String);
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
    WriteLn(FileHandle, FormatDateTime('[HH:MM:SS]', Now) + '  ' + log);
  finally
    CloseFile(FileHandle);
  end;

end;

initialization

finalization

end.

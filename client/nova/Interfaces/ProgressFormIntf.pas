{------------------------------------
  ����˵�����ȴ�����ӿ�
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit ProgressFormIntf;
interface
Type
  IProgressForm=Interface
    ['{EB844FBC-D5A1-4D1E-9BF6-B17058A1008D}']
    procedure ShowMsg(const MsgStr:String);
    procedure progress(const Max,Position:Integer);
    procedure Hide;
  End;

implementation

end.

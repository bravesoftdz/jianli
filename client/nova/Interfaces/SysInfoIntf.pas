{------------------------------------
  ����˵����ϵͳ��Ϣ�ӿ�
  �������ڣ�2010/11/25
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit SysInfoIntf;
interface
uses LoginUser,CardManage,Generics.Collections;
Type
  ISysInfo=Interface
    ['{AECD69EB-D852-49A8-82A9-BCAE582E1DC4}']

    function getServerURL:string;  //Ӧ�÷���������URL  eg:   http://127.0.0.1:80/Station
    procedure SetServerURL(url:String);
    function getServerSecretKey:string;  //����Ӧ�÷�������Կ
    procedure SetServerSecretKey(secretKey:String);

    function getLocalHostAddress : string;
    procedure setLocalHostAddress(LocalHostAddress:string);
    function getLocalHostName : string;
    procedure setLocalHostName(LocalHostName:string);

    function getCurBillLength:TDictionary<String,Integer>;
    procedure setCurBillLength(FBillLength:TDictionary<String,Integer>);
    function AppPath:string;//����Ŀ¼
    function ErrPath:string;//������־Ŀ¼

    procedure setCardManage(cardManage:TCardManage);
    function getCardManage:TCardManage;

    function getLoginUserInfo:TLoginUserInfo;
    procedure setLoginUserINfo(info:TLoginUserInfo);
    property serverURL:string read getServerURL write SetServerURL;
    property serverSecretKey:string read getServerSecretKey write SetServerSecretKey;
    property LoginUserInfo:TLoginUserInfo read getLoginUserInfo write setLoginUserInfo;
    property LocalHostAddress:String read getLocalHostAddress write setLocalHostAddress;
    property LocalHostName:String read getLocalHostName write setLocalHostName;
    property curBillLength:TDictionary<String,Integer> read getCurBillLength write setCurBillLength;
    property cardManage:TCardManage read getCardManage write setCardManage;
  End;

implementation



end.

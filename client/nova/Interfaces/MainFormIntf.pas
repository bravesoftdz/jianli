{------------------------------------
  ����˵����������ӿ�
  �������ڣ�2010/11/11
  ���ߣ�ice
  ��Ȩ��nova
-------------------------------------}
unit MainFormIntf;
interface

uses Forms,Classes,Graphics,FunctionItemIntf;

Type
  //������ʵ�ֵĽӿ�
  IMainForm=Interface
    ['{5A9D183E-D0BC-4033-BF48-D0CC5DB6270F}']
    //�����˵�,һ������DEBUGʱ,ע��˵�
    function CreateMenu(const Path:string;guid:TGUID;parameters:TFunctionItemParameters):TObject;overload;
    //�����˵�,һ������RELEASEʱ,ע��˵�
    function CreateMenu(id:Integer;name:string;guidstr:string;parameters:TFunctionItemParameters;
                        parentid:integer;isvisible:Boolean;hotkeystr:String):TObject;overload;
    //ȡ��ע��˵�
    procedure DeleteMenu(Const Path:string);
    //����������
    function CreateToolButton(const aCaption:String;onClick:TNotifyEvent;Hint:String=''):TObject;
    //��ʾ״̬
    procedure ShowStatus(PnlIndex:Integer;const Msg:string);
    //�˳�����
    procedure ExitApplication;
    //��ImageList���ͼ��
    function AddImage(Img:TGraphic):Integer;
//    function FindForm(const FormClassName:string):TForm;
    procedure ShowForm(aform:TForm);overload;
    //FormClass:Ҫ�����Ĵ�����       Reference �������
    procedure ShowForm(FormClass:TFormClass;var Reference;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true);overload;
    function showFormModal(FormClass:TFormClass;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true): Integer;overload;
    function showFormModal(aform:TForm;autofree:Boolean=True): Integer; overload;
    procedure CloseForm(aForm:TForm);
    //���ݹ��ܼ�������λTABҳ
    function locationTab(guid: TGUID;parameters: TFunctionItemParameters):boolean;
    procedure loadchrom;
    procedure setLblloginname(const loginname: string);
  End;

implementation

end.

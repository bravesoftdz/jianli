unit SellWayEnd;

interface
uses controls,Generics.Collections,jsonClientDataSet;
Type
  ISellWayEnd=Interface
    ['{5E9C5B67-EBCA-4540-A7F2-A61565C290D9}']
    function getfullThroughControl():TList<TWinControl>;
    function getdefaultThroughControl():TList<TWinControl>;
    function getSellWayreceivablenum:Currency; //��ǰ�������������Ӧ�գ������Ѽ������� �����ڼ���ϼ�Ӧ��
    function show():boolean;
    function execute(cdsticketbuffer:TjsonClientDataSet):boolean;
    function reset():boolean;
    function checkreceipt(needpay:Currency):boolean;
    function getContextHint(winControl: TWinControl):String;
    function getServicefee(cdsticketbuffer:TjsonClientDataSet):Currency;//ȡ�����ų�Ʊ��ȡ�ķ����

    procedure setCurTicketNum(const AValue:integer);
    function getCurTicketNum:integer;
    procedure setCdsSchedule(const AValue:TjsonClientDataSet);
    function getCdsSchedule:TjsonClientDataSet;

    procedure setTotalTicketReceivablenum(const AValue:Currency);
    function getTotalTicketreceivablenum:Currency;
    procedure setTotalticketnum(const AValue:integer);
    function getTotalticketnum:integer;
    procedure setTotalinsurereceivablenum(const AValue:Currency);
    function getTotalinsurereceivablenum:Currency;
    procedure setTotalInsurenum(const AValue:integer);
    function getTotalInsurenum:integer;
    function getIsShowEdit:integer;
    procedure setIsShowEdit(const AValue:integer);
    property curTicketNum:integer read getCurTicketNum write setCurTicketNum;//��ǰƱ��
//    property curInsureNum:integer read getCurInsureNum write setCurInsureNum;//��ǰ����Ʊ��
    property cdsSchedule:TjsonClientDataSet read getCdsSchedule write setCdsSchedule;

    property totalTicketReceivablenum:Currency read getTotalTicketreceivablenum write setTotalTicketReceivablenum;//��ǰ��ƱӦ��+���泵ƱӦ��+���泵Ʊ�����
    property totalTicketNum:integer read getTotalticketnum write setTotalticketnum; //�ϼ���Ʊ��
    property totalInsureReceivableNum:Currency read getTotalinsurereceivablenum write setTotalinsurereceivablenum; //�ϼ��۱��ս��
    property totalInsureNum:integer read getTotalInsurenum write setTotalInsurenum;//�ϼ��۱�����
    property isShowEdit:integer read getIsShowEdit write setIsShowEdit; //�Ƿ���ʾ�༭��
  end;

implementation

end.


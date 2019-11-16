unit SellWayEnd;

interface
uses controls,Generics.Collections,jsonClientDataSet;
Type
  ISellWayEnd=Interface
    ['{5E9C5B67-EBCA-4540-A7F2-A61565C290D9}']
    function getfullThroughControl():TList<TWinControl>;
    function getdefaultThroughControl():TList<TWinControl>;
    function getSellWayreceivablenum:Currency; //当前（不含缓存表）的应收（手续费及其它） ，用于计算合计应收
    function show():boolean;
    function execute(cdsticketbuffer:TjsonClientDataSet):boolean;
    function reset():boolean;
    function checkreceipt(needpay:Currency):boolean;
    function getContextHint(winControl: TWinControl):String;
    function getServicefee(cdsticketbuffer:TjsonClientDataSet):Currency;//取出单张车票收取的服务费

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
    property curTicketNum:integer read getCurTicketNum write setCurTicketNum;//当前票数
//    property curInsureNum:integer read getCurInsureNum write setCurInsureNum;//当前保险票数
    property cdsSchedule:TjsonClientDataSet read getCdsSchedule write setCdsSchedule;

    property totalTicketReceivablenum:Currency read getTotalTicketreceivablenum write setTotalTicketReceivablenum;//当前车票应收+缓存车票应收+缓存车票服务费
    property totalTicketNum:integer read getTotalticketnum write setTotalticketnum; //合计售票数
    property totalInsureReceivableNum:Currency read getTotalinsurereceivablenum write setTotalinsurereceivablenum; //合计售保险金额
    property totalInsureNum:integer read getTotalInsurenum write setTotalInsurenum;//合计售保险数
    property isShowEdit:integer read getIsShowEdit write setIsShowEdit; //是否显示编辑框
  end;

implementation

end.


{ ------------------------------------
  功能说明：Fash窗体接口
  创建日期：2010/11/11
  作者：ice
  版权：nova
  ------------------------------------- }
unit SplashFormIntf;

interface

Type
  ISplashForm = Interface
    ['{09728239-7C14-42C9-89EA-E321DFAC4100}']
    procedure Show;
    procedure loading(const msg: String);
    procedure Hide;
  End;

implementation

end.

{------------------------------------
  功能说明：系统加密接口
  创建日期：2010/11/24
  作者：ice
  版权：nova
-------------------------------------}
unit EncdDecdIntf;
{$weakpackageunit on}
interface

uses Classes;

Type
  IEncdDecd=Interface
    ['{58F6F931-CC76-410E-B17D-AA3BD462DCDB}']
    function Encrypt(const Key,SrcStr:String):String;
    function Decrypt(const Key,SrcStr:String):String;
    function MD5(const Input:string):string;

    procedure Base64EncodeStream(Input, Output: TStream);
    procedure Base64DecodeStream(Input, Output: TStream);
    function  Base64EncodeString(const Input: string): string;
    function  Base64DecodeString(const Input: string): string;
  End;
implementation

end.

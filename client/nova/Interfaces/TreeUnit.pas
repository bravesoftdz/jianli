unit TreeUnit;

interface

uses
  Windows, Messages, SysUtils, ComCtrls, Services,jsonClientDataSet;
type
  TIDXRec = record
    id: string;
    parentid: string;
    NAME: string;
  end;

  PDW_TreeRec = ^TIDXRec;
  PIDXRec = ^TIDXRec;

procedure BuildIDXTree(aCDS: TjsonClientDataSet; aTreeView: TTreeView;
  aExpanFlag: boolean); // 生成指标树

implementation

procedure BuildIDXTree(aCDS: TjsonClientDataSet; aTreeView: TTreeView;
  aExpanFlag: boolean); // 生成指标树
  function diguiNode(aNode: TTreeNode; aP_CODE: string): TTreeNode;
  var
    // i: Integer;
    bflag: boolean;
    newNode: TTreeNode;
  begin
    newNode := aNode;
    Result := nil;
    if newNode = nil then
    begin
      Result := nil;
      Exit;
    end
    else
    begin
      bflag := True;
      while bflag do
      begin
        if Trim(aP_CODE) = '' then
        begin
          Result := nil;
          Exit;
        end
        else
        begin
          if newNode = nil then
          begin
            Result := nil;
            Exit;
          end
          else
          begin
            if UpperCase(PDW_TreeRec(newNode.Data)^.id) = UpperCase(aP_CODE)
              then
            begin
              bflag := False;
              Result := newNode;
              Break;
            end
            else
            begin
              newNode := newNode.Parent;
              if newNode = nil then
              begin
                Result := nil;
                bflag := False;
                Break;
              end;
              newNode := diguiNode(newNode, aP_CODE);
            end;
          end;
        end;
      end;
    end;
    //
  end;
  function aGainXH(aP_CODE: string): TTreeNode; // 再循环一次
  var
    i: Integer;
  begin
    Result := nil;
    for i := 0 to aTreeView.Items.Count - 1 do
    begin
      if UpperCase(Trim(PDW_TreeRec(aTreeView.Items.Item[i].Data)^.id))
        = UpperCase(Trim(aP_CODE)) then
      begin
        Result := aTreeView.Items.Item[i];
        Exit;
      end;
    end;
  end;

var
  // TempCDS: TClientDataSet;
  MyIDXRec: PIDXRec;
  TopNode, newNode1: TTreeNode;
  // i, , count1: Integer;
  // aCode: string;
  // LCODE_len: Integer;
begin
  try
    try
      aTreeView.Items.Clear;
     { New(MyIDXRec);
      MyIDXRec^.id := '0';
      MyIDXRec^.NAME := '所有结算扣费项目';
      MyIDXRec^.parentid := '0';
      TopNode := aTreeView.Items.AddObject(nil, MyIDXRec^.NAME, MyIDXRec); }
      newNode1 := nil;
      with aCDS do
      begin
        first;
        while not eof do
        begin
          New(MyIDXRec);
          MyIDXRec^.id := fieldbyname('id').AsString;
          MyIDXRec^.parentid := fieldbyname('parentid').AsString;
          MyIDXRec^.NAME := fieldbyname('NAME').AsString;
          newNode1 := diguiNode(newNode1, fieldbyname('parentid').AsString);
          if newNode1 = nil then
          begin
            // 在这在写一个方法遍历树一边 ，如果没有那就是根节点
            newNode1 := aGainXH(fieldbyname('parentid').AsString);
            if newNode1 <> nil then
            begin
              newNode1 := aTreeView.Items.AddChildObject(newNode1,
                MyIDXRec^.NAME, MyIDXRec);
            end
            else
            begin
              newNode1 := aTreeView.Items.AddChildObject(nil,
                MyIDXRec^.NAME, MyIDXRec);
            end;
          end
          else
          begin
            newNode1 := aTreeView.Items.AddChildObject(newNode1,
              MyIDXRec^.NAME, MyIDXRec);
          end;
          next;
        end;
      end;
      aTreeView.FullExpand;
    except
      on e: Exception do
      begin
        SysLog.WriteErr('创建结算扣费项目目录树失败：' + e.Message);
        Exit;
      end;
    end;
  finally
  end;
end;

end.

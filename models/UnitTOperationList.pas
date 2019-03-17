unit UnitTOperationList;

interface

uses
  System.SysUtils,
  UnitTOperationListNode,
  UnitTOperation;

type
  TOperationList = class
    protected
      head: TOperationListNode;
      last: TOperationListNode;
      fileName: string[255];
    public
      count: Integer;
      constructor create(const filename: string); overload;
      destructor destroy(); override;
      function getItemsMaxId(): Integer;
      procedure addNode(const item: POperation);
      function getItem(const id: Integer): POperation;
      function removeNode(const id: Integer;
        const destroyItem: Boolean = true): Boolean;
      procedure consoleOutput();
  end;

var
  operList: TOperationList;

implementation

const
  dataDName = 'data';
  operFName = 'data/operations.godev';

constructor TOperationList.create(const filename: string);
var
  f: File of TOperation;
  itemTmp: POperation;
begin
  inherited create();
  self.fileName := filename;
  assignFile(f, self.fileName);
  if not fileExists(self.filename) then
    rewrite(f)
  else
  begin
    reset(f);
    while not eof(f) do
    begin
      new(itemTmp);
      read(f, itemTmp^);
      self.addNode(itemTmp);
    end;
  end;
  closeFile(f);
end;

destructor TOperationList.destroy();
var
  f: File of TOperation;
  nodeCurr: TOperationListNode;
begin
  if self.fileName <> '' then
  begin
    assignFile(f, self.fileName);
    rewrite(f);
    nodeCurr := self.head;
    while nodeCurr <> nil do
    begin
      write(f, nodeCurr.item^);
      nodeCurr := nodeCurr.next;
    end;
    closeFile(f);
  end;
  inherited destroy();
end;

function TOperationList.getItemsMaxId(): Integer;
var
  nodeCurr: TOperationListnode;
begin
  result := 0;
  nodeCurr := self.head;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id > result then
      result := nodeCurr.item^.id;
    nodeCurr := nodeCurr.next;
  end;
end;

procedure TOperationList.addNode(const item: POperation);
var
  node, nodeCurr: TOperationListNode;
begin
  node := TOperationListNode.create(item);
  nodeCurr := self.last;
  while (nodeCurr <> nil) and
    (nodeCurr.item^.date > item^.date) do
  begin
    nodeCurr := nodeCurr.prev;
  end;
  if nodeCurr <> nil then
  begin
    if nodeCurr.next = nil then
      self.last := node
    else
    begin
      node.next := nodeCurr.next;
      (nodeCurr.next).prev := node;
    end;
    node.prev := nodeCurr;
    nodeCurr.next := node;
  end
  else
  begin
    if self.head = nil then
      self.last := node
    else
    begin
      node.next := self.head;
      (self.head).prev := node;
    end;
    self.head := node;
  end;
  inc(self.count);
end;

function TOperationList.getItem(const id: Integer): POperation;
var
  nodeCurr: TOperationListNode;
begin
  result := nil;
  nodeCurr := self.head;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id = id then
    begin
      result := nodeCurr.item;
      break;
    end;
    nodeCurr := nodeCurr.next;
  end;
end;

function TOperationList.removeNode(const id: Integer;
  const destroyItem: Boolean = true): Boolean;
var
  nodeCurr: TOperationListNode;
begin
  result := false;
  nodeCurr := self.head;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id = id then
    begin
      if nodeCurr.prev <> nil then
      begin
        (nodeCurr.prev).next := nodeCurr.next;
        if nodeCurr.next = nil then
          self.last := nodeCurr.prev
        else
          (nodeCurr.next).prev := nodeCurr.prev;
      end
      else
      begin
        self.head := nodeCurr.next;
        if self.head = nil then
          self.last := nil
        else
          (self.head).prev := nil
      end;
      if destroyItem then
        dispose(nodeCurr.item);
      nodeCurr.destroy();
      dec(self.count);
      result := true;
      break;
    end;
    nodeCurr := nodeCurr.next;
  end;
end;

procedure TOperationList.consoleOutput();
var
  nodeCurr: TOperationListNode;
begin
  writeln(self.count, ' ��������� � ������ ��������:');
  nodeCurr := self.head;
  while nodeCurr <> nil do
  begin
    nodeCurr.item^.consoleOutput();
    nodeCurr := nodeCurr.next;
  end;
end;

initialization
  if not directoryExists(dataDName) then
    createDir(dataDName);
  operList := TOperationList.create(operFName);

finalization
  operList.destroy();

end.

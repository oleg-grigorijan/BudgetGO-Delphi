unit UnitTOperationList;

interface

uses
  System.SysUtils,
  DateUtils,
  UnitTOperationListNode,
  UnitTOperation;

type
  TOperationList = class
    private
      head: TOperationListNode;
      last: TOperationListNode;
      fileName: string[255];
      maxId: Integer;
      balance: int64;
      function getNodeById(const id: Integer): TOperationListNode;
      procedure insertNode(const node: TOperationListNode);
      procedure removeNode(const node: TOperationListNode);
    public
      constructor create(const filename: string); overload;
      destructor destroy(); override;
      procedure addItem(const item: POperation);
      function getItem(const id: Integer): POperation;
      function getItems(const month, year: Integer;
        var incomeMonth, outcomeMonth: uint64): TOperations;
      function removeItem(const id: Integer): Boolean;
      function getBalance(): Integer;
      function editItem(const id: Integer; const newItem: POperation): Boolean;
  end;

var
  operList: TOperationList;

implementation

const
  dataDName = 'data';
  operFName = 'data/operations.godev';

function TOperationList.getNodeById(const id: Integer): TOperationListNode;
var
  nodeCurr: TOperationListNode;
begin
  result := nil;
  nodeCurr := self.last;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id = id then
    begin
      result := nodeCurr;
      break;
    end;
    nodeCurr := nodeCurr.prev;
  end;
end;

procedure TOperationList.insertNode(const node: TOperationListNode);
var
  nodeCurr: TOperationListNode;
begin
  nodeCurr := self.last;
  while (nodeCurr <> nil) and
    (nodeCurr.item^.date > node.item^.date) do
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
end;

procedure TOperationList.removeNode(const node: TOperationListNode);
begin
  if node.prev <> nil then
  begin
    (node.prev).next := node.next;
    if node.next = nil then
      self.last := node.prev
    else
      (node.next).prev := node.prev;
  end
  else
  begin
    self.head := node.next;
    if self.head = nil then
      self.last := nil
    else
      (self.head).prev := nil
  end;
  dispose(node.item);
  node.destroy();
end;

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
      self.addItem(itemTmp);
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

procedure TOperationList.addItem(const item: POperation);
var
  node: TOperationListNode;
begin
  node := TOperationListNode.create(item);
  insertNode(node);
  if item^.id = 0 then
  begin
    inc(self.maxId);
    item^.id := self.maxId;
  end
  else if item^.id > self.maxId then
    self.maxId := item^.id;
  case item^.tp of
    income: self.balance := self.balance + item^.money;
    outcome: self.balance := self.balance - item^.money;
  end;
end;

function TOperationList.getItem(const id: Integer): POperation;
var
  node: TOperationListNode;
begin
  result := nil;
  node := getNodeById(id);
  if node <> nil then
    result := node.item;
end;

function TOperationList.getItems(const month, year: Integer;
  var incomeMonth, outcomeMonth: uint64): TOperations;
var
  nodeCurr: TOperationListNode;
  found: Integer;
begin
  found := 0;
  incomeMonth := 0;
  outcomeMonth := 0;
  setLength(result, found);
  nodeCurr := self.last;
  while (nodeCurr <> nil) and
    ((yearOf(nodeCurr.item^.date) <> year) or
    (monthOfTheYear(nodeCurr.item^.date) <> month)) do
  begin
    nodeCurr := nodeCurr.prev;
  end;
  while (nodeCurr <> nil) and
    ((yearOf(nodeCurr.item^.date) = year) and
    (monthOfTheYear(nodeCurr.item^.date) = month)) do
  begin
    inc(found);
    setLength(result, found);
    result[found - 1] := nodeCurr.item;
    case nodeCurr.item^.tp of
      income:
        incomeMonth := incomeMonth + nodeCurr.item^.money;
      outcome:
        outcomeMonth := outcomeMonth + nodeCurr.item^.money;
    end;
    nodeCurr := nodeCurr.prev;
  end;
end;

function TOperationList.removeItem(const id: Integer): Boolean;
var
  node: TOperationListNode;
begin
  result := false;
  node := getNodeById(id);
  if node <> nil then
  begin
    if node.item^.tp = income then
      self.balance := self.balance - node.item^.money
    else if node.item^.tp = outcome then
      self.balance := self.balance + node.item^.money;
    removeNode(node);
    result := true;
  end;
end;

function TOperationList.editItem(const id: Integer; const newItem: POperation): Boolean;
var
  oldItem: POperation;
  node: TOperationListNode;
begin
  result := false;
  node := getNodeById(id);
  if node <> nil then
  begin
    oldItem := node.item;
    newItem^.id := oldItem^.id;
    case oldItem^.tp of
      income:
        balance := balance - oldItem^.money;
      outcome:
        balance := balance + oldItem^.money;
    end;
    case newItem^.tp of
      income:
        balance := balance + newItem^.money;
      outcome:
        balance := balance - newItem^.money;
    end;
    if (node.prev = nil) or
      (node.prev.item^.date <= newItem^.date) then
    begin
      node.item := newItem;
      dispose(oldItem);
    end
    else
    begin
      removeNode(node);
      node := TOperationListNode.create(newItem);
      insertNode(node);
    end;
    result := true;
  end;
end;

function TOperationList.getBalance(): Integer;
begin
  result := self.balance;
end;

initialization
  if not directoryExists(dataDName) then
    createDir(dataDName);
  operList := TOperationList.create(operFName);

finalization
  operList.destroy();

end.

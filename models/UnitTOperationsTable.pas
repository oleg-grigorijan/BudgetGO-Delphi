unit UnitTOperationsTable;

interface

uses
  System.SysUtils,
  DateUtils,
  UnitTOperation;

type
  TOperationListNode = class
  private
    item: POperation;
    next: TOperationListNode;
    prev: TOperationListNode;
  public
    constructor create(const item: POperation);
  end;

  TOperationsTable = class
  private
    fBalance: int64;
    fileName: string[255];
    head: TOperationListNode;
    last: TOperationListNode;
    maxId: Integer;
    function getNodeById(const id: Integer):
      TOperationListNode;
    procedure insertNode(const node: TOperationListNode);
    procedure removeNode(const node: TOperationListNode);
  public
    constructor create(const filename: string); overload;
    destructor destroy(); override;
    procedure addItem(const item: POperation);
    function getItem(const id: Integer): POperation;
    function getItems(const month, year: Integer):
      TOperations;
    function removeItem(const id: Integer): Boolean;
    procedure removeItems(const tp: TOperationType;
      const catId: Integer);
    function editItem(const id: Integer;
      const newItem: POperation): Boolean;
    property balance: int64 read fBalance;
  end;

var
  opers: TOperationsTable;

implementation

const
  dataDName = 'data';
  operFName = 'data/operations.godev';

constructor TOperationListNode.create(const item:
  POperation);
begin
  inherited create();
  self.item := item;
end;

function TOperationsTable.getNodeById(const id: Integer):
  TOperationListNode;
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

procedure TOperationsTable.insertNode(const node:
  TOperationListNode);
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

procedure TOperationsTable.removeNode(const node:
  TOperationListNode);
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

constructor TOperationsTable.create(const filename:
  string);
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

destructor TOperationsTable.destroy();
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

procedure TOperationsTable.addItem(const item: POperation);
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
    income: self.fBalance := self.fBalance + item^.money;
    outcome: self.fBalance := self.fBalance - item^.money;
  end;
end;

function TOperationsTable.getItem(const id: Integer):
  POperation;
var
  node: TOperationListNode;
begin
  result := nil;
  node := getNodeById(id);
  if node <> nil then
    result := node.item;
end;

function TOperationsTable.getItems(const month, year:
  Integer): TOperations;
var
  nodeCurr: TOperationListNode;
  found: Integer;
begin
  found := 0;
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
    nodeCurr := nodeCurr.prev;
  end;
end;

function TOperationsTable.removeItem(const id: Integer):
  Boolean;
var
  node: TOperationListNode;
begin
  result := false;
  node := getNodeById(id);
  if node <> nil then
  begin
    if node.item^.tp = income then
      self.fBalance := self.fBalance - node.item^.money
    else if node.item^.tp = outcome then
      self.fBalance := self.fBalance + node.item^.money;
    removeNode(node);
    result := true;
  end;
end;

procedure TOperationsTable.removeItems(
  const tp: TOperationType;
  const catId: Integer
);
var
  nodeCurr, nodeTmp: TOperationListNode;
begin
  nodeCurr := self.last;
  while nodeCurr <> nil do
    if (nodeCurr.item^.tp = tp) and
      (nodeCurr.item^.catId = catId) then
    begin
      nodeTmp := nodeCurr;
      nodeCurr := nodeCurr.prev;
      if nodeTmp.item^.tp = income then
        self.fBalance := self.fBalance -
          nodeTmp.item^.money
      else if nodeTmp.item^.tp = outcome then
        self.fBalance := self.fBalance +
          nodeTmp.item^.money;
      removeNode(nodeTmp);
    end
    else
      nodeCurr := nodeCurr.prev;
end;

function TOperationsTable.editItem(const id: Integer;
  const newItem: POperation): Boolean;
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
        fBalance := fBalance - oldItem^.money;
      outcome:
        fBalance := fBalance + oldItem^.money;
    end;
    case newItem^.tp of
      income:
        fBalance := fBalance + newItem^.money;
      outcome:
        fBalance := fBalance - newItem^.money;
    end;
    if ((node.prev = nil) or
      (node.prev.item^.date <= newItem^.date)) and
      ((node.next = nil) or
      (node.next.item^.date >= newItem^.date)) then
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

initialization
  if not directoryExists(dataDName) then
    createDir(dataDName);
  opers := TOperationsTable.create(operFName);

finalization
  opers.destroy();

end.

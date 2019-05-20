unit UnitOperationsTable;

interface

uses
  System.SysUtils, DateUtils, UnitEvents, UnitOperation;

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
    fEventOpersUpd: TEventManager;
    fBalance: int64;
    fileName: string;
    head: TOperationListNode;
    last: TOperationListNode;
    maxId: integer;
    function getNodeById(const id: integer)
      : TOperationListNode;
    procedure insertNode(const node: TOperationListNode);
    procedure removeNode(const node: TOperationListNode);
  public
    constructor create(); overload;
    constructor create(const fileName: string); overload;
    destructor destroy(); override;
    procedure addItem(const item: POperation);
    function getItem(const id: integer): POperation;
    function getItems(const month, year: integer)
      : TOperations;
    procedure removeItem(const id: integer);
    procedure removeItems(const tp: TOperationType;
      const catId: integer);
    procedure editItem(const id: integer;
      const newItem: POperation);

    property eventOpersUpd: TEventManager
      read fEventOpersUpd;
    property balance: int64 read fBalance;
  end;

implementation

constructor TOperationListNode.create(const item
  : POperation);
begin
  inherited create();
  self.item := item;
end;

function TOperationsTable.getNodeById(const id: integer)
  : TOperationListNode;
var
  nodeCurr: TOperationListNode;
begin
  nodeCurr := last;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id = id then
    begin
      result := nodeCurr;
      exit;
    end;
    nodeCurr := nodeCurr.prev;
  end;
  raise exception.create('Invalid operation id');
end;

procedure TOperationsTable.insertNode(const node
  : TOperationListNode);
var
  nodeCurr: TOperationListNode;
begin
  nodeCurr := last;
  while (nodeCurr <> nil) and
    (nodeCurr.item^.date > node.item^.date) do
    nodeCurr := nodeCurr.prev;
  if nodeCurr <> nil then
  begin
    if nodeCurr.next = nil then
      last := node
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
    if head = nil then
      last := node
    else
    begin
      node.next := head;
      head.prev := node;
    end;
    head := node;
  end;
end;

procedure TOperationsTable.removeNode(const node
  : TOperationListNode);
begin
  if node.prev <> nil then
  begin
    (node.prev).next := node.next;
    if node.next = nil then
      last := node.prev
    else
      (node.next).prev := node.prev;
  end
  else
  begin
    head := node.next;
    if head = nil then
      last := nil
    else
      head.prev := nil
  end;
  dispose(node.item);
  node.destroy();
end;

constructor TOperationsTable.create();
begin
  inherited create();
  fEventOpersUpd := TEventManager.create();
end;

constructor TOperationsTable.create(const fileName
  : string);
{ Table creation with elements import from the file. }
var
  f: File of TOperation;
  itemTmp: POperation;
begin
  create();
  self.fileName := fileName;
  assignFile(f, fileName);
  if not fileExists(fileName) then
    rewrite(f)
  else
  begin
    reset(f);
    while not eof(f) do
    begin
      new(itemTmp);
      read(f, itemTmp^);
      addItem(itemTmp);
    end;
  end;
  closeFile(f);
end;

destructor TOperationsTable.destroy();
{ Table destruction with elements export to the file. }
var
  f: File of TOperation;
  nodeCurr: TOperationListNode;
begin
  if fileName <> '' then
  begin
    assignFile(f, fileName);
    rewrite(f);
    nodeCurr := head;
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
    inc(maxId);
    item^.id := maxId;
  end
  else if item^.id > maxId then
    maxId := item^.id;
  fBalance := fBalance + item^.getDelta;
  eventOpersUpd.notify();
end;

function TOperationsTable.getItem(const id: integer)
  : POperation;
begin
  result := getNodeById(id).item;
end;

function TOperationsTable.getItems(const month,
  year: integer): TOperations;
var
  nodeCurr: TOperationListNode;
  found: integer;
begin
  found := 0;
  setLength(result, found);
  nodeCurr := last;
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

procedure TOperationsTable.removeItem(const id: integer);
var
  node: TOperationListNode;
begin
  node := getNodeById(id);
  fBalance := fBalance - node.item^.getDelta;
  removeNode(node);
  eventOpersUpd.notify();
end;

procedure TOperationsTable.removeItems
  (const tp: TOperationType; const catId: integer);
{ Removing all items with the given operation type and
  category id. }
var
  nodeCurr, nodeTmp: TOperationListNode;
begin
  nodeCurr := last;
  while nodeCurr <> nil do
    if (nodeCurr.item^.tp = tp) and
      (nodeCurr.item^.catId = catId) then
    begin
      nodeTmp := nodeCurr;
      nodeCurr := nodeCurr.prev;
      fBalance := fBalance - nodeTmp.item^.getDelta;
      removeNode(nodeTmp);
    end
    else
      nodeCurr := nodeCurr.prev;
  eventOpersUpd.notify();
end;

procedure TOperationsTable.editItem(const id: integer;
  const newItem: POperation);
{ Changing fields of operation with the given id
  to fields of newItem. }
var
  oldItem: POperation;
  node: TOperationListNode;
begin
  node := getNodeById(id);
  oldItem := node.item;
  newItem^.id := oldItem^.id;
  fBalance := fBalance - oldItem^.getDelta +
    newItem^.getDelta;
  if ((node.prev = nil) or (node.prev.item^.date <=
    newItem^.date)) and
    ((node.next = nil) or (node.next.item^.date >=
    newItem^.date)) then
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
  eventOpersUpd.notify();
end;

end.

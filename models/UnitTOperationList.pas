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
      count: Integer;
      balance: Integer;
    public
      constructor create(const filename: string); overload;
      destructor destroy(); override;
      procedure addNode(const item: POperation);
      function getItem(const id: Integer): POperation;
      function getItems(const month, year: Integer;
        var incomeMonth, outcomeMonth: Longword): TOperations;
      function removeNode(const id: Integer;
        const destroyItem: Boolean = true): Boolean;
      function getBalance(): Integer;
      function editItem(const id: Integer;
        const money: Longword; const catId: Integer;
        const description: string; const date: TDate): Boolean;
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
  if item^.id = 0 then
  begin
    inc(self.maxId);
    item^.id := self.maxId;
  end
  else if item^.id > self.maxId then
    self.maxId := item^.id;
    if item^.tp = income then
      self.balance := self.balance + item^.money
    else if item^.tp = outcome then
      self.balance := self.balance - item^.money;
  inc(self.count);
end;

function TOperationList.getItem(const id: Integer): POperation;
var
  nodeCurr: TOperationListNode;
begin
  result := nil;
  nodeCurr := self.last;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id = id then
    begin
      result := nodeCurr.item;
      break;
    end;
    nodeCurr := nodeCurr.prev;
  end;
end;

function TOperationList.getItems(const month, year: Integer;
  var incomeMonth, outcomeMonth: Longword): TOperations;
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

function TOperationList.removeNode(const id: Integer;
  const destroyItem: Boolean = true): Boolean;
var
  nodeCurr: TOperationListNode;
begin
  result := false;
  nodeCurr := self.last;
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
      if nodeCurr.item^.tp = income then
        self.balance := self.balance - nodeCurr.item^.money
      else if nodeCurr.item^.tp = outcome then
        self.balance := self.balance + nodeCurr.item^.money;
      if destroyItem then
        dispose(nodeCurr.item);
      nodeCurr.destroy();
      dec(self.count);
      result := true;
      break;
    end;
    nodeCurr := nodeCurr.prev;
  end;
end;

function TOperationList.editItem(const id: Integer;
  const money: Longword; const catId: Integer;
  const description: string; const date: TDate): Boolean;
var
  item: POperation;
  nodeCurr: TOperationListNode;
begin
  result := false;
  nodeCurr := self.last;
  while nodeCurr <> nil do
  begin
    if nodeCurr.item^.id = id then
    begin
      item := nodeCurr.item;
      if item^.money <> money then
        case item^.tp of
          income:
            balance := balance - item^.money + money;
          outcome:
            balance := balance + item^.money - money;
        end;
      item^.money := money;
      item^.catId := catId;
      item^.description := description;
      item^.date := date;
      if (nodeCurr.prev <> nil) and
        (nodeCurr.prev.item^.date > date) then
      begin
        removeNode(item^.id, false);
        addNode(item);
      end;
      result := true;
      break;
    end;
    nodeCurr := nodeCurr.prev;
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

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
      count: Longword;
      constructor create(const filename: string); overload;
      destructor destroy(); override;
      function getItemsMaxId(): Longword;
      procedure addNode(const item: POperation);
      function getItem(const id: Longword): POperation;
      function removeNode(const id: Longword;
        const destroyItem: Boolean = true): Boolean;
      procedure consoleOutput();
  end;

implementation

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

function TOperationList.getItemsMaxId(): Longword;
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

function TOperationList.getItem(const id: Longword): POperation;
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

function TOperationList.removeNode(const id: Longword;
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
  writeln(self.count, ' элементов в списке:');
  nodeCurr := self.head;
  while nodeCurr <> nil do
  begin
    writeln('id: ',nodeCurr.item^.id);
    write('  тип: ');
    case nodeCurr.item^.tp of
      income: writeln('доход');
      outcome: writeln('расход');
    end;
    writeln('  сумма: ', nodeCurr.item^.money div 100,
      ' руб. ', nodeCurr.item^.money mod 100, ' коп.');
    writeln('  id хранилища: ', nodeCurr.item^.storageId);
    writeln('  id категории: ', nodeCurr.item^.categoryId);
    writeln('  дата: ', dateToStr(nodeCurr.item^.date));
    writeln('  описание: ', nodeCurr.item^.description);
    nodeCurr := nodeCurr.next;
  end;
end;

end.

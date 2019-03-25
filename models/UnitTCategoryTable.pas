unit UnitTCategoryTable;

interface

uses
  UnitTCategory,
  UnitTOperation,
  System.SysUtils;

type
  TCategoryTable = class
    private
      items: TCategories;
      count: Integer;
      fileName: string[255];
      function getItemIndex(const id: Integer): Integer;
    public
      constructor create(const fileName: string); overload;
      destructor destroy(); override;
      function addItem(const item: PCategory): Boolean;
      function getItem(const id: Integer): PCategory;
      function getItems(): TCategories; overload;
      function getItems(const operTp: TOperationType): TCategories; overload;
      function removeItem(const id: Integer): Boolean;
  end;

var
  catTable: TCategoryTable;

implementation

const
  dataDName = 'data';
  catFName = 'data/categories.godev';

function TCategoryTable.getItemIndex(const id: Integer): Integer;
var
  l, r, k: Integer;
begin
  result := -1;
  l := 0;
  r := self.count - 1;
  while l <= r do
  begin
    k := (l + r) div 2;
    if self.items[k]^.id < id then
      l := k + 1
    else if self.items[k]^.id > id then
      r := k - 1
    else
    begin
      result := k;
      break;
    end;
  end;
end;

constructor TCategoryTable.create(const fileName: string);
var
  f: File of TCategory;
  itemTmp: PCategory;
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

destructor TCategoryTable.destroy();
var
  f: File of TCategory;
  i: Integer;
begin
  if self.fileName <> '' then
  begin
    assignFile(f, self.fileName);
    rewrite(f);
    for i := 0 to self.count - 1 do
      write(f, self.items[i]^);
    closeFile(f);
  end;
  inherited destroy();
end;

function TCategoryTable.addItem(const item: PCategory): Boolean;
var
  i: Integer;
begin
  result := true;
  for i := 0 to self.count - 1 do
    if (self.items[i]^.name = item^.name) and
      (self.items[i]^.operTp = item^.operTp) then
      result := false;
  if result then
  begin
    if item^.id = 0 then
      if self.count = 0 then
        item^.id := 1
      else
        item^.id := self.items[count - 1]^.id + 1;
    inc(self.count);
    setLength(items, self.count);
    self.items[count - 1] := item;
  end;
end;

function TCategoryTable.getItem(const id: Integer): PCategory;
var
  i: Integer;
begin
  result := nil;
  i := getItemIndex(id);
  if i >= 0 then
    result := self.items[i];
end;

function TCategoryTable.getItems(): TCategories;
begin
  result := self.items;
end;

function TCategoryTable.getItems(const operTp: TOperationType): TCategories;
var
  i, found: Integer;
begin
  found := 0;
  setLength(result, found);
  for i := 0 to self.count - 1 do
    if self.items[i]^.operTp = operTp then
    begin
      inc(found);
      setLength(result, found);
      result[found - 1] := self.items[i];
    end;
end;

function TCategoryTable.removeItem(const id: Integer): Boolean;
var
  i, j: Integer;
begin
  result := false;
  i := getItemIndex(id);
  if i >= 0 then
  begin
    dec(self.count);
    dispose(self.items[i]);
    for j := i to count - 1 do
      self.items[j] := self.items[j + 1];
    result := true;
  end;
end;

initialization
  if not directoryExists(dataDName) then
    createDir(dataDName);
  catTable := TCategoryTable.create(catFName);

finalization
  catTable.destroy();

end.

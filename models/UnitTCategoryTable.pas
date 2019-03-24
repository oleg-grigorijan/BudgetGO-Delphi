unit UnitTCategoryTable;

interface

uses
  UnitTCategory,
  System.SysUtils;

type
  TCategoryTable = class
    private
      items: TCategories;
      count: Integer;
      fileName: string[255];
    public
      constructor create(const fileName: string); overload;
      destructor destroy(); override;
      function addItem(const item: PCategory): Boolean;
      function getItem(const id: Integer): PCategory;
      function removeItem(const id: Integer): Boolean;
      procedure consoleOutput();
  end;

var
  catTable: TCategoryTable;

implementation

const
  dataDName = 'data';
  catFName = 'data/categories.godev';

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
    inc(count);
    setLength(items, count);
    self.items[count - 1] := item;
  end;
end;

function TCategoryTable.getItem(const id: Integer): PCategory;
var
  i, l, r: Integer;
begin
  result := nil;
  l := 0;
  r := count - 1;
  while l <= r do
  begin
    i := (l + r) div 2;
    if self.items[i]^.id < id then
      l := i + 1
    else if self.items[i]^.id > id then
      r := i - 1
    else
    begin
      result := self.items[i];
      break;
    end;
  end;
end;

function TCategoryTable.removeItem(const id: Integer): Boolean;
var
  i, j, l, r: Integer;
begin
  result := false;
  l := 0;
  r := count - 1;
  while l <= r do
  begin
    i := (l + r) div 2;
    if self.items[i]^.id < id then
      l := i + 1
    else if self.items[i]^.id > id then
      r := i - 1
    else
    begin
      result := true;
      dec(self.count);
      dispose(self.items[i]);
      for j := i to count - 1 do
        self.items[j] := self.items[j + 1];
      break;
    end;
  end;
end;

procedure TCategoryTable.consoleOutput();
var
  i: Integer;
begin
  writeln(self.count, ' элементов в таблице категорий:');
  for i := 0 to self.count - 1 do
    self.items[i]^.consoleOutput();
end;

initialization
  if not directoryExists(dataDName) then
    createDir(dataDName);
  catTable := TCategoryTable.create(catFName);

finalization
  catTable.destroy();

end.

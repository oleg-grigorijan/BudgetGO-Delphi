unit UnitTCategoryTable;

interface

uses
  UnitTCategory,
  System.SysUtils,

  UnitTOperation; // for console output

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

implementation

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
  i: Integer;
begin
  result := nil;
  for i := id - 1 downto 0 do
    if self.items[i]^.id = id then
      result := self.items[i];
end;

function TCategoryTable.removeItem(const id: Integer): Boolean;
var
  i, j: Integer;
begin
  result := false;
  for i := id - 1 downto 0 do
    if self.items[i]^.id = id then
    begin
      result := true;
      dec(self.count);
      dispose(self.items[i]);
      for j := i to count - 1 do
        self.items[j] := self.items[j + 1];
      break;
    end;
end;

procedure TCategoryTable.consoleOutput();
var
  i: Integer;
begin
  writeln(self.count, ' элементов в таблице:');
  for i := 0 to self.count - 1 do
  begin
    writeln('id: ', self.items[i]^.id);
    write('  тип: ');
    case self.items[i]^.operTp of
      income: writeln('доход');
      outcome: writeln('расход');
    end;
    writeln('  название: ', self.items[i]^.name);
  end;
end;

end.

unit UnitCategoriesTable;

interface

uses
  UnitCategory,
  UnitOperation,
  UnitEvents,
  System.SysUtils;

type
  TCategoriesTable = class
  private
    fEventCatsUpd: TEventManager;
    fCount: Integer;
    fileName: string[255];
    fItems: TCategories;
    fOperTp: TOperationType;
    function checkNameUnique(const name: string): Boolean;
    function getItemByIndex(const i: Integer): PCategory;
  public
    constructor create(const tp: TOperationType); overload;
    constructor create(const fileName: string;
      const tp: TOperationType); overload;
    destructor destroy(); override;
    function getItemIndex(const id: Integer): Integer;
    function addItem(const item: PCategory): Boolean;
    function editItem(const id: Integer;
      const newItem: PCategory): Boolean;
    function getItem(const id: Integer): PCategory;
    function removeItem(const id: Integer): Boolean;

    property eventCatsUpd: TEventManager
      read fEventCatsUpd;
    property operTp: TOperationType read fOperTp;
    property items[const i: Integer]: PCategory
      read getItemByIndex;
    property count: Integer read fCount;
  end;

implementation

function TCategoriesTable.checkNameUnique(const name:
  string): Boolean;
var
  i: Integer;
begin
  result := true;
  for i := 0 to self.fCount - 1 do
    if (self.fItems[i]^.name = name) then
    begin
      result := false;
      break;
    end;
end;

function TCategoriesTable.getItemIndex(const id: Integer):
  Integer;
var
  l, r, k: Integer;
begin
  result := -1;
  l := 0;
  r := self.fCount - 1;
  while l <= r do
  begin
    k := (l + r) div 2;
    if self.fItems[k]^.id < id then
      l := k + 1
    else if self.fItems[k]^.id > id then
      r := k - 1
    else
    begin
      result := k;
      break;
    end;
  end;
end;

constructor TCategoriesTable.create(const tp:
  TOperationType);
begin
  inherited create();
  fOperTp := tp;
  case tp of
    income: fEventCatsUpd := TEventManager.create();
    outcome: fEventCatsUpd := TEventManager.create();
  end;
end;

constructor TCategoriesTable.create(const fileName: string;
  const tp: TOperationType);
var
  f: File of TCategory;
  itemTmp: PCategory;
begin
  create(tp);
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

destructor TCategoriesTable.destroy();
var
  f: File of TCategory;
  i: Integer;
begin
  if self.fileName <> '' then
  begin
    assignFile(f, self.fileName);
    rewrite(f);
    for i := 0 to self.fCount - 1 do
      write(f, self.fItems[i]^);
    closeFile(f);
  end;
  inherited destroy();
end;

function TCategoriesTable.addItem(const item: PCategory):
  Boolean;
begin
  result := checkNameUnique(item^.name);
  if result then
  begin
    if item^.id = 0 then
      if self.fCount = 0 then
        item^.id := 1
      else
        item^.id := self.fItems[fCount - 1]^.id + 1;
    inc(self.fCount);
    setLength(fItems, self.fCount);
    self.fItems[fCount - 1] := item;
  end;
  eventCatsUpd.notify();
end;

function TCategoriesTable.editItem(const id: Integer;
  const newItem: PCategory): Boolean;
var
  i: Integer;
begin
  result := false;
  i := getItemIndex(id);
  if i >= 0 then
    if (newItem^.name = fItems[i].name) or
      checkNameUnique(newItem^.name) then
    begin
      newItem^.id := fItems[i]^.id;
      dispose(fItems[i]);
      fItems[i] := newItem;
      result := true;
    end;
  eventCatsUpd.notify();
end;

function TCategoriesTable.getItem(const id: Integer):
  PCategory;
var
  i: Integer;
begin
  result := nil;
  i := getItemIndex(id);
  if i >= 0 then
    result := self.fItems[i];
end;

function TCategoriesTable.getItemByIndex(const i: Integer):
  PCategory;
begin
  result := self.fItems[i];
end;

function TCategoriesTable.removeItem(const id: Integer):
  Boolean;
var
  i, j: Integer;
begin
  result := false;
  i := getItemIndex(id);
  if i >= 0 then
  begin
    dec(self.fCount);
    dispose(self.fItems[i]);
    for j := i to fCount - 1 do
      self.fItems[j] := self.fItems[j + 1];
    setLength(fItems, self.fCount);
    result := true;
    eventCatsUpd.notify();
  end;
end;

end.

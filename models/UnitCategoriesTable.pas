﻿unit UnitCategoriesTable;

interface

uses
  UnitCategory, UnitOperation, UnitEvents, System.SysUtils;

type
  TCategoriesTable = class
  private
    fEventCatsUpd: TEventManager;
    fCount: integer;
    fileName: string;
    fItems: TCategories;
    fOperTp: TOperationType;
    function checkNameUnique(const name: string): boolean;
  public
    constructor create(const tp: TOperationType); overload;
    constructor create(const fileName: string;
      const tp: TOperationType); overload;
    destructor destroy(); override;
    function addItem(const item: PCategory): boolean;
    function getItem(const id: integer): PCategory;
    function getItemByIndex(const i: integer): PCategory;
    function getItemIndex(const id: integer): integer;
    function editItem(const id: integer;
      const newItem: PCategory): boolean;
    procedure removeItem(const id: integer);

    property eventCatsUpd: TEventManager
      read fEventCatsUpd;
    property operTp: TOperationType read fOperTp;
    property items[const i: integer]: PCategory
      read getItemByIndex;
    property count: integer read fCount;
  end;

implementation

function TCategoriesTable.checkNameUnique(const name
  : string): boolean;
{ Checking whether there is a table element
  with the given name. }
var
  i: integer;
begin
  result := true;
  for i := 0 to count - 1 do
    if (fItems[i]^.name = name) then
    begin
      result := false;
      exit;
    end;
end;

function TCategoriesTable.getItemIndex
  (const id: integer): integer;
var
  l, r, k: integer;
begin
  l := 0;
  r := count - 1;
  while l <= r do
  begin
    k := (l + r) div 2;
    if fItems[k]^.id < id then
      l := k + 1
    else if fItems[k]^.id > id then
      r := k - 1
    else
    begin
      result := k;
      exit;
    end;
  end;
  raise exception.Create('Invalid category id');
end;

constructor TCategoriesTable.create(const tp
  : TOperationType);
begin
  inherited create();
  fOperTp := tp;
  case tp of
  income:
    fEventCatsUpd := TEventManager.create();
  outcome:
    fEventCatsUpd := TEventManager.create();
  end;
end;

constructor TCategoriesTable.create(const fileName: string;
  const tp: TOperationType);
{ Table creation with elements import from the file. }
var
  f: File of TCategory;
  itemTmp: PCategory;
begin
  create(tp);
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

destructor TCategoriesTable.destroy();
{ Table destruction with elements export to the file. }
var
  f: File of TCategory;
  i: integer;
begin
  if fileName <> '' then
  begin
    assignFile(f, fileName);
    rewrite(f);
    for i := 0 to count - 1 do
      write(f, fItems[i]^);
    closeFile(f);
  end;
  inherited destroy();
end;

function TCategoriesTable.addItem(const item
  : PCategory): boolean;
begin
  result := checkNameUnique(item^.name);
  if result then
  begin
    if item^.id = 0 then
      if count = 0 then
        item^.id := 1
      else
        item^.id := fItems[count - 1]^.id + 1;
    inc(fCount);
    setLength(fItems, count);
    fItems[count - 1] := item;
  end;
  eventCatsUpd.notify();
end;

function TCategoriesTable.editItem(const id: integer;
  const newItem: PCategory): boolean;
var
  i: integer;
begin
  result := false;
  i := getItemIndex(id);
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

function TCategoriesTable.getItem(const id: integer)
  : PCategory;
begin
  result := fItems[getItemIndex(id)];
end;

function TCategoriesTable.getItemByIndex(const i: integer)
  : PCategory;
begin
  result := fItems[i];
end;

procedure TCategoriesTable.removeItem(const id: integer);
var
  i, j: integer;
begin
  i := getItemIndex(id);
  dec(fCount);
  dispose(fItems[i]);
  for j := i to count - 1 do
    fItems[j] := fItems[j + 1];
  setLength(fItems, count);
  eventCatsUpd.notify();
end;

end.

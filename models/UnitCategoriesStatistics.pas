unit UnitCategoriesStatistics;

interface

uses
  UnitCategoriesTable, UnitOperation,
  UnitOperationsStatistics, UnitEvents, System.SysUtils;

type
  TCatsStatus = (csEmpty, csSuccess, csFail);
  TCatsMoney = array of longword;

  TCategoriesStatistics = class(TInterfacedObject,
    ISubscriber)
  private
    fEventCatsMoneyUpd: TEventManager;
    fEventCatsStatusUpd: TEventManager;
    opersStats: TOperationsStatistics;
    cats: TCategoriesTable;
    fMoney: TCatsMoney;
    fStatus: TCatsStatus;
    procedure recountCatsMoney();
    procedure determineCatsStatus();
  public
    constructor create(const cats: TCategoriesTable;
      const opersStats: TOperationsStatistics);
    procedure onEvent(const sender: TObject);

    property catsTable: TCategoriesTable read cats;
    property money: TCatsMoney read fMoney;
    property status: TCatsStatus read fStatus;
    property eventCatsMoneyUpd: TEventManager
      read fEventCatsMoneyUpd;
    property eventCatsStatusUpd: TEventManager
      read fEventCatsStatusUpd;
  end;

implementation

constructor TCategoriesStatistics.create(const cats
  : TCategoriesTable;
  const opersStats: TOperationsStatistics);
begin
  inherited create();

  self.cats := cats;
  self.cats.eventCatsUpd.follow(self);

  self.opersStats := opersStats;
  self.opersStats.eventOpersCurrUpd.follow(self);

  fEventCatsMoneyUpd := TEventManager.create();
  fEventCatsStatusUpd := TEventManager.create();

  recountCatsMoney();
  determineCatsStatus();
end;

procedure TCategoriesStatistics.recountCatsMoney();
var
  i, j: integer;
  moneyOld: TCatsMoney;
  isUpdNeeded: boolean;
begin
  isUpdNeeded := false;
  moneyOld := fMoney;
  fMoney := nil;
  setLength(fMoney, cats.count);
  
  for i := 0 to length(opersStats.opersCurr) - 1 do
    with opersStats.opersCurr[i]^ do
      if tp = cats.operTp then
      begin
        j := cats.getItemIndex(catId);
        fMoney[j] := fMoney[j] + money;
      end;

  if length(moneyOld) <> cats.count then
    isUpdNeeded := true
  else
    for i := 0 to cats.count - 1 do
      if moneyOld[i] <> money[i] then
      begin
        isUpdNeeded := true;
        break;
      end;  
    
  if isUpdNeeded then
    eventCatsMoneyUpd.notify();
end;

procedure TCategoriesStatistics.determineCatsStatus();
var
  i: integer;
  oldStatus: TCatsStatus;
begin
  oldStatus := status;
  if cats.count = 0 then
    fStatus := csEmpty
  else
  begin
    fStatus := csSuccess;
    for i := 0 to cats.count - 1 do
      case cats.operTp of
      income:
        if fMoney[i] < cats.items[i]^.moneyMonth then
          fStatus := csFail;
      outcome:
        if (cats.items[i]^.moneyMonth <> 0) and
          (fMoney[i] > cats.items[i]^.moneyMonth) then
          fStatus := csFail;
      end;
  end;
  if oldStatus <> status then
    eventCatsStatusUpd.notify();
end;

procedure TCategoriesStatistics.onEvent(const sender
  : TObject);
begin
  if (sender = cats.eventCatsUpd) or
    (sender = opersStats.eventOpersCurrUpd) then
  begin
    recountCatsMoney;
    determineCatsStatus;
  end
  else
    raise exception.create('Unexpected event');
end;

end.

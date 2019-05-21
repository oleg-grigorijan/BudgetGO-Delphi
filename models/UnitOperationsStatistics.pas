unit UnitOperationsStatistics;

interface

uses
  UnitOperation, UnitOperationsTable, UnitEvents,
  System.SysUtils;

type
  TOperationsStatistics = class(TInterfacedObject,
    ISubscriber)
  private
    fEventOpersCurrUpd: TEventManager;
    fMonthCurr: integer;
    fYearCurr: integer;
    fOpersCurr: TOperations;
    opers: TOperationsTable;
    fIncomeMonth: longword;
    fOutcomeMonth: longword;
    procedure recountIncomeOutcome();
    procedure updOpersCurr();
  public
    constructor create(const opers: TOperationsTable;
      const month, year: integer);
    procedure setYearCurr(const year: integer);
    procedure setMonthCurr(const month: integer);
    procedure onEvent(const sender: TObject);

    property opersTable: TOperationsTable read opers;
    property opersCurr: TOperations read fOpersCurr;
    property yearCurr: integer read fYearCurr
      write setYearCurr;
    property monthCurr: integer read fMonthCurr
      write setMonthCurr;
    property incomeMonth: longword read fIncomeMonth;
    property outcomeMonth: longword read fOutcomeMonth;
    property eventOpersCurrUpd: TEventManager
      read fEventOpersCurrUpd;
  end;

implementation

constructor TOperationsStatistics.create(const opers
  : TOperationsTable; const month, year: integer);
begin
  inherited create();
  self.opers := opers;
  opers.eventOpersUpd.follow(self);

  fEventOpersCurrUpd := TEventManager.create();

  fMonthCurr := month;
  fYearCurr := year;
  updOpersCurr();
end;

procedure TOperationsStatistics.setYearCurr(const year
  : integer);
begin
  if fYearCurr <> year then
  begin
    fYearCurr := year;
    updOpersCurr();
  end;
end;

procedure TOperationsStatistics.setMonthCurr(const month
  : integer);
begin
  if fMonthCurr <> month then
  begin
    fMonthCurr := month;
    updOpersCurr();
  end;
end;

procedure TOperationsStatistics.updOpersCurr();
var
  opersNew: TOperations;
  isUpdNeeded: boolean;
  i: integer;
begin
  opersNew := opers.getItems(monthCurr, yearCurr);
  isUpdNeeded := false;
  if length(opersNew) <> length(opersCurr) then
    isUpdNeeded := true
  else
    for i := 0 to length(opersNew) - 1 do
    if opersNew[i] <> opersCurr[i] then
    begin
      isUpdNeeded := true;
      break;
    end;

  if isUpdNeeded then
  begin
    fOpersCurr := opersNew;
    recountIncomeOutcome();
    eventOpersCurrUpd.notify();
  end;
end;

procedure TOperationsStatistics.recountIncomeOutcome();
var
  i: integer;
begin
  fIncomeMonth := 0;
  fOutcomeMonth := 0;
  for i := 0 to length(fOpersCurr) - 1 do
    with fOpersCurr[i]^ do
      case tp of
      income:
        fIncomeMonth := fIncomeMonth + money;
      outcome:
        fOutcomeMonth := fOutcomeMonth + money;
      end;
end;

procedure TOperationsStatistics.onEvent(const sender
  : TObject);
begin
  if sender = opers.eventOpersUpd then
    updOpersCurr()
  else
    raise exception.create('Unexpected event');
end;

end.

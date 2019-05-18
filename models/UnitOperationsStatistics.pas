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
    procedure setOpersCurr(const opCurr: TOperations);
  public
    constructor create(const opers: TOperationsTable;
      const month, year: integer);
    procedure setYearCurr(const year: integer);
    procedure setMonthCurr(const month: integer);
    procedure onEvent(const sender: TObject);

    property opersTable: TOperationsTable read opers;
    property opersCurr: TOperations read fOpersCurr
      write setOpersCurr;
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
  setOpersCurr(opers.getItems(monthCurr, yearCurr));
end;

procedure TOperationsStatistics.setYearCurr(const year
  : integer);
begin
  fYearCurr := year;
  setOpersCurr(opers.getItems(monthCurr, yearCurr));
end;

procedure TOperationsStatistics.setMonthCurr(const month
  : integer);
begin
  fMonthCurr := month;
  setOpersCurr(opers.getItems(monthCurr, yearCurr));
end;

procedure TOperationsStatistics.setOpersCurr(const opCurr
  : TOperations);
begin
  fOpersCurr := opCurr;
  recountIncomeOutcome();
  eventOpersCurrUpd.notify();
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
    setOpersCurr(opers.getItems(monthCurr, yearCurr))
  else
    raise exception.create('Unexpected event');
end;

end.

program BudgetGO;

{$R *.dres}

uses
  UnitCategoriesTable in 'models\UnitCategoriesTable.pas',
  UnitCategory in 'models\UnitCategory.pas',
  UnitOperation in 'models\UnitOperation.pas',
  UnitOperationsTable in 'models\UnitOperationsTable.pas',
  UnitCategoriesStatistics in 'models\UnitCategoriesStatistics.pas',
  UnitOperationsStatistics in 'models\UnitOperationsStatistics.pas',
  UnitEvents in 'components\UnitEvents.pas',
  UnitMoneyUtils in 'components\UnitMoneyUtils.pas',
  UnitCategoriesView in 'views\UnitCategoriesView.pas' {categoriesView},
  UnitCategoryView in 'views\UnitCategoryView.pas' {categoryView},
  UnitHomeView in 'views\UnitHomeView.pas' {homeView},
  UnitOperationView in 'views\UnitOperationView.pas' {operationView},
  Vcl.Forms,
  System.SysUtils,
  System.DateUtils;

{$R *.res}

var
  opers: TOperationsTable;
  opersStats: TOperationsStatistics;
  catsIncome: TCategoriesTable;
  catsIncomeStats: TCategoriesStatistics;
  catsOutcome: TCategoriesTable;
  catsOutcomeStats: TCategoriesStatistics;

const
  dataDName = 'data';
  operFName = dataDName + '/operations.godev';
  catIncomeFName = dataDName + '/categories_i.godev';
  catOutcomeFName = dataDName + '/categories_o.godev';

begin
  if not directoryExists(dataDName) then
    createDir(dataDName);

  opers := TOperationsTable.create(operFName);
  opersStats := TOperationsStatistics.create(opers,
    monthOfTheYear(date), yearOf(date));

  catsIncome := TCategoriesTable.create
    (catIncomeFName, income);
  catsIncomeStats := TCategoriesStatistics.create
    (catsIncome, opersStats);

  catsOutcome := TCategoriesTable.create
    (catOutcomeFName, outcome);
  catsOutcomeStats := TCategoriesStatistics.create
    (catsOutcome, opersStats);

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(ThomeView, homeView);
  homeView.setModels(opersStats, catsincomeStats,
    catsOutcomeStats);
  Application.Run;

  opers.free();
  catsIncome.free();
  catsOutcome.free();
end.

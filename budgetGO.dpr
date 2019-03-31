program BudgetGO;

{$R *.dres}

uses
  UnitMoneyUtils in 'components\UnitMoneyUtils.pas',
  UnitTCategoriesTable in 'models\UnitTCategoriesTable.pas',
  UnitTCategory in 'models\UnitTCategory.pas',
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationsTable in 'models\UnitTOperationsTable.pas',
  UnitTCategoriesView in 'views\UnitTCategoriesView.pas' {categoriesView},
  UnitTCategoryView in 'views\UnitTCategoryView.pas' {categoryView},
  UnitTHomeView in 'views\UnitTHomeView.pas' {homeView},
  UnitTOperationView in 'views\UnitTOperationView.pas' {operationView},
  Vcl.Forms;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(ThomeView, homeView);
  Application.Run;

end.

program BudgetGO;

uses
  Vcl.Forms,
  UnitTHomeView in 'views\UnitTHomeView.pas' {homeView},
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationList in 'models\UnitTOperationList.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas',
  UnitTOperationView in 'views\UnitTOperationView.pas' {OperationView},
  UnitTCategory in 'models\UnitTCategory.pas',
  UnitTCategoryTable in 'models\UnitTCategoryTable.pas',
  UnitTCategoriesView in 'views\UnitTCategoriesView.pas' {categoriesView},
  UnitTCategoryView in 'views\UnitTCategoryView.pas' {categoryView},
  UnitMoneyUtils in 'components\UnitMoneyUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(ThomeView, homeView);
  Application.Run;
end.

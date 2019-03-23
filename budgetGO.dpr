program BudgetGO;

uses
  Vcl.Forms,
  UnitTHomeView in 'views\UnitTHomeView.pas' {homeView},
  UnitTCategory in 'models\UnitTCategory.pas',
  UnitTCategoryTable in 'models\UnitTCategoryTable.pas',
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationList in 'models\UnitTOperationList.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(THomeView, homeView);
  Application.Run;
end.

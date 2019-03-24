program BudgetGO;

uses
  Vcl.Forms,
  UnitTHomeView in 'views\UnitTHomeView.pas' {homeView},
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationList in 'models\UnitTOperationList.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas',
  UnitTOperationView in 'views\UnitTOperationView.pas' {OperationView};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(ThomeView, homeView);
  Application.CreateForm(TOperationView, OperationView);
  Application.Run;
end.

program budgetGO;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas';

begin
  try

  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

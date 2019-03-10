program budgetGO;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas',
  UnitTOperationList in 'models\UnitTOperationList.pas';

var
  operList: TOperationList;
  operTmp: POperation;

begin
  try
    operList := TOperationList.create;
    readln;
    operList.destroy()
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

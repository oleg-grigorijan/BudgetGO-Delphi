program budgetGO;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas',
  UnitTOperationList in 'models\UnitTOperationList.pas';

const
  dataDName = 'data';
  operFName = 'data/operations.godev';

var
  operList: TOperationList;
  operTmp: POperation;
  i: integer;

begin
  try
    if not directoryExists(dataDName) then
      createDir(dataDName);
    operList := TOperationList.create(operFName);

    readln;

    operList.destroy()
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

program budgetGO;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  UnitTOperation in 'models\UnitTOperation.pas',
  UnitTOperationListNode in 'models\UnitTOperationListNode.pas',
  UnitTOperationList in 'models\UnitTOperationList.pas',
  UnitTCategory in 'models\UnitTCategory.pas',
  UnitTCategoryTable in 'models\UnitTCategoryTable.pas';

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
    //{
    for i := 0 to 3 do
    begin
      new(operTmp);
      operTmp^.id := operList.getItemsMaxId + 1;
      operList.addNode(operTmp);
    end;
    //}
    operlist.consoleOutput;
    readln;

    operList.destroy()
  except
    on E: Exception do
      Writeln(E.ClassName, ': ', E.Message);
  end;
end.

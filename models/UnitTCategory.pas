unit UnitTCategory;

interface

uses
  UnitTOperation;

type
  PCategory = ^TCategory;
  TCategory = record
    id: Integer;
    name: string[255];
    operTp: TOperationType;
    procedure consoleOutput();
  end;
  TCategories = array of PCategory;

implementation

procedure TCategory.consoleOutput();
begin
  writeln('id: ', self.id);
  write('  тип: ');
  case self.operTp of
    income: writeln('доход');
    outcome: writeln('расход');
  end;
  writeln('  название: ', self.name);
end;

end.

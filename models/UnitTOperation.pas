unit UnitTOperation;

interface

uses
  System.SysUtils;

type
  TOperationType = (income, outcome);
  TOperation = record
    id: Integer;
    tp: TOperationType;
    money: Longword;
    categoryId: Integer;
    date: TDateTime;
    description: string[255];
    procedure consoleOutput();
  end;
  TOperations = array of TOperation;
  POperation = ^TOperation;

implementation

procedure TOperation.consoleOutput();
begin
  writeln('id: ', self.id);
  write('  тип: ');
  case self.tp of
    income: writeln('доход');
    outcome: writeln('расход');
  end;
  writeln('  сумма: ', self.money div 100,
    ' руб. ', self.money mod 100, ' коп.');
  writeln('  id категории: ', self.categoryId);
  writeln('  дата: ', dateToStr(self.date));
  writeln('  описание: ', self.description);
end;

end.

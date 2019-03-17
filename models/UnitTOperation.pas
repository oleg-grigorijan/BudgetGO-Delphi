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
  write('  ���: ');
  case self.tp of
    income: writeln('�����');
    outcome: writeln('������');
  end;
  writeln('  �����: ', self.money div 100,
    ' ���. ', self.money mod 100, ' ���.');
  writeln('  id ���������: ', self.categoryId);
  writeln('  ����: ', dateToStr(self.date));
  writeln('  ��������: ', self.description);
end;

end.

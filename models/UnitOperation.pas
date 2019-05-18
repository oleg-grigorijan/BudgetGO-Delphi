unit UnitOperation;

interface

const
  OPER_DESC_LEN = 30;

type
  TOperationType = (income, outcome);

  TOperation = packed record
    id: integer;
    tp: TOperationType;
    money: longword;
    catId: integer;
    date: TDate;
    description: string[OPER_DESC_LEN];
    function getDelta(): longword;
  end;

  POperation = ^TOperation;
  TOperations = array of POperation;

implementation

uses
  System.SysUtils;

function TOperation.getDelta(): longword;
begin
  case tp of
  income:
    result := money;
  outcome:
    result := -money;
  else
    raise exception.create('Unexpected operation type');
  end;
end;

end.

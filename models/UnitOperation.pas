unit UnitOperation;

interface

const
  OPER_DESC_LEN = 30;

type
  TOperationType = (income, outcome);
  TOperation = packed record
    id: Integer;
    tp: TOperationType;
    money: Longword;
    catId: Integer;
    date: TDate;
    description: string[OPER_DESC_LEN];
    function getDelta(): Longword;
  end;
  POperation = ^TOperation;
  TOperations = array of POperation;

implementation

function TOperation.getDelta(): Longword;
begin
  case tp of
    income: result := money;
    outcome: result := -money;
  end;
end;

end.

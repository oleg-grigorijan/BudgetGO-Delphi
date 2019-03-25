unit UnitTOperation;

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
  end;
  POperation = ^TOperation;
  TOperations = array of POperation;

implementation

end.

unit UnitTOperation;

interface

const
  DESC_LEN = 32;

type
  TOperationType = (income, outcome);
  TOperation = record
    id: Integer;
    tp: TOperationType;
    money: Longword;
    catId: Integer;
    date: TDate;
    description: string[DESC_LEN];
  end;
  POperation = ^TOperation;
  TOperations = array of POperation;

implementation

end.

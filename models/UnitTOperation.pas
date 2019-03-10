unit UnitTOperation;

interface

type
  TOperationType = (income, outcome);
  TOperation = record
    public
      id: Longword;
      tp: TOperationType;
      money: Longword;
      storageId: Longword;
      categoryId: Longword;
      date: TDateTime;
      description: string[255];
  end;
  TOperations = array of TOperation;
  POperation = ^TOperation;

implementation

end.

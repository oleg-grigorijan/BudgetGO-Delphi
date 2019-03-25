unit UnitTCategory;

interface

uses
  UnitTOperation;

const
  OPER_NAME_LEN = 18;

type
  PCategory = ^TCategory;
  TCategory = packed record
    id: Integer;
    name: string[OPER_NAME_LEN];
    operTp: TOperationType;
    moneyMonth: Longword;
  end;
  TCategories = array of PCategory;

implementation

end.

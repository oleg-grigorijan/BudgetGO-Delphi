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
    case operTp: TOperationType of
      income: ();
      outcome: (maxMoney: Longword);
  end;
  TCategories = array of PCategory;

implementation

end.

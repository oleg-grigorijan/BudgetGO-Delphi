unit UnitTCategory;

interface

const
  CAT_NAME_LEN = 18;

type
  PCategory = ^TCategory;
  TCategory = packed record
    id: Integer;
    name: string[CAT_NAME_LEN];
    moneyMonth: Longword;
  end;
  TCategories = array of PCategory;

implementation

end.

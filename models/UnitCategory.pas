unit UnitCategory;

interface

const
  CAT_NAME_LEN = 18;

type
  PCategory = ^TCategory;

  TCategory = packed record
    id: integer;
    name: string[CAT_NAME_LEN];
    moneyMonth: longword;
  end;

  TCategories = array of PCategory;

implementation

end.

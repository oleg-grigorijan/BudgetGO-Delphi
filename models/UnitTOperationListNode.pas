unit UnitTOperationListNode;

interface

uses
  UnitTOperation;

type
  TOperationListNode = class
    public
      item: POperation;
      next: TOperationListNode;
      prev: TOperationListNode;
      constructor create(const item: POperation);
  end;

implementation

constructor TOperationListNode.create(const item: POperation);
begin
  inherited create();
  self.item := item;
end;

end.

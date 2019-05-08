unit UnitEvents;

interface

uses
  System.SysUtils;

type
  ISubscriber = interface
    procedure onEvent(const sender: TObject);
  end;

  TEventManager = class
  private
    subscribers: array of ISubscriber;
  public
    procedure follow(const subscriber: ISubscriber);
    procedure notify();
  end;

implementation

procedure TEventManager.follow(const subscriber: ISubscriber);
begin
  setLength(subscribers, length(subscribers) + 1);
  subscribers[length(subscribers) - 1] := subscriber;
end;

procedure TEventManager.notify();
var
  i: integer;
begin
  for i := 0 to length(subscribers) - 1 do
    subscribers[i].onEvent(self);
end;

end.

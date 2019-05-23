unit UnitMoneyUtils;

interface

uses
  System.SysUtils;

function moneyToStr(const money: integer): string;
function strToMoney(const rubles, penny: string): integer;

implementation

function moneyToStr(const money: integer): string;
begin
  result := floatToStrF(money / 100, ffFixed, 7, 2);
end;

function strToMoney(const rubles, penny: string): Integer;
begin
  result := 0;
  if rubles <> '' then
    result := result + strToInt(rubles) * 100;
  if penny <> '' then
    result := result + strToInt(penny);
end;

end.

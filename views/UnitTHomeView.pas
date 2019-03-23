unit UnitTHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitTOperationView, UnitTOperationList, UnitTOperation,
  Vcl.Menus, Vcl.Grids, IdBaseComponent, IdComponent,
  IdIPAddrMon, DateUtils, Vcl.ExtCtrls;

type
  THomeView = class(TForm)
    lblHeader: TLabel;
    lblBalanceAfter: TLabel;
    lblBalance: TLabel;
    Label1: TLabel;
    btnCreateIncome: TButton;
    btnCreateOutcome: TButton;
    lbl3: TLabel;
    grdOperations: TStringGrid;
    lblStatistics: TLabel;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    lblIncomeAfter: TLabel;
    lblIncome: TLabel;
    lbl1: TLabel;
    lblOutcome: TLabel;
    shp3: TShape;
    shpIncome: TShape;
    shpOutcome: TShape;
    procedure actionInit(Sender: TObject);
    procedure actionOperationView(Sender: TObject);
    procedure actionUpdateStatistics(Sender: TObject);
  private
    opersCurr: TOperations;
  public
    procedure dataUpdate();
  end;

var
  homeView: ThomeView;

implementation

{$R *.dfm}

procedure THomeView.actionInit(Sender: TObject);
var
  i: Integer;
begin
  cbbMonth.ItemIndex := monthOfTheYear(date()) - 1;
  for i := currentYear downto 2010 do
    cbbYear.items.add(IntToStr(i));
  cbbYear.ItemIndex := 0;
  with grdOperations do
  begin
    cells[1, 0] := 'Тип';
    cells[2, 0] := 'Сумма';
    cells[3, 0] := 'Категория';
    cells[4, 0] := 'День';
    cells[5, 0] := 'Описание';
  end;
  dataUpdate();
end;

procedure THomeView.actionOperationView(Sender: TObject);
begin
  if not assigned(operationView) then
    operationView := TOperationView.create(self);
  if Sender = btnCreateIncome then
    operationView.prepareToCreate(income)
  else if Sender = btnCreateOutcome then
    operationView.prepareToCreate(outcome);
  operationView.ShowModal;
  if operationView.ModalResult = mrOk then
  begin
    dataUpdate();
    messageBox(handle, 'Операция успешно сохранена', PChar('Уведомление'),
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure THomeView.actionUpdateStatistics(Sender: TObject);
begin
  dataUpdate();
end;

procedure THomeView.dataUpdate();
var
  incomeMonth, outcomeMonth: Longword;
  i: Integer;
begin
  lblBalance.caption := floatToStrF(operList.getBalance
    / 100, ffFixed, 7, 2);
  IntToStr(operList.getBalance);
  opersCurr := operList.getItems(cbbMonth.itemIndex + 1,
    strToInt(cbbYear.text), incomeMonth, outcomeMonth);
  lblIncome.caption := floatToStrF(incomeMonth / 100,
    ffFixed, 7, 2) + ' руб.';
  lblOutcome.caption := floatToStrF(outcomeMonth / 100,
    ffFixed, 7, 2) + ' руб.';
  if incomeMonth + outcomeMonth = 0 then
    shpIncome.width := 0
  else
    shpIncome.width := 280*incomeMonth div (incomeMonth +
      outcomeMonth);
  with grdOperations do
  begin
    RowCount := Length(opersCurr) + 1;
    for i := 1 to Length(opersCurr) do
    begin

      Cells[0, i] := IntToStr(i);
      with opersCurr[i - 1]^ do
      begin
        case tp of
          income:
            Cells[1, i] := 'Доход';
          outcome:
            Cells[1, i] := 'Расход';
        end;
        Cells[2, i] :=  FloatToStrF(money / 100, ffFixed,
          7, 2) + ' руб.';
        Cells[4, i] := intToStr(dayOfTheMonth(date));
        Cells[5, i] := description;
      end;
    end;
  end;
end;

end.

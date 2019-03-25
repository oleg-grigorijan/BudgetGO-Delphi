unit UnitTHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitTOperationView, UnitTOperationList, UnitTOperation,
  Vcl.Menus, Vcl.Grids,
  DateUtils, Vcl.ExtCtrls, UnitTCategory, UnitTCategoryTable;

type
  THomeView = class(TForm)
    btnCreateIncome: TButton;
    btnCreateOutcome: TButton;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    grdOperations: TStringGrid;
    lbl3: TLabel;
    lblBalance: TLabel;
    lblBalanceAfter: TLabel;
    lblHeader: TLabel;
    lblIncome: TLabel;
    lblIncomeBefore: TLabel;
    lblNewOperationBefore: TLabel;
    lblOutcome: TLabel;
    lblOutcomeBefore: TLabel;
    lblStatistics: TLabel;
    miDelete: TMenuItem;
    miEdit: TMenuItem;
    miRepeat: TMenuItem;
    pmOperation: TPopupMenu;
    shpHeaderBG: TShape;
    shpIncome: TShape;
    shpOutcome: TShape;
    procedure actionInit(Sender: TObject);
    procedure actionOperationDelete(Sender: TObject);
    procedure actionOperationSelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
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
  cbbMonth.itemIndex := monthOfTheYear(date()) - 1;
  for i := currentYear downto 2010 do
    cbbYear.items.add(IntToStr(i));
  cbbYear.itemIndex := 0;
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

procedure THomeView.actionOperationDelete(Sender: TObject);
var
  answer: Integer;
begin
  if grdOperations.tag <> 0 then
  begin
    answer := MessageBox(handle, 'Вы действительно хотите удалить операцию?' +
      #13#10 + 'Удалённые данные будет невозможно восстановить.',
      'Уведомление', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    if answer = IDYES then
    begin
      operList.removeItem(grdOperations.tag);
      dataUpdate();
    end;
  end;
end;

procedure THomeView.actionOperationSelect(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col, row: Integer;
begin
  grdOperations.mouseToCell(X, Y, col, row);
  grdOperations.col := col;
  if grdOperations.rowCount = 1 then
    grdOperations.tag := 0
  else
  begin
    if row = 0 then
      grdOperations.row := 1
    else
      grdOperations.row := row;
    grdOperations.tag := opersCurr[grdOperations.row - 1]^.id;
  end;
end;

procedure THomeView.actionOperationView(Sender: TObject);
begin
  if not assigned(operationView) then
    operationView := TOperationView.create(self);
  if Sender = btnCreateIncome then
    operationView.prepareToCreate(income)
  else if Sender = btnCreateOutcome then
    operationView.prepareToCreate(outcome)
  else if (Sender = miEdit) or (Sender = grdOperations) then
    operationView.prepareToEdit(grdOperations.tag)
  else if Sender = miRepeat then
    operationView.prepareToRepeat(grdOperations.tag);
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
  incomeMonth, outcomeMonth: uint64;
  i: Integer;
begin
  lblBalance.caption := floatToStrF(operList.getBalance
    / 100, ffFixed, 7, 2) + ' руб.';
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
    shpIncome.width := shpOutcome.width*incomeMonth div
      (incomeMonth + outcomeMonth);
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
            cells[1, i] := 'Доход';
          outcome:
            cells[1, i] := 'Расход';
        end;
        cells[2, i] :=  FloatToStrF(money / 100, ffFixed,
          7, 2) + ' руб.';
        cells[3, i] := catTable.getItem(catId)^.name;
        cells[4, i] := intToStr(dayOfTheMonth(date));
        cells[5, i] := description;
      end;
    end;
  end;
end;

end.

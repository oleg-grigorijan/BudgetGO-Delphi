unit UnitTCategoriesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Grids, Vcl.ComCtrls, UnitTCategory, UnitTCategoryTable, UnitTOperation, UnitTCategoryView,
  Vcl.Menus, UnitTOperationList, UnitTHomeView, UnitMoneyUtils,
  Vcl.ExtCtrls;

type
  TCategoriesView = class(TForm)
    btnCreate: TButton;
    grdCategories: TStringGrid;
    lblHeader: TLabel;
    miEdit: TMenuItem;
    pmCategory: TPopupMenu;
    tbcOperType: TTabControl;
    miDelete: TMenuItem;
    lblNoCategories: TLabel;
    shpNoCategoriesBG: TShape;
    procedure actionCategorySelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure actionCategoryView(Sender: TObject);
    procedure actionCategoryDelete(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOnTypeChange(Sender: TObject);
  private
    tpCurr: TOperationType;
  public
    procedure dataUpdate();
  end;

var
  categoriesView: TcategoriesView;

implementation

{$R *.dfm}

procedure TCategoriesView.actionCategorySelect(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col, row: Integer;
begin
  grdCategories.mouseToCell(X, Y, col, row);
  grdCategories.col := col;
  if grdCategories.rowCount = 1 then
    grdCategories.tag := 0
  else
  begin
    if row = 0 then
      grdCategories.row := 1
    else
      grdCategories.row := row;
    case tpCurr of
      income:
        grdCategories.tag := catsIncome.getItems[grdCategories.row - 1]^.id;
      outcome:
        grdCategories.tag := catsOutcome.getItems[grdCategories.row - 1]^.id;
    end;
  end;
end;

procedure TCategoriesView.actionCategoryView(Sender: TObject);
var
  success: Boolean;
begin
  repeat
  if not assigned(categoryView) then
    categoryView := TCategoryView.create(self);
  if Sender = btnCreate then
    categoryView.prepareToCreate(tpCurr)
  else if (Sender = miEdit) or
    (Sender = grdCategories) then
    categoryView.prepareToEdit(tpCurr, grdCategories.tag);
  categoryView.showModal;
  success := true;
  if categoryView.modalResult = mrOk then
  begin
    dataUpdate();
    homeView.updateData();
    messageBox(handle, 'Категория успешно сохранена', PChar('Уведомление'),
      MB_OK + MB_ICONINFORMATION);
  end
  else if categoryView.modalResult = mrAbort then
    if messageBox(Handle, 'Категория с таким именем и типом уже существует.',
      'Уведомление', MB_RETRYCANCEL + MB_ICONSTOP) = IDRETRY then
    success := false;
  until success;
end;

procedure TCategoriesView.actionCategoryDelete(Sender: TObject);
var
  answer: Integer;
begin
  if grdCategories.tag <> 0 then
  begin
    answer := MessageBox(handle, 'Вы действительно хотите удалить категоирю?' +
      #13#10 + 'Также будут удалены все операции с данной категорией.' +
      #13#10 + 'Удалённые данные будет невозможно восстановить.',
      'Уведомление', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    if answer = IDYES then
    begin
      operList.removeItems(tpCurr, grdCategories.tag);
      case tpCurr of
        income: catsIncome.removeItem(grdCategories.tag);
        outcome: catsOutcome.removeItem(grdCategories.tag);
      end;
      dataUpdate();
      homeView.updateData();
    end;
  end;
end;

procedure TCategoriesView.actionInit(Sender: TObject);
begin
  grdCategories.cells[1, 0] := 'Название';
  dataUpdate();
end;

procedure TCategoriesView.actionOnTypeChange(Sender: TObject);
begin
  dataUpdate();
end;

procedure TCategoriesView.dataUpdate();
var
  catsCurr: TCategories;
  i: Integer;
begin
  case tbcOperType.tabIndex of
    0: // income tab
    begin
      self.tpCurr := income;
      grdCategories.cells[2, 0] := 'Минимально в мес.';
      catsCurr := catsIncome.getItems();
    end;
    1: // outcome tab
    begin
      self.tpCurr := outcome;
      grdCategories.cells[2, 0] := 'Максимально в мес.';
      catsCurr := catsOutcome.getItems();
    end;
  end;
  if length(catsCurr) = 0 then
    grdCategories.visible := false
  else
  with grdCategories do
  begin
    visible := true;
    rowCount := length(catsCurr) + 1;
    for i := 1 to length(catsCurr) do
    begin
      cells[0, i] := IntToStr(i);
      with catsCurr[i - 1]^ do
      begin
        cells[1, i] := name;
        if moneyMonth = 0 then
          cells[2, i] := ''
        else
          cells[2, i] := moneyToStr(moneyMonth) + ' руб.';
      end;
    end;
  end;
end;

end.

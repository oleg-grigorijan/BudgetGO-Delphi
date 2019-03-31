unit UnitTCategoriesView;

interface

uses
  System.Classes,
  System.SysUtils,
  UnitMoneyUtils,
  UnitTCategoriesTable,
  UnitTCategory,
  UnitTCategoryView,
  UnitTOperation,
  UnitTOperationsTable,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Menus,
  Vcl.StdCtrls,
  Winapi.Windows;

type
  TCategoriesView = class(TForm)
    btnCreate: TButton;
    grdCategories: TStringGrid;
    lblHeader: TLabel;
    lblNoCategories: TLabel;
    miDelete: TMenuItem;
    miEdit: TMenuItem;
    pmCategory: TPopupMenu;
    shpNoCategoriesBG: TShape;
    tbcOperType: TTabControl;
    procedure actionCategoryDelete(Sender: TObject);
    procedure actionCategorySelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure actionCategoryView(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOnTypeChange(Sender: TObject);
  private
    const
      INCOME_TAB = 0;
      OUTCOME_TAB = 1;
    var
      catsCurr: TCategoriesTable;
      selectedCatId: Integer;
  public
    procedure updateData();
  end;

var
  categoriesView: TcategoriesView;

implementation

{$R *.dfm}

uses
  UnitTHomeView;

procedure TCategoriesView.actionCategoryDelete(Sender:
  TObject);
var
  answer: Integer;
begin
  if selectedCatId <> 0 then
  begin
    answer := messageBox(handle,
      'Вы действительно хотите удалить категоирю?' + #13#10 +
      'Также будут удалены все операции с данной категорией.' +
      #13#10 + 'Удалённые данные будет невозможно восстановить.',
      'Уведомление', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    if answer = IDYES then
    begin
      opers.removeItems(catsCurr.operTp, selectedCatId);
      catsCurr.removeItem(selectedCatId);
      updateData();
      homeView.updateData();
    end;
  end;
end;

procedure TCategoriesView.actionCategorySelect(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X, Y: Integer
);
var
  col, row: Integer;
begin
  grdCategories.mouseToCell(X, Y, col, row);
  grdCategories.col := col;
  if grdCategories.rowCount = 1 then
    selectedCatId := 0
  else
  begin
    if row = 0 then
      grdCategories.row := 1
    else
      grdCategories.row := row;
    selectedCatId :=
      catsCurr.items[grdCategories.row - 1]^.id;
  end;
end;

procedure TCategoriesView.actionCategoryView(Sender:
  TObject);
var
  success: Boolean;
begin
  repeat
  if not assigned(categoryView) then
    categoryView := TCategoryView.create(self);

  if Sender = btnCreate then
    categoryView.prepareToCreate(catsCurr)
  else if (Sender = miEdit) or
    (Sender = grdCategories) then
    categoryView.prepareToEdit(catsCurr, selectedCatId);

  categoryView.showModal;
  success := true;
  if categoryView.modalResult = mrOk then
  begin
    updateData();
    homeView.updateData();
    messageBox(handle, 'Категория успешно сохранена',
      PChar('Уведомление'), MB_OK + MB_ICONINFORMATION);
  end
  else if categoryView.modalResult = mrAbort then
    if messageBox(Handle,
      'Категория с таким именем и типом уже существует.',
      'Уведомление', MB_RETRYCANCEL + MB_ICONSTOP) =
      IDRETRY then
    success := false;
  until success;
end;

procedure TCategoriesView.actionInit(Sender: TObject);
begin
  grdCategories.cells[1, 0] := 'Название';
  actionOnTypeChange(self);
  updateData();
end;

procedure TCategoriesView.actionOnTypeChange(Sender:
  TObject);
begin
  case tbcOperType.tabIndex of
    INCOME_TAB:
    begin
      btnCreate.caption := 'Новая категория дохода';
      grdCategories.cells[2, 0] := 'Минимально в мес.';
      catsCurr := catsIncome;
    end;
    OUTCOME_TAB:
    begin
      btnCreate.caption := 'Новая категория расхода';
      grdCategories.cells[2, 0] := 'Максимально в мес.';
      catsCurr := catsOutcome;
    end;
  end;
  updateData();
end;

procedure TCategoriesView.updateData();
var
  i: Integer;
begin
  if catsCurr.count = 0 then
    grdCategories.visible := false
  else
  with grdCategories do
  begin
    visible := true;
    rowCount := catsCurr.count + 1;
    for i := 1 to catsCurr.count do
    begin
      cells[0, i] := IntToStr(i);
      with catsCurr.items[i - 1]^ do
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

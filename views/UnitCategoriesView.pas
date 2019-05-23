unit UnitCategoriesView;

interface

uses
  System.Classes, System.SysUtils, UnitMoneyUtils,
  UnitCategoriesTable, UnitCategory, UnitCategoryView,
  UnitOperation, UnitOperationsTable, Vcl.ComCtrls,
  Vcl.Controls, Vcl.ExtCtrls, Vcl.Forms, Vcl.Grids,
  Vcl.Menus, Vcl.StdCtrls, Winapi.Windows;

type
  TCategoriesView = class(TForm)
    // Components
    btnCreate: TButton;
    grdCategories: TStringGrid;
    lblHeader: TLabel;
    lblNoCategories: TLabel;
    miDelete: TMenuItem;
    miEdit: TMenuItem;
    pmCategory: TPopupMenu;
    shpNoCategoriesBG: TShape;
    tbcOperType: TTabControl;

    constructor create(owner: TComponent;
      const opers: TOperationsTable;
      const catsIncome, catsOutcome
      : TCategoriesTable);

    // Actions
    procedure actionCategoryDelete(Sender: TObject);
    procedure actionCategorySelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: integer);
    procedure actionCategoryView(Sender: TObject);
    procedure actionOnTypeChange(Sender: TObject);
  private
  const
    INCOME_TAB = 0;
    OUTCOME_TAB = 1;
  var
    // Models
    opers: TOperationsTable;
    cats: array [TOperationType] of TCategoriesTable;
    catsCurr: TCategoriesTable;

    selectedCatId: integer;
  public
    procedure updateData();
  end;

implementation

{$R *.dfm}

constructor TCategoriesView.create(owner: TComponent;
  const opers: TOperationsTable;
  const catsIncome, catsOutcome: TCategoriesTable);
begin
  inherited create(owner);
  self.opers := opers;
  cats[income] := catsIncome;
  cats[outcome] := catsOutcome;

  grdCategories.cells[1, 0] := '��������';
  actionOnTypeChange(self);
  updateData();
end;

procedure TCategoriesView.actionCategoryDelete
  (Sender: TObject);
var
  answer: integer;
begin
  if selectedCatId <> 0 then
  begin
    answer := messageBox(handle,
      '�� ������������� ������ ������� ���������?' + #13#10
      + '����� ����� ������� ��� �������� � ������ ����������.'
      + #13#10 +
      '�������� ������ ����� ���������� ������������.',
      '�����������', MB_YESNO + MB_ICONQUESTION +
      MB_DEFBUTTON2);
    if answer = IDYES then
    begin
      opers.removeItems(catsCurr.operTp, selectedCatId);
      catsCurr.removeItem(selectedCatId);
      updateData();
    end;
  end;
end;

procedure TCategoriesView.actionCategorySelect
  (Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: integer);
var
  col, row: integer;
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
    selectedCatId := catsCurr.items
      [grdCategories.row - 1]^.id;
  end;
end;

procedure TCategoriesView.actionCategoryView
  (Sender: TObject);
var
  categoryView: TCategoryView;
  success: Boolean;
begin
  categoryView := TCategoryView.create(self);
  repeat
    if Sender = btnCreate then
      categoryView.prepareToCreate(catsCurr)
    else if (Sender = miEdit) or (Sender = grdCategories)
    then
      categoryView.prepareToEdit(catsCurr, selectedCatId);

    categoryView.showModal;
    success := true;
    if categoryView.modalResult = mrOk then
    begin
      updateData();
      messageBox(handle, '��������� ������� ���������',
        PChar('�����������'), MB_OK + MB_ICONINFORMATION);
    end
    else if categoryView.modalResult = mrAbort then
      if messageBox(handle,
        '��������� � ����� ������ � ����� ��� ����������.',
        '�����������', MB_RETRYCANCEL + MB_ICONSTOP) = IDRETRY
      then
        success := false;
  until success;
  categoryView.free;
end;

procedure TCategoriesView.actionOnTypeChange
  (Sender: TObject);
begin
  case tbcOperType.tabIndex of
  INCOME_TAB:
    begin
      btnCreate.caption := '����� ��������� ������';
      grdCategories.cells[2, 0] := '���������� � �����';
      catsCurr := cats[income];
    end;
  OUTCOME_TAB:
    begin
      btnCreate.caption := '����� ��������� �������';
      grdCategories.cells[2, 0] := '����������� � �����';
      catsCurr := cats[outcome];
    end;
  end;
  updateData();
end;

procedure TCategoriesView.updateData();
var
  i: integer;
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
            cells[2, i] := moneyToStr(moneyMonth)
              + ' ���.';
        end;
      end;
    end;
end;

end.

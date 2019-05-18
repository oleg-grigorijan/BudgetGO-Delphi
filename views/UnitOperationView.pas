unit UnitOperationView;

interface

uses
  System.Classes, System.SysUtils, UnitMoneyUtils,
  UnitCategoriesTable, UnitCategory, UnitOperation,
  UnitOperationsTable, Vcl.ComCtrls, Vcl.Controls,
  Vcl.Forms, Vcl.StdCtrls;

type
  TOperationView = class(TForm)
    btnCancel: TButton;
    btnCreate: TButton;
    btnSave: TButton;
    cbbCategory: TComboBox;
    dtpDate: TDateTimePicker;
    edtDescription: TEdit;
    edtPenny: TEdit;
    edtRubles: TEdit;
    lblCategoryBefore: TLabel;
    lblDateBefore: TLabel;
    lblDescriptionBefore: TLabel;
    lblMoneyBefore: TLabel;
    lblPennyAfter: TLabel;
    lblRublesAfter: TLabel;
    lblTp: TLabel;
    constructor create(owner: TComponent;
      const opers: TOperationsTable;
      const catsIncome, catsOutcome
      : TCategoriesTable); overload;
    procedure actionCreate(Sender: TObject);
    procedure actionMoneyChange(Sender: TObject);
    procedure actionSave(Sender: TObject);
  private
    cats: array [TOperationType] of TCategoriesTable;
    catsCurr: TCategoriesTable;
    opers: TOperationsTable;
    procedure setCategories(const tp: TOperationType);
  public
    procedure prepareToCreate(const tp: TOperationType);
    procedure prepareToEdit(const id: integer);
    procedure prepareToRepeat(const id: integer);
  end;

implementation

{$R *.dfm}

constructor TOperationView.create(owner: TComponent;
  const opers: TOperationsTable;
  const catsIncome, catsOutcome: TCategoriesTable);
begin
  inherited create(owner);
  self.opers := opers;
  cats[income] := catsIncome;
  cats[outcome] := catsOutcome;

  edtDescription.maxLength := OPER_DESC_LEN;
end;

procedure TOperationView.actionCreate(Sender: TObject);
var
  operation: POperation;
begin
  new(operation);
  with operation^ do
  begin
    id := 0;
    tp := catsCurr.operTp;
    money := strToMoney(edtRubles.text, edtPenny.text);
    catId := catsCurr.items[cbbCategory.itemIndex]^.id;
    description := trim(edtDescription.text);
    date := dtpDate.date;
  end;
  opers.addItem(operation);
end;

procedure TOperationView.actionMoneyChange
  (Sender: TObject);
begin
  if strToMoney(edtRubles.text, edtPenny.text) = 0 then
  begin
    btnCreate.enabled := false;
    btnSave.enabled := false;
  end
  else
  begin
    btnCreate.enabled := true;
    btnSave.enabled := true;
  end;
end;

procedure TOperationView.actionSave(Sender: TObject);
var
  newItem: POperation;
begin
  new(newItem);
  with newItem^ do
  begin
    tp := catsCurr.operTp;
    money := strToMoney(edtRubles.text, edtPenny.text);
    catId := catsCurr.items[cbbCategory.itemIndex]^.id;
    description := trim(edtDescription.text);
    date := dtpDate.date;
  end;
  opers.editItem(btnSave.tag, newItem);
end;

procedure TOperationView.prepareToCreate
  (const tp: TOperationType);
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  case tp of
  income:
    lblTp.caption := 'Новый доход';
  outcome:
    lblTp.caption := 'Новый расход';
  end;
  edtRubles.text := '0';
  edtPenny.text := '0';
  setCategories(tp);
  cbbCategory.itemIndex := 0;
  edtDescription.text := '';
  dtpDate.date := date();
  dtpDate.maxDate := date();
end;

procedure TOperationView.prepareToEdit(const id: integer);
var
  item: POperation;
begin
  btnSave.visible := true;
  btnCreate.visible := false;
  item := opers.getItem(id);
  with item^ do
  begin
    btnSave.tag := id;
    case tp of
    income:
      lblTp.caption := 'Редактирование дохода';
    outcome:
      lblTp.caption := 'Редактирование расхода';
    end;
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    setCategories(tp);
    cbbCategory.itemIndex := catsCurr.getItemIndex(catId);
    edtDescription.text := description;
    dtpDate.date := date;
  end;
  dtpDate.maxDate := date();
end;

procedure TOperationView.prepareToRepeat
  (const id: integer);
var
  item: POperation;
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  item := opers.getItem(id);
  with item^ do
  begin
    case tp of
    income:
      lblTp.caption := 'Новый доход';
    outcome:
      lblTp.caption := 'Новый расход';
    end;
    setCategories(tp);
    cbbCategory.itemIndex := catsCurr.getItemIndex(catId);
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    edtDescription.text := description;
  end;
  dtpDate.date := date();
  dtpDate.maxDate := date();
end;

procedure TOperationView.setCategories
  (const tp: TOperationType);
var
  i: integer;
begin
  catsCurr := cats[tp];
  cbbCategory.clear;
  for i := 0 to self.catsCurr.count - 1 do
    cbbCategory.items.add(self.catsCurr.items[i]^.name);
end;

end.

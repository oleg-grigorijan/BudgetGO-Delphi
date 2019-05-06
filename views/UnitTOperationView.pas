unit UnitTOperationView;

interface

uses
  System.Classes,
  System.SysUtils,
  UnitMoneyUtils,
  UnitTCategoriesTable,
  UnitTCategory,
  UnitTOperation,
  UnitTOperationsTable,
  Vcl.ComCtrls,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls;

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
    procedure actionCreate(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionMoneyChange(Sender: TObject);
    procedure actionSave(Sender: TObject);
  public
    procedure prepareToCreate(const tp: TOperationType);
    procedure prepareToEdit(const id: Integer);
    procedure prepareToRepeat(const id: Integer);
  private
    catsCurr: TCategoriesTable;
    procedure setCategories(const operTp: TOperationType);
  end;

implementation

{$R *.dfm}

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

procedure TOperationView.actionInit(Sender: TObject);
begin
  edtDescription.maxLength := OPER_DESC_LEN;
end;

procedure TOperationView.actionMoneyChange(Sender:
  TObject);
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

procedure TOperationView.prepareToCreate(const tp:
  TOperationType);
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  case tp of
    income: lblTp.caption := 'Новый доход';
    outcome: lblTp.caption := 'Новый расход';
  end;
  edtRubles.text := '0';
  edtPenny.text := '0';
  setCategories(tp);
  cbbCategory.itemIndex := 0;
  edtDescription.text := '';
  dtpDate.date := date();
  dtpDate.maxDate := date();
end;

procedure TOperationView.prepareToEdit(const id: Integer);
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

procedure TOperationView.prepareToRepeat(const id:
  Integer);
var
  item: POperation;
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  item := opers.getItem(id);
  with item^ do
  begin
    case tp of
      income: lblTp.caption := 'Новый доход';
      outcome: lblTp.caption := 'Новый расход';
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

procedure TOperationView.setCategories(const operTp:
  TOperationType);
var
  i: Integer;
begin
  case operTp of
    income:
      catsCurr := catsIncome;
    outcome:
      catsCurr := catsOutcome;
  end;
  cbbCategory.clear;
  for i := 0 to catsCurr.count - 1 do
    cbbCategory.items.add(catsCurr.items[i]^.name);
end;

end.

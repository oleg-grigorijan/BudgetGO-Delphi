unit UnitTOperationView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, UnitTOperation,
  UnitTOperationList, UnitTCategory, UnitTCategoryTable;

type
  TOperationView = class(TForm)
    btnCancel: TButton;
    btnCreate: TButton;
    btnSave: TButton;
    dtpDate: TDateTimePicker;
    edtDescription: TEdit;
    edtPenny: TEdit;
    edtRubles: TEdit;
    lblDateBefore: TLabel;
    lblDescriptionBefore: TLabel;
    lblMoneyBefore: TLabel;
    lblPennyAfter: TLabel;
    lblRublesAfter: TLabel;
    lblTp: TLabel;
    lblCategoryBefore: TLabel;
    cbbCategory: TComboBox;
    procedure actionCreate(Sender: TObject);
    procedure actionMoneyChange(Sender: TObject);
    procedure actionSave(Sender: TObject);
  public
    procedure prepareToCreate(const tp: TOperationType);
    procedure prepareToEdit(const id: Integer);
    procedure prepareToRepeat(const id: Integer);
    procedure setCategories(const operTp: TOperationType); overload;
    procedure setCategories(const operTp: TOperationType; const catId: Integer); overload;
  private
    catsCurr: TCategories;
  end;

var
  operationView: TOperationView;

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
    tp := TOperationType(lblTp.tag);
    money := strToInt(edtRubles.text) * 100 +
      strToInt(edtPenny.text);
    catId := catsCurr[cbbCategory.ItemIndex]^.id;
    description := edtDescription.text;
    date := dtpDate.date;
  end;
  operList.addItem(operation);
end;

procedure TOperationView.actionMoneyChange(Sender: TObject);
var
  sum: Longword;
begin
  sum := 0;
  if (edtRubles.text = '') or
    (edtPenny.text = '') or
    (strToInt(edtRubles.text) +
    strToInt(edtPenny.text) = 0) then
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
    tp := TOperationType(lblTp.tag);
    money := strToInt(edtRubles.text)*100 +
      strToInt(edtPenny.text);
    catId := catsCurr[cbbCategory.ItemIndex]^.id;
    description := edtDescription.text;
    date := dtpDate.date;
  end;
  operList.editItem(btnSave.tag, newItem);
end;

procedure TOperationView.prepareToCreate(const tp: TOperationType);
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  case tp of
    income: lblTp.caption := 'Новый доход';
    outcome: lblTp.caption := 'Новый расход';
  end;
  lblTp.tag := ord(tp);
  edtRubles.text := '0';
  edtPenny.text := '0';
  setCategories(tp);
  edtDescription.text := '';
  dtpDate.maxDate := date();
  dtpDate.date := date();
end;

procedure TOperationView.prepareToEdit(const id: Integer);
var
  item: POperation;
begin
  btnSave.visible := true;
  btnCreate.visible := false;
  item := operList.getItem(id);
  with item^ do
  begin
    btnSave.tag := id;
    case tp of
      income:
        lblTp.caption := 'Редактирование дохода';
      outcome:
        lblTp.caption := 'Редактирование расхода';
    end;
    lblTp.tag := ord(tp);
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    setCategories(tp, catId);
    edtDescription.text := description;
    dtpDate.date := date;
  end;
  dtpDate.maxDate := date();
end;

procedure TOperationView.prepareToRepeat(const id: Integer);
var
  item: POperation;
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  item := operList.getItem(id);
  with item^ do
  begin
    case tp of
      income: lblTp.caption := 'Новый доход';
      outcome: lblTp.caption := 'Новый расход';
    end;
    lblTp.tag := ord(tp);
    setCategories(tp, catId);
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    edtDescription.text := description;
  end;
  dtpDate.date := date();
  dtpDate.maxDate := date();
end;

procedure TOperationView.setCategories(const operTp: TOperationType);
var
  i: Integer;
begin
  case operTp of
    income:
      catsCurr := catsIncome.getItems;
    outcome:
      catsCurr := catsOutcome.getItems;
  end;
  cbbCategory.clear;
  for i := 0 to length(catsCurr) - 1 do
    cbbCategory.items.add(catsCurr[i]^.name);
  cbbCategory.itemIndex := 0;
end;

procedure TOperationView.setCategories(const operTp: TOperationType; const catId: Integer);
var
  i: Integer;
begin
  case operTp of
    income:
      catsCurr := catsIncome.getItems;
    outcome:
      catsCurr := catsOutcome.getItems;
  end;
  cbbCategory.clear;
  for i := 0 to length(catsCurr) - 1 do
  begin
    cbbCategory.items.add(catsCurr[i]^.name);
    if catsCurr[i]^.id = catId then
      cbbCategory.itemIndex := i;
  end;
end;

end.

unit UnitCategoryView;

interface

uses
  System.Classes, System.SysUtils, UnitMoneyUtils,
  UnitCategoriesTable, UnitCategory, UnitOperation,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls;

type
  TcategoryView = class(TForm)
    // Components
    btnCancel: TButton;
    btnCreate: TButton;
    btnSave: TButton;
    edtName: TEdit;
    edtPenny: TEdit;
    edtRubles: TEdit;
    lblInfo: TLabel;
    lblMoneyBefore: TLabel;
    lblNameBefore: TLabel;
    lblPennyAfter: TLabel;
    lblRublesAfter: TLabel;
    lblTp: TLabel;

    // Actions
    procedure actionCreate(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOnNameChange(Sender: TObject);
    procedure actionSave(Sender: TObject);
  private
    // Models
    catsTable: TCategoriesTable;

    procedure setInfo(const operTp: TOperationType);
  public
    procedure prepareToCreate(const catsTable
      : TCategoriesTable);
    procedure prepareToEdit(const catsTable
      : TCategoriesTable; const id: integer);
  end;

var
  categoryView: TcategoryView;

implementation

{$R *.dfm}

procedure TcategoryView.actionCreate(Sender: TObject);
var
  item: PCategory;
begin
  new(item);
  with item^ do
  begin
    id := 0;
    name := trim(edtName.text);
    moneyMonth := strToMoney(edtRubles.text,
      edtPenny.text);
  end;
  if not catsTable.addItem(item) then
    self.modalResult := mrAbort;
end;

procedure TcategoryView.actionInit(Sender: TObject);
begin
  edtName.maxLength := CAT_NAME_LEN;
end;

procedure TcategoryView.actionOnNameChange
  (Sender: TObject);
begin
  if edtName.text = '' then
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

procedure TcategoryView.actionSave(Sender: TObject);
var
  newItem: PCategory;
begin
  new(newItem);
  with newItem^ do
  begin
    name := trim(edtName.text);
    moneyMonth := strToMoney(edtRubles.text, edtPenny.text)
  end;
  if not catsTable.editItem(btnSave.tag, newItem) then
    self.modalResult := mrAbort;
end;

procedure TcategoryView.setInfo(const operTp
  : TOperationType);
begin
  case operTp of
  income:
    begin
      lblMoneyBefore.caption := 'Минимально в месяц';
      lblInfo.caption := 'Мы уведомим вас, если до конца' +
        #13#10 + 'месяца вы не достигнете желаемой' +
        #13#10 + 'суммы по данной категории';
    end;
  outcome:
    begin
      lblMoneyBefore.caption := 'Максимально в месяц';
      lblInfo.caption :=
        'Мы предупредим вас, если в течение' + #13#10 +
        'месяца вы превысите желаемую' + #13#10 +
        'сумму по данной категории';
    end;
  end;
end;

procedure TcategoryView.prepareToCreate(const catsTable
  : TCategoriesTable);
begin
  self.catsTable := catsTable;
  btnSave.visible := false;
  btnCreate.visible := true;
  case catsTable.operTp of
  income:
    lblTp.caption := 'Новая категория' + #13#10 + 'дохода';
  outcome:
    lblTp.caption := 'Новая категория' + #13#10 +
      'расхода';
  end;
  setInfo(catsTable.operTp);
  edtName.text := '';
  edtRubles.text := '';
  edtPenny.text := '';
end;

procedure TcategoryView.prepareToEdit(const catsTable
  : TCategoriesTable; const id: integer);
begin
  self.catsTable := catsTable;
  btnSave.visible := true;
  btnCreate.visible := false;
  case catsTable.operTp of
  income:
    lblTp.caption := 'Редактирование' + #13#10 +
      'категории дохода';
  outcome:
    lblTp.caption := 'Редактирование' + #13#10 +
      'категории расхода';
  end;
  setInfo(catsTable.operTp);
  with catsTable.getItem(id)^ do
  begin
    btnSave.tag := id;
    edtName.text := name;
    if moneyMonth = 0 then
    begin
      edtRubles.text := '';
      edtPenny.text := '';
    end
    else
    begin
      edtRubles.text := intToStr(moneyMonth div 100);
      edtPenny.text := intToStr(moneyMonth mod 100);
    end;
  end;
end;

end.

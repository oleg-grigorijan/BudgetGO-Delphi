unit UnitTCategoryView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitTOperation, UnitTCategory, UnitTCategoryTable, UnitMoneyUtils;

type
  TcategoryView = class(TForm)
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
    procedure actionCreate(Sender: TObject);
    procedure actionSave(Sender: TObject);
  private
    procedure setInfo(const operTp: TOperationType);
  public
    procedure prepareToCreate(const operTp: TOperationType);
    procedure prepareToEdit(const operTp: TOperationType;
      const id: Integer);
  end;

var
  categoryView: TcategoryView;

implementation

{$R *.dfm}

procedure TCategoryView.actionCreate(Sender: TObject);
var
  success: Boolean;
  item: PCategory;
begin
  new(item);
  with item^ do
  begin
    id := 0;
    name := edtName.text;
    moneyMonth := strToMoney(edtRubles.text, edtPenny.text);
  end;
  case lblTp.tag of
    ord(income): success := catsIncome.addItem(item);
    ord(outcome): success := catsOutcome.addItem(item);
  end;
  if not success then
    self.modalResult := mrAbort;
end;

procedure TCategoryView.actionSave(Sender: TObject);
var
  success: Boolean;
  newItem: PCategory;
begin
  new(newItem);
  with newItem^ do
  begin
    name := edtName.text;
    moneyMonth := strToMoney(edtRubles.text, edtPenny.text)
  end;
  case lblTp.tag of
    ord(income):
      success := catsIncome.editItem(btnSave.tag, newItem);
    ord(outcome):
      success := catsOutcome.editItem(btnSave.tag, newItem);
  end;
  if not success then
    self.modalResult := mrAbort;
end;

procedure TCategoryView.setInfo(const operTp: TOperationType);
begin
  case operTp of
    income:
    begin
      lblMoneyBefore.caption := 'Минимально в месяц';
      lblInfo.caption := 'Мы уведомим вас, если до конца'#13#10 +
        'месяца вы не достигнете желаемой'#13#10 +
        'суммы по данной категории.';
    end;
    outcome:
    begin
      lblMoneyBefore.caption := 'Максимально в месяц';
      lblInfo.caption := 'Мы предупредим вас, если в течение'#13#10 +
        'месяца вы превысите желаемую'#13#10 +
        'сумму по данной категории.';
    end;
  end;
end;

procedure TCategoryView.prepareToCreate(const operTp: TOperationType);
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  case operTp of
    income: lblTp.caption := 'Новая категория'#13#10'дохода';
    outcome: lblTp.caption := 'Новая категория'#13#10'расхода';
  end;
  setInfo(operTp);
  lblTp.tag := ord(operTp);
  edtName.text := '';
  edtRubles.text := '';
  edtPenny.text := '';
end;

procedure TCategoryView.prepareToEdit(const operTp: TOperationType; const id: Integer);
var
  item: PCategory;
begin
  btnSave.visible := true;
  btnCreate.visible := false;
  case operTp of
    income:
    begin
      item := catsIncome.getItem(id);
      lblTp.caption := 'Редактирование'#13#10'категории дохода';
    end;
    outcome:
    begin
      item := catsOutcome.getItem(id);
      lblTp.caption := 'Редактирование'#13#10'категории расхода';
    end;
  end;
  lblTp.tag := ord(operTp);
  setInfo(operTp);
  with item^ do
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

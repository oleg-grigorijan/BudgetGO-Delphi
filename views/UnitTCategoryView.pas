unit UnitTCategoryView;

interface

uses
  System.Classes,
  System.SysUtils,
  UnitMoneyUtils,
  UnitTCategoriesTable,
  UnitTCategory,
  UnitTOperation,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.StdCtrls;

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
    procedure actionInit(Sender: TObject);
    procedure actionOnNameChange(Sender: TObject);
    procedure actionSave(Sender: TObject);
  private
    catsTable: TCategoriesTable;
    procedure setInfo(const operTp: TOperationType);
  public
    procedure prepareToCreate(const catsTable:
      TCategoriesTable);
    procedure prepareToEdit(const catsTable:
      TCategoriesTable; const id: Integer);
  end;

var
  categoryView: TcategoryView;

implementation

{$R *.dfm}

procedure TCategoryView.actionCreate(Sender: TObject);
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

procedure TCategoryView.actionInit(Sender: TObject);
begin
  edtName.maxLength := CAT_NAME_LEN;
end;

procedure TCategoryView.actionOnNameChange(Sender:
  TObject);
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

procedure TCategoryView.actionSave(Sender: TObject);
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

procedure TCategoryView.setInfo(const operTp:
  TOperationType);
begin
  case operTp of
    income:
    begin
      lblMoneyBefore.caption := '���������� � �����';
      lblInfo.caption := '�� �������� ���, ���� �� �����' +
        #13#10 + '������ �� �� ���������� ��������' +
        #13#10 + '����� �� ������ ���������';
    end;
    outcome:
    begin
      lblMoneyBefore.caption := '����������� � �����';
      lblInfo.caption :=
        '�� ����������� ���, ���� � �������' + #13#10 +
        '������ �� ��������� ��������' + #13#10 +
        '����� �� ������ ���������';
    end;
  end;
end;

procedure TCategoryView.prepareToCreate(const catsTable:
  TCategoriesTable);
begin
  self.catsTable := catsTable;
  btnSave.visible := false;
  btnCreate.visible := true;
  case catsTable.operTp of
    income: lblTp.caption := '����� ���������' + #13#10 +
      '������';
    outcome: lblTp.caption := '����� ���������' + #13#10 +
      '�������';
  end;
  setInfo(catsTable.operTp);
  edtName.text := '';
  edtRubles.text := '';
  edtPenny.text := '';
end;

procedure TCategoryView.prepareToEdit(
  const catsTable: TCategoriesTable;
  const id: Integer
);
var
  item: PCategory;
begin
  self.catsTable := catsTable;
  btnSave.visible := true;
  btnCreate.visible := false;
  case catsTable.operTp of
    income: lblTp.caption := '��������������' + #13#10 +
      '��������� ������';
    outcome: lblTp.caption := '��������������' + #13#10 +
      '��������� �������';
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

unit UnitTCategoryView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitTOperation, UnitTCategory, UnitTCategoryTable;

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
  private
    procedure setInfo(const tp: TOperationType);
  public
    procedure prepareToCreate(const tp: TOperationType);
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
    name := edtName.text;
    operTp := TOperationType(lblTp.tag);
    moneyMonth := strToInt(edtRubles.text)*100 +
      strToInt(edtPenny.text);
  end;
  if not catTable.addItem(item) then
    self.modalResult := mrAbort;
end;

procedure TCategoryView.setInfo(const tp: TOperationType);
begin
  case tp of
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

procedure TCategoryView.prepareToCreate(const tp: TOperationType);
begin
  btnSave.visible := false;
  btnCreate.visible := true;
  case tp of
    income: lblTp.caption := 'Новая категория'#13#10'дохода';
    outcome: lblTp.caption := 'Новая категория'#13#10'расхода';
  end;
  setInfo(tp);
  lblTp.tag := ord(tp);
  edtName.text := '';
  edtRubles.text := '';
  edtPenny.text := '';
end;

end.

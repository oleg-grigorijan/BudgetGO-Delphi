unit UnitTOperationView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.ComCtrls, Vcl.ExtCtrls, UnitTOperation,
  UnitTOperationList;

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
    procedure actionSave(Sender: TObject);
  public
    procedure prepareToCreate(tp: TOperationType);
    procedure prepareToEdit(id: Integer);
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
    tp := TOperationType(lblTp.tag);
    money := strToInt(edtRubles.text) * 100 +
      strToInt(edtPenny.text);
    date := dtpDate.date;
    description := edtDescription.text;
  end;
  operList.addNode(operation);
end;

procedure TOperationView.actionSave(Sender: TObject);
begin
  operList.editItem(
    btnSave.tag,
    strToInt(edtRubles.text)*100 + strToInt(edtPenny.text),
    0, // category
    edtDescription.text,
    dtpDate.date
  )
end;

procedure TOperationView.prepareToCreate(tp: TOperationType);
begin
  case tp of
    income: lblTp.caption := 'Новый доход';
    outcome: lblTp.caption := 'Новый расход';
  end;
  lblTp.tag := ord(tp);
  btnSave.visible := false;
  btnCreate.visible := true;
  edtRubles.text := '0';
  edtPenny.text := '0';
  // category
  edtDescription.text := '';
  dtpDate.maxDate := date();
  dtpDate.date := date();
end;

procedure TOperationView.prepareToEdit(id: Integer);
var
  item: POperation;
begin
  btnSave.visible := true;
  btnCreate.Visible := false;
  item := operList.getItem(id);
  with item^ do
  begin
    btnSave.tag := id;
    case tp of
      income:
      begin
        lblTp.caption := 'Редактирование дохода';
        lblTp.tag := ord(income);
      end;
      outcome:
      begin
        lblTp.caption := 'Редактирование расхода';
        lblTp.tag := ord(outcome);
      end;
    end;
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    edtDescription.text := description;
    dtpDate.date := date;
  end;
end;

end.


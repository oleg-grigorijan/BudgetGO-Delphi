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
    procedure actionCreate(Sender: TObject);
    procedure actionMoneyChange(Sender: TObject);
    procedure actionSave(Sender: TObject);
  public
    procedure prepareToCreate(tp: TOperationType);
    procedure prepareToEdit(id: Integer);
    procedure prepareToRepeat(id: Integer);
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
  if edtRubles.text <> '' then
    sum := sum + strToInt(edtRubles.text);
  if edtPenny.text <> '' then
    sum := sum + strToInt(edtPenny.text);
  if sum = 0 then
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
    money := strToInt(edtRubles.text)*100 +
      strToInt(edtPenny.text);
    description := edtDescription.text;
    date := dtpDate.date;
  end;
  operList.editItem(btnSave.tag, newItem);
end;

procedure TOperationView.prepareToCreate(tp: TOperationType);
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
        lblTp.caption := 'Редактирование дохода';
      outcome:
        lblTp.caption := 'Редактирование расхода';
    end;
    lblTp.tag := ord(tp);
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    edtDescription.text := description;
    dtpDate.date := date;
  end;
  dtpDate.maxDate := date();
end;

procedure TOperationView.prepareToRepeat(id: Integer);
var
  item: POperation;
begin
  btnSave.visible := false;
  btnCreate.Visible := true;
  item := operList.getItem(id);
  with item^ do
  begin
    case tp of
      income: lblTp.caption := 'Новый доход';
      outcome: lblTp.caption := 'Новый расход';
    end;
    lblTp.tag := ord(tp);
    edtRubles.text := intToStr(money div 100);
    edtPenny.text := intToStr(money mod 100);
    edtDescription.text := description;
  end;
  dtpDate.date := date();
  dtpDate.maxDate := date();
end;

end.


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
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lblTp: TLabel;
    procedure actionCreate(Sender: TObject);
  private
    { Private declarations }
  public
    procedure prepareToCreate(tp: TOperationType);
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
  dtpDate.date := date();
end;

end.


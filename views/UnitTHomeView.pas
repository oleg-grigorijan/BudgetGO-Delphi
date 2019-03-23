unit UnitTHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitTOperationView, UnitTOperationList, UnitTOperation;

type
  THomeView = class(TForm)
    lblHeader: TLabel;
    lbl1: TLabel;
    lblBalance: TLabel;
    Label1: TLabel;
    btnCreateIncome: TButton;
    btnCreateOutcome: TButton;
    procedure actionInit(Sender: TObject);
    procedure actionOperationView(Sender: TObject);
  private

  public
    procedure dataUpdate();
  end;

var
  homeView: ThomeView;

implementation

{$R *.dfm}

procedure THomeView.actionInit(Sender: TObject);
begin
  dataUpdate();
end;

procedure THomeView.actionOperationView(Sender: TObject);
begin
  if not assigned(operationView) then
    operationView := TOperationView.create(self);
  if Sender = btnCreateIncome then
    operationView.prepareToCreate(income)
  else if Sender = btnCreateOutcome then
    operationView.prepareToCreate(outcome);
  operationView.ShowModal;
  if operationView.ModalResult = mrOk then
  begin
    dataUpdate();
    messageBox(handle, 'Операция успешно сохранена', PChar('Уведомление'),
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure THomeView.dataUpdate();
begin
  lblBalance.Caption := IntToStr(operList.getBalance);
end;

end.

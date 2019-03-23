unit UnitTHomeView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, UnitTOperationList;

type
  THomeView = class(TForm)
    lblHeader: TLabel;
    lbl1: TLabel;
    lblBalance: TLabel;
    Label1: TLabel;
    btnCreateIncome: TButton;
    btnCreateOutcome: TButton;
    procedure actionInit(Sender: TObject);
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

procedure THomeView.dataUpdate();
begin
  lblBalance.Caption := IntToStr(operList.getBalance);
end;

end.

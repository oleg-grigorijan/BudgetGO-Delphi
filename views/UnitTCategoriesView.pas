unit UnitTCategoriesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Grids, Vcl.ComCtrls, UnitTCategory, UnitTCategoryTable, UnitTOperation;

type
  TCategoriesView = class(TForm)
    lblHeader: TLabel;
    tbcOperType: TTabControl;
    grdCategories: TStringGrid;
    btnCreate: TButton;
    procedure actionInit(Sender: TObject);
    procedure actionOnTypeChange(Sender: TObject);
  private
    catsCurr: TCategories;
  public
    procedure dataUpdate();
  end;

var
  categoriesView: TcategoriesView;

implementation

{$R *.dfm}

procedure TCategoriesView.actionInit(Sender: TObject);
begin
  grdCategories.cells[1, 0] := 'Название';
  dataUpdate();
end;

procedure TCategoriesView.actionOnTypeChange(Sender: TObject);
begin
  dataUpdate();
end;

procedure TCategoriesView.dataUpdate();
var
  i: Integer;
begin
  case tbcOperType.TabIndex of
    0:
    begin
      catsCurr := catTable.getItems(income);
      grdCategories.cells[2, 0] := 'Минимально в мес.';
    end;
    1:
    begin
      catsCurr := catTable.getItems(outcome);
      grdCategories.cells[2, 0] := 'Максимально в мес.';
    end;
  end;
  with grdCategories do
  begin
    RowCount := Length(catsCurr) + 1;
    for i := 1 to Length(catsCurr) do
    begin
      cells[0, i] := IntToStr(i);
      with catsCurr[i - 1]^ do
      begin
        cells[1, i] := name;
        cells[2, i] :=  FloatToStrF(moneyMonth / 100,
          ffFixed, 7, 2) + ' руб.';
      end;
    end;
  end;
end;

end.

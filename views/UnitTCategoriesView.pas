unit UnitTCategoriesView;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Vcl.Grids, Vcl.ComCtrls, UnitTCategory, UnitTCategoryTable, UnitTOperation, UnitTCategoryView;

type
  TCategoriesView = class(TForm)
    btnCreate: TButton;
    grdCategories: TStringGrid;
    lblHeader: TLabel;
    tbcOperType: TTabControl;
    procedure actionCategoryView(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOnTypeChange(Sender: TObject);
  private
    catsCurr: TCategories;
    tpCurr: TOperationType;
  public
    procedure dataUpdate();
  end;

var
  categoriesView: TcategoriesView;

implementation

{$R *.dfm}

procedure TCategoriesView.actionCategoryView(Sender: TObject);
var
  success: Boolean;
begin
  repeat
  if not assigned(categoryView) then
    categoryView := TCategoryView.create(self);
  if Sender = btnCreate then
    categoryView.prepareToCreate(tpCurr);
  categoryView.showModal;
  success := true;
  if categoryView.modalResult = mrOk then
  begin
    dataUpdate();
    messageBox(handle, 'Категория успешно сохранена', PChar('Уведомление'),
      MB_OK + MB_ICONINFORMATION);
  end
  else if categoryView.modalResult = mrAbort then
    if messageBox(Handle, 'Категория с таким именем и типом уже существует.',
      'Уведомление', MB_RETRYCANCEL + MB_ICONSTOP) = IDRETRY then
    success := false;
  until success;
end;

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
  case tbcOperType.tabIndex of
    0:
    begin
      self.tpCurr := income;
      grdCategories.cells[2, 0] := 'Минимально в мес.';
    end;
    1:
    begin
      self.tpCurr := outcome;
      grdCategories.cells[2, 0] := 'Максимально в мес.';
    end;
  end;
  catsCurr := catTable.getItems(tpCurr);
  with grdCategories do
  begin
    rowCount := length(catsCurr) + 1;
    for i := 1 to length(catsCurr) do
    begin
      cells[0, i] := IntToStr(i);
      with catsCurr[i - 1]^ do
      begin
        cells[1, i] := name;
        if moneyMonth = 0 then
          cells[2, i] := ''
        else
          cells[2, i] :=  FloatToStrF(moneyMonth / 100,
            ffFixed, 7, 2) + ' руб.'
      end;
    end;
  end;
end;

end.

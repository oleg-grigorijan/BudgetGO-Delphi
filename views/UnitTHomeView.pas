unit UnitTHomeView;

interface

uses
  DateUtils,
  System.Classes,
  System.SysUtils,
  UnitMoneyUtils,
  UnitTCategoriesTable,
  UnitTCategory,
  UnitTCategoriesView,
  UnitTOperation,
  UnitTOperationsTable,
  UnitTOperationView,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Imaging.pngimage,
  Vcl.Menus,
  Vcl.StdCtrls,
  Winapi.Windows, Vcl.Imaging.jpeg, Vcl.Buttons,
  Vcl.ComCtrls;

type
  THomeView = class(TForm)
    btnEditCategories: TButton;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    grdCatsIncome: TStringGrid;
    grdCatsOutcome: TStringGrid;
    grdOperations: TStringGrid;
    imgCatsIncomeStatus: TImage;
    imgCatsOutcomeStatus: TImage;
    imgIcoNo: TImage;
    imgIcoOk: TImage;
    imgIcoWarning: TImage;
    lblBalanceBefore: TLabel;
    lblCategoriesBefore: TLabel;
    lblCatsIncomeBefore: TLabel;
    lblCatsIncomeStatus: TLabel;
    lblCatsOutcomeBefore: TLabel;
    lblCatsOutcomeStatus: TLabel;
    lblHeader: TLabel;
    lblIncome: TLabel;
    lblIncomeBefore: TLabel;
    lblNewOperationBefore: TLabel;
    lblNoOperations: TLabel;
    lblOperationsBefore: TLabel;
    lblOutcome: TLabel;
    lblOutcomeBefore: TLabel;
    lblStatisticsBefore: TLabel;
    miDelete: TMenuItem;
    miEdit: TMenuItem;
    miRepeat: TMenuItem;
    pmOperation: TPopupMenu;
    pnlCategories: TPanel;
    pnlContent: TPanel;
    pnlHeader: TPanel;
    pnlMainTools: TPanel;
    pnlMainToolsWrapper: TPanel;
    pnlOperations: TPanel;
    pnlStatistics: TPanel;
    shpIncome: TShape;
    shpOutcome: TShape;
    imgBG: TImage;
    lblEditCategories: TLabel;
    imgEditCategories: TImage;
    pnlEditCategories: TPanel;
    imgCreateOutcome: TImage;
    imgCreateIncome: TImage;
    lblBalance: TLabel;
    imgCreateIncomeOff: TImage;
    imgCreateOutcomeOff: TImage;
    procedure actionCategoriesView(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOperationDelete(Sender: TObject);
    procedure actionOperationSelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure actionOperationView(Sender: TObject);
    procedure actionResize(Sender: TObject; var newWidth,
      newHeight: Integer; var resize: Boolean);
    procedure actionScroll(Sender: TObject;
      Shift: TShiftState; WheelDelta: Integer;
      MousePos: TPoint; var Handled: Boolean);
    procedure actionUpdateStatistics(Sender: TObject);
  private
    type
      TCatsMoney = array of Longword;
    var
      catsIncomeMoney, catsOutcomeMoney: TCatsMoney;
      incomeMonth: Longword;
      opersCurr: TOperations;
      outcomeMonth: Longword;
      selectedOperId: Integer;
    procedure arrangeComponents();
    procedure countCategoriesMoney();
    procedure fillCategoriesStatus();
    procedure fillCategoriesGrid(const grdCats:
      TStringGrid; const catsTable: TCategoriesTable;
      const catsMoney: TCatsMoney);
    procedure fillOperationsGrid();
  public
    procedure updateData();
  end;

var
  homeView: ThomeView;

implementation

{$R *.dfm}

procedure THomeView.actionCategoriesView(Sender: TObject);
var
  categoriesView: TCategoriesView;
begin
  categoriesView := TCategoriesView.create(self);
  categoriesView.showModal;
  categoriesView.free;
end;

procedure THomeView.actionInit(Sender: TObject);
var
  i: Integer;
  noHighlight: TGridRect;
begin
  self.clientWidth := pnlContent.width;

  cbbMonth.itemIndex := monthOfTheYear(date()) - 1;
  for i := currentYear downto 2010 do
    cbbYear.items.add(IntToStr(i));
  cbbYear.itemIndex := 0;

  with grdCatsIncome do
  begin
    cells[0, 0] := 'Категория';
    cells[1, 0] := 'Получено за месяц';
  end;

  with grdCatsOutcome do
  begin
    cells[0, 0] := 'Категория';
    cells[1, 0] := 'Потрачено за месяц';
  end;

  noHighlight.left := -1;
  noHighlight.right := -1;
  noHighlight.top := -1;
  noHighlight.bottom := -1;
  grdCatsIncome.selection := noHighlight;
  grdCatsOutcome.selection := noHighlight;

  with grdOperations do
  begin
    cells[1, 0] := 'Тип';
    cells[2, 0] := 'Сумма';
    cells[3, 0] := 'Категория';
    cells[4, 0] := 'День';
    cells[5, 0] := 'Описание';
  end;

  updateData();
end;

procedure THomeView.actionOperationDelete(Sender: TObject);
var
  answer: Integer;
begin
  if selectedOperId <> 0 then
  begin
    answer := MessageBox(handle,
      'Вы действительно хотите удалить операцию?' + #13#10
       + 'Удалённые данные будет невозможно восстановить.',
      'Уведомление', MB_YESNO + MB_ICONQUESTION +
      MB_DEFBUTTON2);
    if answer = IDYES then
    begin
      opers.removeItem(selectedOperId);
      updateData();
    end;
  end;
end;

procedure THomeView.actionOperationSelect(
  Sender: TObject;
  Button: TMouseButton;
  Shift: TShiftState;
  X, Y: Integer
);
var
  col, row: Integer;
begin
  grdOperations.mouseToCell(X, Y, col, row);
  grdOperations.col := col;
  if grdOperations.rowCount = 1 then
    selectedOperId := 0
  else
  begin
    if row = 0 then
      grdOperations.row := 1
    else
      grdOperations.row := row;
    selectedOperId := opersCurr[grdOperations.row - 1]^.id;
  end;
end;

procedure THomeView.actionOperationView(Sender: TObject);
var
  operationView: TOperationView;
begin
  operationView := TOperationView.create(self);
  if Sender = imgCreateIncome then
    operationView.prepareToCreate(income)
  else if Sender = imgCreateOutcome then
    operationView.prepareToCreate(outcome)
  else if (Sender = miEdit) or
    (Sender = grdOperations) then
    operationView.prepareToEdit(selectedOperId)
  else if Sender = miRepeat then
    operationView.prepareToRepeat(selectedOperId);
  if (Sender = imgCreateIncomeOff) or
    (Sender = imgCreateOutcomeOff) then
  begin
    messageBox(Handle,
      'Чтобы создавать операции данного типа,' + #13#10 +
      'сначала создайте категории', 'Уведомление',
      MB_OK + MB_ICONWARNING);
    actionCategoriesView(Sender);
  end
  else
  begin
    if operationView.showModal = mrOk then
    begin
      updateData();
      messageBox(handle,
        'Операция успешно сохранена', PChar('Уведомление'),
        MB_OK + MB_ICONINFORMATION);
    end;
  end;
  operationView.free;
end;

procedure THomeView.actionResize(
  Sender: TObject;
  var newWidth, newHeight: Integer;
  var resize: Boolean
);
var
  center: Integer;
begin
  if newWidth < pnlContent.width + self.width -
    self.clientWidth +
    getSystemMetrics(SM_CXVSCROLL) then
  begin
    newWidth := pnlContent.width + self.width -
      self.clientWidth +
      getSystemMetrics(SM_CXVSCROLL);
  end;
  center := self.clientWidth;
  if not self.vertScrollBar.isScrollBarVisible then
    center := center - getSystemMetrics(SM_CXVSCROLL);
  center := center div 2;
  lblHeader.left := center - lblHeader.width div 2;
  pnlContent.left := center - pnlContent.width div 2;
  pnlMainTools.left := pnlContent.left;
end;

procedure THomeView.actionScroll(
  Sender: TObject;
  Shift: TShiftState;
  WheelDelta: Integer;
  MousePos: TPoint;
  var Handled: Boolean
);
begin
  self.VertScrollBar.Position :=
    self.VertScrollBar.Position - WheelDelta;
end;

procedure THomeView.actionUpdateStatistics(Sender:
  TObject);
begin
  updateData();
end;

procedure THomeView.arrangeComponents();

  procedure setGtidHeight(const grid: TStringGrid);
  begin
    with grid do
      height := defaultRowHeight*rowCount +
        gridLineWidth*(rowCount + 4);
  end;

begin
  if catsIncome.count = 0 then
  begin
    grdCatsIncome.visible := false;
    imgCreateIncomeOff.visible := true;
    imgCreateIncome.visible := false;
  end
  else
  begin
    setGtidHeight(grdCatsIncome);
    grdCatsIncome.visible := true;
    imgCreateIncome.visible := true;
    imgCreateIncomeOff.visible := false;
  end;

  if catsOutcome.count = 0 then
  begin
    grdCatsOutcome.visible := false;
    imgCreateOutcomeOff.visible := true;
    imgCreateOutcome.visible := false;
  end
  else
  begin
    setGtidHeight(grdCatsOutcome);
    grdCatsOutcome.visible := true;
    imgCreateOutcome.visible := true;
    imgCreateOutcomeOff.visible := false;
  end;

  if length(opersCurr) = 0 then
  begin
    grdOperations.visible := false;
    lblNoOperations.visible := true;
  end
  else
  begin
    setGtidHeight(grdOperations);
    grdOperations.visible := true;
    lblNoOperations.visible := false;
  end;
end;

procedure THomeView.countCategoriesMoney();
var
  i, j: Integer;
begin
  setLength(catsIncomeMoney, catsIncome.count);
  for i := 0 to length(catsIncomeMoney) - 1 do
    catsIncomeMoney[i] := 0;

  setLength(catsOutcomeMoney, catsOutcome.count);
  for i := 0 to length(catsOutcomeMoney) - 1 do
    catsOutcomeMoney[i] := 0;

  for i := 0 to length(opersCurr) - 1 do
    with opersCurr[i]^ do
    begin
      case tp of
        income:
        begin
          j := catsIncome.getItemIndex(catId);
          catsIncomeMoney[j] := catsIncomeMoney[j] + money;
        end;
        outcome:
        begin
          j := catsOutcome.getItemIndex(catId);
          catsOutcomeMoney[j] := catsOutcomeMoney[j] +
            money;
        end;
      end;
    end;
end;

procedure THomeView.fillCategoriesGrid(
  const grdCats: TStringGrid;
  const catsTable: TCategoriesTable;
  const catsMoney: TCatsMoney
);
var
  i: Integer;
begin
  with grdCats, catsTable do
  begin
    rowCount := count + 1;
    height := (defaultRowHeight + gridLineWidth) *
      rowCount;
    for i := 0 to count - 1 do
    begin
      cells[0, i + 1] := items[i]^.name;
      cells[1, i + 1] := moneyToStr(catsMoney[i]);
      if items[i]^.moneyMonth <> 0 then
        cells[1, i + 1] := cells[1, i + 1] + ' / ' +
          moneyToStr(items[i]^.moneyMonth);
      cells[1, i + 1] := cells[1, i + 1] + ' руб.';
    end;
  end;
end;

procedure THomeView.fillOperationsGrid();
var
  i: Integer;
begin
  if length(opersCurr) <> 0 then
    with grdOperations do
    begin
      rowCount := length(opersCurr) + 1;
      for i := 1 to length(opersCurr) do
      begin
        cells[0, i] := intToStr(i);
        with opersCurr[i - 1]^ do
        begin
          case tp of
            income:
            begin
              cells[1, i] := 'Доход';
              cells[3, i] :=
                catsIncome.getItem(catId)^.name;
            end;
            outcome:
            begin
              cells[1, i] := 'Расход';
              cells[3, i] :=
                catsOutcome.getItem(catId)^.name;
            end;
          end;
          cells[2, i] := moneyToStr(money) + ' руб.';
          cells[4, i] := intToStr(dayOfTheMonth(date));
          cells[5, i] := description;
        end;
      end;
    end;
end;

procedure THomeView.fillCategoriesStatus();
var
  i: Integer;
begin
  if catsIncome.count = 0 then
  begin
    imgCatsIncomeStatus.picture := imgIcoWarning.picture;
    lblCatsIncomeStatus.caption :=
      'Для полноценного использования' + #13#10 +
      'программы создайте категории доходов';
  end
  else
  begin
    imgCatsIncomeStatus.picture := imgIcoOk.picture;
    lblCatsIncomeStatus.caption :=
      'Вы достигли желаемых доходов' + #13#10 +
      'по всем категориям в этом месяце';
    for i := 0 to catsIncome.count - 1 do
      if catsIncomeMoney[i] <
        catsIncome.items[i]^.moneyMonth then
      begin
        lblCatsIncomeStatus.caption :=
          'Вы не достигли желаемых доходов' + #13#10 +
          'по некоторым категориям в этом месяце';
        imgCatsIncomeStatus.picture := imgIcoNo.picture;
      end;
  end;

  if catsOutcome.count = 0 then
  begin
    imgCatsOutcomeStatus.picture := imgIcoWarning.picture;
    lblCatsOutcomeStatus.caption :=
      'Для полноценного использования' + #13#10 +
      'программы создайте категории расходов';
  end
  else
  begin
    imgCatsOutcomeStatus.picture := imgIcoOk.picture;
    lblCatsOutcomeStatus.caption :=
      'Вы не превысили запланированные' + #13#10 +
      'расходы по категориям в этом месяце';
    for i := 0 to catsOutcome.count - 1 do
      if (catsOutcome.items[i]^.moneyMonth <> 0) and
        (catsOutcomeMoney[i] >
        catsOutcome.items[i]^.moneyMonth) then
      begin
        lblCatsOutcomeStatus.caption :=
          'Вы превысили запланированные расходы' + #13#10 +
          'по некоторым категориям в этом месяце';
        imgCatsOutcomeStatus.picture := imgIcoNo.picture;
      end;
  end;
end;

procedure THomeView.updateData();
var
  i: Integer;
begin
  lblBalance.caption := moneyToStr(opers.balance) +
    ' руб.';

  opersCurr := opers.getItems(cbbMonth.itemIndex + 1,
    strToInt(cbbYear.text));

  countCategoriesMoney();

  incomeMonth := 0;
  for i := 0 to length(catsIncomeMoney) - 1 do
    incomeMonth := incomeMonth + catsIncomeMoney[i];
  lblIncome.caption := moneyToStr(incomeMonth) + ' руб.';

  outcomeMonth := 0;
  for i := 0 to length(catsOutcomeMoney) - 1 do
    outcomeMonth := outcomeMonth + catsOutcomeMoney[i];
  lblOutcome.caption := moneyToStr(outcomeMonth) + ' руб.';

  if incomeMonth + outcomeMonth = 0 then
    shpIncome.width := 0
  else
    shpIncome.width := shpOutcome.width*incomeMonth div
      (incomeMonth + outcomeMonth);

  fillCategoriesStatus();
  fillCategoriesGrid(grdCatsIncome, catsIncome,
    catsIncomeMoney);
  fillCategoriesGrid(grdCatsOutcome, catsOutcome,
    catsOutcomeMoney);

  fillOperationsGrid();

  arrangeComponents();
end;

end.

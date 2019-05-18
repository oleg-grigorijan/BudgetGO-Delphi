unit UnitHomeView;

interface

uses
  DateUtils, System.Classes, System.SysUtils,
  UnitMoneyUtils, UnitEvents, UnitCategoriesStatistics,
  UnitCategoriesTable, UnitCategory, UnitCategoriesView,
  UnitOperation, UnitOperationsTable, UnitOperationView,
  UnitOperationsStatistics, Vcl.Controls, Vcl.ExtCtrls,
  Vcl.Forms, Vcl.Grids, Vcl.Menus, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Winapi.Windows;

type
  THomeView = class(TForm, ISubscriber)
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
    lblCatsBefore: TLabel;
    lblCatsIncomeBefore: TLabel;
    lblCatsIncomeStatus: TLabel;
    lblCatsOutcomeBefore: TLabel;
    lblCatsOutcomeStatus: TLabel;
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
    lblBalance: TLabel;
    btnCreateIncome: TButton;
    btnCreateOutcome: TButton;
    imgLogo: TImage;
    procedure actionCategoriesView(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOperationDelete(Sender: TObject);
    procedure actionOperationSelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: integer);
    procedure actionOperationView(Sender: TObject);
    procedure actionResize(Sender: TObject;
      var newWidth, newHeight: integer;
      var resize: boolean);
    procedure actionScroll(Sender: TObject;
      Shift: TShiftState; WheelDelta: integer;
      MousePos: TPoint; var Handled: boolean);
    procedure actionMonthUpdate(Sender: TObject);
    procedure actionYearUpdate(Sender: TObject);
  private
    lblCatsStatus: array [TOperationType] of TLabel;
    imgIcons: array [TCatsStatus] of TImage;
    imgCatsStatus: array [TOperationType] of TImage;
    grdCats: array [TOperationType] of TStringGrid;
    btnCreateOper: array [TOperationType] of TButton;
    selectedOperId: integer;
    // Models
    opers: TOperationsTable;
    cats: array [TOperationType] of TCategoriesTable;
    opersStats: TOperationsStatistics;
    catsStats: array [TOperationType]
      of TCategoriesStatistics;

  const
    currencyStr = ' руб.';
    procedure updCategoriesStatus(const tp
      : TOperationType);
    procedure updCategoriesGrid(const tp: TOperationType);
    procedure updOperationsGrid();
    procedure updIncomeOutcome();
    procedure updBtnCreateOper(const tp: TOperationType);
    procedure updBalance();
    procedure setGridHeight(const grid: TStringGrid);
  public
    procedure onEvent(const Sender: TObject);
    procedure setModels(const opersStats
      : TOperationsStatistics; const catsStatsIncome,
      catsStatsOutcome: TCategoriesStatistics);
  end;

var
  homeView: THomeView;

implementation

{$R *.dfm}

var
  catsStatusCaption: array [TOperationType] of array
    [TCatsStatus] of string;

procedure THomeView.actionCategoriesView(Sender: TObject);
var
  categoriesView: TCategoriesView;
begin
  categoriesView := TCategoriesView.create(self, opers,
    cats[income], cats[outcome]);
  categoriesView.showModal;
  categoriesView.free;
end;

procedure THomeView.actionInit(Sender: TObject);
var
  i: integer;
  noHighlight: TGridRect;
begin
  clientWidth := pnlContent.width;

  cbbMonth.itemIndex := monthOfTheYear(date()) - 1;
  for i := currentYear downto 2015 do
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

  lblCatsStatus[income] := lblCatsIncomeStatus;
  lblCatsStatus[outcome] := lblCatsOutcomeStatus;
  imgCatsStatus[income] := imgCatsIncomeStatus;
  imgCatsStatus[outcome] := imgCatsOutcomeStatus;
  imgIcons[csEmpty] := imgIcoWarning;
  imgIcons[csSuccess] := imgIcoOk;
  imgIcons[csFail] := imgIcoNo;
  grdCats[income] := grdCatsIncome;
  grdCats[outcome] := grdCatsOutcome;
  btnCreateOper[income] := btnCreateIncome;
  btnCreateOper[outcome] := btnCreateOutcome;
end;

procedure THomeView.setModels(const opersStats
  : TOperationsStatistics; const catsStatsIncome,
  catsStatsOutcome: TCategoriesStatistics);
begin
  self.opersStats := opersStats;
  opersStats.eventOpersCurrUpd.follow(self);

  catsStats[income] := catsStatsIncome;
  catsStats[income].eventCatsMoneyUpd.follow(self);
  catsStats[income].eventCatsStatusUpd.follow(self);

  catsStats[outcome] := catsStatsOutcome;
  catsStats[outcome].eventCatsMoneyUpd.follow(self);
  catsStats[outcome].eventCatsStatusUpd.follow(self);

  opers := opersStats.opersTable;
  opers.EventOpersUpd.follow(self);

  cats[income] := catsStats[income].catsTable;
  cats[outcome] := catsStats[outcome].catsTable;
  cats[income].eventCatsUpd.follow(self);
  cats[outcome].eventCatsUpd.follow(self);

  updBalance();
  updBtnCreateOper(income);
  updBtnCreateOper(outcome);
  updIncomeOutcome();
  updCategoriesStatus(income);
  updCategoriesGrid(income);
  updCategoriesStatus(outcome);
  updCategoriesGrid(outcome);
  updOperationsGrid();
end;

procedure THomeView.actionOperationDelete(Sender: TObject);
var
  answer: integer;
begin
  if selectedOperId <> 0 then
  begin
    answer := MessageBox(handle,
      'Вы действительно хотите удалить операцию?' + #13#10
      + 'Удалённые данные будет невозможно восстановить.',
      'Уведомление', MB_YESNO + MB_ICONQUESTION +
      MB_DEFBUTTON2);
    if answer = IDYES then
      opers.removeItem(selectedOperId);
  end;
end;

procedure THomeView.actionOperationSelect(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: integer);
var
  col, row: integer;
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
    selectedOperId := opersStats.opersCurr
      [grdOperations.row - 1]^.id;
  end;
end;

procedure THomeView.actionOperationView(Sender: TObject);
var
  operationView: TOperationView;
begin
  operationView := TOperationView.create(self, opers,
    cats[income], cats[outcome]);
  if Sender = btnCreateIncome then
    operationView.prepareToCreate(income)
  else if Sender = btnCreateOutcome then
    operationView.prepareToCreate(outcome)
  else if (Sender = miEdit) or (Sender = grdOperations)
  then
    operationView.prepareToEdit(selectedOperId)
  else if Sender = miRepeat then
    operationView.prepareToRepeat(selectedOperId);
  if operationView.showModal = mrOk then
    MessageBox(handle, 'Операция успешно сохранена',
      PChar('Уведомление'), MB_OK + MB_ICONINFORMATION);
  operationView.free;
end;

procedure THomeView.actionResize(Sender: TObject;
  var newWidth, newHeight: integer; var resize: boolean);
var
  center: integer;
begin
  if newWidth < pnlContent.width + self.width -
    self.clientWidth + getSystemMetrics(SM_CXVSCROLL) then
  begin
    newWidth := pnlContent.width + self.width -
      self.clientWidth + getSystemMetrics(SM_CXVSCROLL);
  end;
  center := self.clientWidth;
  if not self.vertScrollBar.isScrollBarVisible then
    center := center - getSystemMetrics(SM_CXVSCROLL);
  center := center div 2;
  imgLogo.left := center - imgLogo.width div 2;
  pnlContent.left := center - pnlContent.width div 2;
  pnlMainTools.left := pnlContent.left;
end;

procedure THomeView.actionScroll(Sender: TObject;
  Shift: TShiftState; WheelDelta: integer;
  MousePos: TPoint; var Handled: boolean);
begin
  self.vertScrollBar.Position :=
    self.vertScrollBar.Position - WheelDelta;
end;

procedure THomeView.actionMonthUpdate(Sender: TObject);
begin
  opersStats.monthCurr := cbbMonth.itemIndex + 1;
end;

procedure THomeView.actionYearUpdate(Sender: TObject);
begin
  opersStats.yearCurr := strToInt(cbbYear.text);
end;

procedure THomeView.setGridHeight(const grid: TStringGrid);
begin
  with grid do
    height := defaultRowHeight * rowCount + gridLineWidth *
      (rowCount + 4);
end;

procedure THomeView.updCategoriesGrid
  (const tp: TOperationType);
var
  i: integer;
begin
  with grdCats[tp], cats[tp] do
  begin
    rowCount := count + 1;
    for i := 0 to count - 1 do
    begin
      cells[0, i + 1] := items[i]^.name;
      cells[1, i + 1] :=
        moneyToStr(catsStats[tp].money[i]);
      if items[i]^.moneyMonth <> 0 then
        cells[1, i + 1] := cells[1, i + 1] + ' / ' +
          moneyToStr(items[i]^.moneyMonth);
      cells[1, i + 1] := cells[1, i + 1] + currencyStr;
    end;
    setGridHeight(grdCats[tp]);
    visible := count >= 1;
  end;
end;

procedure THomeView.updOperationsGrid();
var
  i: integer;
begin
  grdOperations.visible :=
    length(opersStats.opersCurr) <> 0;
  lblNoOperations.visible := not grdOperations.visible;

  if length(opersStats.opersCurr) <> 0 then
    with grdOperations do
    begin
      rowCount := length(opersStats.opersCurr) + 1;
      setGridHeight(grdOperations);
      for i := 1 to length(opersStats.opersCurr) do
      begin
        cells[0, i] := IntToStr(i);
        with opersStats.opersCurr[i - 1]^ do
        begin
          cells[3, i] := cats[tp].getItem(catId)^.name;
          case tp of
          income:
            cells[1, i] := 'Доход';
          outcome:
            cells[1, i] := 'Расход';
          end;
          cells[2, i] := moneyToStr(money) + currencyStr;
          cells[4, i] := IntToStr(dayOfTheMonth(date));
          cells[5, i] := description;
        end;
      end;
    end;
end;

procedure THomeView.updCategoriesStatus
  (const tp: TOperationType);
begin
  lblCatsStatus[tp].caption := catsStatusCaption[tp]
    [catsStats[tp].status];
  imgCatsStatus[tp].picture :=
    imgIcons[catsStats[tp].status].picture;
end;

procedure THomeView.updIncomeOutcome();
begin
  with opersStats do
  begin
    lblIncome.caption := moneyToStr(incomeMonth) +
      currencyStr;
    lblOutcome.caption := moneyToStr(outcomeMonth) +
      currencyStr;
    if incomeMonth + outcomeMonth = 0 then
      shpIncome.width := 0
    else
      shpIncome.width := shpOutcome.width *
        incomeMonth div (incomeMonth + outcomeMonth);
  end;
end;

procedure THomeView.updBtnCreateOper(const tp
  : TOperationType);
begin
  btnCreateOper[tp].enabled := catsStats[tp].status
    <> csEmpty;
end;

procedure THomeView.updBalance();
begin
  lblBalance.caption := moneyToStr(opers.balance) +
    currencyStr
end;

procedure THomeView.onEvent(const Sender: TObject);
begin
  if Sender = opers.EventOpersUpd then
    updBalance()
  else if Sender = cats[income].eventCatsUpd then
  begin
    updCategoriesGrid(income);
    updOperationsGrid();
  end
  else if Sender = cats[outcome].eventCatsUpd then
  begin
    updCategoriesGrid(outcome);
    updOperationsGrid();
  end
  else if Sender = opersStats.eventOpersCurrUpd then
  begin
    updIncomeOutcome();
    updOperationsGrid();
  end
  else if Sender = catsStats[income].eventCatsMoneyUpd then
    updCategoriesGrid(income)
  else if Sender = catsStats[income].eventCatsStatusUpd
  then
  begin
    updCategoriesStatus(income);
    updBtnCreateOper(income);
  end
  else if Sender = catsStats[outcome].eventCatsMoneyUpd
  then
    updCategoriesGrid(outcome)
  else if Sender = catsStats[outcome].eventCatsStatusUpd
  then
  begin
    updCategoriesStatus(outcome);
    updBtnCreateOper(outcome);
  end
  else
    raise exception.create('Unexpected event');
end;

initialization

catsStatusCaption[income][csEmpty] :=
  'Для полноценного использования' + #13#10 +
  'программы создайте категории доходов';
catsStatusCaption[income][csSuccess] :=
  'Вы достигли желаемых доходов' + #13#10 +
  'по всем категориям в этом месяце';;
catsStatusCaption[income][csFail] :=
  'Вы не достигли желаемых доходов' + #13#10 +
  'по некоторым категориям в этом месяце';

catsStatusCaption[outcome][csEmpty] :=
  'Для полноценного использования' + #13#10 +
  'программы создайте категории расходов';
catsStatusCaption[outcome][csSuccess] :=
  'Вы не превысили запланированные' + #13#10 +
  'расходы по категориям в этом месяце';
catsStatusCaption[outcome][csFail] :=
  'Вы превысили запланированные расходы' + #13#10 +
  'по некоторым категориям в этом месяце';

end.

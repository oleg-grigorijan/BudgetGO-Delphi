unit UnitTHomeView;

interface

uses
  DateUtils,
  System.Classes,
  System.SysUtils,
  UnitMoneyUtils,
  UnitTCategory,
  UnitTCategoryTable,
  UnitTCategoriesView,
  UnitTOperation,
  UnitTOperationList,
  UnitTOperationView,
  Vcl.Controls,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Grids,
  Vcl.Imaging.pngimage,
  Vcl.Menus,
  Vcl.StdCtrls,
  Winapi.Windows;

type
  THomeView = class(TForm)
    btnCreateIncome: TButton;
    btnCreateOutcome: TButton;
    btnEditCategories: TButton;
    cbbMonth: TComboBox;
    cbbYear: TComboBox;
    grdCatsIncome: TStringGrid;
    grdCatsOutcome: TStringGrid;
    grdOperations: TStringGrid;
    imgCatsIncomeStatusNo: TImage;
    imgCatsIncomeStatusOk: TImage;
    imgCatsIncomeStatusWarning: TImage;
    imgCatsOutcomeStatusNo: TImage;
    imgCatsOutcomeStatusOk: TImage;
    imgCatsOutcomeStatusWarning: TImage;
    lblBalance: TLabel;
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
    shpHeaderBG: TShape;
    shpIncome: TShape;
    shpNoOperationsBG: TShape;
    shpOutcome: TShape;
    procedure actionCategoriesView(Sender: TObject);
    procedure actionInit(Sender: TObject);
    procedure actionOperationDelete(Sender: TObject);
    procedure actionOperationSelect(Sender: TObject;
      Button: TMouseButton; Shift: TShiftState;
      X, Y: Integer);
    procedure actionOperationView(Sender: TObject);
    procedure actionResize(Sender: TObject; var newWidth, newHeight: Integer; var resize: Boolean);
    procedure actionScroll(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure actionUpdateStatistics(Sender: TObject);
  private
    var
      catsIncomeMoney, catsOutcomeMoney: array of Longword;
      incomeMonth: Longword;
      opersCurr: TOperations;
      outcomeMonth: Longword;
    procedure countCategoriesMoney();
    procedure fillCategoriesStatus();
    procedure fillCategoriesGrids();
    procedure fillOperationsGrid();
  public
    procedure updateData();
  end;

var
  homeView: ThomeView;

implementation

{$R *.dfm}

procedure THomeView.actionCategoriesView(Sender: TObject);
begin
  if not assigned(categoriesView) then
    categoriesView := TCategoriesView.create(self);
    categoriesView.showModal;
end;

procedure THomeView.actionInit(Sender: TObject);
var
  i: Integer;
begin
  homeView.width := shpHeaderBG.width + homeView.width - homeView.clientWidth;
  cbbMonth.itemIndex := monthOfTheYear(date()) - 1;
  for i := currentYear downto 2010 do
    cbbYear.items.add(IntToStr(i));
  cbbYear.itemIndex := 0;
  with grdCatsIncome do
  begin
    cells[0, 0] := '���������';
    cells[1, 0] := '�������� �� ���.';
  end;
  with grdCatsOutcome do
  begin
    cells[0, 0] := '���������';
    cells[1, 0] := '��������� �� ���.';
  end;
  with grdOperations do
  begin
    cells[1, 0] := '���';
    cells[2, 0] := '�����';
    cells[3, 0] := '���������';
    cells[4, 0] := '����';
    cells[5, 0] := '��������';
  end;
  updateData();
end;

procedure THomeView.actionOperationDelete(Sender: TObject);
var
  answer: Integer;
begin
  if grdOperations.tag <> 0 then
  begin
    answer := MessageBox(handle, '�� ������������� ������ ������� ��������?' +
      #13#10 + '�������� ������ ����� ���������� ������������.',
      '�����������', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2);
    if answer = IDYES then
    begin
      operList.removeItem(grdOperations.tag);
      updateData();
    end;
  end;
end;

procedure THomeView.actionOperationSelect(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  col, row: Integer;
begin
  grdOperations.mouseToCell(X, Y, col, row);
  grdOperations.col := col;
  if grdOperations.rowCount = 1 then
    grdOperations.tag := 0
  else
  begin
    if row = 0 then
      grdOperations.row := 1
    else
      grdOperations.row := row;
    grdOperations.tag := opersCurr[grdOperations.row - 1]^.id;
  end;
end;

procedure THomeView.actionOperationView(Sender: TObject);
begin
  if not assigned(operationView) then
    operationView := TOperationView.create(self);
  if Sender = btnCreateIncome then
    operationView.prepareToCreate(income)
  else if Sender = btnCreateOutcome then
    operationView.prepareToCreate(outcome)
  else if (Sender = miEdit) or (Sender = grdOperations) then
    operationView.prepareToEdit(grdOperations.tag)
  else if Sender = miRepeat then
    operationView.prepareToRepeat(grdOperations.tag);
  operationView.ShowModal;
  if operationView.ModalResult = mrOk then
  begin
    updateData();
    messageBox(handle, '�������� ������� ���������', PChar('�����������'),
      MB_OK + MB_ICONINFORMATION);
  end;
end;

procedure THomeView.actionResize(Sender: TObject; var newWidth, newHeight: Integer; var resize: Boolean);
begin
  if newWidth > shpHeaderBG.width + homeView.width - homeView.clientWidth then
  begin
    homeView.clientWidth := shpHeaderBG.width;
    resize := false;
  end;
end;

procedure THomeView.actionScroll(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  homeView.VertScrollBar.Position :=  homeView.VertScrollBar.Position - WheelDelta;
end;

procedure THomeView.actionUpdateStatistics(Sender: TObject);
begin
  updateData();
end;

procedure THomeView.countCategoriesMoney();
var
  i, j: Integer;
begin
  setLength(catsIncomeMoney, length(catsIncome.getItems));
  for i := 0 to length(catsIncomeMoney) - 1 do
    catsIncomeMoney[i] := 0;
  setLength(catsOutcomeMoney, length(catsOutcome.getItems));
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
          catsOutcomeMoney[j] := catsOutcomeMoney[j] + money;
        end;
      end;
    end;
end;

procedure THomeView.fillCategoriesGrids();
var
  i: Integer;
begin
  with grdCatsIncome do
  begin
    rowCount := length(catsIncome.getItems) + 1;
    height := (defaultRowHeight + gridLineWidth) * rowCount;
    for i := 0 to length(catsIncome.getItems) - 1 do
    begin
      cells[0, i + 1] := catsIncome.getItems[i]^.name;
      cells[1, i + 1] := moneyToStr(catsIncomeMoney[i]);
      if catsIncome.getItems[i]^.moneyMonth <> 0 then
        cells[1, i + 1] := cells[1, i + 1] + ' / ' +
          moneyToStr(catsIncome.getItems[i]^.moneyMonth);
      cells[1, i + 1] := cells[1, i + 1] + ' ���.';
    end;
  end;
  with grdCatsOutcome do
  begin
    rowCount := length(catsOutcome.getItems) + 1;
    height := (defaultRowHeight + gridLineWidth) * rowCount;
    for i := 0 to length(catsOutcome.getItems) - 1 do
    begin
      cells[0, i + 1] := catsOutcome.getItems[i]^.name;
      cells[1, i + 1] := moneyToStr(catsOutcomeMoney[i]);
      if catsOutcome.getItems[i]^.moneyMonth <> 0 then
        cells[1, i + 1] := cells[1, i + 1] + ' / ' +
        moneyToStr(catsOutcome.getItems[i]^.moneyMonth);
      cells[1, i + 1] := cells[1, i + 1] + ' ���.';
    end;
  end;
end;

procedure THomeView.fillOperationsGrid();
var
  i: Integer;
begin
  with grdOperations do
  begin
    if length(opersCurr) = 0 then
    begin
      visible := false;
      lblNoOperations.visible := true;
      shpNoOperationsBG.visible := true;
    end
    else
    begin
      visible := true;
      lblNoOperations.visible := false;
      shpNoOperationsBG.visible := false;
      rowCount := length(opersCurr) + 1;
      height := defaultRowHeight*rowCount + gridLineWidth*(rowCount + 4);
      for i := 1 to length(opersCurr) do
      begin
        cells[0, i] := intToStr(i);
        with opersCurr[i - 1]^ do
        begin
          case tp of
            income:
            begin
              cells[1, i] := '�����';
              cells[3, i] := catsIncome.getItem(catId)^.name;
            end;
            outcome:
            begin
              cells[1, i] := '������';
              cells[3, i] := catsOutcome.getItem(catId)^.name;
            end;
          end;
          cells[2, i] := moneyToStr(money) + ' ���.';
          cells[4, i] := intToStr(dayOfTheMonth(date));
          cells[5, i] := description;
        end;
      end;
    end;
  end;
end;

procedure THomeView.fillCategoriesStatus();
var
  i: Integer;
begin
  imgCatsIncomeStatusNo.visible := false;
  if length(catsIncome.getItems) = 0 then
  begin
    btnCreateIncome.enabled := false;
    imgCatsIncomeStatusOk.visible := false;
    imgCatsIncomeStatusWarning.visible := true;
    lblCatsIncomeStatus.caption := '��� ������������ �������������' + #13#10 +
      '���������� �������� ��������� �������';
  end
  else
  begin
    btnCreateIncome.enabled := true;
    imgCatsIncomeStatusOk.visible := true;
    imgCatsIncomeStatusWarning.visible := false;
    lblCatsIncomeStatus.caption := '�� �������� �������� �������' + #13#10 +
      '�� ���� ���������� � ���� ������';
    for i := 0 to length(catsIncome.getItems) - 1 do
      if catsIncomeMoney[i] < catsIncome.getItems[i]^.moneyMonth then
      begin
        lblCatsIncomeStatus.caption := '�� �� �������� �������� �������' + #13#10 +
          '�� ��������� ���������� � ���� ������';
        imgCatsIncomeStatusNo.visible := true;
        imgCatsIncomeStatusOk.visible := false;
      end;
  end;
  imgCatsOutcomeStatusNo.visible := false;
  if length(catsOutcome.getItems) = 0 then
  begin
    btnCreateOutcome.enabled := false;
    imgCatsOutcomeStatusOk.visible := false;
    imgCatsOutcomeStatusWarning.visible := true;
    lblCatsOutcomeStatus.caption := '��� ������������ �������������' + #13#10 +
      '���������� �������� ��������� ��������';
  end
  else
  begin
    btnCreateOutcome.enabled := true;
    imgCatsOutcomeStatusOk.visible := true;
    imgCatsOutcomeStatusWarning.visible := false;
    lblCatsOutcomeStatus.caption := '�� �� ��������� ���������������' + #13#10 +
      '������� �� ���������� � ���� ������';
    for i := 0 to length(catsOutcome.getItems) - 1 do
      if (catsOutcome.getItems[i]^.moneyMonth <> 0) and
      (catsOutcomeMoney[i] > catsOutcome.getItems[i]^.moneyMonth) then
      begin
        lblCatsOutcomeStatus.caption := '�� ��������� ��������������� �������' + #13#10 +
          '�� ��������� ���������� � ���� ������';
        imgCatsOutcomeStatusNo.visible := true;
        imgCatsOutcomeStatusOk.visible := false;
      end;
  end;
end;

procedure THomeView.updateData();
var
  i: Integer;
  topCurr: Integer;
begin
  lblBalance.caption := moneyToStr(operList.getBalance) + ' ���.';
  opersCurr := operList.getItems(cbbMonth.itemIndex + 1,
    strToInt(cbbYear.text));

  countCategoriesMoney();

  incomeMonth := 0;
  for i := 0 to length(catsIncomeMoney) - 1 do
    incomeMonth := incomeMonth + catsIncomeMoney[i];
  outcomeMonth := 0;
  for i := 0 to length(catsOutcomeMoney) - 1 do
    outcomeMonth := outcomeMonth + catsOutcomeMoney[i];
  lblIncome.caption := moneyToStr(incomeMonth) + ' ���.';
  lblOutcome.caption := moneyToStr(outcomeMonth) + ' ���.';

  if incomeMonth + outcomeMonth = 0 then
    shpIncome.width := 0
  else
    shpIncome.width := shpOutcome.width*incomeMonth div
      (incomeMonth + outcomeMonth);

  fillCategoriesStatus();
  fillCategoriesGrids();

  if grdCatsIncome.height >= grdCatsOutcome.height then
    topCurr := grdCatsIncome.top + grdCatsIncome.height
  else
    topCurr := grdCatsOutcome.top + grdCatsOutcome.height;
  lblOperationsBefore.top := topCurr + 25;
  topCurr := lblOperationsBefore.top + lblOperationsBefore.height;
  grdOperations.top := topCurr + 8;
  shpNoOperationsBG.top := topCurr + 8;
  lblNoOperations.top := shpNoOperationsBG.top + 55;
  fillOperationsGrid();
end;

end.

object categoriesView: TcategoriesView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'BudgetGO'
  ClientHeight = 308
  ClientWidth = 290
  Color = clBtnFace
  DefaultMonitor = dmMainForm
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = actionInit
  OnMouseDown = actionCategorySelect
  PixelsPerInch = 120
  TextHeight = 16
  object lblHeader: TLabel
    Left = 18
    Top = 18
    Width = 104
    Height = 25
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object tbcOperType: TTabControl
    Left = -1
    Top = 56
    Width = 295
    Height = 290
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Tabs.Strings = (
      #1044#1086#1093#1086#1076#1099
      #1056#1072#1089#1093#1086#1076#1099)
    TabIndex = 0
    OnChange = actionOnTypeChange
    object grdCategories: TStringGrid
      Left = 0
      Top = 80
      Width = 294
      Height = 176
      Cursor = crHandPoint
      ColCount = 3
      FixedCols = 0
      GradientEndColor = clWhite
      Options = [goFixedHorzLine, goHorzLine, goDrawFocusSelected, goRowSelect]
      PopupMenu = pmCategory
      ScrollBars = ssVertical
      TabOrder = 1
      OnDblClick = actionCategoryView
      OnMouseDown = actionCategorySelect
      ColWidths = (
        28
        129
        155)
    end
    object btnCreate: TButton
      Left = 75
      Top = 40
      Width = 145
      Height = 25
      Caption = #1053#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Google Sans'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = actionCategoryView
    end
  end
  object pmCategory: TPopupMenu
    Left = 239
    Top = 144
    object miEdit: TMenuItem
      Caption = '&'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = actionCategoryView
    end
  end
end

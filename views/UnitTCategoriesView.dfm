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
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = actionInit
  PixelsPerInch = 120
  TextHeight = 17
  object lblHeader: TLabel
    Left = 18
    Top = 15
    Width = 98
    Height = 28
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI Semibold'
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
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Tabs.Strings = (
      #1044#1086#1093#1086#1076#1099
      #1056#1072#1089#1093#1086#1076#1099)
    TabIndex = 0
    OnChange = actionOnTypeChange
    object shpNoCategoriesBG: TShape
      Left = 0
      Top = 80
      Width = 290
      Height = 172
      Brush.Color = 16185078
      Pen.Color = 13290186
    end
    object lblNoCategories: TLabel
      Left = 58
      Top = 140
      Width = 179
      Height = 34
      Alignment = taCenter
      Caption = #1042#1099' '#1077#1097#1105' '#1085#1077' '#1089#1086#1079#1076#1072#1083#1080' '#1082#1072#1090#1077#1075#1086#1088#1080#1080#13#10#1076#1083#1103' '#1086#1087#1077#1088#1072#1094#1080#1081' '#1076#1072#1085#1085#1086#1075#1086' '#1090#1080#1087#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object grdCategories: TStringGrid
      Left = 0
      Top = 80
      Width = 294
      Height = 174
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
        22
        124
        155)
    end
    object btnCreate: TButton
      Left = 61
      Top = 40
      Width = 174
      Height = 25
      Cursor = crHandPoint
      Caption = #1053#1086#1074#1072#1103' '#1082#1072#1090#1077#1075#1086#1088#1080#1103' '#1088#1072#1089#1093#1086#1076#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Segoe UI'
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
    object miDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      OnClick = actionCategoryDelete
    end
  end
end

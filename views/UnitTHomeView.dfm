object homeView: ThomeView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BudgetGO'
  ClientHeight = 489
  ClientWidth = 689
  Color = clWhite
  DragKind = dkDock
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = actionInit
  PixelsPerInch = 120
  TextHeight = 16
  object shp3: TShape
    Left = -8
    Top = 47
    Width = 701
    Height = 119
    Brush.Color = 16185078
    Pen.Color = 13290186
  end
  object lblHeader: TLabel
    Left = 286
    Top = 8
    Width = 104
    Height = 25
    Caption = 'BudgetGO'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblBalanceAfter: TLabel
    Left = 226
    Top = 124
    Width = 94
    Height = 17
    Caption = #1085#1072' '#1074#1072#1096#1077#1084' '#1089#1095#1077#1090#1091
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
  end
  object lblBalance: TLabel
    Left = 167
    Top = 75
    Width = 153
    Height = 58
    Alignment = taRightJustify
    BiDiMode = bdLeftToRight
    Caption = '104.03'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -47
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 369
    Top = 65
    Width = 104
    Height = 17
    Caption = #1053#1086#1074#1072#1103' '#1086#1087#1077#1088#1072#1094#1080#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbl3: TLabel
    Left = 40
    Top = 308
    Width = 86
    Height = 21
    Caption = #1054#1087#1077#1088#1072#1094#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblStatistics: TLabel
    Left = 40
    Top = 188
    Width = 113
    Height = 25
    Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblIncomeAfter: TLabel
    Left = 40
    Top = 230
    Width = 107
    Height = 17
    Caption = #1044#1086#1093#1086#1076#1099' '#1079#1072' '#1084#1077#1089#1103#1094
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
  end
  object lblIncome: TLabel
    Left = 40
    Top = 248
    Width = 82
    Height = 17
    BiDiMode = bdLeftToRight
    Caption = '2265.50 '#1088#1091#1073'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 187
    Top = 230
    Width = 110
    Height = 17
    Caption = #1056#1072#1089#1093#1086#1076#1099' '#1079#1072' '#1084#1077#1089#1103#1094
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
  end
  object lblOutcome: TLabel
    Left = 187
    Top = 248
    Width = 81
    Height = 17
    BiDiMode = bdLeftToRight
    Caption = '1250.64 '#1088#1091#1073'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object shpOutcome: TShape
    Left = 40
    Top = 271
    Width = 280
    Height = 10
    Brush.Color = 13815295
    Pen.Color = 13815295
    Shape = stRoundRect
  end
  object shpIncome: TShape
    Left = 40
    Top = 271
    Width = 89
    Height = 10
    Brush.Color = 14019539
    Pen.Color = 14019539
    Shape = stRoundRect
  end
  object btnCreateIncome: TButton
    Left = 351
    Top = 88
    Width = 146
    Height = 25
    Caption = #1044#1086#1093#1086#1076
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnClick = actionOperationView
  end
  object btnCreateOutcome: TButton
    Left = 351
    Top = 119
    Width = 146
    Height = 25
    Caption = #1056#1072#1089#1093#1086#1076
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = actionOperationView
  end
  object grdOperations: TStringGrid
    Left = 0
    Top = 335
    Width = 690
    Height = 155
    Cursor = crHandPoint
    ColCount = 6
    FixedCols = 0
    GradientEndColor = clWhite
    Options = [goFixedHorzLine, goHorzLine, goDrawFocusSelected, goRowSelect]
    ScrollBars = ssVertical
    TabOrder = 2
    ColWidths = (
      29
      57
      109
      90
      41
      371)
  end
  object cbbMonth: TComboBox
    Left = 167
    Top = 188
    Width = 88
    Height = 25
    HelpType = htKeyword
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    OnChange = actionUpdateStatistics
    Items.Strings = (
      #1071#1085#1074#1072#1088#1100
      #1060#1077#1074#1088#1072#1083#1100
      #1052#1072#1088#1090
      #1040#1087#1088#1077#1083#1100
      #1052#1072#1081
      #1048#1102#1085#1100
      #1048#1102#1083#1100
      #1040#1074#1075#1091#1089#1090
      #1057#1077#1085#1090#1103#1073#1088#1100
      #1054#1082#1090#1103#1073#1088#1100
      #1053#1086#1103#1073#1088#1100
      #1044#1077#1082#1072#1073#1088#1100)
  end
  object cbbYear: TComboBox
    Left = 254
    Top = 188
    Width = 88
    Height = 25
    HelpType = htKeyword
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnChange = actionUpdateStatistics
  end
end

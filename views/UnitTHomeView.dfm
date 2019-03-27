object homeView: ThomeView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BudgetGO'
  ClientHeight = 583
  ClientWidth = 689
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Google Sans'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = actionInit
  PixelsPerInch = 120
  TextHeight = 17
  object shpHeaderBG: TShape
    Left = 0
    Top = 42
    Width = 701
    Height = 106
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
    Left = 350
    Top = 74
    Width = 94
    Height = 17
    Alignment = taRightJustify
    Caption = #1085#1072' '#1074#1072#1096#1077#1084' '#1089#1095#1077#1090#1091
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
  end
  object lblBalance: TLabel
    Left = 350
    Top = 87
    Width = 162
    Height = 41
    BiDiMode = bdLeftToRight
    Caption = '10.03 '#1088#1091#1073'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -33
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object lblNewOperationBefore: TLabel
    Left = 193
    Top = 56
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
    Top = 379
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
    Top = 172
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
  object lblIncomeBefore: TLabel
    Left = 40
    Top = 214
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
    Top = 232
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
  object lblOutcomeBefore: TLabel
    Left = 187
    Top = 214
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
    Top = 232
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
    Top = 255
    Width = 280
    Height = 10
    Brush.Color = 13815295
    Pen.Color = 13815295
    Shape = stRoundRect
  end
  object shpIncome: TShape
    Left = 40
    Top = 255
    Width = 89
    Height = 10
    Brush.Color = 14019539
    Pen.Color = 14019539
    Shape = stRoundRect
  end
  object lbl1: TLabel
    Left = 40
    Top = 290
    Width = 89
    Height = 21
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -17
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnCreateIncome: TButton
    Left = 174
    Top = 75
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
    Left = 174
    Top = 103
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
    Top = 406
    Width = 690
    Height = 179
    Cursor = crHandPoint
    ColCount = 6
    FixedCols = 0
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    GradientEndColor = clWhite
    Options = [goFixedHorzLine, goHorzLine, goDrawFocusSelected, goRowSelect]
    ParentFont = False
    PopupMenu = pmOperation
    ScrollBars = ssVertical
    TabOrder = 5
    OnDblClick = actionOperationView
    OnMouseDown = actionOperationSelect
    ColWidths = (
      34
      57
      99
      92
      44
      359)
  end
  object cbbMonth: TComboBox
    Left = 174
    Top = 175
    Width = 83
    Height = 25
    HelpType = htKeyword
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
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
    Left = 268
    Top = 175
    Width = 52
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
  end
  object btnCategories: TButton
    Left = 141
    Top = 290
    Width = 90
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    OnClick = actionCategoriesView
  end
  object pmOperation: TPopupMenu
    Left = 640
    Top = 424
    object miEdit: TMenuItem
      Caption = '&'#1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100
      OnClick = actionOperationView
    end
    object miRepeat: TMenuItem
      Caption = '&'#1055#1086#1074#1090#1086#1088#1080#1090#1100
      OnClick = actionOperationView
    end
    object miDelete: TMenuItem
      Caption = '&'#1059#1076#1072#1083#1080#1090#1100
      OnClick = actionOperationDelete
    end
  end
end

object OperationView: TOperationView
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
  Padding.Top = 5
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 120
  TextHeight = 17
  object lblRublesAfter: TLabel
    Left = 107
    Top = 77
    Width = 25
    Height = 17
    Caption = #1088#1091#1073'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblPennyAfter: TLabel
    Left = 228
    Top = 77
    Width = 24
    Height = 17
    Caption = #1082#1086#1087'.'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object lblMoneyBefore: TLabel
    Left = 18
    Top = 55
    Width = 42
    Height = 17
    Caption = #1057#1091#1084#1084#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDescriptionBefore: TLabel
    Left = 18
    Top = 154
    Width = 62
    Height = 17
    Caption = #1054#1087#1080#1089#1072#1085#1080#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTp: TLabel
    Left = 18
    Top = 15
    Width = 237
    Height = 28
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#1088#1072#1089#1093#1086#1076#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblDateBefore: TLabel
    Left = 18
    Top = 203
    Width = 29
    Height = 17
    Caption = #1044#1072#1090#1072
    Color = clWhite
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object lblCategoryBefore: TLabel
    Left = 18
    Top = 104
    Width = 64
    Height = 17
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object btnSave: TButton
    Left = 180
    Top = 263
    Width = 90
    Height = 25
    Cursor = crHandPoint
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    DoubleBuffered = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 1
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 7
    Visible = False
    StyleElements = [seFont, seClient]
    OnClick = actionSave
  end
  object edtRubles: TEdit
    Left = 18
    Top = 74
    Width = 83
    Height = 25
    Cursor = crIBeam
    Hint = 's'
    Alignment = taRightJustify
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    ParentShowHint = False
    ShowHint = False
    TabOrder = 0
    OnChange = actionMoneyChange
  end
  object edtPenny: TEdit
    Left = 139
    Top = 74
    Width = 83
    Height = 25
    Cursor = crIBeam
    Alignment = taRightJustify
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    NumbersOnly = True
    ParentFont = False
    TabOrder = 1
    OnChange = actionMoneyChange
  end
  object btnCreate: TButton
    Left = 180
    Top = 263
    Width = 90
    Height = 25
    Cursor = crHandPoint
    Caption = #1057#1086#1079#1076#1072#1090#1100
    DoubleBuffered = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 1
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 6
    Visible = False
    StyleElements = [seFont, seClient]
    OnClick = actionCreate
  end
  object edtDescription: TEdit
    Left = 18
    Top = 173
    Width = 252
    Height = 25
    Cursor = crIBeam
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
  end
  object btnCancel: TButton
    Left = 84
    Top = 263
    Width = 90
    Height = 25
    Cursor = crHandPoint
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = False
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 5
    StyleElements = [seFont, seClient]
  end
  object dtpDate: TDateTimePicker
    Left = 18
    Top = 223
    Width = 252
    Height = 25
    Cursor = crIBeam
    Date = 43546.000000000000000000
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    MinDate = 40179.000000000000000000
    ParentFont = False
    TabOrder = 4
  end
  object cbbCategory: TComboBox
    Left = 18
    Top = 124
    Width = 252
    Height = 25
    Cursor = crHandPoint
    Style = csDropDownList
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
  end
end

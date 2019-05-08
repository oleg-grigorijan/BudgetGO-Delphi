object categoryView: TcategoryView
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'BudgetGO'
  ClientHeight = 308
  ClientWidth = 290
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = actionInit
  PixelsPerInch = 120
  TextHeight = 17
  object lblTp: TLabel
    Left = 18
    Top = 15
    Width = 171
    Height = 56
    Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077' '#13#10#1082#1072#1090#1077#1075#1086#1088#1080#1080' '#1076#1086#1093#1086#1076#1072
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -20
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblRublesAfter: TLabel
    Left = 107
    Top = 157
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
    Top = 157
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
    Top = 136
    Width = 136
    Height = 17
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1086' '#1074' '#1084#1077#1089#1103#1094
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblNameBefore: TLabel
    Left = 18
    Top = 84
    Width = 60
    Height = 17
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblInfo: TLabel
    Left = 18
    Top = 193
    Width = 214
    Height = 51
    Caption = 
      #1052#1099' '#1091#1074#1077#1076#1086#1084#1080#1084' '#1074#1072#1089', '#1077#1089#1083#1080' '#1076#1086' '#1082#1086#1085#1094#1072#13#10#1084#1077#1089#1103#1094#1072' '#1074#1099' '#1085#1077' '#1076#1086#1089#1090#1080#1075#1085#1077#1090#1077' '#1078#1077#1083#1072#1077#1084#1086#1081 +
      #13#10#1089#1091#1084#1084#1099' '#1087#1086' '#1076#1072#1085#1085#1086#1081' '#1082#1072#1090#1077#1075#1086#1088#1080#1080'.'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object edtRubles: TEdit
    Left = 18
    Top = 155
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
    TabOrder = 1
  end
  object edtPenny: TEdit
    Left = 139
    Top = 155
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
    TabOrder = 2
  end
  object edtName: TEdit
    Left = 18
    Top = 103
    Width = 252
    Height = 25
    Cursor = crIBeam
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    Text = ' '
    OnChange = actionOnNameChange
  end
  object btnSave: TButton
    Left = 180
    Top = 263
    Width = 90
    Height = 25
    Cursor = crHandPoint
    Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
    DoubleBuffered = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 1
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 5
    Visible = False
    StyleElements = [seFont, seClient]
    OnClick = actionSave
  end
  object btnCreate: TButton
    Left = 180
    Top = 263
    Width = 90
    Height = 25
    Cursor = crHandPoint
    Caption = #1057#1086#1079#1076#1072#1090#1100
    DoubleBuffered = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 1
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 4
    Visible = False
    StyleElements = [seFont, seClient]
    OnClick = actionCreate
  end
  object btnCancel: TButton
    Left = 84
    Top = 263
    Width = 90
    Height = 25
    Cursor = crHandPoint
    Caption = #1054#1090#1084#1077#1085#1072
    DoubleBuffered = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ModalResult = 2
    ParentDoubleBuffered = False
    ParentFont = False
    TabOrder = 3
    StyleElements = [seFont, seClient]
  end
end

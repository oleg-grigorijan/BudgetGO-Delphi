object homeView: ThomeView
  Left = 0
  Top = 0
  Caption = 'BudgetGO'
  ClientHeight = 450
  ClientWidth = 677
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = actionInit
  PixelsPerInch = 120
  TextHeight = 16
  object lblHeader: TLabel
    Left = 281
    Top = 16
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
  object lbl1: TLabel
    Left = 185
    Top = 119
    Width = 137
    Height = 16
    Caption = #1082#1086#1087#1077#1077#1082' '#1085#1072' '#1074#1072#1096#1077#1084' '#1089#1095#1077#1090#1091
  end
  object lblBalance: TLabel
    Left = 160
    Top = 57
    Width = 167
    Height = 75
    BiDiMode = bdRightToLeft
    Caption = '10522'
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -60
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentBiDiMode = False
    ParentFont = False
  end
  object Label1: TLabel
    Left = 397
    Top = 57
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
  object btnCreateIncome: TButton
    Left = 376
    Top = 80
    Width = 146
    Height = 25
    Caption = #1044#1086#1093#1086#1076
    TabOrder = 0
    OnClick = actionOperationView
  end
  object btnCreateOutcome: TButton
    Left = 376
    Top = 111
    Width = 146
    Height = 25
    Caption = #1056#1072#1089#1093#1086#1076
    TabOrder = 1
    OnClick = actionOperationView
  end
end

object homeView: ThomeView
  Left = 0
  Top = 0
  Width = 709
  Height = 600
  VertScrollBar.Smooth = True
  AutoScroll = True
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = 'BudgetGO'
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Google Sans'
  Font.Style = []
  OldCreateOrder = False
  OnCanResize = actionResize
  OnCreate = actionInit
  OnMouseWheel = actionScroll
  PixelsPerInch = 120
  TextHeight = 17
  object lblCatsIncomeStatus: TLabel
    Left = 65
    Top = 348
    Width = 251
    Height = 34
    Caption = 
      #1042#1099' '#1085#1077' '#1076#1086#1089#1090#1080#1075#1083#1080' '#1078#1077#1083#1072#1077#1084#1099#1093' '#1076#1086#1093#1086#1076#1086#1074#13#10#1087#1086' '#1085#1077#1082#1086#1090#1086#1088#1099#1084' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1074' '#1101#1090#1086#1084' ' +
      #1084#1077#1089#1103#1094#1077
  end
  object lblCatsOutcomeStatus: TLabel
    Left = 375
    Top = 348
    Width = 236
    Height = 34
    Caption = 
      #1042#1099' '#1085#1077' '#1087#1088#1077#1074#1099#1089#1080#1083#1080' '#1079#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1085#1099#1077#13#10#1088#1072#1089#1093#1086#1076#1099' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1074' '#1101#1090#1086#1084' '#1084#1077 +
      'c'#1103#1094#1077
  end
  object shpHeaderBG: TShape
    Left = 0
    Top = 42
    Width = 670
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
  object lblBalanceBefore: TLabel
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
  object lblOperationsBefore: TLabel
    Left = 40
    Top = 514
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
  object lblStatisticsBefore: TLabel
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
    Brush.Color = 3951847
    Pen.Color = 3951847
    Shape = stRoundRect
  end
  object shpIncome: TShape
    Left = 40
    Top = 255
    Width = 89
    Height = 10
    Brush.Color = 7457838
    Pen.Color = 7457838
    Shape = stRoundRect
  end
  object lblCategoriesBefore: TLabel
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
  object shpNoOperationsBG: TShape
    Left = 0
    Top = 541
    Width = 670
    Height = 120
    Brush.Color = 16185078
    Pen.Color = 13290186
  end
  object lblNoOperations: TLabel
    Left = 251
    Top = 588
    Width = 168
    Height = 34
    Alignment = taCenter
    Caption = #1042#1099' '#1085#1077' '#1089#1086#1074#1077#1088#1096#1072#1083#1080' '#1086#1087#1077#1088#1072#1094#1080#1080#13#10#1074' '#1101#1090#1086#1084' '#1084#1077#1089#1103#1094#1077
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    ParentFont = False
  end
  object imgCatsOutcomeStatus: TImage
    Left = 350
    Top = 348
    Width = 24
    Height = 24
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
      00180806000000E0773DF80000000473424954080808087C0864880000000970
      4859730000017C0000017C01B2BA8C670000001974455874536F667477617265
      007777772E696E6B73636170652E6F72679BEE3C1A000002184944415478DA63
      64A031601C500B546EE7B2737F620DFDFFEF7F2050A5015048102AF51EC83FFF
      9FE1FFFAEF7C7FD7DC519DFC93640BF44E17843030327603990A041C799FE13F
      63E925D3BEB5445910BA2A94F9A6924C1F9099475258FCFF3F41FDFED392D561
      ABFFE2B540FF74D194FF8CFFB3C9086E109874C9A43F1FA705BA670A02181918
      D7936938D81F4013FD2F19F76FC6B040617F03071FEFC7EB0C84C39C10B8FF8D
      FF8F262CE2E116E89D2E8C00F2969368D82B6042F067FCCFC0094C51FB90BC11
      76D9A46F359A05052B808AC34932FCFF5FE74BA693AEE89F2E34FBCFC8701249
      6E19302EA2512CD03F5378FB3F30E91369F85326E6BF8E170C27DD3638956FFA
      8F896917504C0049FE26D0020D541F9C29FC0CA478A86038087C065AC0876EC1
      1720C50DE333FDFFEFF89799E127E33FC60D40AE1854F825331393D379A3DE6B
      BA670A75819AF702C544B13802AB05B780942ADC827FFFCC2E984D3CAD7FAA50
      FB3F13D8A0FFFF18FF3B5D319E709D80E138820833925F03E3C4F9B249FF65C3
      73C55ABFFFFFFD4FA4E1D823194732855B02E2106938F664AA7DB5818DF9FB87
      6B402165744B80C1E5FD9F9189119814B710321C086EB3327CD53E6B32EB378A
      051017D2B0A88007D5998236A0702559C633FE6FBD643CA10645085D0DCD8B6B
      B84F6855E120035095C9F58105585DFEF70406AE0950B11224A019EE01D9A719
      1919B77FE5FBBD81AC2A935A80E61600001E17EE19B492A1EC0000000049454E
      44AE426082}
  end
  object imgCatsIncomeStatus: TImage
    Left = 40
    Top = 348
    Width = 24
    Height = 24
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
      00180806000000E0773DF80000000473424954080808087C0864880000000970
      4859730000017C0000017C01B2BA8C670000001974455874536F667477617265
      007777772E696E6B73636170652E6F72679BEE3C1A0000025E4944415478DAC5
      55CD6B5341109FD9885A5A0BF52B79C18328054B542A580F3109B4CD254DD2DA
      C353C13F41E8490FE2BD070F22E8DFA0428AA5E635154A2A3689E047A12AAD5F
      201E34AFB18A87446A91EC388989BEF7FA12D260742FBB3B333BBF99DFECCE22
      B478E07F05781B0A6D6B170515058D02412F8BBA2AAAAF7C729188EE7C2B764E
      74CFCCAC6F1A400FFB5400BA0288FBEB8648F41E505C54B4D4444300A4AA0E7D
      4DBFCA8AB14D518178CDB9DD750163B1625D003DE2BBC1D3F9E608A7EB4A3C63
      0ACC04908DFA4F21D16453CE2B04B0C31197968E6F0058523D5B777EEF5AE662
      1E341CE81720D72588295EEFB138FB84482324A18DF999FB8DC07743D1D73CB8
      B0F0C304B012F69F25A45BA67024F5B91399A72B61EF61429164D1DE8A2AC774
      0C321D4B7AC47F822D1F99F380D3CA743A660260C3DBAC39638D921D0D941D45
      4F7A98806459EAC001652AB55C91CD1980AB59DC746BE97326806CC4F78637DD
      36BCE68844BF7B7AFE65361CE82909AA6B44799FB74E9B33AF142DDD63C9C097
      E7A9A346F156518A415762FE4599CEA1C01112B214F9EE1AF67906E8B4021478
      6AB7B7C72F45590CEE4B3C5C2CED3E0E078E0949B34CC6AE8601EA50F4590004
      9D5AFA9991A20F43DE5E8710B335B278CD00871A29F2AA101874DE4D3DB72B72
      6ED87F544A4A5A416C8BDCF4358D7AFB80C46330236CBCA6760F8DBB65005170
      A7240D6C1E1AA08C50714B1B0AF9C010BDFD432BD7A195ADE24FB1FDE30874A9
      39EF34EE8E672E1B65FFBE5D5747CB3E1CE3287D993B446194530F71F58EB3F5
      815F4EE11D087C8212EEE565C764535FE6DF1A2D07F809E5D22A286D7DF6D400
      00000049454E44AE426082}
  end
  object lblCatsIncomeBefore: TLabel
    Left = 40
    Top = 320
    Width = 53
    Height = 17
    Caption = #1044#1086#1093#1086#1076#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblCatsOutcomeBefore: TLabel
    Left = 350
    Top = 320
    Width = 56
    Height = 17
    Caption = #1056#1072#1089#1093#1086#1076#1099
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object grdOperations: TStringGrid
    Left = 0
    Top = 541
    Width = 670
    Height = 120
    Cursor = crHandPoint
    ColCount = 6
    FixedCols = 0
    RowCount = 2
    Font.Charset = RUSSIAN_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Google Sans'
    Font.Style = []
    GradientEndColor = clWhite
    Options = [goFixedHorzLine, goHorzLine, goDrawFocusSelected, goRowSelect]
    ParentFont = False
    PopupMenu = pmOperation
    ScrollBars = ssNone
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
  object btnEditCategories: TButton
    Left = 141
    Top = 286
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
  object grdCatsIncome: TStringGrid
    Left = 40
    Top = 390
    Width = 285
    Height = 105
    BorderStyle = bsNone
    ColCount = 2
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedHorzLine, goHorzLine, goRowSelect]
    ScrollBars = ssNone
    TabOrder = 6
    ColWidths = (
      110
      173)
  end
  object grdCatsOutcome: TStringGrid
    Left = 350
    Top = 390
    Width = 285
    Height = 105
    BorderStyle = bsNone
    ColCount = 2
    Enabled = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedHorzLine, goHorzLine, goRowSelect]
    ScrollBars = ssNone
    TabOrder = 7
    ColWidths = (
      110
      173)
  end
  object pmOperation: TPopupMenu
    Left = 24
    Top = 457
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

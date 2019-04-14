object homeView: ThomeView
  Left = 480
  Top = 231
  Width = 754
  Height = 754
  HorzScrollBar.Visible = False
  VertScrollBar.Smooth = True
  VertScrollBar.Tracking = True
  AutoScroll = True
  Caption = 'BudgetGO'
  Color = clWhite
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  OnCanResize = actionResize
  OnCreate = actionInit
  OnMouseWheel = actionScroll
  PixelsPerInch = 120
  TextHeight = 17
  object imgIcoNo: TImage
    Left = 641
    Top = 411
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
    Visible = False
  end
  object imgIcoOk: TImage
    Left = 641
    Top = 441
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
    Visible = False
  end
  object imgIcoWarning: TImage
    Left = 641
    Top = 471
    Width = 24
    Height = 24
    Picture.Data = {
      0954506E67496D61676589504E470D0A1A0A0000000D49484452000000180000
      00180806000000E0773DF80000000473424954080808087C0864880000000970
      485973000001BB000001BB013AECE3E20000001974455874536F667477617265
      007777772E696E6B73636170652E6F72679BEE3C1A000001D14944415478DAE5
      953B4B0341108067F60CBE6F13444B51C4C2206261631E480A9B542241FC07FA
      07042B412C44B117FC03162168A38228624CB4B1107C1482A0580921DE5DF045
      CC8EA346D198C49844109C6A766676BED9D95916E19705FF0F201E7674698216
      9F754DE0709DEBFAB06C005A854A4BCA4320684F9B4E75CBEC423F3C94056044
      E438074E7F82128CDBBDE64CC980EB3D7B8B48D131AB3519AE5B85E874B88D8B
      9200D68E0C124220EB6684A0EE36878A069811DDCF212BF94B20BFF4586B3F06
      D03ED8AC7BFB016BCE379B22F4A12081049B1F529CE8554637F640F247002B22
      C70860F6A34D7A4C7C3D99A48C2463BAC79C2B18606CCB56D0E0989DD5850078
      71471A5F78AF715E18202A97B80D0399F65C803464C9EE3107BF05F0CCF7B371
      3DFB718517918422DACEE6E7B7D1CF6F63232780B6A0CAB2C92356DBA03839D3
      936627FAE03E2B80C772824D9345267F2B7382C776EA0B201E71346BA04E58AD
      CDB555A854135F3E2AD2AEF2106E1E535A47435FFCF213807B1FE2C520E41341
      0DA8115252C4F285719E108F6DE01D60EDD6BB48896869ADC980A072E9EEC41E
      A6AB1F6565BE9C009EA8119EA8851740225CD7A8B06219905C65AA3F8AC9D480
      EE4BC4FECE97F967014F9124A5197B904C160000000049454E44AE426082}
    Visible = False
  end
  object pnlHeader: TPanel
    Left = 0
    Top = 0
    Width = 736
    Height = 42
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object lblHeader: TLabel
      Left = 320
      Top = 4
      Width = 95
      Height = 28
      Alignment = taCenter
      Caption = 'BudgetGO'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Segoe UI Semibold'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object pnlMainToolsWrapper: TPanel
    Left = 0
    Top = 42
    Width = 736
    Height = 110
    Align = alTop
    BevelEdges = [beBottom]
    BevelKind = bkFlat
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 1
    object pnlMainTools: TPanel
      Left = 0
      Top = 17
      Width = 293
      Height = 77
      AutoSize = True
      BevelOuter = bvNone
      Padding.Left = 20
      TabOrder = 0
      object lblNewOperationBefore: TLabel
        Left = 20
        Top = 0
        Width = 104
        Height = 17
        Alignment = taCenter
        Caption = #1053#1086#1074#1072#1103' '#1086#1087#1077#1088#1072#1094#1080#1103
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblBalance: TLabel
        AlignWithMargins = True
        Left = 154
        Top = 33
        Width = 136
        Height = 41
        BiDiMode = bdLeftToRight
        Caption = '10.03 '#1088#1091#1073'.'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -30
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblBalanceBefore: TLabel
        Left = 154
        Top = 21
        Width = 94
        Height = 17
        Caption = #1085#1072' '#1074#1072#1096#1077#1084' '#1089#1095#1077#1090#1091
      end
      object btnCreateOutcome: TButton
        Left = 20
        Top = 47
        Width = 104
        Height = 25
        Caption = #1056#1072#1089#1093#1086#1076
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = actionOperationView
      end
      object btnCreateIncome: TButton
        Left = 20
        Top = 24
        Width = 104
        Height = 25
        Caption = #1044#1086#1093#1086#1076
        Default = True
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = actionOperationView
      end
    end
  end
  object pnlContent: TPanel
    Left = 2
    Top = 158
    Width = 732
    Height = 533
    Margins.Left = 20
    Margins.Right = 20
    AutoSize = True
    BevelOuter = bvNone
    Color = clGradientActiveCaption
    Constraints.MinWidth = 680
    Padding.Left = 20
    Padding.Right = 20
    TabOrder = 2
    object pnlCategories: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 132
      Width = 692
      Height = 161
      Margins.Left = 0
      Margins.Top = 20
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 1
      object imgCatsIncomeStatus: TImage
        Left = 3
        Top = 58
        Width = 24
        Height = 24
      end
      object imgCatsOutcomeStatus: TImage
        Left = 313
        Top = 58
        Width = 24
        Height = 24
      end
      object lblCategoriesBefore: TLabel
        Left = 3
        Top = 0
        Width = 82
        Height = 23
        Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1080
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCatsIncomeBefore: TLabel
        Left = 3
        Top = 32
        Width = 50
        Height = 17
        Caption = #1044#1086#1093#1086#1076#1099
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCatsIncomeStatus: TLabel
        Left = 33
        Top = 56
        Width = 249
        Height = 34
        Caption = 
          #1042#1099' '#1085#1077' '#1076#1086#1089#1090#1080#1075#1083#1080' '#1078#1077#1083#1072#1077#1084#1099#1093' '#1076#1086#1093#1086#1076#1086#1074#13#10#1087#1086' '#1085#1077#1082#1086#1090#1086#1088#1099#1084' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1074' '#1101#1090#1086#1084' ' +
          #1084#1077#1089#1103#1094#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblCatsOutcomeBefore: TLabel
        Left = 313
        Top = 32
        Width = 54
        Height = 17
        Caption = #1056#1072#1089#1093#1086#1076#1099
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblCatsOutcomeStatus: TLabel
        Left = 343
        Top = 56
        Width = 233
        Height = 34
        Caption = 
          #1042#1099' '#1085#1077' '#1087#1088#1077#1074#1099#1089#1080#1083#1080' '#1079#1072#1087#1083#1072#1085#1080#1088#1086#1074#1072#1085#1085#1099#1077#13#10#1088#1072#1089#1093#1086#1076#1099' '#1087#1086' '#1082#1072#1090#1077#1075#1086#1088#1080#1103#1084' '#1074' '#1101#1090#1086#1084' '#1084#1077 +
          'c'#1103#1094#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object btnEditCategories: TButton
        Left = 108
        Top = 1
        Width = 90
        Height = 25
        Caption = #1048#1079#1084#1077#1085#1080#1090#1100
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = actionCategoriesView
      end
      object grdCatsIncome: TStringGrid
        Left = 0
        Top = 100
        Width = 285
        Height = 53
        BorderStyle = bsNone
        ColCount = 2
        Enabled = False
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedHorzLine, goHorzLine, goRowSelect]
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 1
        ColWidths = (
          110
          173)
      end
      object grdCatsOutcome: TStringGrid
        Left = 310
        Top = 100
        Width = 285
        Height = 61
        BorderStyle = bsNone
        ColCount = 2
        Enabled = False
        FixedCols = 0
        RowCount = 2
        FixedRows = 0
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        Options = [goFixedHorzLine, goHorzLine, goRowSelect]
        ParentFont = False
        ScrollBars = ssNone
        TabOrder = 2
        ColWidths = (
          110
          173)
      end
    end
    object pnlOperations: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 313
      Width = 692
      Height = 220
      Margins.Left = 0
      Margins.Top = 20
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 2
      object lblOperationsBefore: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 0
        Width = 689
        Height = 23
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 10
        Align = alTop
        Caption = #1054#1087#1077#1088#1072#1094#1080#1080
        Color = clWhite
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -17
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        ExplicitWidth = 82
      end
      object lblNoOperations: TLabel
        AlignWithMargins = True
        Left = 0
        Top = 153
        Width = 689
        Height = 17
        Margins.Left = 0
        Margins.Top = 0
        Margins.Bottom = 50
        Align = alTop
        Caption = #1042#1099' '#1085#1077' '#1089#1086#1074#1077#1088#1096#1072#1083#1080' '#1086#1087#1077#1088#1072#1094#1080#1080' '#1074' '#1101#1090#1086#1084' '#1084#1077#1089#1103#1094#1077
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        ExplicitWidth = 258
      end
      object grdOperations: TStringGrid
        Left = 0
        Top = 33
        Width = 692
        Height = 120
        Cursor = crHandPoint
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alTop
        ColCount = 6
        Constraints.MaxWidth = 732
        FixedCols = 0
        RowCount = 2
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        GradientEndColor = clWhite
        Options = [goFixedHorzLine, goHorzLine, goDrawFocusSelected, goRowSelect]
        ParentFont = False
        PopupMenu = pmOperation
        ScrollBars = ssNone
        TabOrder = 0
        OnDblClick = actionOperationView
        OnMouseDown = actionOperationSelect
        ColWidths = (
          34
          57
          99
          92
          48
          361)
      end
    end
    object pnlStatistics: TPanel
      AlignWithMargins = True
      Left = 20
      Top = 20
      Width = 692
      Height = 92
      Margins.Left = 0
      Margins.Top = 20
      Margins.Right = 0
      Margins.Bottom = 0
      Align = alTop
      AutoSize = True
      BevelOuter = bvNone
      Color = clWhite
      TabOrder = 0
      object lblIncome: TLabel
        Left = 0
        Top = 59
        Width = 75
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = '2265.50 '#1088#1091#1073'.'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblIncomeBefore: TLabel
        Left = 0
        Top = 42
        Width = 104
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = #1044#1086#1093#1086#1076#1099' '#1079#1072' '#1084#1077#1089#1103#1094
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOutcome: TLabel
        Left = 147
        Top = 59
        Width = 73
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = '1250.64 '#1088#1091#1073'.'
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clBlack
        Font.Height = -13
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblOutcomeBefore: TLabel
        Left = 147
        Top = 42
        Width = 107
        Height = 17
        BiDiMode = bdLeftToRight
        Caption = #1056#1072#1089#1093#1086#1076#1099' '#1079#1072' '#1084#1077#1089#1103#1094
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblStatisticsBefore: TLabel
        Left = 0
        Top = 0
        Width = 103
        Height = 28
        BiDiMode = bdLeftToRight
        Caption = #1057#1090#1072#1090#1080#1089#1090#1080#1082#1072
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -20
        Font.Name = 'Segoe UI Semibold'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
      object shpOutcome: TShape
        Left = 0
        Top = 82
        Width = 280
        Height = 10
        Brush.Color = 3951847
        Pen.Color = 3951847
        Shape = stRoundRect
      end
      object shpIncome: TShape
        Left = 0
        Top = 82
        Width = 89
        Height = 10
        Brush.Color = 7457838
        Pen.Color = 7457838
        Shape = stRoundRect
      end
      object cbbMonth: TComboBox
        Left = 132
        Top = 6
        Width = 83
        Height = 25
        HelpType = htKeyword
        Style = csDropDownList
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
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
        Left = 223
        Top = 6
        Width = 57
        Height = 25
        HelpType = htKeyword
        Style = csDropDownList
        Font.Charset = RUSSIAN_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnChange = actionUpdateStatistics
      end
    end
  end
  object pmOperation: TPopupMenu
    Left = 683
    Top = 9
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

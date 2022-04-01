module Ui.Typography exposing
    ( h900, h800, h700, h600, h500, h400, h300, h200, h100
    , p300, p200, p100
    , code, codeMinimal
    )

{-|

@docs h900, h800, h700, h600, h500, h400, h300, h200, h100
@docs p300, p200, p100

@docs code, codeMinimal

-}

import Ui
import Ui.Attr
import Ui.Palette


h900 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h900 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 32
        , lineHeight = 40
        , weight = Semibold
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h800 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h800 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 24
        , lineHeight = 32
        , weight = Semibold
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h700 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h700 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 20
        , lineHeight = 24
        , weight = Semibold
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h600 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h600 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 18
        , lineHeight = 24
        , weight = Semibold
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h500 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h500 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 16
        , lineHeight = 24
        , weight = Semibold
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h400 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h400 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 14
        , lineHeight = 24
        , weight = Medium
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h300 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h300 attributes text =
    viewTypography
        { color = Ui.Palette.n900
        , fontSize = 12
        , lineHeight = 16
        , weight = Medium
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


h200 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h200 attributes str =
    viewTypography
        { color = Ui.Palette.n800
        , fontSize = 12
        , lineHeight = 16
        , weight = Semibold
        , family = SansSerif
        , attributes = attributes
        , text = String.toUpper str
        }


h100 : List (Ui.Attribute msg) -> String -> Ui.Html msg
h100 attributes str =
    viewTypography
        { color = Ui.Palette.n800
        , fontSize = 10
        , lineHeight = 16
        , weight = Medium
        , family = SansSerif
        , attributes = attributes
        , text = String.toUpper str
        }



-- PARAGRAPH


p300 : List (Ui.Attribute msg) -> String -> Ui.Html msg
p300 attributes text =
    viewTypography
        { color = Ui.Palette.n800
        , fontSize = 16
        , lineHeight = 24
        , weight = Regular
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


p200 : List (Ui.Attribute msg) -> String -> Ui.Html msg
p200 attributes text =
    viewTypography
        { color = Ui.Palette.n800
        , fontSize = 14
        , lineHeight = 20
        , weight = Regular
        , family = SansSerif
        , attributes = attributes
        , text = text
        }


p100 : List (Ui.Attribute msg) -> String -> Ui.Html msg
p100 attributes text =
    viewTypography
        { color = Ui.Palette.n800
        , fontSize = 12
        , lineHeight = 16
        , weight = Regular
        , family = SansSerif
        , attributes = attributes
        , text = text
        }



-- CODE


codeMinimal : List (Ui.Attribute msg) -> String -> Ui.Html msg
codeMinimal attributes str =
    viewTypography
        { color = Ui.Palette.n800
        , fontSize = 14
        , lineHeight = 16
        , weight = Regular
        , family = Monospace
        , attributes =
            [ Ui.Attr.backgroundColor Ui.Palette.n50
            , Ui.Attr.border.px1 Ui.Palette.n400
            , Ui.Attr.radius.px4
            , Ui.Attr.padXY.px8.px4
            ]
                ++ attributes
        , text = str
        }


code : List (Ui.Attribute msg) -> String -> Ui.Html msg
code attributes str =
    viewTypography
        { color = Ui.Palette.b600
        , fontSize = 14
        , lineHeight = 16
        , weight = Regular
        , family = Monospace
        , attributes =
            [ Ui.Attr.backgroundColor Ui.Palette.b50
            , Ui.Attr.border.px1 Ui.Palette.b200
            , Ui.Attr.radius.px4
            , Ui.Attr.padXY.px8.px4
            ]
                ++ attributes
        , text = str
        }



-- INTERNALS


viewTypography :
    { color : Ui.Palette.Color
    , fontSize : Float
    , lineHeight : Float
    , weight : Weight
    , family : Family
    , attributes : List (Ui.Attribute msg)
    , text : String
    }
    -> Ui.Html msg
viewTypography options =
    Ui.el
        ([ Ui.Attr.fontColor options.color
         , toUiTypographyAttr options
         ]
            ++ options.attributes
        )
        (Ui.text options.text)


toUiTypographyAttr :
    { options
        | fontSize : Float
        , lineHeight : Float
        , weight : Weight
        , family : Family
    }
    -> Ui.Attribute msg
toUiTypographyAttr options =
    Ui.Attr.typography
        { fontSize = options.fontSize
        , lineHeight = options.lineHeight
        , weight = fromFontWeightToInt options.weight
        , families = toFontFamilies options.family
        }


type Weight
    = Regular
    | Medium
    | Semibold


fromFontWeightToInt : Weight -> Int
fromFontWeightToInt weight =
    case weight of
        Regular ->
            400

        Medium ->
            500

        Semibold ->
            600


type Family
    = SansSerif
    | Monospace


toFontFamilies : Family -> List String
toFontFamilies family =
    case family of
        SansSerif ->
            [ "Fira Sans", "sans-serif" ]

        Monospace ->
            [ "Fira Mono", "monospace" ]

module Ui.Attr exposing
    ( Attribute, none
    , fontColor, backgroundColor
    , border, radius
    , width, height
    , gap, align
    , pad, padXY
    , padTop, padLeft, padRight, padBottom
    , elevation
    , textAlign
    )

{-|

@docs Attribute, none
@docs fontColor, backgroundColor
@docs border, radius
@docs width, height
@docs gap, align

@docs pad, padXY
@docs padTop, padLeft, padRight, padBottom

@docs elevation

-}

import Css
import Html.Styled
import Html.Styled.Attributes
import Ui.Palette


type alias Attribute msg =
    Html.Styled.Attribute msg


none : Attribute msg
none =
    Html.Styled.Attributes.css []


fontColor : Ui.Palette.Color -> Attribute msg
fontColor color =
    Html.Styled.Attributes.css [ Css.color color ]


backgroundColor : Ui.Palette.Color -> Attribute msg
backgroundColor color =
    Html.Styled.Attributes.css [ Css.backgroundColor color ]


width :
    { px80 : Attribute msg
    }
width =
    { px80 = fromPixels Css.width 80
    }


height :
    { px80 : Attribute msg
    }
height =
    { px80 = fromPixels Css.height 80
    }


border :
    { px1 : Ui.Palette.Color -> Attribute msg
    }
border =
    { px1 = toBorder 1
    }


radius :
    { px4 : Attribute msg
    }
radius =
    { px4 = fromPixels Css.borderRadius 4
    }


gap :
    { px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    , px32 : Attribute msg
    }
gap =
    { px4 = toGap 4
    , px8 = toGap 8
    , px16 = toGap 16
    , px32 = toGap 32
    }


align :
    { center : Attribute msg
    , centerX : Attribute msg
    , centerY : Attribute msg
    , top : Attribute msg
    , left : Attribute msg
    , bottom : Attribute msg
    , right : Attribute msg
    }
align =
    { center =
        Html.Styled.Attributes.css
            [ Css.alignItems Css.center
            , Css.justifyContent Css.center
            ]
    , centerX = Html.Styled.Attributes.class "elm-align-center-x"
    , centerY = Html.Styled.Attributes.class "elm-align-center-y"
    , top = Html.Styled.Attributes.class "elm-align-top"
    , left = Html.Styled.Attributes.class "elm-align-left"
    , bottom = Html.Styled.Attributes.class "elm-align-bottom"
    , right = Html.Styled.Attributes.class "elm-align-right"
    }


textAlign : { center : Attribute msg }
textAlign =
    { center = Html.Styled.Attributes.css [ Css.textAlign Css.center ]
    }



-- PADDING


pad :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    }
pad =
    toPadding "padding"


padLeft :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    }
padLeft =
    toPadding "padding-left"


padRight :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    }
padRight =
    toPadding "padding-right"


padTop :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    }
padTop =
    toPadding "padding-top"


padBottom :
    { zero : Attribute msg
    , px4 : Attribute msg
    , px8 : Attribute msg
    , px16 : Attribute msg
    }
padBottom =
    toPadding "padding-bottom"


padXY :
    { zero :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        }
    , px4 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        }
    , px8 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        }
    , px16 :
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        }
    }
padXY =
    { zero = toPadXY "0"
    , px4 = toPadXY "4px"
    , px8 = toPadXY "8px"
    , px16 = toPadXY "16px"
    }



-- ELEVATION


elevation :
    { level1 : Attribute msg
    , level2 : Attribute msg
    , level3 : Attribute msg
    }
elevation =
    { level1 =
        toElevation
            { x = 0
            , y = 4
            , blur = 8
            , spread = 0
            , rgb = ( 16, 24, 64 )
            , alpha = 0.08
            }
    , level2 =
        toElevation
            { x = 0
            , y = 4
            , blur = 8
            , spread = 0
            , rgb = ( 16, 24, 64 )
            , alpha = 0.16
            }
    , level3 =
        toElevation
            { x = 0
            , y = 12
            , blur = 40
            , spread = 0
            , rgb = ( 16, 24, 64 )
            , alpha = 0.24
            }
    }



-- INTERNALS


toElevation :
    { rgb : ( Int, Int, Int )
    , x : Float
    , y : Float
    , blur : Float
    , spread : Float
    , alpha : Float
    }
    -> Html.Styled.Attribute msg
toElevation options =
    let
        ( r, g, b ) =
            options.rgb
    in
    Html.Styled.Attributes.css
        [ Css.boxShadow5
            (Css.px options.x)
            (Css.px options.y)
            (Css.px options.blur)
            (Css.px options.spread)
            (Css.rgba r g b options.alpha)
        ]


toGap : Int -> Attribute msg
toGap px =
    Html.Styled.Attributes.css [ Css.property "gap" (String.fromInt px ++ "px") ]


fromPixels : (Css.Px -> Css.Style) -> Float -> Attribute msg
fromPixels toStyle px =
    Html.Styled.Attributes.css [ toStyle (Css.px px) ]


toBorder : Float -> Ui.Palette.Color -> Attribute msg
toBorder px color =
    Html.Styled.Attributes.css
        [ Css.borderStyle Css.solid
        , Css.borderColor color
        , Css.borderWidth (Css.px px)
        ]


toPadding :
    String
    ->
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        }
toPadding propertyName =
    { zero = Html.Styled.Attributes.css [ Css.property propertyName "0" ]
    , px4 = Html.Styled.Attributes.css [ Css.property propertyName "4px" ]
    , px8 = Html.Styled.Attributes.css [ Css.property propertyName "8px" ]
    , px16 = Html.Styled.Attributes.css [ Css.property propertyName "16px" ]
    }


toPadXY :
    String
    ->
        { zero : Attribute msg
        , px4 : Attribute msg
        , px8 : Attribute msg
        , px16 : Attribute msg
        }
toPadXY xValue =
    { zero = Html.Styled.Attributes.css [ Css.property "padding" ("0 " ++ xValue) ]
    , px4 = Html.Styled.Attributes.css [ Css.property "padding" ("4px " ++ xValue) ]
    , px8 = Html.Styled.Attributes.css [ Css.property "padding" ("8px " ++ xValue) ]
    , px16 = Html.Styled.Attributes.css [ Css.property "padding" ("16px " ++ xValue) ]
    }

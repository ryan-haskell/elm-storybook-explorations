module Ui.Attr exposing
    ( Attribute, none
    , fontColor, backgroundColor
    , border, radius
    , width, height
    , gap
    )

{-|

@docs Attribute, none
@docs fontColor, backgroundColor
@docs border, radius
@docs width, height
@docs gap

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
    }
gap =
    { px4 = toGap 4
    , px8 = toGap 8
    , px16 = toGap 16
    }



-- INTERNALS


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

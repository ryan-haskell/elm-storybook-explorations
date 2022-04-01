module Ui.Transition exposing
    ( Property
    , background, borderColor, fontColor
    , elevation
    , toCssPropertyName
    )

{-|

@docs Property
@docs background, borderColor, fontColor
@docs elevation

@docs toCssPropertyName

-}


type Property
    = Property String


toCssPropertyName : Property -> String
toCssPropertyName (Property name) =
    name



-- PROPERTIES


elevation : Property
elevation =
    Property "box-shadow"


background : Property
background =
    Property "background"


borderColor : Property
borderColor =
    Property "border-color"


fontColor : Property
fontColor =
    Property "color"

module Ui.Icon exposing
    ( Icon, toClassName
    , more, search
    )

{-| More icons available here:
<https://blueprintjs.com/docs/#icons>

@docs Icon, toClassName

-}


type Icon
    = Icon String


toClassName : Icon -> String
toClassName (Icon name) =
    "bp4-icon bp4-icon-" ++ name



-- ICONS


more : Icon
more =
    Icon "more"


search : Icon
search =
    Icon "search"

module Ui.Icon exposing
    ( Icon, toClassName
    , arrowLeft, arrowRight, caretDown, infoSign, more, search, sort, trash
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


arrowLeft : Icon
arrowLeft =
    Icon "arrow-left"


arrowRight : Icon
arrowRight =
    Icon "arrow-right"


caretDown : Icon
caretDown =
    Icon "caret-down"


trash : Icon
trash =
    Icon "trash"


infoSign : Icon
infoSign =
    Icon "info-sign"


sort : Icon
sort =
    Icon "sort"

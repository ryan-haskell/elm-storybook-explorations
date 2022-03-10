module Ui.Typography exposing (h1)

import Html exposing (Html)
import Html.Attributes as Attr


h1 : String -> Html msg
h1 str =
    Html.h1 [ Attr.style "color" "red" ] [ Html.text str ]

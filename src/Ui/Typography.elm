module Ui.Typography exposing
    ( h1, h2, h3
    , p
    , markdown
    )

{-|

@docs h1, h2, h3
@docs p

@docs markdown

-}

import Html exposing (Html)
import Html.Attributes as Attr
import Markdown


h1 : String -> Html msg
h1 str =
    Html.h1 [ Attr.class "h1" ] [ Html.text str ]


h2 : String -> Html msg
h2 str =
    Html.h2 [ Attr.class "h2" ] [ Html.text str ]


h3 : String -> Html msg
h3 str =
    Html.h3 [ Attr.class "h3" ] [ Html.text str ]


p : String -> Html msg
p str =
    Html.p [ Attr.class "p" ] [ Html.text str ]


markdown : String -> Html msg
markdown str =
    Markdown.toHtml [ Attr.class "markdown" ] str

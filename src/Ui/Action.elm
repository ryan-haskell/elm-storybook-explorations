module Ui.Action exposing
    ( Action
    , fromMsg, fromUrl
    , toHtmlNode
    )

{-|

@docs Action
@docs fromMsg, fromUrl

@docs toHtmlNode

-}

import Html.Styled
import Html.Styled.Attributes
import Html.Styled.Events


type Action msg
    = FromMsg msg
    | FromUrl String


fromMsg : msg -> Action msg
fromMsg =
    FromMsg


fromUrl : String -> Action msg
fromUrl =
    FromUrl


toHtmlNode :
    Action msg
    -> List (Html.Styled.Attribute msg)
    -> List (Html.Styled.Html msg)
    -> Html.Styled.Html msg
toHtmlNode action attrs children =
    case action of
        FromMsg msg ->
            Html.Styled.button (Html.Styled.Events.onClick msg :: attrs) children

        FromUrl url ->
            Html.Styled.a (Html.Styled.Attributes.href url :: attrs) children

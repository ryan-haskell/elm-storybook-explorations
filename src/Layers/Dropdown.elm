module Layers.Dropdown exposing (viewLeft, viewRight)

import Browser.Dom
import Html.Styled as Html exposing (Html)
import Html.Styled.Attributes as Attr


viewLeft : Browser.Dom.Element -> Html msg -> Html msg
viewLeft parent content =
    view parent
        (Html.div
            [ Attr.class "elm-layers__dropdown elm-layers__dropdown--left"
            ]
            [ content ]
        )


viewRight : Browser.Dom.Element -> Html msg -> Html msg
viewRight parent content =
    view parent
        (Html.div
            [ Attr.class "elm-layers__dropdown elm-layers__dropdown--right"
            ]
            [ content ]
        )



-- INTERNALS


view : Browser.Dom.Element -> Html msg -> Html msg
view parent dropdown =
    Html.div
        [ Attr.class "elm-layers__parent"
        , Attr.style "left" (String.fromFloat parent.element.x ++ "px")
        , Attr.style "top" (String.fromFloat parent.element.y ++ "px")
        , Attr.style "width" (String.fromFloat parent.element.width ++ "px")
        , Attr.style "height" (String.fromFloat parent.element.height ++ "px")
        ]
        [ dropdown ]

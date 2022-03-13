module Ui.Button exposing
    ( viewDanger
    , viewPrimary
    , viewSecondary
    )

import Html exposing (Html)
import Html.Attributes
import Html.Events


viewPrimary : { label : String, onClick : msg } -> Html msg
viewPrimary options =
    viewWithClass "button--primary" options


viewSecondary : { label : String, onClick : msg } -> Html msg
viewSecondary options =
    viewWithClass "button--secondary" options


viewDanger : { label : String, onClick : msg } -> Html msg
viewDanger options =
    viewWithClass "button--danger" options



-- INTERNALS


viewWithClass : String -> { label : String, onClick : msg } -> Html msg
viewWithClass modifierClass options =
    Html.button
        [ Html.Attributes.class ("button " ++ modifierClass)
        , Html.Events.onClick options.onClick
        ]
        [ Html.text options.label ]

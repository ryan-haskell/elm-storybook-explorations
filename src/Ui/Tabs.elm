module Ui.Tabs exposing (view)

import Html exposing (Html)
import Html.Attributes as Attr
import Html.Events


view :
    { selected : tab
    , tabs : List tab
    , toTabLabel : tab -> String
    , viewTabContent : tab -> Html msg
    , onTabClicked : tab -> msg
    }
    -> Html msg
view options =
    let
        viewTabHeader : Html msg
        viewTabHeader =
            Html.div [ Attr.class "tabs__header" ]
                (List.map viewTabButton options.tabs)

        viewTabButton : tab -> Html msg
        viewTabButton tab =
            Html.button
                [ Attr.classList
                    [ ( "tabs__button", True )
                    , ( "tabs__button--selected", tab == options.selected )
                    ]
                , Html.Events.onClick (options.onTabClicked tab)
                ]
                [ Html.text (options.toTabLabel tab)
                ]

        viewTabContentWithWrapper : Html msg
        viewTabContentWithWrapper =
            Html.div [ Attr.class "tabs__content" ]
                [ options.viewTabContent options.selected
                ]
    in
    Html.div [ Attr.class "tabs" ]
        [ viewTabHeader
        , viewTabContentWithWrapper
        ]

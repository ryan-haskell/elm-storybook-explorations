module Stories.Button exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Button
import Ui.Icon
import Ui.Palette exposing (..)


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


view : () -> Ui.Html msg
view _ =
    Ui.col [ Ui.Attr.gap.px40 ]
        [ Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view [] "Confirm"
            , Ui.Button.view [ Ui.Button.secondary ] "Cancel"
            , Ui.Button.view [ Ui.Button.error ] "Delete"
            ]
        , Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view
                [ Ui.Button.iconLeft Ui.Icon.search ]
                "Search"
            , Ui.Button.view
                [ Ui.Button.secondary
                , Ui.Button.iconLeft Ui.Icon.arrowLeft
                ]
                "Back"
            , Ui.Button.view
                [ Ui.Button.error
                , Ui.Button.iconLeft Ui.Icon.trash
                ]
                "Delete"
            ]
        , Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view
                [ Ui.Button.iconRight Ui.Icon.arrowRight ]
                "Continue"
            , Ui.Button.view
                [ Ui.Button.secondary
                , Ui.Button.iconRight Ui.Icon.caretDown
                ]
                "Pick a color"
            , Ui.Button.view
                [ Ui.Button.error
                , Ui.Button.iconRight Ui.Icon.caretDown
                ]
                "Delete"
            ]
        ]

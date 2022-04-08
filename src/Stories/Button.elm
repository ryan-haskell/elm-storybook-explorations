module Stories.Button exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Button
import Ui.Icon
import Ui.Palette exposing (..)


main : Component () Msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


type Msg
    = UserClickedButton


view : () -> Ui.Html Msg
view _ =
    Ui.col [ Ui.Attr.gap.px16 ]
        [ Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view []
                { label = "Confirm"
                , onClick = UserClickedButton
                }
            , Ui.Button.view [ Ui.Button.secondary ]
                { label = "Cancel"
                , onClick = UserClickedButton
                }
            , Ui.Button.view [ Ui.Button.minimal ]
                { label = "Close"
                , onClick = UserClickedButton
                }
            , Ui.Button.view [ Ui.Button.error ]
                { label = "Delete"
                , onClick = UserClickedButton
                }
            ]
        , Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view
                [ Ui.Button.iconLeft Ui.Icon.search ]
                { label = "Search"
                , onClick = UserClickedButton
                }
            , Ui.Button.view
                [ Ui.Button.secondary
                , Ui.Button.iconLeft Ui.Icon.arrowLeft
                ]
                { label = "Back"
                , onClick = UserClickedButton
                }
            , Ui.Button.view
                [ Ui.Button.minimal
                , Ui.Button.iconLeft Ui.Icon.sort
                ]
                { label = "Sort"
                , onClick = UserClickedButton
                }
            , Ui.Button.view
                [ Ui.Button.error
                , Ui.Button.iconLeft Ui.Icon.trash
                ]
                { label = "Delete"
                , onClick = UserClickedButton
                }
            ]
        , Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view
                [ Ui.Button.iconRight Ui.Icon.arrowRight ]
                { label = "Continue"
                , onClick = UserClickedButton
                }
            , Ui.Button.view
                [ Ui.Button.secondary
                , Ui.Button.iconRight Ui.Icon.caretDown
                ]
                { label = "Pick a color"
                , onClick = UserClickedButton
                }
            , Ui.Button.view
                [ Ui.Button.minimal
                , Ui.Button.iconRight Ui.Icon.infoSign
                ]
                { label = "Learn more"
                , onClick = UserClickedButton
                }
            , Ui.Button.view
                [ Ui.Button.error
                , Ui.Button.iconRight Ui.Icon.caretDown
                ]
                { label = "Delete"
                , onClick = UserClickedButton
                }
            ]
        , Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.viewIconOnly []
                { icon = Ui.Icon.arrowRight
                , onClick = UserClickedButton
                }
            , Ui.Button.viewIconOnly [ Ui.Button.secondary ]
                { icon = Ui.Icon.more
                , onClick = UserClickedButton
                }
            , Ui.Button.viewIconOnly [ Ui.Button.minimal ]
                { icon = Ui.Icon.infoSign
                , onClick = UserClickedButton
                }
            , Ui.Button.viewIconOnly [ Ui.Button.error ]
                { icon = Ui.Icon.trash
                , onClick = UserClickedButton
                }
            ]
        ]

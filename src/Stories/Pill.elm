module Stories.Pill exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Pill


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


view : () -> Ui.Html msg
view _ =
    Ui.row
        [ Ui.Attr.align.left
        , Ui.Attr.gap.px16
        ]
        [ Ui.Pill.neutral "69"
        , Ui.Pill.blue "69"
        , Ui.Pill.green "69"
        , Ui.Pill.yellow "69"
        , Ui.Pill.red "69"
        , Ui.Pill.violet "69"
        , Ui.Pill.teal "69"
        , Ui.Pill.pink "69"
        , Ui.Pill.orange "69"
        ]

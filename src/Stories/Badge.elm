module Stories.Badge exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Badge


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
        [ Ui.Badge.view (Ui.Badge.neutral "Data")
        , Ui.Badge.view (Ui.Badge.blue "Data")
        , Ui.Badge.view (Ui.Badge.green "Data")
        , Ui.Badge.view (Ui.Badge.yellow "Data")
        , Ui.Badge.view (Ui.Badge.red "Data")
        , Ui.Badge.view (Ui.Badge.violet "Data")
        , Ui.Badge.view (Ui.Badge.teal "Data")
        , Ui.Badge.view (Ui.Badge.pink "Data")
        , Ui.Badge.view (Ui.Badge.orange "Data")
        ]

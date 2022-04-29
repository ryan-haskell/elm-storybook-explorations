module Stories.Avatar exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Avatar


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
        [ Ui.Avatar.viewCircle (Ui.Avatar.neutral "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.blue "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.green "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.yellow "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.red "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.violet "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.teal "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.pink "RH")
        , Ui.Avatar.viewCircle (Ui.Avatar.orange "RH")
        ]

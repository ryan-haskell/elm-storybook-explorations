module Stories.Status exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Status


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
        [ Ui.Status.view (Ui.Status.neutral "Disabled")
        , Ui.Status.view (Ui.Status.green "Enabled")
        , Ui.Status.view (Ui.Status.blue "Info")
        , Ui.Status.view (Ui.Status.yellow "Warning")
        , Ui.Status.view (Ui.Status.red "No Data")
        , Ui.Status.view (Ui.Status.cross "Label")
        , Ui.Status.view (Ui.Status.tick "Label")
        ]

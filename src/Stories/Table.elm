module Stories.Table exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Table


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


view : () -> Ui.Html msg
view _ =
    Ui.Table.view

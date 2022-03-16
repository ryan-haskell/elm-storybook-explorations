module Stories.Button.Secondary exposing (main)

import Html exposing (Html)
import Json.Encode
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui.Button
import Ui.Typography


main : Component () Msg
main =
    Storybook.Component.stateless
        { controls =
            Storybook.Controls.new Controls
                |> Storybook.Controls.withString
                    { name = "label"
                    , fallback = "Cancel"
                    }
        , view = view
        }


type alias Controls =
    { label : String
    }


type Msg
    = UserClickedButton


view : Controls -> Html Msg
view controls =
    Ui.Button.viewSecondary
        { label = controls.label
        , onClick = UserClickedButton
        }

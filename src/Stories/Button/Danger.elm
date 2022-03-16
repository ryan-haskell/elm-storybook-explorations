module Stories.Button.Danger exposing (main)

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
                    , fallback = "Delete post"
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
    Ui.Button.viewDanger
        { label = controls.label
        , onClick = UserClickedButton
        }

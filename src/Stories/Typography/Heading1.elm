module Stories.Typography.Heading1 exposing (main)

import Html exposing (Html)
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui.Typography


main : Component () msg
main =
    Storybook.Component.stateless
        { controls =
            Storybook.Controls.new Controls
                |> Storybook.Controls.withString
                    { name = "label"
                    , fallback = "Heading 1"
                    }
        , view = view
        }


type alias Controls =
    { label : String
    }


view : Controls -> Html msg
view controls =
    Ui.Typography.h1 controls.label

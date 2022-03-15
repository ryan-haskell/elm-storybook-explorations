module Stories.Typography.Heading3 exposing (main)

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
                    , fallback = "Heading 3"
                    }
        , view = view
        }


type alias Controls =
    { label : String
    }


view : Controls -> Html msg
view controls =
    Ui.Typography.h3 controls.label

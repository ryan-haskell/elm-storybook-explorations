module Stories.Typography.Paragraph exposing (main)

import Html exposing (Html)
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui.Typography


exampleText : String
exampleText =
    "This is a paragraph of text. As we add more content, you can see that it eventually hits a maximum width and begins to wrap. Defining a maximum width helps with readability! If the text is too wide, it's hard to find the next line. If it's too short, then the user is constantly interrupted by jumping from one line to another!"


main : Component () msg
main =
    Storybook.Component.stateless
        { controls =
            Storybook.Controls.new Controls
                |> Storybook.Controls.withString
                    { name = "label"
                    , fallback = exampleText
                    }
        , view = view
        }


type alias Controls =
    { label : String
    }


view : Controls -> Html msg
view controls =
    Ui.Typography.p controls.label

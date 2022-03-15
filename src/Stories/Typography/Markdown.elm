module Stories.Typography.Markdown exposing (main)

import Html exposing (Html)
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui.Typography


exampleMarkdown : String
exampleMarkdown =
    String.trim """

# Hey, there!

## This was written in markdown!

This is some markdown content rendered in our design system. Markdown allows users to easily
embed __bold text__, _italic text_, or even [links](#link clicked) without writing HTML by hand.

### Neat, right?

Because we are using the same styles as other stories like "Header 1" or "Paragraph", this is 
an easy way to showcase all those in one place. That makes QA testing _much_ easier!

    """


main : Component () msg
main =
    Storybook.Component.stateless
        { controls =
            Storybook.Controls.new Controls
                |> Storybook.Controls.withString
                    { name = "label"
                    , fallback = exampleMarkdown
                    }
        , view = view
        }


type alias Controls =
    { label : String
    }


view : Controls -> Html msg
view controls =
    Ui.Typography.markdown controls.label

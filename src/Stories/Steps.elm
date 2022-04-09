module Stories.Steps exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Steps


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }


type Step
    = Step1
    | Step2
    | Step3


fromStepToLabel : Step -> String
fromStepToLabel step =
    case step of
        Step1 ->
            "Buy some apples"

        Step2 ->
            "Eat some apples"

        Step3 ->
            "Buy some oranges"



-- VIEW


view : () -> Ui.Html msg
view _ =
    Ui.col
        [ Ui.Attr.align.left
        , Ui.Attr.gap.px40
        ]
        [ Ui.Steps.view
            { steps = [ Step1, Step2, Step3 ]
            , toLabel = fromStepToLabel
            , current = Step1
            }
        , Ui.Steps.view
            { steps = [ Step1, Step2, Step3 ]
            , toLabel = fromStepToLabel
            , current = Step2
            }
        , Ui.Steps.view
            { steps = [ Step1, Step2, Step3 ]
            , toLabel = fromStepToLabel
            , current = Step3
            }
        ]

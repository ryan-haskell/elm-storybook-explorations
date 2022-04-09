module Stories.Steps exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Button
import Ui.Icon
import Ui.Steps


main : Component Model Msg
main =
    Storybook.Component.sandbox
        { controls = Storybook.Controls.none
        , init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    { currentStep : Step
    }


init : Model
init =
    { currentStep = Step1
    }



-- UPDATE


type Msg
    = UserClickedNext
    | UserClickedPrevious


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserClickedNext ->
            { model | currentStep = nextStep model.currentStep }

        UserClickedPrevious ->
            { model | currentStep = previousStep model.currentStep }



-- VIEW


view : () -> Model -> Ui.Html Msg
view _ model =
    Ui.col
        [ Ui.Attr.align.center
        , Ui.Attr.gap.px40
        ]
        [ Ui.Steps.view
            { steps = [ Step1, Step2, Step3 ]
            , toLabel = fromStepToLabel
            , current = model.currentStep
            }
        , Ui.row [ Ui.Attr.gap.px16 ]
            [ Ui.Button.view
                [ Ui.Button.iconLeft Ui.Icon.arrowLeft
                , Ui.Button.disabled (model.currentStep == Step1)
                ]
                { label = "Previous"
                , onClick = UserClickedPrevious
                }
            , Ui.Button.view
                [ Ui.Button.iconRight Ui.Icon.arrowRight
                , Ui.Button.disabled (model.currentStep == Step3)
                ]
                { label = "Next"
                , onClick = UserClickedNext
                }
            ]
        ]



-- STEPS


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


nextStep : Step -> Step
nextStep step =
    case step of
        Step1 ->
            Step2

        Step2 ->
            Step3

        Step3 ->
            Step3


previousStep : Step -> Step
previousStep step =
    case step of
        Step1 ->
            Step1

        Step2 ->
            Step1

        Step3 ->
            Step2

module Stories.Checkbox exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Checkbox


main : Component Model Msg
main =
    Storybook.Component.sandbox
        { controls =
            Storybook.Controls.new Controls
                |> Storybook.Controls.withBool
                    { name = "isDisabled"
                    , fallback = False
                    }
        , init = init
        , update = update
        , view = view
        }


type alias Controls =
    { isDisabled : Bool
    }



-- INIT


type alias Model =
    { checkbox1 : Ui.Checkbox.State
    , checkbox2 : Ui.Checkbox.State
    , checkbox3 : Ui.Checkbox.State
    }


init : Model
init =
    { checkbox1 = Ui.Checkbox.Unselected
    , checkbox2 = Ui.Checkbox.Indeterminate
    , checkbox3 = Ui.Checkbox.Selected
    }



-- UPDATE


type Msg
    = UserCheckedBox1 Ui.Checkbox.State
    | UserCheckedBox2 Ui.Checkbox.State
    | UserCheckedBox3 Ui.Checkbox.State


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserCheckedBox1 newState ->
            { model | checkbox1 = newState }

        UserCheckedBox2 newState ->
            { model | checkbox2 = newState }

        UserCheckedBox3 newState ->
            { model | checkbox3 = newState }



-- VIEW


view : Controls -> Model -> Ui.Html Msg
view controls model =
    Ui.row
        [ Ui.Attr.align.left
        , Ui.Attr.gap.px40
        ]
        [ Ui.Checkbox.view
            { state = model.checkbox1
            , label = "Label"
            , onClick = UserCheckedBox1
            , isDisabled = controls.isDisabled
            }
        , Ui.Checkbox.view
            { state = model.checkbox2
            , label = "Label"
            , onClick = UserCheckedBox2
            , isDisabled = controls.isDisabled
            }
        , Ui.Checkbox.view
            { state = model.checkbox3
            , label = "Label"
            , onClick = UserCheckedBox3
            , isDisabled = controls.isDisabled
            }
        ]

module Stories.Button exposing (main)

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
                    , fallback = "Create post"
                    }
                |> Storybook.Controls.withEnum
                    { name = "kind"
                    , fallback = Primary
                    , options =
                        [ ( "primary", Primary )
                        , ( "secondary", Secondary )
                        , ( "danger", Danger )
                        ]
                    }
        , view = view
        }


type alias Controls =
    { label : String
    , kind : Kind
    }


type Kind
    = Primary
    | Secondary
    | Danger


type Msg
    = UserClickedButton


view : Controls -> Html Msg
view controls =
    case controls.kind of
        Primary ->
            Ui.Button.viewPrimary
                { label = controls.label
                , onClick = UserClickedButton
                }

        Secondary ->
            Ui.Button.viewSecondary
                { label = controls.label
                , onClick = UserClickedButton
                }

        Danger ->
            Ui.Button.viewDanger
                { label = controls.label
                , onClick = UserClickedButton
                }

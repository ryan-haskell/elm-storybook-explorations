module Stories.Button exposing (main)

import Html exposing (Html)
import Json.Encode
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui.Button
import Ui.Typography


main : Component () msg
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


view : Controls -> Html (Storybook.Component.Msg msg)
view controls =
    let
        onClick : Storybook.Component.Msg msg
        onClick =
            Storybook.Component.log
                { name = "onClick"
                }
    in
    case controls.kind of
        Primary ->
            Ui.Button.viewPrimary
                { label = controls.label
                , onClick = onClick
                }

        Secondary ->
            Ui.Button.viewSecondary
                { label = controls.label
                , onClick = onClick
                }

        Danger ->
            Ui.Button.viewDanger
                { label = controls.label
                , onClick = onClick
                }

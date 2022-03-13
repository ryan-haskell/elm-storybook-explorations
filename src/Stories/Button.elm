module Stories.Button exposing (main)

import Html exposing (Html)
import Json.Encode
import Storybook.Argument
import Storybook.Component exposing (Component)
import Ui.Button
import Ui.Typography


main : Component
main =
    Storybook.Component.new
        { view = view
        , decoder =
            Storybook.Argument.new Arguments
                |> Storybook.Argument.withString
                    { name = "label"
                    , fallback = "Create post"
                    }
                |> Storybook.Argument.withEnum
                    { name = "kind"
                    , fallback = Primary
                    , options =
                        [ ( "primary", Primary )
                        , ( "secondary", Secondary )
                        , ( "danger", Danger )
                        ]
                    }
        }


type alias Arguments =
    { label : String
    , kind : Kind
    }


type Kind
    = Primary
    | Secondary
    | Danger


view : Arguments -> Html Storybook.Component.Msg
view args =
    let
        onClick =
            Storybook.Component.log
                { actionName = "onClick"
                }
    in
    case args.kind of
        Primary ->
            Ui.Button.viewPrimary
                { label = args.label
                , onClick = onClick
                }

        Secondary ->
            Ui.Button.viewSecondary
                { label = args.label
                , onClick = onClick
                }

        Danger ->
            Ui.Button.viewDanger
                { label = args.label
                , onClick = onClick
                }

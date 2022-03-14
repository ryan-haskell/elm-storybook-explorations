module Stories.Typography exposing (main)

import Html exposing (Html)
import Storybook.Argument
import Storybook.Component exposing (Component)
import Ui.Typography


main : Component
main =
    Storybook.Component.new
        { view = view
        , decoder =
            Storybook.Argument.new Arguments
                |> Storybook.Argument.withString
                    { name = "label"
                    , fallback = "Header text"
                    }
                |> Storybook.Argument.withEnum
                    { name = "kind"
                    , fallback = H1
                    , options =
                        [ ( "h1", H1 )
                        , ( "h2", H2 )
                        , ( "h3", H3 )
                        , ( "h4", H4 )
                        , ( "p", Paragraph )
                        ]
                    }
        }


type alias Arguments =
    { label : String
    , kind : Kind
    }


type Kind
    = H1
    | H2
    | H3
    | H4
    | Paragraph


view : Arguments -> Html msg
view args =
    case args.kind of
        H1 ->
            Ui.Typography.h1 args.label

        H2 ->
            Ui.Typography.h2 args.label

        H3 ->
            Ui.Typography.h3 args.label

        H4 ->
            Ui.Typography.h4 args.label

        Paragraph ->
            Ui.Typography.p args.label

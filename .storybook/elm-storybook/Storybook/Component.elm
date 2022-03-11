module Storybook.Component exposing
    ( Component
    , new
    )

import Browser
import Html exposing (Html)
import Json.Decode as Json
import Storybook.Argument


type alias Component =
    Program Json.Value Json.Value ()


new :
    { view : arguments -> Html ()
    , decoder : Storybook.Argument.Decoder arguments
    }
    -> Component
new options =
    Browser.element
        { init = \json -> ( json, Cmd.none )
        , update = \_ model -> ( model, Cmd.none )
        , view =
            \json ->
                options.decoder
                    |> Storybook.Argument.decode json
                    |> options.view
        , subscriptions = \_ -> Sub.none
        }

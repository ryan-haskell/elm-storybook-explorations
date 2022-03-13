port module Storybook.Component exposing
    ( Component, new
    , Msg, log, logWithPayload
    )

{-|

@docs Component, new
@docs Msg, log, logWithPayload

-}

import Browser
import Html exposing (Html)
import Json.Decode as Json
import Json.Encode
import Storybook.Argument


type alias Component =
    Program Json.Value Model Msg


type alias Model =
    Json.Value


type Msg
    = Log
        { actionName : String
        , payload : Json.Value
        }


log : { actionName : String } -> Msg
log { actionName } =
    Log
        { actionName = actionName
        , payload = Json.Encode.object []
        }


logWithPayload :
    { actionName : String
    , payload : Json.Value
    }
    -> Msg
logWithPayload =
    Log


new :
    { view : arguments -> Html Msg
    , decoder : Storybook.Argument.Decoder arguments
    }
    -> Component
new options =
    Browser.element
        { init = \json -> ( json, Cmd.none )
        , update = update
        , view =
            \json ->
                options.decoder
                    |> Storybook.Argument.decode json
                    |> options.view
        , subscriptions = \_ -> Sub.none
        }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        Log action ->
            ( model
            , logAction action
            )


port logAction :
    { actionName : String
    , payload : Json.Value
    }
    -> Cmd msg

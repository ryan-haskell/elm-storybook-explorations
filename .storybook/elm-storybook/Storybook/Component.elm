port module Storybook.Component exposing
    ( Component
    , stateless, sandbox
    )

{-|

@docs Component
@docs stateless, sandbox

-}

import Browser
import Html exposing (Html)
import Json.Decode as Json
import Json.Encode
import Storybook.Controls
import Task


type alias Component model msg =
    Program Json.Value (Model model) (Msg msg)


type alias Model model =
    { controls : Json.Value
    , component : model
    }


type alias Action =
    { name : String
    , payload : Json.Value
    }


type Msg msg
    = UserLoggedMessage Action
    | ComponentSentMessage msg
    | ComponentSentMessageAndLoggedAction { msg : msg, action : Action }


mapMsg : (msg1 -> msg2) -> Msg msg1 -> Msg msg2
mapMsg fn msg =
    case msg of
        UserLoggedMessage data ->
            UserLoggedMessage data

        ComponentSentMessage componentMsg ->
            ComponentSentMessage (fn componentMsg)

        ComponentSentMessageAndLoggedAction data ->
            ComponentSentMessageAndLoggedAction
                { msg = fn data.msg
                , action = data.action
                }


stateless :
    { view : controls -> Html msg
    , controls : Storybook.Controls.Decoder controls
    }
    -> Component () msg
stateless options =
    Browser.element
        { init =
            \json ->
                ( { controls = json
                  , component = ()
                  }
                , Cmd.none
                )
        , update = update (\_ model -> model)
        , view =
            \model ->
                options.controls
                    |> Storybook.Controls.decode model.controls
                    |> options.view
                    |> Html.map logMessageAndAction
        , subscriptions = \_ -> Sub.none
        }


sandbox :
    { controls : Storybook.Controls.Decoder controls
    , init : model
    , update : msg -> model -> model
    , view : controls -> model -> Html msg
    }
    -> Component model msg
sandbox options =
    Browser.element
        { init =
            \json ->
                ( { controls = json
                  , component = options.init
                  }
                , Cmd.none
                )
        , update = update options.update
        , view =
            \model ->
                options.view
                    (Storybook.Controls.decode
                        model.controls
                        options.controls
                    )
                    model.component
                    |> Html.map logMessageAndAction
        , subscriptions = \_ -> Sub.none
        }


logMessageAndAction : msg -> Msg msg
logMessageAndAction msg =
    ComponentSentMessageAndLoggedAction
        { msg = msg
        , action =
            { name = "onAction"
            , payload = Json.Encode.string (Debug.toString msg)
            }
        }


update :
    (msg -> model -> model)
    -> Msg msg
    -> Model model
    -> ( Model model, Cmd (Msg msg) )
update componentUpdateFn msg model =
    case msg of
        UserLoggedMessage actionToLog ->
            ( model
            , logAction actionToLog
            )

        ComponentSentMessage componentMsg ->
            ( { model | component = componentUpdateFn componentMsg model.component }
            , Cmd.none
            )

        ComponentSentMessageAndLoggedAction data ->
            ( { model | component = componentUpdateFn data.msg model.component }
            , Task.perform UserLoggedMessage
                (Task.succeed data.action)
            )


port logAction :
    { name : String
    , payload : Json.Value
    }
    -> Cmd msg

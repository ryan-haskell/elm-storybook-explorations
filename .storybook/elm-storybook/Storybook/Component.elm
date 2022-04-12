port module Storybook.Component exposing
    ( Component
    , stateless, sandbox, element
    )

{-|

@docs Component
@docs stateless, sandbox, element

-}

import Browser
import Json.Decode as Json
import Json.Encode
import Storybook.Controls
import Ui


type alias Component model msg =
    Program
        Json.Value
        (ComponentModel model)
        msg


stateless :
    { view : controls -> Ui.Html msg
    , controls : Storybook.Controls.Decoder controls
    }
    -> Component () msg
stateless options =
    let
        view : ComponentModel () -> Ui.Html msg
        view model =
            options.controls
                |> Storybook.Controls.decode model.controls
                |> options.view
    in
    Browser.element
        { init =
            \json ->
                ( { controls = json
                  , component = ()
                  }
                , Cmd.none
                )
        , update = updateSandbox (\_ model -> model)
        , view = view >> Ui.toHtml
        , subscriptions = \_ -> Sub.none
        }


sandbox :
    { controls : Storybook.Controls.Decoder controls
    , init : model
    , update : msg -> model -> model
    , view : controls -> model -> Ui.Html msg
    }
    -> Component model msg
sandbox options =
    let
        init : Json.Value -> ( ComponentModel model, Cmd msg )
        init json =
            ( { controls = json
              , component = options.init
              }
            , Cmd.none
            )

        view : ComponentModel model -> Ui.Html msg
        view model =
            options.view
                (Storybook.Controls.decode
                    model.controls
                    options.controls
                )
                model.component
    in
    Browser.element
        { init = init
        , update = updateSandbox options.update
        , view = view >> Ui.toHtml
        , subscriptions = \_ -> Sub.none
        }


element :
    { controls : Storybook.Controls.Decoder controls
    , init : ( model, Cmd msg )
    , update : msg -> model -> ( model, Cmd msg )
    , subscriptions : model -> Sub msg
    , view : controls -> model -> Ui.Html msg
    }
    -> Component model msg
element options =
    let
        init : Json.Value -> ( ComponentModel model, Cmd msg )
        init json =
            let
                ( model, cmd ) =
                    options.init
            in
            ( { controls = json
              , component = model
              }
            , cmd
            )

        view : ComponentModel model -> Ui.Html msg
        view model =
            options.view
                (Storybook.Controls.decode
                    model.controls
                    options.controls
                )
                model.component
    in
    Browser.element
        { init = init
        , update = updateElement options.update
        , view = view >> Ui.toHtml
        , subscriptions = \_ -> Sub.none
        }



-- INTERNALS


{-| We wrap the components `model` with our own, so we can
track the component's state, but also store the Storybook
controls passed in as flags by `.storybook/elm-storybook/index.js`
-}
type alias ComponentModel model =
    { controls : Json.Value
    , component : model
    }


{-| Rather than just handling the message using the
component's `update` function, we use the `logAction` port
to let Storybook's "Actions" tab log which Elm message was
sent.
-}
updateSandbox :
    (msg -> model -> model)
    -> msg
    -> ComponentModel model
    -> ( ComponentModel model, Cmd msg )
updateSandbox componentUpdateFn msg model =
    ( { model | component = componentUpdateFn msg model.component }
    , logAction
        { payload = Json.Encode.string (Debug.toString msg)
        }
    )


updateElement :
    (msg -> model -> ( model, Cmd msg ))
    -> msg
    -> ComponentModel model
    -> ( ComponentModel model, Cmd msg )
updateElement componentUpdateFn msg model =
    let
        ( newComponentModel, cmd ) =
            componentUpdateFn msg model.component
    in
    ( { model | component = newComponentModel }
    , Cmd.batch
        [ logAction
            { payload = Json.Encode.string (Debug.toString msg)
            }
        , cmd
        ]
    )


{-| This port allows us to send messages to JavaScript!
In this case, it means we can tell Storybook about Elm messages so
it can log them in the "Actions" tab
-}
port logAction : { payload : Json.Value } -> Cmd msg

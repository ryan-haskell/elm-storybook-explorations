module Storybook.Controls exposing
    ( Decoder, new, none
    , withString, withInt, withEnum
    , decode
    )

{-|

@docs Decoder, new, none
@docs withString, withInt, withEnum
@docs decode

-}

import Dict
import Json.Decode as Json


type Decoder value
    = Decoder
        { decoder : Json.Decoder value
        , fallback : value
        }


new : (a -> b) -> Decoder (a -> b)
new fn =
    Decoder
        { decoder = Json.succeed fn
        , fallback = fn
        }


none : Decoder ()
none =
    Decoder
        { decoder = Json.succeed ()
        , fallback = ()
        }


with :
    Decoder value
    -> Decoder (value -> output)
    -> Decoder output
with (Decoder field) (Decoder fn) =
    Decoder
        { decoder = Json.map2 (|>) field.decoder fn.decoder
        , fallback = fn.fallback field.fallback
        }



-- DECODER


decode : Json.Value -> Decoder value -> value
decode json (Decoder { decoder, fallback }) =
    case Json.decodeValue decoder json of
        Ok value ->
            value

        Err _ ->
            fallback



-- PRIMITIVES


withString :
    { name : String
    , fallback : String
    }
    -> Decoder (String -> output)
    -> Decoder output
withString options =
    with <|
        Decoder
            { decoder =
                Json.oneOf
                    [ Json.field options.name Json.string
                    , Json.succeed options.fallback
                    ]
            , fallback = options.fallback
            }


withInt :
    { name : String
    , fallback : Int
    }
    -> Decoder (Int -> output)
    -> Decoder output
withInt options =
    with <|
        Decoder
            { decoder =
                Json.oneOf
                    [ Json.field options.name Json.int
                    , Json.succeed options.fallback
                    ]
            , fallback = options.fallback
            }


withEnum :
    { name : String
    , options : List ( String, enum )
    , fallback : enum
    }
    -> Decoder (enum -> output)
    -> Decoder output
withEnum options =
    with <|
        Decoder
            { decoder =
                Json.oneOf
                    [ Json.field options.name Json.string
                        |> Json.andThen
                            (\str ->
                                case Dict.fromList options.options |> Dict.get str of
                                    Just enum_ ->
                                        Json.succeed enum_

                                    Nothing ->
                                        Json.fail ""
                            )
                    , Json.succeed options.fallback
                    ]
            , fallback = options.fallback
            }

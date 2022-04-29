module Ui.Table.Column exposing
    ( Column
    , person, badge, string, actions
    , toLabel, view
    )

{-|

@docs Column

@docs person, badge, string, actions

@docs toLabel, view

-}

import Ui
import Ui.Attr
import Ui.Avatar
import Ui.Badge
import Ui.Icon
import Ui.Palette
import Ui.Typography


type alias Person =
    { name : String
    }


type Column item
    = PersonColumn
        { label : String
        , toPerson : item -> Person
        }
    | BadgeColumn
        { label : String
        , toBadge : item -> Ui.Badge.Badge
        }
    | StringColumn
        { label : String
        , toString : item -> String
        }
    | ActionsColumn
        { options : List String
        }


person : { label : String, toPerson : item -> Person } -> Column item
person options =
    PersonColumn options


badge : { label : String, toBadge : item -> Ui.Badge.Badge } -> Column item
badge options =
    BadgeColumn options


string : { label : String, toString : item -> String } -> Column item
string options =
    StringColumn options


actions : { options : List String } -> Column item
actions options =
    ActionsColumn options


toLabel : Column item -> String
toLabel column =
    case column of
        PersonColumn options ->
            options.label

        BadgeColumn options ->
            options.label

        StringColumn options ->
            options.label

        ActionsColumn _ ->
            ""


view : item -> Column item -> Ui.Html msg
view item column =
    case column of
        PersonColumn options ->
            viewPersonColumn (options.toPerson item)

        BadgeColumn options ->
            Ui.Badge.view (options.toBadge item)

        StringColumn options ->
            Ui.Typography.p100 [] (options.toString item)

        ActionsColumn _ ->
            Ui.el [ Ui.Attr.fontColor Ui.Palette.n600 ]
                (Ui.icon.px12 Ui.Icon.more)


viewPersonColumn : Person -> Ui.Html msg
viewPersonColumn person_ =
    let
        initials : String
        initials =
            person_.name
                |> String.split " "
                |> List.filterMap getFirstLetter
                |> String.fromList
                |> String.toUpper

        getFirstLetter : String -> Maybe Char
        getFirstLetter str =
            case String.toList str of
                [] ->
                    Nothing

                char :: _ ->
                    Just char
    in
    Ui.row
        [ Ui.Attr.width.max.fill
        , Ui.Attr.gap.px8
        , Ui.Attr.align.centerY
        ]
        [ Ui.Avatar.viewCircle (Ui.Avatar.violet initials)
        , Ui.Typography.h300 [ Ui.Attr.ellipsis ] person_.name
        ]

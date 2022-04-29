module Stories.Table exposing (main)

import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Badge
import Ui.Table
import Ui.Table.Column


main : Component () msg
main =
    Storybook.Component.stateless
        { controls = Storybook.Controls.none
        , view = view
        }



-- VIEW


type alias Row =
    { person : Person
    , status : Status
    , team : String
    }


type alias Person =
    { name : String
    }


type Status
    = Online
    | Away
    | Offline
    | Invisible
    | DoNotDisturb


fromStatusToBadge : Status -> Ui.Badge.Badge
fromStatusToBadge status =
    case status of
        Online ->
            Ui.Badge.green "Online"

        Away ->
            Ui.Badge.yellow "Away"

        Offline ->
            Ui.Badge.neutral "Offline"

        Invisible ->
            Ui.Badge.neutral "Invisible"

        DoNotDisturb ->
            Ui.Badge.red "Do not Disturb"


items : List Row
items =
    [ { person = { name = "Ryan Haskell-Glatz" }
      , status = Online
      , team = "Frontend Engineers"
      }
    , { person = { name = "HyFlicker" }
      , status = DoNotDisturb
      , team = "NodeJS CRM Lords"
      }
    , { person = { name = "Rosie" }
      , status = Away
      , team = "Doggos"
      }
    ]


view : () -> Ui.Html msg
view _ =
    Ui.Table.view
        { columns =
            [ Ui.Table.Column.person
                { label = "User"
                , toPerson = .person
                }
            , Ui.Table.Column.badge
                { label = "Status"
                , toBadge = \row -> fromStatusToBadge row.status
                }
            , Ui.Table.Column.string
                { label = "Team"
                , toString = .team
                }
            , Ui.Table.Column.actions
                { options = []
                }
            ]
        , items = items
        }

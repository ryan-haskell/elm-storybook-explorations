module Stories.Dropdown exposing (main)

import Browser.Dom
import Layers
import Layers.Dropdown
import List.Extra
import Simple.Fuzzy
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Dropdown
import Ui.Typography


main : Component Model Msg
main =
    Storybook.Component.element
        { controls = Storybook.Controls.none
        , init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { layers : Layers.Model Item
    , selected : Maybe Fruit
    , searchInputValue : String
    }


init : ( Model, Cmd Msg )
init =
    ( { layers = Layers.init
      , selected = Nothing
      , searchInputValue = ""
      }
    , Cmd.none
    )



-- UPDATE


type Msg
    = LayersSentMsg (Layers.Msg Item)
    | UserClickedSelect
    | UserClickedOption Fruit
    | UserChangedSearchInput String
    | UserPressedArrowUp
    | UserPressedArrowDown
    | UserPressedEscape


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LayersSentMsg layersMsg ->
            Layers.update
                { model = model.layers
                , msg = layersMsg
                , toAppMsg = LayersSentMsg
                , toAppModel = \layers -> { model | layers = layers }
                }

        UserClickedSelect ->
            Layers.toggleMenu
                { item = DropdownMenu
                , model = model.layers
                , toAppMsg = LayersSentMsg
                , toAppModel = \layers -> { model | layers = layers }
                }

        UserPressedEscape ->
            Layers.closeMenu
                { item = DropdownMenu
                , model = model.layers
                , toAppMsg = LayersSentMsg
                , toAppModel = \layers -> { model | layers = layers, searchInputValue = "" }
                }

        UserClickedOption fruit ->
            ( { model | selected = Just fruit }
            , Cmd.none
            )

        UserChangedSearchInput string ->
            ( { model | searchInputValue = string }
            , Cmd.none
            )

        UserPressedArrowUp ->
            ( { model
                | selected =
                    allFruits
                        |> List.filter (contains model.searchInputValue)
                        |> previous model.selected
              }
            , Cmd.none
            )

        UserPressedArrowDown ->
            ( { model
                | selected =
                    allFruits
                        |> List.filter (contains model.searchInputValue)
                        |> next model.selected
              }
            , Cmd.none
            )


previous : Maybe Fruit -> List Fruit -> Maybe Fruit
previous maybe fruits =
    case maybe of
        Just fruit ->
            List.Extra.elemIndex fruit fruits
                |> Maybe.map (\i -> decrementIndex i fruits)
                |> Maybe.andThen (\i -> getItemAtIndex i fruits)

        Nothing ->
            getItemAtIndex (List.length fruits - 1) fruits


next : Maybe Fruit -> List Fruit -> Maybe Fruit
next maybe fruits =
    case maybe of
        Just fruit ->
            List.Extra.elemIndex fruit fruits
                |> Maybe.map (\i -> incrementIndex i fruits)
                |> Maybe.andThen (\i -> getItemAtIndex i fruits)

        Nothing ->
            getItemAtIndex 0 fruits


decrementIndex : Int -> List Fruit -> Int
decrementIndex index fruits =
    keepWithinBounds (index - 1) fruits


incrementIndex : Int -> List Fruit -> Int
incrementIndex index fruits =
    keepWithinBounds (index + 1) fruits


keepWithinBounds : Int -> List Fruit -> Int
keepWithinBounds index fruits =
    clamp 0 (List.length fruits - 1) index


getItemAtIndex : Int -> List Fruit -> Maybe Fruit
getItemAtIndex index fruits =
    List.Extra.getAt index fruits



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


type Fruit
    = Apple
    | Banana
    | Cherry


allFruits : List Fruit
allFruits =
    [ Apple
    , Banana
    , Cherry
    ]


fromFruitToLabel : Fruit -> String
fromFruitToLabel fruit =
    case fruit of
        Apple ->
            "Apple"

        Banana ->
            "Banana"

        Cherry ->
            "Cherry"


view : () -> Model -> Ui.Html Msg
view _ model =
    Layers.view
        { model = model.layers
        , toAppMsg = LayersSentMsg
        , viewAppLayer = viewAppLayer model
        , viewLayerItem = viewLayerItem model
        }


viewAppLayer : Model -> Ui.Html Msg
viewAppLayer model =
    Ui.col [ Ui.Attr.align.left, Ui.Attr.gap.px8 ]
        [ Ui.Dropdown.view
            { placeholder = "Select fruit"
            , toLabel = fromFruitToLabel
            , buttonId = Layers.idForItem DropdownMenu model.layers
            , onSelectClicked = UserClickedSelect
            , onSelectArrowUp = UserPressedArrowUp
            , onSelectArrowDown = UserPressedArrowDown
            , selected = model.selected
            }
        , Ui.Typography.p100 [ Ui.Attr.width.px216, Ui.Attr.relative ] "Hey I'm a paragraph, and I love blocking dropdown menus!! Even though this has a higher z-index, we will never see it block the dropdown menu!"
        ]



-- DROPDOWN MENUS


type Item
    = DropdownMenu


viewLayerItem : Model -> String -> Item -> Browser.Dom.Element -> Ui.Html Msg
viewLayerItem model id item parent =
    case item of
        DropdownMenu ->
            Layers.Dropdown.viewLeft parent
                (Ui.Dropdown.viewMenu
                    { menuId = id
                    , selected = model.selected
                    , toLabel = fromFruitToLabel
                    , items =
                        List.concat
                            [ [ Ui.Dropdown.group "Fruits" ]
                            , allFruits
                                |> List.filter (contains model.searchInputValue)
                                |> List.map Ui.Dropdown.item
                            ]
                    , searchInputValue = model.searchInputValue
                    , onOptionClicked = UserClickedOption
                    , onSearchInputChanged = UserChangedSearchInput
                    , onArrowUp = UserPressedArrowUp
                    , onArrowDown = UserPressedArrowDown
                    , onEscape = UserPressedEscape
                    }
                )


contains : String -> Fruit -> Bool
contains searchString fruit =
    Simple.Fuzzy.match
        searchString
        (fromFruitToLabel fruit)

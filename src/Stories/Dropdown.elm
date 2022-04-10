module Stories.Dropdown exposing (main)

import List.Extra
import Storybook.Component exposing (Component)
import Storybook.Controls
import Ui
import Ui.Attr
import Ui.Dropdown


main : Component Model Msg
main =
    Storybook.Component.sandbox
        { controls = Storybook.Controls.none
        , init = init
        , update = update
        , view = view
        }



-- INIT


type alias Model =
    { isMenuOpen : Bool
    , selected : Maybe Fruit
    , searchInputValue : String
    }


init : Model
init =
    { isMenuOpen = False
    , selected = Nothing
    , searchInputValue = ""
    }



-- UPDATE


type Msg
    = UserClickedSelect
    | UserClickedOption Fruit
    | UserChangedSearchInput String
    | UserPressedSpacebarOnSelect
    | UserPressedArrowUpOnSelect
    | UserPressedArrowDownOnSelect


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserClickedSelect ->
            { model | isMenuOpen = not model.isMenuOpen }

        UserClickedOption fruit ->
            { model | selected = Just fruit }

        UserChangedSearchInput string ->
            { model | searchInputValue = string }

        UserPressedSpacebarOnSelect ->
            { model | isMenuOpen = not model.isMenuOpen }

        UserPressedArrowUpOnSelect ->
            { model | selected = previous model.selected }

        UserPressedArrowDownOnSelect ->
            { model | selected = next model.selected }


previous : Maybe Fruit -> Maybe Fruit
previous maybe =
    case maybe of
        Just fruit ->
            List.Extra.elemIndex fruit fruits
                |> Maybe.map decrementIndex
                |> Maybe.andThen getItemAtIndex

        Nothing ->
            getItemAtIndex (List.length fruits - 1)


next : Maybe Fruit -> Maybe Fruit
next maybe =
    case maybe of
        Just fruit ->
            List.Extra.elemIndex fruit fruits
                |> Maybe.map incrementIndex
                |> Maybe.andThen getItemAtIndex

        Nothing ->
            getItemAtIndex 0


decrementIndex : Int -> Int
decrementIndex index =
    keepWithinBounds (index - 1)


incrementIndex : Int -> Int
incrementIndex index =
    keepWithinBounds (index + 1)


keepWithinBounds : Int -> Int
keepWithinBounds index =
    clamp 0 (List.length fruits - 1) index


getItemAtIndex : Int -> Maybe Fruit
getItemAtIndex index =
    List.Extra.getAt index fruits



-- VIEW


type Fruit
    = Apple
    | Banana
    | Cherry


fruits : List Fruit
fruits =
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
    Ui.Dropdown.view
        { placeholder = "Select fruit"
        , toLabel = fromFruitToLabel
        , items =
            [ Ui.Dropdown.group "Fruits"
            , Ui.Dropdown.item Apple
            , Ui.Dropdown.item Banana
            , Ui.Dropdown.item Cherry
            ]
        , onSelectClicked = UserClickedSelect
        , onOptionClicked = UserClickedOption
        , onSearchInputChanged = UserChangedSearchInput
        , onSelectSpacebar = UserPressedSpacebarOnSelect
        , onSelectArrowUp = UserPressedArrowUpOnSelect
        , onSelectArrowDown = UserPressedArrowDownOnSelect
        , isMenuOpen = model.isMenuOpen
        , searchInputValue = model.searchInputValue
        , selected = model.selected
        }

module Page.Home.Main exposing (Model, Msg, getKey, init, update, view)

import Browser
import Browser.Navigation as Navigation
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode exposing (Decoder, Error(..))
import Json.Decode.Pipeline as Pipeline
import Url



-- Model


type alias Model =
    { key : Navigation.Key
    , searchStr : String
    }


init : Navigation.Key -> Model
init key =
    Model key ""



-- Update


type Msg
    = TextInput String
    | SelectRandomRecipe
    | Search String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        TextInput input ->
            ( { model
                | searchStr = input
              }
            , Cmd.none
            )

        SelectRandomRecipe ->
            ( model, Navigation.pushUrl model.key "/random" )

        Search string ->
            ( model, Navigation.pushUrl model.key ("/list?" ++ string) )



-- View


view : Model -> Html Msg
view model =
    Html.div
        [ Attributes.id "home-screen" ]
        [ Html.div
            [ Attributes.class "home-container" ]
            [ Html.img
                [ Attributes.class "home-image"
                , Attributes.src "../assets/recipe_book.png"
                , Attributes.alt "Recipe book logo"
                ]
                []
            ]
        , Html.div
            [ Attributes.class "home-container" ]
            [ Html.input
                [ Attributes.type_ "text"
                , onInput TextInput
                , Attributes.value model.searchStr
                , Attributes.class "home"
                ]
                []
            ]
        , Html.div
            [ Attributes.class "home-container" ]
            [ Html.button [ onClick (Search model.searchStr) ] [ Html.text "Search" ]
            , Html.button [ onClick SelectRandomRecipe ] [ Html.text "Random" ]
            ]
        ]



-- Utils


getKey : Model -> Navigation.Key
getKey model =
    model.key

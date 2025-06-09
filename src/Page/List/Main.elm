module Page.List.Main exposing (Model, Msg, getKey, init, update, view)

import Browser.Navigation as Navigation
import Html exposing (Html)



-- Model


type alias Model =
    { key : Navigation.Key, query : String }


init : Navigation.Key -> String -> Model
init key query =
    update (Model key query) (GetQuery query)



-- Update


type Msg
    = GetQuery String


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    GetQuery query ->
        ( model, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    Html.div [] []

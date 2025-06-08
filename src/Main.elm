module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode exposing (Decoder, Error(..))
import Json.Decode.Pipeline as Pipeline
import Url



-- Main


main : Program () Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangeUrl
        , onUrlRequest = LinkClick
        }



-- Model


type alias Model =
    { searchStr : String }


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ _ _ =
    ( Model "", Cmd.none )


type Msg
    = ChangeUrl Url.Url
    | LinkClick Browser.UrlRequest



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    ( Model "", Cmd.none )



-- Subscription


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- View


view : Model -> Browser.Document Msg
view model =
    { title = "Le Livre de Recettes"
    , body = [ Html.div [] [] ]
    }

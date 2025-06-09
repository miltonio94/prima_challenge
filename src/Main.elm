module Main exposing (main)

import Browser
import Browser.Navigation as Navigation
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode exposing (Decoder, Error(..))
import Json.Decode.Pipeline as Pipeline
import Page.Details.Main as Details
import Page.Home.Main as Home
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


type Model
    = HomeModel Home.Model
    | DetailsModel Details.Model


init : () -> Url.Url -> Navigation.Key -> ( Model, Cmd Msg )
init _ url key =
    case url.path of
        "/random" ->
            Details.init Nothing key
                |> Tuple.mapBoth DetailsModel (Cmd.map DetailsMsg)

        _ ->
            ( HomeModel
                (Home.init key)
            , Cmd.none
            )


type Msg
    = ChangeUrl Url.Url
    | LinkClick Browser.UrlRequest
    | HomeMsg Home.Msg
    | DetailsMsg Details.Msg



-- Update


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case ( msg, model ) of
        ( HomeMsg subMsg, HomeModel subModel ) ->
            Home.update subMsg subModel
                |> Tuple.mapBoth HomeModel (Cmd.map HomeMsg)

        ( DetailsMsg subMsg, DetailsModel subModel ) ->
            Details.update subMsg subModel
                |> Tuple.mapBoth DetailsModel (Cmd.map DetailsMsg)

        ( ChangeUrl url, _ ) ->
            let
                _ =
                    Debug.log "url" url
            in
            case url.path of
                "/random" ->
                    let
                        _ =
                            Debug.log "hello" "hello"
                    in
                    model
                        |> getKey
                        |> Details.init Nothing
                        |> Tuple.mapBoth DetailsModel (Cmd.map DetailsMsg)

                _ ->
                    ( model
                        |> getKey
                        |> Home.init
                        |> HomeModel
                    , Cmd.none
                    )

        _ ->
            ( model, Cmd.none )



-- Subscription


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- View


view : Model -> Browser.Document Msg
view model =
    case model of
        HomeModel homeModel ->
            pageView
                "La Recettes"
                (Home.view homeModel
                    |> Html.map HomeMsg
                )

        DetailsModel detailsModel ->
            pageView
                "La Recettes Details"
                (Details.view detailsModel
                    |> Html.map DetailsMsg
                )



-- Utils


pageView : String -> Html Msg -> Browser.Document Msg
pageView title html =
    { title = title
    , body =
        [ Html.div [ Attributes.id "la-recettes-root" ] [ html ] ]
    }


getKey : Model -> Navigation.Key
getKey model =
    case model of
        HomeModel subModel ->
            Home.getKey subModel

        DetailsModel subModel ->
            Details.getKey subModel

module Page.Details.Main exposing (Model, Msg, getKey, init, update, view)

import Api.TheMealDb as TheMealDb
import Browser
import Browser.Navigation as Navigation
import FeatherIcons
import Helper.Html as Html
import Html exposing (Html)
import Html.Attributes as Attributes
import Html.Events exposing (onClick, onInput)
import Http
import Json.Decode as Decode exposing (Decoder, Error(..))
import Json.Decode.Pipeline as Pipeline
import Maybe.Extra as Maybe
import Task
import Url



-- Model


type alias Model =
    { key : Navigation.Key
    , recipeDetails : List RecipeDetails
    }


type Msg
    = GetDetailsById
    | GetRandomDetails
    | GoHome
    | DetailsResult (Result.Result Http.Error TheMealDb.RecipeDetailsResponse)


type alias ResourceId =
    String


type alias RecipeDetails =
    { id : String
    , title : String
    , alternateTitle : Maybe String
    , category : Maybe String
    , origin : Maybe String
    , instructions : String
    , thumbnail : Maybe String
    , tags : Maybe String
    , video : Maybe String
    , ingredients : List String
    , measurements : List String
    , source : Maybe String
    , imgSrc : Maybe String
    }


init : Maybe ResourceId -> Navigation.Key -> ( Model, Cmd Msg )
init resourceId key =
    case resourceId of
        Nothing ->
            update GetRandomDetails { key = key, recipeDetails = [] }

        Just id ->
            ( { key = key, recipeDetails = [] }, Cmd.none )



-- Update


responseToDetails : TheMealDb.RecipeDetailsResponse -> List RecipeDetails
responseToDetails response =
    List.map
        (\recipe ->
            { id = recipe.idMeal
            , title = recipe.strMeal
            , alternateTitle = recipe.strMealAlternate
            , category = recipe.strCategory
            , origin = recipe.strArea
            , instructions = recipe.strInstructions
            , thumbnail = recipe.strMealThumb
            , tags = recipe.strTags
            , video = recipe.strYoutube
            , ingredients =
                Maybe.toList recipe.strIngredient1
                    ++ Maybe.toList recipe.strIngredient2
                    ++ Maybe.toList recipe.strIngredient3
                    ++ Maybe.toList recipe.strIngredient4
                    ++ Maybe.toList recipe.strIngredient5
                    ++ Maybe.toList recipe.strIngredient6
                    ++ Maybe.toList recipe.strIngredient7
                    ++ Maybe.toList recipe.strIngredient8
                    ++ Maybe.toList recipe.strIngredient9
                    ++ Maybe.toList recipe.strIngredient10
                    ++ Maybe.toList recipe.strIngredient11
                    ++ Maybe.toList recipe.strIngredient12
                    ++ Maybe.toList recipe.strIngredient13
                    ++ Maybe.toList recipe.strIngredient14
                    ++ Maybe.toList recipe.strIngredient15
                    ++ Maybe.toList recipe.strIngredient16
                    ++ Maybe.toList recipe.strIngredient17
                    ++ Maybe.toList recipe.strIngredient18
                    ++ Maybe.toList recipe.strIngredient19
                    ++ Maybe.toList recipe.strIngredient20
            , measurements = []
            , source = recipe.strSource
            , imgSrc = recipe.strImageSource
            }
        )
        response.meals


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetRandomDetails ->
            ( model, TheMealDb.getRandom DetailsResult )

        DetailsResult res ->
            ( { model
                | recipeDetails =
                    res
                        |> Result.map responseToDetails
                        |> Result.withDefault []
              }
            , Cmd.none
            )

        GoHome ->
            ( model, Navigation.pushUrl model.key "/" )

        _ ->
            ( model, Cmd.none )



-- View


view : Model -> Html Msg
view model =
    Html.div
        [ Attributes.id "recipe-details" ]
        [ Html.div
            [ Attributes.class "recipe-details-top-bar" ]
            [ Html.div
                [ Attributes.class "home-button" ]
                [ FeatherIcons.home
                    |> FeatherIcons.withClass "home-button-icon"
                    |> FeatherIcons.toHtml [ Html.Events.onClick GoHome ]
                ]
            ]
        , Html.div
            [ Attributes.class "recipe-details-content" ]
            (List.map
                (\recipe ->
                    Html.div
                        []
                        ([ case recipe.thumbnail of
                            Just url ->
                                Html.img [ Attributes.src url ] []

                            Nothing ->
                                Html.none
                         , Html.div
                            [ Attributes.class "title-container" ]
                            [ Html.h1 [] [ Html.text recipe.title ] ]
                         ]
                            ++ (if List.length recipe.measurements > 0 then
                                    List.map2
                                        (\a b ->
                                            Html.div
                                                []
                                                [ Html.div
                                                    []
                                                    [ Html.text a ]
                                                , Html.div
                                                    []
                                                    [ Html.text b ]
                                                ]
                                        )
                                        recipe.ingredients
                                        recipe.measurements

                                else
                                    List.map
                                        (\a ->
                                            Html.div
                                                []
                                                [ Html.div
                                                    []
                                                    [ Html.text a ]
                                                ]
                                        )
                                        recipe.ingredients
                               )
                            ++ (recipe.instructions
                                    |> String.split "."
                                    |> List.map
                                        (\p ->
                                            Html.p [] [ Html.text (p ++ ".") ]
                                        )
                               )
                        )
                )
                model.recipeDetails
            )
        ]



-- Utils


getKey : Model -> Navigation.Key
getKey model =
    model.key

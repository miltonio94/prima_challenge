module Api.TheMealDb exposing (..)

import Http
import Json.Decode as Decode
import Json.Decode.Extra as Decode
import Json.Decode.Pipeline as DecodePipe


type alias Endpoint =
    String


apiEndpoint : Endpoint
apiEndpoint =
    "https://www.themealdb.com/api/json/v1/1/"


searchEndPoint : Endpoint
searchEndPoint =
    apiEndpoint ++ "search.php"


randomEndPoint : Endpoint
randomEndPoint =
    apiEndpoint ++ "random.php"


categoriesEndpoint : Endpoint
categoriesEndpoint =
    apiEndpoint ++ "categories.php"


filterEndpoint : Endpoint
filterEndpoint =
    apiEndpoint ++ "categories.php"


getRandom : (Result Http.Error RecipeDetailsResponse -> msg) -> Cmd msg
getRandom msg =
    Http.get
        { url = randomEndPoint
        , expect = Http.expectJson msg recipeReponseDecoder
        }


type alias RecipeDetails =
    { idMeal : String
    , strMeal : String
    , strMealAlternate : Maybe String
    , strCategory : Maybe String
    , strArea : Maybe String
    , strInstructions : String
    , strMealThumb : Maybe String
    , strTags : Maybe String
    , strYoutube : Maybe String
    , strIngredient1 : Maybe String
    , strIngredient2 : Maybe String
    , strIngredient3 : Maybe String
    , strIngredient4 : Maybe String
    , strIngredient5 : Maybe String
    , strIngredient6 : Maybe String
    , strIngredient7 : Maybe String
    , strIngredient8 : Maybe String
    , strIngredient9 : Maybe String
    , strIngredient10 : Maybe String
    , strIngredient11 : Maybe String
    , strIngredient12 : Maybe String
    , strIngredient13 : Maybe String
    , strIngredient14 : Maybe String
    , strIngredient15 : Maybe String
    , strIngredient16 : Maybe String
    , strIngredient17 : Maybe String
    , strIngredient18 : Maybe String
    , strIngredient19 : Maybe String
    , strIngredient20 : Maybe String
    , strMeasure1 : Maybe String
    , strMeasure2 : Maybe String
    , strMeasure3 : Maybe String
    , strMeasure4 : Maybe String
    , strMeasure5 : Maybe String
    , strMeasure6 : Maybe String
    , strMeasure7 : Maybe String
    , strMeasure8 : Maybe String
    , strMeasure9 : Maybe String
    , strMeasure10 : Maybe String
    , strMeasure11 : Maybe String
    , strMeasure12 : Maybe String
    , strMeasure13 : Maybe String
    , strMeasure14 : Maybe String
    , strMeasure15 : Maybe String
    , strMeasure16 : Maybe String
    , strMeasure17 : Maybe String
    , strMeasure18 : Maybe String
    , strMeasure19 : Maybe String
    , strMeasure20 : Maybe String
    , strSource : Maybe String
    , strImageSource : Maybe String
    , strCreativeCommonsConfirmed : Maybe String
    , dateModified : Maybe String
    }


type alias RecipeDetailsResponse =
    { meals : List RecipeDetails
    }


recipeReponseDecoder : Decode.Decoder RecipeDetailsResponse
recipeReponseDecoder =
    Decode.succeed RecipeDetailsResponse
        |> DecodePipe.required "meals" (Decode.list recipeDecoder)


recipeDecoder : Decode.Decoder RecipeDetails
recipeDecoder =
    Decode.succeed RecipeDetails
        |> DecodePipe.required "idMeal" Decode.string
        |> DecodePipe.required "strMeal" Decode.string
        |> DecodePipe.required "strMealAlternate" (Decode.maybe Decode.string)
        |> DecodePipe.required "strCategory" (Decode.maybe Decode.string)
        |> DecodePipe.required "strArea" (Decode.maybe Decode.string)
        |> DecodePipe.required "strInstructions" Decode.string
        |> DecodePipe.required "strMealThumb" (Decode.maybe Decode.string)
        |> DecodePipe.required "strTags" (Decode.maybe Decode.string)
        |> DecodePipe.required "strYoutube" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient1" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient2" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient3" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient4" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient5" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient6" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient7" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient8" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient9" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient10" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient11" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient12" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient13" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient14" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient15" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient16" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient17" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient18" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient19" (Decode.maybe Decode.string)
        |> DecodePipe.required "strIngredient20" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure1" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure2" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure3" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure4" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure5" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure6" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure7" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure8" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure9" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure10" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure11" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure12" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure13" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure14" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure15" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure16" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure17" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure18" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure19" (Decode.maybe Decode.string)
        |> DecodePipe.required "strMeasure20" (Decode.maybe Decode.string)
        |> DecodePipe.required "strSource" (Decode.maybe Decode.string)
        |> DecodePipe.required "strImageSource" (Decode.maybe Decode.string)
        |> DecodePipe.required "strCreativeCommonsConfirmed" (Decode.maybe Decode.string)
        |> DecodePipe.required "dateModified" (Decode.maybe Decode.string)

port module Main exposing (main)

import Browser exposing (element)
import Html exposing (Html, iframe, text)
import Html.Attributes exposing (attribute, src, style)
import Json.Decode as D
import Json.Encode as E
import Maybe
import Random


filterEncoder =
    E.list E.string


filterDecoder =
    D.list D.string


port responseFilter : (String -> msg) -> Sub msg


port requestFilter : () -> Cmd msg


port setFilter : String -> Cmd msg


youtubeIframe : String -> ( String, Html Msg )
youtubeIframe id =
    ( id
    , iframe
        [ style "width" "100%"
        , style "height" "100%"
        , src ([ "https://www.youtube-nocookie.com/embed/", id ] |> String.join "")
        , style "frameborder" "0"
        , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        , attribute "allowfullscreen" "true"
        ]
        []
    )


embeds : { head : ( String, Html Msg ), rest : List ( String, Html Msg ) }
embeds =
    { head = youtubeIframe "qSJCSR4MuhU"
    , rest =
        [ youtubeIframe "9320tG1bQaY"
        , youtubeIframe "gbxyZAduGvY"
        , youtubeIframe "VT2_7aq3ytE"
        , youtubeIframe "BeS46weU4ZI"
        , youtubeIframe "GJdm3c83L0w"
        ]
    }


type Msg
    = ReceiveFilter String
    | RandomResult (List String) ( String, Html Msg )


type alias Model =
    Maybe.Maybe (Html Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        RandomResult filter ( id, html ) ->
            ( Maybe.Just html, setFilter (filterEncoder (id :: filter) |> E.encode 0) )

        ReceiveFilter filterString ->
            case D.decodeString filterDecoder filterString of
                Result.Ok filter ->
                    ( model, Random.uniform embeds.head embeds.rest |> Random.generate (RandomResult filter) )

                _ ->
                    ( model, Random.uniform embeds.head embeds.rest |> Random.generate (RandomResult []) )


main : Program () Model Msg
main =
    element
        { init = \_ -> ( Maybe.Nothing, requestFilter () )
        , view = Maybe.withDefault (text "")
        , update = update
        , subscriptions = \_ -> responseFilter ReceiveFilter
        }

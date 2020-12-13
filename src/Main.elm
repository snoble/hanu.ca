module Main exposing (main)

import Browser exposing (element)
import Html exposing (Html, iframe, text)
import Html.Attributes exposing (attribute, src, style)
import Maybe
import Random


youtubeIframe : String -> Html Msg
youtubeIframe id =
    iframe
        [ style "width" "100%"
        , style "height" "100%"
        , src ([ "https://www.youtube-nocookie.com/embed/", id ] |> String.join "")
        , style "frameborder" "0"
        , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
        , attribute "allowfullscreen" "true"
        ]
        []


embeds =
    { head = youtubeIframe "qSJCSR4MuhU"
    , rest =
        [ youtubeIframe "9320tG1bQaY"
        , youtubeIframe "gbxyZAduGvY"
        , youtubeIframe "VT2_7aq3ytE"
        , youtubeIframe "BeS46weU4ZI"
        , youtubeIframe "7U0k_vHxc2k"
        , youtubeIframe "GJdm3c83L0w"
        ]
    }


type Msg
    = HtmlUpdate (Html Msg)


type alias Model =
    Maybe.Maybe (Html Msg)


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        HtmlUpdate html ->
            ( Maybe.Just html, Cmd.none )


main : Program () Model Msg
main =
    element
        { init = \_ -> ( Maybe.Nothing, Random.uniform embeds.head embeds.rest |> Random.generate HtmlUpdate )
        , view = Maybe.withDefault (text "")
        , update = update
        , subscriptions = \_ -> Sub.none
        }

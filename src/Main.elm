module Main exposing (main)

import Browser exposing (element)
import Html exposing (Html, iframe, text)
import Html.Attributes exposing (attribute, src, style)
import Maybe
import Random


embeds =
    { head =
        iframe
            [ style "width" "100%"
            , style "height" "100%"
            , src "https://www.youtube-nocookie.com/embed/qSJCSR4MuhU"
            , style "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" "true"
            ]
            []
    , rest =
        [ iframe
            [ style "width" "100%"
            , style "height" "100%"
            , src "https://www.youtube.com/embed/9320tG1bQaY"
            , style "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" "true"
            ]
            []
        , iframe
            [ style "width" "100%"
            , style "height" "100%"
            , src "https://www.youtube.com/embed/gbxyZAduGvY"
            , style "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" "true"
            ]
            []
        , iframe
            [ style "width" "100%"
            , style "height" "100%"
            , src "https://www.youtube.com/embed/VT2_7aq3ytE"
            , style "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" "true"
            ]
            []
        , iframe
            [ style "width" "100%"
            , style "height" "100%"
            , src "https://www.youtube.com/embed/BeS46weU4ZI"
            , style "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" "true"
            ]
            []
        , iframe
            [ style "width" "100%"
            , style "height" "100%"
            , src "https://www.youtube.com/embed/7U0k_vHxc2k"
            , style "frameborder" "0"
            , attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
            , attribute "allowfullscreen" "true"
            ]
            []
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

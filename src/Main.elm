module Main exposing (main)

import Browser
import Html exposing (iframe)
import Html.Attributes exposing (style, src, attribute)

main =
  iframe [
    style "width" "100%",
    style "height" "100%",
    src "https://www.youtube-nocookie.com/embed/qSJCSR4MuhU",
    style "frameborder" "0",
    attribute "allow" "accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture",
    attribute "allowfullscreen" "true"
  ] []
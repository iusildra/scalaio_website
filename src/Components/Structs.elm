module Components.Structs exposing (publicFooter, publicHeader, publicNav)

import Components.DropDown as DropDown exposing (..)
import Components.Utils exposing (capitalize)
import Html exposing (Html, div, h3, img, input, label, li, nav, p, span, ul)
import Html.Attributes as Attr exposing (..)
import Shared exposing (Msg(..))
import String exposing (..)
import Svg exposing (..)


viewLink : String -> Html msg
viewLink path =
    Html.a [ Attr.href path ] [ Html.text (capitalize path) ]


publicHeader : Html msg
publicHeader =
    div [ Attr.class "flex grow flex-col items-center header justify-around" ]
        [ img [ src "assets/logos/scalaio/scalaio_black.svg", alt "scalaio logo" ] []
        , Html.h1 [ Attr.class "headerTitle" ] [ Html.text "The Scala event in France!" ]
        , Html.h2 [ Attr.class "teaser" ] [ Html.text "October 28th, 2022 - ", Html.span [ Attr.class "red" ] [ Html.text "Paris"], Html.text ", France" ]
        ]


publicNav : DropDown.Model -> (DropDown.MsgChangeState -> msg) -> Html msg
publicNav model wrapDd  =
    nav [ Attr.class "flex justify-center items-center gap-x-8 navheaderColor" ]
        [ Html.header []
            [ Html.a [ Attr.class "brand" ] [ Html.text "Scala", Html.span [ Attr.class "red" ] [ Html.text "IO" ] ] ]
        , Html.div [] [ viewLink "venue" ]
        , Html.div [] [ viewLink "Speakers" ]
        , Html.div [] [ viewLink "Partners" ]
        , Html.div [] [ viewLink "Talks" ]
        , Html.div [] [ viewLink "Schedule" ]
        , Html.div [] [ viewLink "Videos" ]
        , Html.div [] [ viewLink "FAQ" ]
        , Html.div [] [ viewLink "Hall of fame" ]
        , DropDown.view model |> Html.map wrapDd
        ]


publicFooter : Html msg
publicFooter =
    div [ Attr.class "flex grow flex-row footer justify-center" ] [
    Html.footer [Attr.class "flex grow flex-row"] [    div
                    [ Attr.class "flex social flex-col content-center items-center"]
                    [ h3 [][ text "Social Networks" ]
                    , ul [] [li [][Html.text "Twitter"]]],
                  div[ Attr.class "flex newsletter flex-col content-center justify-items justify-around"][
                            h3 [][ text "Newsletter" ]
                       , p [][ text "Subscribe to our newsletter and be the first to know about our news !" ]
                       ,         {- Begin MailChimp Signup Form -}
                       Html.form
                           [ action "https://scala.us7.list-manage.com/subscribe/post?u=d1e91c63df589371ca4d8a48e&id=8ea1a2ab18",
                           method "post",
                            id "mc-embedded-subscribe-form",
                            name "mc-embedded-subscribe-form",
                            class "validate",
                            target "_blank",
                            novalidate True
                           ]
                           [ div [ Attr.class "controls mc-field-group"]
                               [ div[ Attr.class "form-group"][ label
                                       [ Attr.for "mce-EMAIL"]
                                       [ text "Email Address", span
                                           [ Attr.class "asterisk"
                                           ]
                                           [ text "*" ]
                                       ]
                                   , input[ Attr.type_ "email"
                                       , Attr.value ""
                                       , Attr.name "EMAIL"
                                       , Attr.class "required email form-control"
                                       , Attr.id "mce-EMAIL"][]
                                   ]
                                               {-/row-}
                               ]
                           ,             {- /container -}
                          Html.button [Attr.value "Subscribe", Attr.type_ "submit"][]

                           ]
                       ]
                  ],    div  [class "copyright"][ p [][ text "Scala", span [ Attr.class "red"][ text "IO" ]
                                , text "conference, All Rights Reserved." ]
                            ]
                  ]



globalPageStructure : Html Msg -> Shared.Model -> List (Html Msg)

globalPageStructure bodyContent model= [ publicNav model.dropdown DropDownMsg, publicHeader, bodyContent, publicFooter ]
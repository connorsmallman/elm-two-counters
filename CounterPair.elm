module CounterPair where

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- Model
type alias Model =
  { topCounter : Counter.Model
  , bottomCounter : Counter.Model
  }

init : Int -> Int -> Model
init top bottom =
  { topCounter = Counter.init top
  , bottomCounter = Counter.init bottom
  }


-- Update
type Action = Reset
  | Top Counter.Action
  | Bottom Counter.Action

update : Action -> Model -> Model
update action model =
  case action of
    Reset -> init 0 0
    Top act -> 
      {model | topCounter = Counter.update act model.topCounter}
    Bottom act -> 
      {model | bottomCounter = Counter.update act model.bottomCounter}


-- View
view : Signal.Address Action -> Model -> Html
view address model =
  div [ containerStyle ]
    [ (App.map Top (Counter.view model.topCounter))
    , (App.map Bottom (Counter.view model.bottomCounter))
    , button [ onClick address Reset ] [ text "Reset" ]
    ]

containerStyle : Attribute
containerStyle =
  style
    [ ("width", "100px")
    , ("text-align", "center")
    ]

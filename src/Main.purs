module Main where

import Prelude

import Data.Maybe
import Data.Newtype

import Effect (Effect)
import Effect.Console (log)
import Effect.Uncurried 

import Web.HTML
import Web.HTML.Window
import Web.Event.Event
import Web.Event.EventTarget

import Web.UIEvent.KeyboardEvent
import Web.UIEvent.KeyboardEvent.EventTypes


{-- import Control.Monad.Reader.Class --}

foreign import trial :: EffectFn1 Number Unit

main :: Effect Unit
main = do
  log "🍝"
  {-- runEffectFn1 trial 0.1 --}
  setupApp ["bunny.png"] setup update
  w <- window
  eL <- eventListener keyListener
  addEventListener keydown eL true (toEventTarget w)
  addEventListener keyup eL true (toEventTarget w)

keyListener e = case fromEvent e of
  Nothing -> log "not a keyboard event"
  Just ke -> do
     log $ key ke <> " " <> unwrap (type_ e)

setup s r = do
  b <- newSprite r "bunny.png"
  updateX b (const 200.0)
  updateY b (const 200.0)
  updateAnchorX b (const 0.5)
  updateAnchorY b (const 0.5)
  addToStage s b
  pure b
  

update b dt = do
  updateRotation b (\r -> r + dt * 0.1)

foreign import data Stage :: Type
foreign import data Resource :: Type

foreign import setupAppImpl :: forall s. EffectFn3 (Array String) (EffectFn2 Stage Resource s) (EffectFn2 s Number Unit) Unit

setupApp :: forall s. (Array String) -> (Stage -> Resource -> Effect s) -> (s -> Number -> Effect Unit) -> Effect Unit
setupApp paths f u = runEffectFn3 setupAppImpl paths (mkEffectFn2 f) (mkEffectFn2 u)

foreign import data Sprite :: Type
foreign import newSpriteImpl :: EffectFn2 Resource String Sprite

newSprite :: Resource -> String -> Effect Sprite
newSprite = runEffectFn2 newSpriteImpl

foreign import addToStageImpl :: EffectFn2 Stage Sprite Unit
addToStage :: Stage -> Sprite -> Effect Unit
addToStage = runEffectFn2 addToStageImpl

foreign import updateXImpl :: EffectFn2 Sprite (Number -> Number) Unit
updateX :: Sprite -> (Number -> Number) -> Effect Unit
updateX = runEffectFn2 updateXImpl

foreign import updateYImpl :: EffectFn2 Sprite (Number -> Number) Unit
updateY :: Sprite -> (Number -> Number) -> Effect Unit
updateY = runEffectFn2 updateYImpl

foreign import updateAnchorXImpl :: EffectFn2 Sprite (Number -> Number) Unit
updateAnchorX :: Sprite -> (Number -> Number) -> Effect Unit
updateAnchorX = runEffectFn2 updateAnchorXImpl

foreign import updateAnchorYImpl :: EffectFn2 Sprite (Number -> Number) Unit
updateAnchorY :: Sprite -> (Number -> Number) -> Effect Unit
updateAnchorY = runEffectFn2 updateAnchorYImpl

foreign import updateRotationImpl :: EffectFn2 Sprite (Number -> Number) Unit
updateRotation :: Sprite -> (Number -> Number) -> Effect Unit
updateRotation = runEffectFn2 updateRotationImpl

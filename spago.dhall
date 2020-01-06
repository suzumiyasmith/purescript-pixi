{-
Welcome to a Spago project!
You can edit this file as you like.
-}
{ name = "purescirpt-pixi"
, dependencies = [ "console", "effect", "web-events", "web-html", "web-uievents", "psci-support" ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}

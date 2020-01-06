"use strict";

const PIXI = require('pixi.js')

exports.trial = function (i) {
  const app = new PIXI.Application();
  document.body.appendChild(app.view);
  app.loader.add(['bunny.png']).load((loader, resources) => {
    // This creates a texture from a 'bunny.png' image
    const bunny = new PIXI.Sprite(resources['bunny.png'].texture);

    // Setup the position of the bunny
    bunny.x = app.renderer.width / 2;
    bunny.y = app.renderer.height / 2;

    // Rotate around the center
    bunny.anchor.x = 0.5;
    bunny.anchor.y = 0.5;

    // Add the bunny to the scene we are building
    app.stage.addChild(bunny);

    // Listen for frame updates
    app.ticker.add((t) => {
         // each frame we spin the bunny around a bit
        bunny.rotation += i * t;
    });
  });
}

exports.setupAppImpl = function (images, f, u) {
  const app = new PIXI.Application()
  document.body.appendChild(app.view)
  app.loader.add(images).load((loader, resources) => {
    const s = f(app.stage, resources)
    app.ticker.add((t) => u(s,t))
  });
}

exports.newSpriteImpl = (res, tex) => new PIXI.Sprite(res[tex].texture)

exports.addToStageImpl = (stage, sprite) => stage.addChild(sprite)

exports.updateXImpl = (sprite, f) => sprite.x = f(sprite.x)
exports.getXImpl = (sprite) => sprite.x
exports.updateYImpl = (sprite, f) => sprite.y = f(sprite.y)
exports.getYImpl = (sprite) => sprite.y
exports.updateAnchorXImpl = (sprite, f) => sprite.anchor.x = f(sprite.anchor.x)
exports.updateAnchorYImpl = (sprite, f) => sprite.anchor.y = f(sprite.anchor.y)


exports.updateRotationImpl = (sprite, f) => sprite.rotation = f(sprite.rotation)


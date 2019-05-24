require('./prizes')

wheel = {}
wheel.x = love.graphics.getWidth()/2
wheel.y = love.graphics.getHeight()
wheel.rotation = 0
wheel.defaultAcceleration = 1
wheel.acceleration = wheel.defaultAcceleration
wheel.defaultSpeed = 0
wheel.addJumpStartSpeed = 0.1
wheel.cutOffSpeed = 0.00002
wheel.idleSpeed = 0.002
wheel.maxSpeed = 15.0
wheel.speed = wheel.defaultSpeed
wheel.speedDecay = .02
wheel.speedDecayFast = .5

wheel.wedges = {
  { stop = 18.0, prizeKey = 'sketch2' },
  { stop = 36.0, prizeKey = 'sketchSet1' },
  { stop = 54.0, prizeKey = 'pen' },
  { stop = 72.0, prizeKey = 'sketch1' },
  { stop = 90.0, prizeKey = 'hardcover' },

  { stop = 105.0, prizeKey = 'sketch1' },
  { stop = 119.5, prizeKey = 'sketch2' },
  { stop = 134.9, prizeKey = 'sketch1' },
  { stop = 150.0, prizeKey = 'pen' },
  { stop = 164.6, prizeKey = 'softcover' },

  { stop = 195.0, prizeKey = 'sketch1' },
  { stop = 209.6, prizeKey = 'sketchSet2' },
  { stop = 225.0, prizeKey = 'pen' },
  { stop = 240.1, prizeKey = 'hardcover' },
  { stop = 254.6, prizeKey = 'sketch2' },

  { stop = 284.9, prizeKey = 'sketch1' },
  { stop = 299.6, prizeKey = 'shirt' },
  { stop = 315.0, prizeKey = 'blank' },
  { stop = 330.0, prizeKey = 'softcover' },
  { stop = 344.5, prizeKey = 'sketch1' },
}
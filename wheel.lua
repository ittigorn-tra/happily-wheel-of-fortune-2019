require('./prizes')

wheel = {}
wheel.x = love.graphics.getWidth()/2
wheel.y = love.graphics.getHeight()
wheel.centerOffsetX = 1
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
  { stop = 18.2, prizeKey = 'blank' },
  { stop = 36.1, prizeKey = 'sketch2' },
  { stop = 54.0, prizeKey = 'sketchSet1' },
  { stop = 72.0, prizeKey = 'sketch1' },
  { stop = 90.3, prizeKey = 'blank' },

  { stop = 108.3, prizeKey = 'sketch1' },
  { stop = 126.1, prizeKey = 'sketch2' },
  { stop = 144.0, prizeKey = 'sketch1' },
  { stop = 162.1, prizeKey = 'blank' },
  { stop = 180.0, prizeKey = 'softcover' },

  { stop = 198.1, prizeKey = 'sketch1' },
  { stop = 216.0, prizeKey = 'sketchSet2' },
  { stop = 233.8, prizeKey = 'blank' },
  { stop = 251.7, prizeKey = 'hardcover' },
  { stop = 270.0, prizeKey = 'sketch2' },

  { stop = 293.7, prizeKey = 'sketch1' },
  { stop = 299.3, prizeKey = 'shirt' },
  { stop = 323.9, prizeKey = 'blank' },
  { stop = 342.0, prizeKey = 'softcover' },
  { stop = 360.0, prizeKey = 'sketch1' }
}
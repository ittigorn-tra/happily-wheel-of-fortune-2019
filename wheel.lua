require('./prizes')

wheel = {}
wheel.x = love.graphics.getWidth()/2
wheel.y = love.graphics.getHeight()/2
wheel.rotation = 0
wheel.defaultAcceleration = 1
wheel.acceleration = wheel.defaultAcceleration
wheel.defaultSpeed = 0
wheel.idleSpeed = 0.002
wheel.maxSpeed = 15.0
wheel.speed = wheel.defaultSpeed
wheel.speedDecay = .98
wheel.speedDecayFast = .5

wheel.wedges = {
  { stop = 15.0, prizeKey = 'hardcover' },
  { stop = 29.5, prizeKey = 'shirtB' },
  { stop = 45.0, prizeKey = 'paperback' },
  { stop = 59.9, prizeKey = 'pen' },
  { stop = 74.6, prizeKey = 'sketch1' },
  { stop = 90.0, prizeKey = 'sketch2' },

  { stop = 105.0, prizeKey = 'hardcover' },
  { stop = 119.5, prizeKey = 'sketch2' },
  { stop = 134.9, prizeKey = 'pen' },
  { stop = 150.0, prizeKey = 'shirtW' },
  { stop = 164.6, prizeKey = 'sketch1' },
  { stop = 180.0, prizeKey = 'sketch2' },

  { stop = 195.0, prizeKey = 'paperback' },
  { stop = 209.6, prizeKey = 'shirtB' },
  { stop = 225.0, prizeKey = 'hardcover' },
  { stop = 240.1, prizeKey = 'pen' },
  { stop = 254.6, prizeKey = 'sketch2' },
  { stop = 270.0, prizeKey = 'sketch1' },

  { stop = 284.9, prizeKey = 'paperback' },
  { stop = 299.6, prizeKey = 'sketch1' },
  { stop = 315.0, prizeKey = 'pen' },
  { stop = 330.0, prizeKey = 'shirtW' },
  { stop = 344.5, prizeKey = 'sketch2' },
  { stop = 360.0, prizeKey = 'sketch1' }
}
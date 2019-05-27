local congrats = love.audio.newSource("sounds/51.wav", "stream")
local blank = nil
prizes = {
  softcover   = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='สมุดปกอ่อน' },
  hardcover   = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='สมุดปกแข็ง' },
  sketch1     = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='Sketchbook' },
  sketch2     = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='Sketchbook Large' },
  sketchSet1  = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='Sketchbook Rainbow Set' },
  sketchSet2  = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='Sketchbook Summer Set' },
  pen         = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='ปากกา' },
  shirt       = { sound = congrats, sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='Happily T-shirt Black / White' },
  blank       = { sound = blank,    sprite = love.graphics.newImage('sprites/prizes/placeholder.png'), name='Blank' },
}
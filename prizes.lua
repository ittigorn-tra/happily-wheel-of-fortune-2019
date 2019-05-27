local success = love.audio.newSource("sounds/success.mp3", "stream")
local blank = love.audio.newSource("sounds/fail.mp3", "stream")
prizes = {
  softcover   = { sound = success, sprite = love.graphics.newImage('sprites/prizes/softbook.png'), name='สมุดปกอ่อน' },
  hardcover   = { sound = success, sprite = love.graphics.newImage('sprites/prizes/Hardbook.png'), name='สมุดปกแข็ง' },
  sketch1     = { sound = success, sprite = love.graphics.newImage('sprites/prizes/Notebook-small.png'), name='Sketchbook' },
  sketch2     = { sound = success, sprite = love.graphics.newImage('sprites/prizes/Sketchbook.png'), name='Sketchbook Large' },
  sketchSet1  = { sound = success, sprite = love.graphics.newImage('sprites/prizes/colorful-set.png'), name='Sketchbook Rainbow Set' },
  sketchSet2  = { sound = success, sprite = love.graphics.newImage('sprites/prizes/summer-set.png'), name='Sketchbook Summer Set' },
  pen         = { sound = success, sprite = love.graphics.newImage('sprites/prizes/Pen.png'), name='ปากกา' },
  shirt       = { sound = success, sprite = love.graphics.newImage('sprites/prizes/T-shirt.png'), name='Happily T-shirt Black / White' },
  blank       = { sound = blank,    sprite = love.graphics.newImage('sprites/prizes/fail.png'), name='Blank' },
}
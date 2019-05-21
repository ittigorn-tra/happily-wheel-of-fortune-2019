function love.load()

  love.window.setMode( 1920, 1000, {fullscreen=true} )
  gameState = 1
  bg = love.graphics.newImage('sprites/bg.png')

  moonshine = require 'moonshine'
  require('./wheel')

  effect = moonshine(moonshine.effects.boxblur)
  effect.boxblur.radius = {0,0}

  sprites = {}
  sprites.wheel = love.graphics.newImage('sprites/wheel.png')
  sprites.wheelHub = love.graphics.newImage('sprites/wheel-hub.png')
  sprites.shadow = love.graphics.newImage('sprites/shadow-wheel.png')

  sounds = {}
  sounds.congrats = love.audio.newSource("sounds/51.wav", "static")
  sounds.click1 = love.audio.newSource("sounds/IR-sweep.wav", "static")
  sounds.click2 = sounds.click1:clone()

  justFinishedSpinning = false
  prize = ''
end

function love.update(dt)

  -- clicking sound
  if (wheel.speed > 0) and (wheel.speed < 0.3) then
    if (wheel.rotation >= 0) and (wheel.rotation < (math.pi/6)) then
      sounds.click1:play()
    elseif (wheel.rotation >= (math.pi/6)) and (wheel.rotation < (math.pi/4)) then
      sounds.click2:play()
    end
  end

  -- boxblur
  effect.boxblur.radius = {wheel.speed*15,wheel.speed*15}

  -- update rotation calculation
  if wheel.rotation > (math.pi*2) then
    wheel.rotation = math.fmod(wheel.rotation, (math.pi*2)) -- wheel.rotation = wheel.rotation - (math.pi*2)
  end
  wheel.rotation = wheel.rotation + wheel.speed

  -- if game is in session
  if gameState == 2 then
    if love.keyboard.isDown('space') then
      if wheel.speed <= 0.1 then
        wheel.speed = math.random(3,5)/10
        justFinishedSpinning = true
      end
      if wheel.speed < wheel.maxSpeed then
        wheel.acceleration = wheel.acceleration * 1.00025
        wheel.speed = wheel.speed * wheel.acceleration
      else
        wheel.speed = wheel.speed + 0.0005
      end
    else
      wheel.acceleration = wheel.defaultAcceleration
      if wheel.speed > 0.00002 then
        wheel.speed = wheel.speed * wheel.speedDecay
      else
        wheel.speed = wheel.defaultSpeed
        if justFinishedSpinning then
          sounds.congrats:play()
          determinePrize(radToDeg(wheel.rotation))
          justFinishedSpinning = false
        end
      end
    end
  else
    wheel.speed = wheel.idleSpeed
  end

end -- end love.update

function love.draw()
  love.graphics.draw(bg)
  -- love.graphics.draw(sprites.shadow, wheel.x, wheel.y, nil, wheel.scaleX, wheel.scaleY, sprites.shadow:getWidth()/2, sprites.shadow:getWidth()/2)
  love.graphics.draw(sprites.wheel, wheel.x, wheel.y, wheel.rotation, wheel.scaleX, wheel.scaleY, sprites.wheel:getWidth()/2, sprites.wheel:getWidth()/2)
  
  -- effect.draw(function()
  --   love.graphics.draw(sprites.wheel, wheel.x, wheel.y, wheel.rotation, wheel.scaleX, wheel.scaleY, sprites.wheel:getWidth()/2, sprites.wheel:getWidth()/2)
  -- end)

  love.graphics.draw(sprites.wheelHub, wheel.x, wheel.y, (3*math.pi)/2, nil, nil, sprites.wheelHub:getWidth()/2, sprites.wheelHub:getWidth()/2)
  love.graphics.print(wheel.speed)
  love.graphics.print(wheel.rotation, 300, 0)
  love.graphics.print(prize, 600, 0)
  
end

function love.keypressed(k)
  if k == 'escape' then
     love.event.quit()
  elseif k == 'return' and gameState == 1 then
    startGame()
  end
end

function radToDeg(rad)
  return rad * (180/math.pi)
end

function determinePrize(deg)
  lastPrizeDeg = 0
  for i, w in ipairs(wheel.wedges) do
    if deg > lastPrizeDeg and deg <= wheel.wedges[i].stop then
      prize = wheel.wedges[i].prizeKey
      break
    end
    lastPrizeDeg = wheel.wedges[i].stop
  end
end

function startGame()
  gameState = 2
  wheel.rotation = 0
  wheel.speed = 0
end

function resetGameState()
  gameState = 1
end
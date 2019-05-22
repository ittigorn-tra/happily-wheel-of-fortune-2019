-- ESC to exit game
-- HOME to enter idle mode or idle for 10 seconds
-- ENTER to start
-- SPACEBAR to spin

function love.load()

  debugMode = true
  gameState = 1
  idleTime = 0
  triggerIdleMode = 10.0
  justFinishedSpinning = false
  prize = ''
  lastClickedWedge = 0

  love.window.setMode( 1920, 1080, {fullscreen=true,display=1} )

  require('./wheel')
  -- moonshine = require 'moonshine'
  -- effect = moonshine(moonshine.effects.boxblur)
  -- effect.boxblur.radius = {0,0}

  -- graphics
  bg = love.graphics.newImage('sprites/bg.png')
  sprites = {}
  sprites.wheel = love.graphics.newImage('sprites/wheel.png')
  sprites.wheelHub = love.graphics.newImage('sprites/wheel-hub.png')
  sprites.shadow = love.graphics.newImage('sprites/shadow-wheel.png')

  -- sounds
  sounds = {}
  sounds.congrats = love.audio.newSource("sounds/51.wav", "static")
  sounds.clicks = loadClicks()
  
end

function love.update(dt)
  -- clicking sound
  click()

  -- boxblur
  -- effect.boxblur.radius = {wheel.speed*15,wheel.speed*15}

  -- update rotation calculation
  if wheel.rotation > (math.pi*2) then
    wheel.rotation = math.fmod(wheel.rotation, (math.pi*2)) -- modulus operation
  end
  wheel.rotation = wheel.rotation + wheel.speed

  -- if game is in session
  if gameState == 2 then
    if love.mouse.isDown(1) then
      if wheel.speed <= 0.1 then
        wheel.speed = math.random(3,5)/10
        justFinishedSpinning = true
      end
      if wheel.speed < wheel.maxSpeed then
        wheel.acceleration = wheel.acceleration * 1.00025
      else
        wheel.acceleration = wheel.acceleration * 1.00000000025
      end
      wheel.speed = wheel.speed * wheel.acceleration
    else
      wheel.acceleration = wheel.defaultAcceleration
      if wheel.speed > 0.00002 then
        if wheel.speed > wheel.maxSpeed then
          wheel.speed = wheel.speed * wheel.speedDecayFast
        else
          wheel.speed = wheel.speed * wheel.speedDecay
        end
      else
        wheel.speed = wheel.defaultSpeed
        if justFinishedSpinning then
          sounds.congrats:play()
          determinePrize(radToDeg(wheel.rotation))
          justFinishedSpinning = false
        end
      end
    end
  -- if game is idle
  else
    wheel.speed = wheel.idleSpeed
  end
  
  -- update idle time
  checkIdling(dt)

end -- end love.update

function love.draw()
  love.graphics.draw(bg, 0, 0, 0, love.graphics.getWidth()/bg:getWidth(), love.graphics.getHeight()/bg:getHeight())
  love.graphics.draw(sprites.wheel, wheel.x, wheel.y, wheel.rotation, (love.graphics.getHeight()*.8)/sprites.wheel:getHeight(), nil, sprites.wheel:getWidth()/2, sprites.wheel:getWidth()/2)
  
  -- effect.draw(function()
  --   love.graphics.draw(sprites.wheel, wheel.x, wheel.y, wheel.rotation, wheel.scaleX, wheel.scaleY, sprites.wheel:getWidth()/2, sprites.wheel:getWidth()/2)
  -- end)

  love.graphics.draw(sprites.wheelHub, wheel.x, wheel.y, (3*math.pi)/2, (love.graphics.getHeight()*.25)/sprites.wheelHub:getHeight(), nil, sprites.wheelHub:getWidth()/2, sprites.wheelHub:getWidth()/2)

  -- debug messages
  if debugMode then
    love.graphics.print('Speed: ' ..wheel.speed)
    love.graphics.print('Acc: ' ..wheel.acceleration, 0, 20)
    love.graphics.print('Rotation: ' ..wheel.rotation, 0, 40)
    love.graphics.print('Price: ' ..prize, 300, 0)
    love.graphics.print('Idle: ' ..idleTime, 600, 0)
  end
end

function love.keypressed(k)
  if gameState == 2 then
    idleTime = 0 -- reset idle time
  end
  if k == 'escape' then
     love.event.quit()
  elseif k == 'home' and gameState == 2 then
    enterIdleState()
  end
end

function love.mousepressed( x, y, button, istouch, presses )
  if (button == 1) and (gameState == 1) then
    startGame()
  end
end

function radToDeg(rad)
  return rad * (180/math.pi)
end

function determinePrize(deg)
  lastPrizeDeg = 0
  for i, w in ipairs(wheel.wedges) do
    if deg > lastPrizeDeg and deg <= w.stop then
      prize = w.prizeKey
      break
    end
    lastPrizeDeg = w.stop
  end
end

function startGame()
  gameState = 2
  wheel.speed = 0
end

function enterIdleState()
  gameState = 1
  idleTime = 0
end

function loadClicks()
  local clicks = {}
  table.insert(clicks, love.audio.newSource("sounds/IR-sweep.wav", "static"))
  for i = 1, 30, 1 do
    table.insert(clicks, clicks[1]:clone())
  end
  return clicks
end

function click()
  if (wheel.speed > 0) and (wheel.speed < 0.2) then
    local deg = radToDeg(wheel.rotation)
    local lastPrizeDeg = 0
    for i, w in ipairs(wheel.wedges) do
      if deg > lastPrizeDeg and deg <= w.stop then
        if not (i == lastClickedWedge) then
          for i, s in ipairs(sounds.clicks) do
            if not s:isPlaying() then
              s:play()
              break
            end
          end
          lastClickedWedge = i
        end
        break
      end
      lastPrizeDeg = w.stop
    end
  end
end

function checkIdling(dt)
  if (gameState == 2) and (wheel.speed == 0) then
    if idleTime > triggerIdleMode then
      enterIdleState()
    else
      idleTime = idleTime + dt
    end
  end
end
-- ESC to exit game
-- HOME to enter idle mode or idle for 10 seconds
-- ENTER to start
-- SPACEBAR to spin

function love.load()

  debugMode = true
  gameState = 1
  gameStateTimeout = 10.0
  justSpun = false
  showPrizeTimer = 0
  showPrizeTimeout = 10
  showPrize = false
  prize = ''
  lastClickedWedge = 0

  -- love.window.setMode( 1920, 1080, {fullscreen=true,display=1} )
  love.window.setMode( love.graphics.getWidth(), love.graphics.getHeight(), {fullscreen=true,display=1} )

  require('./wheel')

  -- graphics
  bg = {}
  table.insert(bg, love.graphics.newImage('sprites/shadow.png'))
  table.insert(bg, love.graphics.newImage('sprites/bg.png'))
  table.insert(bg, love.graphics.newImage('sprites/wheel-hub.png'))

  sprites = {}
  sprites.wheel = love.graphics.newImage('sprites/wheel.png')

  -- sounds
  sounds = {}
  sounds.congrats = love.audio.newSource("sounds/51.wav", "static")
  sounds.clicks = loadClickingSound()
  
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
        justSpun = true
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
        if justSpun then
          gameState = 3
          -- sounds.congrats:play()
          -- determinePrize(radToDeg(wheel.rotation))
          -- justSpun = false
        end
      end
    end
  -- if game is in show prize state
  elseif gameState == 3 then
    showPrizeTimer = showPrizeTimer + dt
    if justSpun then
      sounds.congrats:play()
      determinePrize(radToDeg(wheel.rotation))
      showPrize = true
      justSpun = false
    elseif showPrizeTimer >= showPrizeTimeout then
      enterIdleState()
    end
  -- if game is idle
  else
    wheel.speed = wheel.idleSpeed
  end
  
end -- end love.update

function love.draw()
  love.graphics.draw(bg[1], 0, 0, (3*math.pi)/2, love.graphics.getWidth()/bg[1]:getHeight(), nil, bg[1]:getWidth(), nil) -- shadow
  love.graphics.draw(sprites.wheel, wheel.x, wheel.y, wheel.rotation, love.graphics.getWidth()/sprites.wheel:getHeight(), nil, sprites.wheel:getWidth()/2, sprites.wheel:getWidth()/2)
  love.graphics.draw(bg[2], 0, 0, (3*math.pi)/2, love.graphics.getWidth()/bg[2]:getHeight(), nil, bg[2]:getWidth(), nil) -- background
  love.graphics.draw(bg[3], 0, love.graphics.getHeight(), (3*math.pi)/2, love.graphics.getWidth()/sprites.wheel:getWidth(), nil)

  -- debug messages
  if debugMode then
    love.graphics.print('Speed: ' ..wheel.speed)
    love.graphics.print('Acc: ' ..wheel.acceleration, 0, 20)
    love.graphics.print('Rotation: ' ..wheel.rotation, 0, 40)
    love.graphics.print('Prize: ' ..prize, 300, 0)
    love.graphics.print('Show prize timer: ' ..showPrizeTimer, 600, 0)
  end
end

function love.keypressed(k)
  if k == 'escape' then
     love.event.quit()
  elseif k == 'home' and gameState == 2 then
    enterIdleState()
  end
end

function love.mousepressed( x, y, button, istouch, presses )
  if (button == 1) and ((gameState == 1) or (gameState == 3)) then
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

function resetState()
  wheel.speed = 0
  showPrizeTimer = 0
  showPrize = false
  prize = ''
end

function startGame()
  gameState = 2
  resetState()
end

function enterIdleState()
  gameState = 1
  resetState()
end

function loadClickingSound()
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
-- Sea Shell Seeking

function love.load()
  --image = love.graphics.newImage("cake.jpg")
  love.graphics.setNewFont(14)
  love.graphics.setColor(0,0,0)
  love.graphics.setBackgroundColor(220,240,250)
  -- stage
  stage = {}
  stage.width = love.graphics.getWidth()
  stage.height = love.graphics.getHeight() 
  -- actions
  f_down = false
  r_down = false
  sft_down = false
  spc_down = false
  -- player
  player = {}
  player.radius = 15
  player.x = (800 / 2) - (player.radius / 2)
  player.y = (600 / 2) - (player.radius / 2)
  player.speed = 3
  player.health = 5
  -- enemy
  enemies = {}
  enemy_speed = .5
  enemy_hispeed = 3
  for i=1,3 do
    enemies[i] = {}
    enemies[i].x = math.random(10, stage.width - 10)
    enemies[i].y = math.random(10, stage.height - 10)
    enemies[i].speed = enemy_speed
  end
  -- loot
  loot = {}
  for i=1,6 do
    loot[i] = {}
    loot[i].x = math.random(10, stage.width - 10)
    loot[i].y = math.random(10, stage.height - 10)
  end
end

function love.update(dt)
  --if gameIsPaused then return end
  player_walk()
  enemies_walk()
end

function love.draw()
  love.graphics.print("w a s d to walk, r f sft spc to do things", 10, 10)
  love.graphics.circle('fill', player.x, player.y, player.radius, 100 )
  for k,v in pairs(enemies) do
    love.graphics.rectangle("fill", v.x, v.y, 20, 20)
  end
  for k,v in pairs(loot) do
    love.graphics.circle('line', v.x, v.y, 10, 100)
  end
end

function love.keypressed(key)
  if key == ' ' then
    spc_down = true
  end
end

function love.keyreleased(key)
  if key == ' ' then
    spc_down = false
  end
end

function player_walk()
  if love.keyboard.isDown('w') then
    player.y = player.y +(-1 * player.speed)
    if player.y < 0 then
      player.y = 0
    end
  elseif love.keyboard.isDown('s') then
    player.y = player.y +(1 * player.speed)
    if player.y > stage.height then
      player.y = stage.height
    end
  end
  if love.keyboard.isDown('a') then
    player.x = player.x +(-1 * player.speed)
    if player.x < 0 then
      player.x = 0
    end
  elseif love.keyboard.isDown('d') then
    player.x = player.x +(1 * player.speed)
    if player.x > stage.width then
      player.x = stage.width
    end
  end
end

function enemies_walk()
  for k,v in pairs(enemies) do
    if v.x > player.x then
      if v.x - player.x < 10 then
        v.speed = enemy_hispeed
      else
        v.speed = enemy_speed
      end
      v.x = v.x + (-1 * v.speed)
    elseif v.x < player.x then
      if player.x - v.x < 10 then
        v.speed = enemy_hispeed
      else
        v.speed = enemy_speed
      end
      v.x = v.x + (1 * v.speed)
    end

    if v.y > player.y then
      if v.y - player.y < 10 then
        v.speed = enemy_hispeed
      else
        v.speed = enemy_speed
      end
      v.y = v.y + (-1 * v.speed)
    elseif v.y < player.y then
      if player.y - v.y < 10 then
        v.speed = enemy_hispeed
      else
        v.speed = enemy_speed
      end
      v.y = v.y + (1 * v.speed)
    end
  end
end

-- pause game if focus is lost
--function love.focus(f) gameIsPaused = not f end

function love.quit()
  print("Thanks for playing! Come back soon!")
end
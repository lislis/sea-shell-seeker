-- Sea Shell Seeking

function love.load()

  love.graphics.setNewFont(14)
  -- our tiles
  tile = {}
  for i=1,3 do -- change 3 to the number of tile images minus 1.
    tile[i] = love.graphics.newImage( "graphics/tile_"..i..".png" )
  end
  -- map variables
  map_w = 15
  map_h = 10
  map_x = 0
  map_y = 0
  map_offset_x = -48
  map_offset_y = -48
  tile_w = 48
  tile_h = 48
  map={
    { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
    { 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3},
    { 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
  }
  -- stage
  stage = {}
  stage.width = love.graphics.getWidth()
  stage.height = love.graphics.getHeight() 
  -- actions
  -- f_down = false
  -- r_down = false
  -- sft_down = false
  -- spc_down = false
  -- player
  player = {}
  player.radius = 15
  player.x = (800 / 2) - (player.radius / 2)
  player.y = (600 / 2) - (player.radius / 2)
  player.speed = 2
  player.health = 5
  player.ability = false
  -- enemy
  enemies = {}
  enemy_speed = 0.7
  enemy_hispeed = 1.4
  enemy_image = love.graphics.newImage("graphics/enemy.png")
  enemy_count = 1
  enemy_w = 36
  for i=1, enemy_count do
    enemies[i] = {}
    enemies[i].x = math.random(10, stage.width - 10)
    enemies[i].y = math.random(10, stage.height - 10)
    enemies[i].speed = enemy_speed
  end
  -- shell
  shell = {}
  shell.image = love.graphics.newImage("graphics/shell.png")
  shell.active = true
  shell.start_time = 0
  shell.delta_time = 0
  shell.time_till_respawn = 2
  shell.x = math.random(10, stage.width - 10)
  shell.y = math.random(10, stage.height - 10)
  shell.r = math.random(0, 360)
  shell.w = 36
end

function love.update(dt)
  --if gameIsPaused then return end
  collide_player_shell()
  collide_enemy_shell()
  player_walk()
  enemies_walk()

  if enemy_count == 0 then
    print("you win")
  end
end

function love.draw()
  draw_map()
  draw_shell()
  draw_score()
  draw_enemies()
  draw_player()
end

-- basic "collision" detection
-- pass in tables with coordinates
function distance(pt1, pt2)
  return math.sqrt((pt1[1] - pt2[1]) ^ 2 + (pt1[2] - pt2[2]) ^2)
end

function spawn_enemy()
  enemies[enemy_count] = {}
  enemies[enemy_count].x = math.random(10, stage.width - 10)
  enemies[enemy_count].y = math.random(10, stage.height - 10)
  enemies[enemy_count].speed = enemy_speed
end

function collide_enemy_player(k, v)
  local temp_p = { player.x, player.y }
  local temp_e = { v.x, v.y }
  if distance(temp_p, temp_e) < enemy_w/ 2 then
    if player_kills_enemy() then
      table.remove(enemies, k)
      enemy_count = enemy_count - 1
    else
      print("game over")
    end
  end
end

function player_kills_enemy()
  if player.ability == true then
    player.ability = false
    return true
  else
    return false
  end
end

function collide_enemy_shell()
  if shell.active == true then
    local temp_s = { shell.x, shell.y }
    for k,v in pairs(enemies) do
      local temp_e = { v.x, v.y }
      if distance(temp_s, temp_e) < shell.w then
        shell.active = false
        shell.start_time = love.timer.getTime()
        enemy_count = enemy_count + 1
        spawn_enemy()
      end
    end
  end
end

function collide_player_shell()
  if shell.active == true then
    local temp_p = { player.x, player.y }
    local temp_s = { shell.x, shell.y }
    if distance(temp_p, temp_s) < shell.w then
      shell.active = false
      shell.start_time = love.timer.getTime()
      player.ability = true
    end
  else
    shell.delta_time = love.timer.getTime()
    if shell.delta_time - shell.start_time >= shell.time_till_respawn then
      spawn_shell()
      shell.active = true
    end
  end
end

function player_walk()
  if love.keyboard.isDown('up') then
    player.y = player.y +(-1 * player.speed)
    if player.y < 0 then
      player.y = 0
    end
  elseif love.keyboard.isDown('down') then
    player.y = player.y +(1 * player.speed)
    if player.y > stage.height then
      player.y = stage.height
    end
  end
  if love.keyboard.isDown('left') then
    player.x = player.x +(-1 * player.speed)
    if player.x < 0 then
      player.x = 0
    end
  elseif love.keyboard.isDown('right') then
    player.x = player.x +(1 * player.speed)
    if player.x > stage.width then
      player.x = stage.width
    end
  end
end

function collide_enemy_enemy()
  print("collide!")
end

function enemy_target()
  if shell.active == true then
    return shell
  else
    return player
  end
end

function enemies_walk()
  local target = enemy_target()
  
  for k,v in pairs(enemies) do
    -- set range in which enemies accelerate
    local highspeed_range = math.random(10, 50)
    -- implement acceleration
    if v.x - target.x < highspeed_range then
      v.speed = enemy_hispeed
    else
      v.speed = enemy_speed
    end
    if v.y - target.y < highspeed_range then
      v.speed = enemy_hispeed
    else
      v.speed = enemy_speed
    end

    if v.x > target.x then
      v.x = v.x + (-1 * v.speed)
    elseif v.x < target.x then
      v.x = v.x + (1 * v.speed)
    end

    if v.y > target.y then
      v.y = v.y + (-1 * v.speed)
    elseif v.y < target.y then
      if target.y - v.y < highspeed_range then
        v.speed = enemy_hispeed
      else
        v.speed = enemy_speed
      end
      v.y = v.y + (1 * v.speed)
    end

    collide_enemy_player(k, v)

  end
end

function draw_map()
   for y=1, map_h do
      for x=1, map_w do
         love.graphics.draw(
            tile[map[y+map_y][x+map_x]],
            (x*tile_w)+map_offset_x,
            (y*tile_h)+map_offset_y )
      end
   end
end
function draw_player()
  love.graphics.circle('fill', player.x, player.y, player.radius, 100 )
end
function draw_shell()
  if shell.active == true then
    love.graphics.draw(shell.image, shell.x, shell.y, shell.r)
  end
end
function draw_score()
  love.graphics.print("evil octo count: " ..enemy_count , 10, 10)
  local s = player.ability and "true" or "false"
  love.graphics.print("octo kill ability: " ..s , 10, 30)
end
function draw_enemies()
  for k,v in pairs(enemies) do
    love.graphics.draw(enemy_image, v.x, v.y)
  end
end
function spawn_shell()
  shell.x = math.random(10, stage.width - 10)
  shell.y = math.random(10, stage.height - 10)
  shell.r = math.random(0, 360)
end

-- pause game if focus is lost
--function love.focus(f) gameIsPaused = not f end

function love.quit()
  print("Thanks for playing! Come back soon!")
end
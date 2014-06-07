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
  -- shell
  shell = {}
  shell.active = true
  shell.time_till_respawn = 2000
  shell.x = math.random(10, stage.width - 10)
  shell.y = math.random(10, stage.height - 10)
end

function love.update(dt)
  --if gameIsPaused then return end
  player_walk()
  --enemies_walk()
end

function love.draw()
  draw_map()
  draw_player()
  draw_shell()
  --for k,v in pairs(enemies) do
    --love.graphics.rectangle("fill", v.x, v.y, 20, 20)
  --end
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
  love.graphics.draw()
end

-- pause game if focus is lost
--function love.focus(f) gameIsPaused = not f end

function love.quit()
  print("Thanks for playing! Come back soon!")
end
-- player controls
-- wasd

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

button = {}

function spawn_button(x, y, text, id)
  table.insert(button, { x = x, y = y, text = text, id = id })
end

function draw_button()
  for i, v in ipairs(button) do
    love.graphics.setColor(38, 153, 250)
    love.graphics.setFont(font, 30)
    love.graphics.print(v.text, v.x, v.y)
  end
end

function click_button(x, y)
  for i, v in ipairs(button) do
    if x > v.x and
    x < v.x + font:getWidth(v.text) and
    y > v.y and
    y < v.y + font:getHeight() then
      if v.id == 'start' then
        current_state = 'main'
      elseif v.id == 'credits' then
        current_state = 'credits'
      elseif v.id == 'exit' then
        love.event.push('quit')
      end
    end
  end
end

function click_credit_button(x, y)
  local btn = {}
  btn.x = 50
  btn.y = 300
  if x > btn.x and
  x < btn.x + 300 and
  y > btn.y and
  y < btn.y + font:getHeight() then
      current_state = 'start'
  end
end

function draw_credit_button()
  love.graphics.setColor(38, 153, 250)
  love.graphics.print("back to menu", 50, 300)
end


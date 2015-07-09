 
isAlive = true

local Quads, tileset --Player tileset

function loadPlayer(hero)


end

function drawPlayer(hero)
    if isAlive then
       love.graphics.draw(hero.img, hero.x, hero.y)
    end
end

function movePlayer(hero, dt)
   
  if love.keyboard.isDown('left', 'a') then
        if hero.x > 0  then
        hero.x = hero.x - (hero.speed*dt)
        end
    elseif love.keyboard.isDown('right', 'd') then
            hero.x = hero.x + (hero.speed*dt)
  elseif love.keyboard.isDown('up', 'w') then
     if hero.y > 0 then
         hero.y = hero.y - (hero.speed*dt)
     end
  elseif love.keyboard.isDown('down', 's') then
      if hero.y < (love.graphics.getHeight() - hero.img:getHeight()) then
          hero.y = hero.y + (hero.speed*dt)
      end
  end
end


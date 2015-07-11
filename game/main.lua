require 'player'
require 'animated-sprite'
require 'collision'
local sti = require "sti"

local x, y = 0,0


function love.load(arg) 
    
  map = sti.new("/maps/map01")
  startCollision(map)
  hero = GetInstance('sprites/hero.lua')
  background = love.graphics.newImage("/assets/bg.png")
  spriteLayer = createSpriteLayer(map, hero, world)


end
function love.update(dt)
    world:update(dt)
    map:update(dt)
    movePlayer(hero, dt)
    UpdateInstance(hero, dt)

end

function love.draw(dt)
    love.graphics.draw(background, 0, 0)
    map:drawWorldCollision(collision)
    DrawInstance(spriteLayer, spriteLayer.sprite.x, spriteLayer.sprite.y  )



    --Track mouse and Player position
    getMouse()
    love.graphics.print("Player Position: (" ..spriteLayer.sprite.x .. "," .. spriteLayer.sprite.y .. ")", 50,70)
end

function getMouse()
 x = love.mouse.getX()
 y = love.mouse.getY()
     love.graphics.print("Mouse Position: (" ..x.. "," ..y..")", 50,50)
end
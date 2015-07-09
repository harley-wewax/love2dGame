require 'player'
require 'animated-sprite'

local loader = require "AdvTiledLoader/Loader"
loader.path = "maps/"
local x, y = 0,0

function love.load(arg) 
    
  map = loader.load("map01.tmx")
  hero = GetInstance('sprites/hero.lua')
  background = love.graphics.newImage("/assets/bg.png")


end
function love.update(dt)
    UpdateInstance(hero, dt)
    doPlayer(hero, dt)
 x = love.mouse.getX()
 y = love.mouse.getY()
end

function love.draw(dt)
    love.graphics.draw(background, 0, 0)
    map:draw()
    DrawInstance(hero, hero.x, hero.y  )
    --Track mouse and Player position
    love.graphics.print("Mouse Position: (" ..x.. "," ..y..")", 50,50)
    love.graphics.print("Player Position: (" .. hero.sprite.x .. "," .. hero.sprite.y .. ")", 50,70)
end

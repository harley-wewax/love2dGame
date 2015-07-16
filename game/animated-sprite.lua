--[[
    AnimatedSprite.lua - 2014
    
    Copyright Dejaime Antônio de Oliveira Neto, 2014
    
    Released under the MIT license.
    Visit for more information:
    http://opensource.org/licenses/MIT
]]
print("AnimatedSprite.lua loaded")
local sti = require "sti"

local ManagerVersion = 1.0

sprite_bank = {} --Map with all the sprite definitions
image_bank = {} --Contains all images that were already loaded


--Actor Physics Variables
gravity = 9.8
maxFallSpeed = 3.0


function LoadSprite (sprite_def)

	if sprite_def == nil then return nil end
	

	--Load the sprite definition file to ensure it exists
	local definition_file = loadfile(sprite_def)

	--If the file doesn't exist or has syntax errors, it'll be nil.
	if definition_file == nil then
		--Spit out a warning and return nil.
		print("Attempt to load an invalid file (inexistent or syntax errors?): "..sprite_def)
		return nil
	end

	--[[Loading the sprite definition as an entry in our table.

		We can execute the file by calling it as a function
			with these () as we loaded with loadfile previously.
		If we used dofile with an invalid file path our program
			would crash. 
		At this point, executing the file will load all the necessary
			information in a single call. There's no need to parse
			this of serialization.
	]]
	local old_sprite = sprite_bank [sprite_def]
	sprite_bank [sprite_def] = definition_file()
	
	--Check the version to verify if it is compatible with this one.
	if sprite_bank[sprite_def].serialization_version ~= ManagerVersion then
		print("Attempt to load file with incompatible versions: "..sprite_def)
		print("Expected version "..ManagerVersion..", got version "
				..sprite_bank[sprite_def].serialization_version.." .")
		sprite_bank[sprite_def] = old_sprite -- Undo the changes due to error
		-- Return old value (nil if not previously loaded)
		return sprite_bank[sprite_def]
	end
	
	
	--All we need to do now is check if the image exist
	--	and load it.
	
	--Storing the path to the image in a variable (to add readability)
	local sprite_sheet = sprite_bank[sprite_def].sprite_sheet

	--Load the image.
	local old_image = image_bank [sprite_sheet]
	image_bank [sprite_sheet] = love.graphics.newImage(sprite_sheet)
		
	--Check if the loaded image is valid.
	if image_bank[sprite_sheet] == nil then
		-- Invalid image, reverting all changes
		image_bank [sprite_sheet] = old_image	-- Revert image
		sprite_bank[sprite_def] = old_sprite	-- Revert sprite
		
		print("Failed loading sprite "..sprite_def..", invalid image path ( "
				..sprite_sheet.." ).")
	end
	
	return sprite_bank [sprite_def]
end

function GetInstance (sprite_def)

	if sprite_def == nil then return nil end -- invalid use
	
	if sprite_bank[sprite_def] == nil then
		--Sprite not loaded attempting to load; abort on failure.
		if LoadSprite (sprite_def) == nil then return nil end
	end
	
	--All set, return the default table.
	return {
		sprite = sprite_bank[sprite_def], --Sprite reference
		--Sets the animation as the first one in the list.
		curr_anim = sprite_bank[sprite_def].animations_names[1],
		curr_frame = 1,
		elapsed_time = 0,
		size_scale = 1,
		time_scale = 1,
		rotation = 0,
		flip_h = 1,
		flip_v = 1
	}
end

function UpdateInstance(spr, dt) --Handles Sprite Instances
	--Increment the internal counter.
	spr.elapsed_time = spr.elapsed_time + dt

	--We check we need to change the current frame.
	if spr.elapsed_time > spr.sprite.frame_duration * spr.time_scale then
		--Check if we are at the last frame.
		--	# returns the total entries of an array.
		if spr.curr_frame <	#spr.sprite.animations[spr.curr_anim] then
			-- Not on last frame, increment.
			spr.curr_frame = spr.curr_frame + 1
		else
			-- Last frame, loop back to 1.
			spr.curr_frame = 1
		end
		-- Reset internal counter on frame change.
		spr.elapsed_time = 0
	end
end


function updateSpriteLayer(spr) --Update image specific information regarding sprite to display animations

  spriteLayer.sprite.frame = spr.sprite.animations[spr.curr_anim][spr.curr_frame]
  spriteLayer.sprite.flip_h = spr.flip_h
  spriteLayer.sprite.flip_v = spr.flip_v

end

function DrawInstance (spr) --Updated to handle Physics

  local image = spr.sprite.image
  local x,y = math.floor(spr.sprite.x), math.floor(spr.sprite.y)
    
	love.graphics.draw (
		image_bank[spr.sprite.image], --Holds path to image
		spr.sprite.frame,
    x,
    y,
    0,
    spr.sprite.flip_h,
    spr.sprite.flip_v,
    spr.sprite.width/2, -- Horizontal Offset to draw Sprite in center of body
    spr.sprite.height/2 --Vertical Offset
	)

end


function createSpriteLayer(map, hero, world) --Recieves map object in main.lua

  map:addCustomLayer("SpriteLayer", 4)
  
    local spriteLayer = map.layers["SpriteLayer"] -- Global spriteLayer
  
  spriteLayer.sprite = {
    image = hero.sprite.sprite_sheet, --Image referenced for drawing
    frame = hero.sprite.animations[hero.curr_anim][hero.curr_frame], --Can also try giving curr. frame
    x = hero.sprite.x,
    y = hero.sprite.y,
    width = hero.sprite.width,
    height = hero.sprite.height,
    flip_h = 0,
    flip_v = 0
  }
  
  --Create Physical Bodies
    spriteLayer.sprite.body = love.physics.newBody(world, spriteLayer.sprite.x/2, spriteLayer.sprite.y/2, "dynamic")
    --Create shape from frame height and width
    spriteLayer.sprite.shape = love.physics.newRectangleShape(72, 97)
    spriteLayer.sprite.fixture = love.physics.newFixture(spriteLayer.sprite.body, spriteLayer.sprite.shape)
      
      --Give properties to the player body
    spriteLayer.sprite.body:setLinearDamping(.005)
    spriteLayer.sprite.body:setFixedRotation(true) --We dont need the player flipping around n shit!
        
  
    return spriteLayer
end

function movePlayer(hero, dt)

  local sprite = map.layers["SpriteLayer"].sprite
  local down = love.keyboard.isDown
    
  local x, y = 0, 0
  
  if down("w") or down("up") then 
  y = y - 8000  
  --sprite.body:setLinearVelocity(0,0)
  elseif down("a") or down("left")  then 
  x = x - 2000
  hero.curr_anim = hero.sprite.animations_names[2] -- Set Sprite to run must use sprite object not sprite layer object
  hero.flip_h = -1
  hero.flip_v = 1 
  elseif down("d") or down("right") then 
    hero.curr_anim = hero.sprite.animations_names[2] 
    hero.flip_h = 1
    hero.flip_v = 1       
    x = x + 2000
  else
  hero.curr_anim = hero.sprite.animations_names[1]
  hero.curr_frame = 1
  --spriteLayer.sprite.body:setLinearVelocity(0,0) --Playing around w/ Linear Velocity to fix movement
 -- spriteLayer.sprite.body:setInertia(0)
  x = 0
  y = 0
  end
  
  sprite.body:applyForce(x, y)
  sprite.x, sprite.y = sprite.body:getWorldCenter()

end


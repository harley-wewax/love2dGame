print("Hero.lua loaded")

require "love.graphics"


local image_w = 792 --This info can be accessed with a Löve2D call
local image_h = 97 --		after the image has been loaded. I'm creating these for readability.


return {
	serialization_version = 1.0, -- The version of this serialization process

	sprite_sheet = "assets/player.png", -- The path to the spritesheet
	sprite_name = "hero", -- The name of the sprite

	frame_duration = 0.10,
        --Player Variables used for Physics/Tile Collision Detection
        x = 80,  --xpos
        y=325, --ypos
        width = 72,
        height = 97,
        speed = 100,
        offset = 0,
        onGround,
        thinkTime,
        dirX = 0,
        dirY = 0,
	
	
	--This will work as an array.
	--So, these names can be accessed with numeric indexes starting at 1.
	--If you use < #sprite.animations_names > it will return the total number
	--		of animations in in here.
	animations_names = {
                "idle",
                "run"
	},

	--The list with all the frames mapped to their respective animations
	--	each one can be accessed like this:
	--	mySprite.animations["idle"][1], or even
	animations = {
		
            idle = {
             
                love.graphics.newQuad(505, 1, 71, 96, image_w, image_h)
            },
            
            run = {
                
                love.graphics.newQuad(1,1, 71, 96, image_w, image_h),
                love.graphics.newQuad(73, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(145,1, 71, 96, image_w, image_h),
                love.graphics.newQuad(217, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(289, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(361, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(433, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(505, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(577, 1, 71, 96, image_w, image_h),
                love.graphics.newQuad(649,1, 71, 96, image_w, image_h),
                love.graphics.newQuad(721,1, 71, 96, image_w, image_h),

            }

		
	} --animations

} --return (end of file)


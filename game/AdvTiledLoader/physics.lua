
objects = {}
 

function createActor(image_bank, sprite_bank, sprite_def, world) -- Creates object 

    actor = sprite_def.name
    
    objects.actor = {} -- Create Actor Table
    objects.actor.body = love.physics.newBody(world, sprite_def.sprite.x + 22, sprite_def.sprite.y + 22)
    objects.actor.image = image_bank[sprite_def.sprite.sprite_sheet]
    objects.actor.shape = love.physics.newRectangleShape(46,46)
    objects.actor.fixture = love.physics.newFixture(objects.actor.body, objects.actor.shape)
    
    
  
    
end

function moveActor(sprite_def, world) -- Moves Actor
   
    if love.keyboard.isDown("right") then
       objects.actor.body:applyForce(400, 2)
    end
    
end
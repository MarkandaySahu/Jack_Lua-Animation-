_G.love = require("love")--importing love module
function love.load()
   Jack = {
    x=0,
    y=0,
    sprite = love.graphics.newImage("spritesheet.png"),
    animation={
        direction="right",
        idle=false,
        frame=1,
        max_frames=8,
        speed=50,
        timer=0.1
    }
   }
   sprite_width,sprite_height=5352,569
   quad_width=669
   quad_height=sprite_height
   quads={}
    for i = 1, Jack.animation.max_frames do
        quads[i]=love.graphics.newQuad(quad_width*(i-1),0,quad_width,quad_height,sprite_width,sprite_height)
    end
end

function love.update(dt)
    if love.keyboard.isDown("d") then
        Jack.animation.idle=false
        Jack.animation.direction="right"
    elseif love.keyboard.isDown("a") then
        Jack.animation.idle=false
        Jack.animation.direction="left"
    else
        Jack.animation.idle=true
        Jack.animation.frame=1
    end
  if not Jack.animation.idle then
    Jack.animation.timer = Jack.animation.timer + dt
    if Jack.animation.timer > 0.2 then
        Jack.animation.timer = 0.1--reset time to initial time
        Jack.animation.frame = Jack.animation.frame + 1--change quad frame
        if Jack.animation.direction=="right" then
            Jack.x = Jack.x + Jack.animation.speed
        elseif Jack.animation.direction=="left" then
            Jack.x = Jack.x - Jack.animation.speed
        end
        if Jack.animation.frame > Jack.animation.max_frames then
            Jack.animation.frame = 1--reset frame to initial state
        end
    end
  end
end
function love.draw()
    love.graphics.scale(0.3)--this will scale down every rendered graphics.
    if Jack.animation.direction=="right" then
        love.graphics.draw(Jack.sprite,quads[Jack.animation.frame],Jack.x,Jack.y)
    elseif Jack.animation.direction=="left" then
        love.graphics.draw(Jack.sprite,quads[Jack.animation.frame],Jack.x,Jack.y,
         0,-1,1,-- 0 rotation, then the X and Y scales
         quad_width,0-- the origin offsets relative to 0,0 on the sprite
      )--this will make our quad sprites go flipped
    end
end

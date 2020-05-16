Bird = Class{}

BIRD_IMAGE = love.graphics.newImage('images/bird.png')

local GRAVITY = 20

function Bird:init()
    self.image = BIRD_IMAGE
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()
    
    self.dy = 0
    
    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = (VIRTUAL_HEIGHT/2) - (self.image:getHeight()/2)
end

function Bird:update(dt)
    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') or love.mouse.wasPressed(1) then
        sounds['jump']:play()
        self.dy = -5
    end

    self.y = self.y + self.dy
end

function Bird:collides(pipe)
    
    if (self.x + 2) + (self.width - 4) >= pipe.x and (self.x + 2) <= pipe.x + pipe.width then
    
        if(self.y + 2) + (self.height - 4) >= pipe.y and (self.y + 2) <= pipe.y + pipe.height then
           return true
    
        end
    
    end
end

function Bird:render()
    love.graphics.draw(self.image , self.x , self.y)
end    
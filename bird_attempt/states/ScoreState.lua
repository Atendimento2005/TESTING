ScoreState = Class{__includes = BaseState}

function ScoreState:enter(params)
    self.score = params.score
    self.gold = love.graphics.newImage('images/gold.png')
    self.silver = love.graphics.newImage('images/silver.png')-- Sprites for the medals
    self.bronze = love.graphics.newImage('images/bronze.png')
end

function ScoreState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end
end

function ScoreState:render()
    love.graphics.setFont(flappyFont)
    love.graphics.printf('GAME OVER!', 0, 64, VIRTUAL_WIDTH, 'center')
 
    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- logic to determine the medal according to points scored
    if self.score >= 8 and self.score < 16 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf('You got a Bronze Medal!', 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(self.bronze, (VIRTUAL_WIDTH/2)-32, 130, 0, 2, 2)
    end
    
    if self.score >=16 and self.score < 24 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf('You got a Silver Medal!', 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(self.silver, (VIRTUAL_WIDTH/2)-32, 130, 0, 2, 2)
    end     
    
    if self.score >= 24 then
        love.graphics.setFont(mediumFont)
        love.graphics.printf('You got a Gold Medal!', 0, 120, VIRTUAL_WIDTH, 'center')
        love.graphics.draw(self.gold, (VIRTUAL_WIDTH/2)-32, 130, 0, 2 ,2)
    end

    love.graphics.printf('Press Enter to Play Again!', 0, 190, VIRTUAL_WIDTH, 'center')
end
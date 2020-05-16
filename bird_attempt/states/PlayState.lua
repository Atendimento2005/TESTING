PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_HEIGHT = PIPE_IMAGE:getHeight()
PIPE_WIDTH = PIPE_IMAGE:getWidth()

BIRD_HEIGHT = BIRD_IMAGE:getHeight()
BIRD_WIDTH = BIRD_IMAGE:getWidth()

function PlayState:init()
    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0 
    self.score = 0
    self.lastY = -PIPE_HEIGHT + math.random(50) + 20 
    pipeSpawn = math.random(175,275)
end

function PlayState:update(dt)

    if love.keyboard.wasPressed('p') then --to pause the game
        if SCROLLING then
            SCROLLING = false
            sounds['music']:pause()
            sounds['pause']:play()
        end
        if not SCROLLING then
            SCROLLING = true
            sounds['pause']:play()   
        end
    end

    if SCROLLING then

        sounds['music']:resume()
         
        --dt multiplied to 100 to add more variation in spawn time

        self.timer = (self.timer + (dt*100))*1.004 --[[ multiplier to reduce distance between pipes 
                                                        as the game progresses thus making it harder]]--

        if self.timer > pipeSpawn then

            y = math.max(-PIPE_HEIGHT + 60,
                math.min(self.lastY + math.random(20 , -20) , VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))

            self.lastY = y 

            table.insert(self.pipePairs, PipePair(y))
            self.timer = 0

            pipeSpawn = math.random(175,275)
        end

        for k , pair in pairs(self.pipePairs) do   
            
            if not pair.scored then
                if pair.x + PIPE_WIDTH < self.bird.x then
                    self.score = self.score + 1
                    sounds['score']:play()
                    pair.scored = true
                end
            end

            pair:update(dt)
        end  
        
        for k , pair in pairs(self.pipePairs) do
            if pair.remove then
                table.remove(pipePairs , k)
            end 
        end

        self.bird:update(dt)

        for k , pair in pairs(self.pipePairs) do
            for l , pipe in pairs(pair.pipes) do 
                if self.bird:collides(pipe) then
                    sounds['hurt']:play()
                    gStateMachine:change('score' , {
                        score = self.score
                    })
                end
            end      
        end

        if (self.bird.y + 2) + (BIRD_HEIGHT-4) >= VIRTUAL_HEIGHT - 16 or self.bird.y + 2 <= 0 then
            sounds['hurt']:play()
            gStateMachine:change('score' , {
                score = self.score
            })
        end
    end
end

function PlayState:render()
    for k , pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()

    if SCROLLING then
        love.graphics.setFont(flappyFont)
        love.graphics.print('Score: ' .. tostring(self.score), 8, 8)
    end
    if not SCROLLING then
        love.graphics.setFont(flappyFont)
        love.graphics.printf('Score: '.. tostring(self.score), 0, 64, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(hugeFont)
        love.graphics.printf('||', 0, 110, VIRTUAL_WIDTH, 'center')
        love.graphics.setFont(mediumFont)
        love.graphics.printf('Game Paused!', 0, 180, VIRTUAL_WIDTH, 'center')
        love.graphics.printf('Press P to resume', 0, 200, VIRTUAL_WIDTH, 'center')
    end
    
end

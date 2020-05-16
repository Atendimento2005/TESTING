PipePair = Class{}
function PipePair:init(y)
    self.x = VIRTUAL_WIDTH + 32
    
    self.y = y

    gapHeight = math.random(95,110)

    self.pipes = {
        ['upper'] = Pipe('top' , self.y),
        ['lower'] = Pipe('bottom' , self.y + gapHeight + PIPE_HEIGHT)
    }
    
    self.remove = false

    self.scored = false
end

function PipePair:update(dt)
    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['upper'].x = self.x
        self.pipes['lower'].x = self.x
    else
        self.remove = false
    end
end

function PipePair:render()
    for k , pipe in pairs(self.pipes) do
        pipe:render()
    end
end
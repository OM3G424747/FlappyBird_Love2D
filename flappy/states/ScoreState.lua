--[[
    ScoreState Class
    Author: Colton Ogden
    Edited By: Chris Joubert
    cogden@cs50.harvard.edu

    A simple state used to display the player's score before they
    transition back into the play state. Transitioned to from the
    PlayState when they collide with a Pipe.
]]

ScoreState = Class{__includes = BaseState}

--[[
    When we enter the score state, we expect to receive the score
    from the play state so we know what to render to the State.
]]
function ScoreState:enter(params)
    self.score = params.score
end

function ScoreState:update(dt)
    -- go back to play if enter is pressed
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('countdown')
    end

    -- prevents pausing in score state
    if IS_PAUSED then
        IS_PAUSED = false
    end

end

function ScoreState:render()
    -- simply render the score to the middle of the screen
    love.graphics.setFont(flappyFont)
    love.graphics.printf('Oof! You lost!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Score: ' .. tostring(self.score), 0, 100, VIRTUAL_WIDTH, 'center')

    -- sets initial trophy image as bronze, then checks the score for the following conditions
    -- over 30 gets silver
    -- over 60 gets gold
    local trophy =  love.graphics.newImage('bronze_trophy.png')

    if self.score > 10 then
        trophy =  love.graphics.newImage('silver_trophy.png')

    elseif self.score > 20 then
        trophy =  love.graphics.newImage('gold_trophy.png')
    end
    
    -- displays trophy below the player's score
    love.graphics.draw(trophy, 230, 120)

    love.graphics.printf('Press Enter to Play Again!', 0, 160, VIRTUAL_WIDTH, 'center')
end
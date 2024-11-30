local composer = require("composer")
local audio = require("audio") 

local scene = composer.newScene()

local MARGIN = 40
local isSoundOn = true 


local backgroundSound

function scene:create(event)
    local sceneGroup = self.view

    
    local background = display.newImageRect(sceneGroup, "assets/capa/capa.png", 768, 1024)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    
    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function(event)
        composer.gotoScene("pagina2", {
            effect = "fade",
            time = 500
        })
    end)

    
    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width / 2 - MARGIN - 500
    som.y = display.contentHeight - som.height / 2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width / 2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height / 2 - MARGIN
    semsom.isVisible = false 

    
    backgroundSound = audio.loadStream("audios/audio1.mp3")

    
    local function toggleSound(event)
        if som.isVisible then
            som.isVisible = false
            semsom.isVisible = true
            audio.stop() 
            print("Som desligado")
        else
            som.isVisible = true
            semsom.isVisible = false
            audio.play(backgroundSound, { loops = -1 }) 
            print("Som ligado")
        end
        return true 
    end

    
    som:addEventListener("tap", toggleSound)
    semsom:addEventListener("tap", toggleSound)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
       
    elseif (phase == "did") then
       
        if isSoundOn then
            audio.play(backgroundSound, { loops = -1 }) 
        end
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        
        audio.stop() 
    elseif (phase == "did") then
     
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    
    if backgroundSound then
        audio.dispose(backgroundSound) 
        backgroundSound = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

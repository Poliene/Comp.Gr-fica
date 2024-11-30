local composer = require( "composer" )
 
local scene = composer.newScene()
 
local MARGIN = 40
 
function scene:create( event )
    local sceneGroup = self.view

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina6/pagina6.png", 768, 1024)

    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width/2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function (event)
        composer.removeScene("pagina6")
        composer.gotoScene("contracapa", {
            effect = "fade",
            time = 500
        });
        
    end)

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width/2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function (event)
        composer.removeScene("pagina6")
        composer.gotoScene("pagina5", {
            effect = "fade",
            time = 500
        });
        
    end)

    local texto5 = display.newImageRect(sceneGroup, "/assets/texto5/texto5.png", 653, 305)
    texto5.x = display.contentCenterX + 6
    texto5.y = display.contentHeight - 710
    
    local nmr6 = display.newImageRect(sceneGroup, "/assets/nmr6/nmr6.png", 29, 70)
    nmr6.x = display.contentCenterX - 5
    nmr6.y = display.contentHeight - 85

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width/2 - MARGIN - 500
    som.y = display.contentHeight - som.height/2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width/2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height/2 - MARGIN
    semsom.isVisible = false
 
    backgroundSound = audio.loadStream("audio6/audio6.mp3")

    local function toggleSound(event)
        if som.isVisible then
            som.isVisible = false
            semsom.isVisible = true
            print("Som desligado")
        else
            som.isVisible = true
            semsom.isVisible = false
            print("Som ligado")
        end
        return true
    end

    som:addEventListener("tap", toggleSound)
    semsom:addEventListener("tap", toggleSound)

end
 
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then

    end
end
 
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
 
    end
end
 
function scene:destroy( event )
    local sceneGroup = self.view
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
 
return scene

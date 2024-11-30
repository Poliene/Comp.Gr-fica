local composer = require( "composer" )
 
local scene = composer.newScene()
 
local MARGIN = 40
 
function scene:create( event )
    local sceneGroup = self.view

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina3/pagina3.png", 768, 1024)

    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width/2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function (event)
        composer.removeScene("pagina3")
        composer.gotoScene("pagina4", {
            effect = "fade",
            time = 500
        });
        
    end)

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width/2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function (event)
        composer.removeScene("pagina3")
        composer.gotoScene("pagina2", {
            effect = "fade",
            time = 500
        });
        
    end)

    local texto2 = display.newImage(sceneGroup, "/assets/texto2/texto2.png", 287, 492)
    texto2.x = display.contentWidth - 560
    texto2.y = display.contentHeight - 560

    local nmr3 = display.newImage(sceneGroup, "/assets/nmr3/nmr3.png", 29, 70)
    nmr3.x = display.contentWidth - 390
    nmr3.y = display.contentHeight - 85

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width/2 - MARGIN - 500
    som.y = display.contentHeight - som.height/2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width/2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height/2 - MARGIN
    semsom.isVisible = false  

    backgroundSound = audio.loadStream("audio3/audio3.mp3")

    
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

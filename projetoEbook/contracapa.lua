local composer = require( "composer" )
 
local scene = composer.newScene()
 
local MARGIN = 40
 
function scene:create( event )
    local sceneGroup = self.view

    local background = display.newImageRect(sceneGroup, "assets/contracapa/contracapa.png", 768, 1024)

    background.x = display.contentCenterX
    background.y = display.contentCenterY

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width/2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function (event)
        composer.gotoScene("pagina6", {
            effect = "slideRight",
            time = 500
        });
        
    end)

    local vi = display.newImage(sceneGroup, "/assets/botao/inicio.png")
    vi.x = display.contentWidth - vi.width/2 - MARGIN
    vi.y = display.contentHeight - 940

    vi:addEventListener("tap", function (event)
        composer.gotoScene("capa", {
            effect = "fade",
            time = 500
        });
        
    end)

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width/2 - MARGIN - 500
    som.y = display.contentHeight - som.height/2 - MARGIN
    
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
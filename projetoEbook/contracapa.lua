local composer = require( "composer" )
 
local scene = composer.newScene()
 
local MARGIN = 40
 
function scene:create( event )
    local sceneGroup = self.view

    audio.setVolume(1)

    local testSound = audio.loadSound("assets/audios/audio7.mp3")
    if testSound then
        print("Som de teste carregado com sucesso!")
        audio.play(testSound)
    else
        print("Erro: Não foi possível carregar o som de teste.")
    end

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

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width/2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height/2 - MARGIN
    semsom.isVisible = false  -- Inicialmente invisível
    
    backgroundSound = audio.loadStream("audio7/audio7.mp3")

    local function toggleSound()
        if isSoundOn then
            audio.stop()
            som.isVisible = false
            semsom.isVisible = true
            isSoundOn = false
            print("Som desligado.")
        else
            if not backgroundSoundHandle then
                backgroundSoundHandle = audio.play(backgroundSound, { loops = -1 })
            end
            if clickSound then
                audio.play(clickSound)
            end
            som.isVisible = true
            semsom.isVisible = false
            isSoundOn = true
            print("Som ligado.")
        end
    end

    som:addEventListener("tap", toggleSound)
    semsom:addEventListener("tap", toggleSound)

    clickSound = audio.loadSound("assets/audios/audio1.mp3")
    if not clickSound then
        print("Erro: Som de clique não foi carregado.")
    end

    backgroundSound = audio.loadStream("assets/audio/background.mp3")
    if not backgroundSound then
        print("Erro: Som de fundo não foi carregado.")
    end
end
 

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
    elseif (phase == "did") then
        if isSoundOn and backgroundSound and not isSoundPlaying then
            backgroundSoundHandle = audio.play(backgroundSound, { loops = -1 })
            isSoundPlaying = true
            print("Som de fundo reproduzido.")
        else
            print("Som de fundo não disponível ou já está tocando.")
        end
    end
end
 
function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        if backgroundSoundHandle then
            audio.stop(backgroundSoundHandle)
            backgroundSoundHandle = nil
            isSoundPlaying = false
            print("Som de fundo parado.")
        end
    elseif (phase == "did") then
    end
end
 
function scene:destroy(event)
    local sceneGroup = self.view

    if backgroundSound then
        audio.dispose(backgroundSound)
        backgroundSound = nil
    end
    if clickSound then
        audio.dispose(clickSound)
        clickSound = nil
    end

    audio.stop()
    print("Todos os recursos de áudio foram liberados.")
end
 
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene

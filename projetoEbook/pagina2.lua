local composer = require("composer")

local scene = composer.newScene()

local MARGIN = 40

function scene:create(event)
    local sceneGroup = self.view

    audio.setVolume(1)

    local testSound = audio.loadSound("assets/audios/audio2.mp3")
    if testSound then
        print("Som de teste carregado com sucesso!")
        audio.play(testSound)
    else
        print("Erro: Não foi possível carregar o som de teste.")
    end

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina2/pagina2.png", 768, 1024)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function(event)
        composer.removeScene("pagina2")
        composer.gotoScene("pagina3", {
            effect = "fade",
            time = 500
        })
    end)

    local casa = display.newImage(sceneGroup, "/assets/casa/casa.png", 356, 356)
    casa.x = display.contentWidth - 435
    casa.y = display.contentHeight - 360

    local destinoX = display.contentCenterX + 180
    local destinoY = display.contentCenterY + 155

    local chuveiroDestinoX = display.contentCenterX - 260
    local chuveiroDestinoY = display.contentHeight - 310

    local cano = display.newImageRect(sceneGroup, "/assets/cano/cano.png", 290, 173)
    cano.x = display.contentCenterX - 260
    cano.y = display.contentCenterY + 70
    cano.isVisible = true

    local textocano = display.newImageRect(sceneGroup, "/assets/textocano/textocano.png", 299, 31)
    textocano.x = display.contentCenterX - 260
    textocano.y = display.contentCenterY + 115

    local encanamento = display.newImageRect(sceneGroup, "/assets/encanamento/encanamento.png", 328, 32)
    encanamento.x = display.contentCenterX + 190
    encanamento.y = display.contentCenterY + 296

    local canolimpo = display.newImageRect(sceneGroup, "/assets/canolimpo/canolimpo.png", 290, 137)
    canolimpo.x = destinoX - 5
    canolimpo.y = destinoY + 10
    canolimpo.isVisible = false

    local chuveirosujo = display.newImageRect(sceneGroup, "/assets/chuveirosujo/chuveirosujo.png", 105, 105)
    chuveirosujo.x = display.contentCenterX - 260
    chuveirosujo.y = display.contentHeight - 280
    chuveirosujo.isVisible = true

    local chuveirolimpo = display.newImageRect(sceneGroup, "/assets/chuveirolimpo/chuveirolimpo.png", 105, 105)
    chuveirolimpo.x = display.contentCenterX - 260
    chuveirolimpo.y = display.contentHeight - 280
    chuveirolimpo.isVisible = false

    local canoSubstituido = false

    local function arrastarCano(event)
        if event.phase == "moved" then
            cano.x = event.x
            cano.y = event.y
        elseif event.phase == "ended" then
            if math.abs(cano.x - destinoX) < 30 and math.abs(cano.y - destinoY) < 120 then
                print("Cano posicionado corretamente!")
                canolimpo.x = destinoX
                canolimpo.y = destinoY + 110
                canolimpo.isVisible = true
                cano.isVisible = false
                chuveirosujo.isVisible = false
                chuveirolimpo.isVisible = true
            else
                print("Cano não foi posicionado corretamente. Retorne para a posição inicial.")
                cano.x = display.contentCenterX - 260
                cano.y = display.contentCenterY + 70
            end
        end
        return true
    end

    cano:addEventListener("touch", arrastarCano)

    local canoesgoto = display.newImageRect(sceneGroup, "/assets/canoesgoto/canoesgoto.png", 268, 152)
    canoesgoto.x = display.contentWidth - 650
    canoesgoto.y = display.contentHeight - 170

    local caixaAgua = display.newImageRect(sceneGroup, "/assets/caixaAgua/caixaAgua.png", 187, 187)
    caixaAgua.x = display.contentCenterX + 310
    caixaAgua.y = display.contentCenterY + 200

    local esgoto = display.newImageRect(sceneGroup, "/assets/esgoto/esgoto.png", 290, 31)
    esgoto.x = display.contentCenterX - 260
    esgoto.y = display.contentHeight - 150

    local texto1 = display.newImageRect(sceneGroup, "/assets/texto1/texto1.png", 653, 255)
    texto1.x = display.contentCenterX - 6
    texto1.y = display.contentHeight - 740

    local dica1 = display.newImageRect(sceneGroup, "/assets/dica1/dica1.png", 328, 54)
    dica1.x = display.contentCenterX + 150
    dica1.y = display.contentHeight - 530

    local nmr2 = display.newImageRect(sceneGroup, "/assets/nmr2/nmr2.png", 29, 70)
    nmr2.x = display.contentCenterX - 10
    nmr2.y = display.contentHeight - 85

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width / 2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function(event)
        composer.removeScene("pagina2")
        composer.gotoScene("capa", {
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

    backgroundSound = audio.loadStream("audios/audio2.mp3")

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

    clickSound = audio.loadSound("assets/audios/audio2.mp3")
    if not clickSound then
        print("Erro: Som de clique não foi carregado.")
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

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

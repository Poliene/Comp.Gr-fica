local composer = require("composer")
local scene = composer.newScene()

local physics = require("physics")
physics.start()
physics.setGravity(0, 0)

local MARGIN = 40
local lixo
local lixeira2

function scene:create(event)
    local sceneGroup = self.view

    audio.setVolume(1)

    local testSound = audio.loadSound("assets/audios/audio3.mp3")
    if testSound then
        print("Som de teste carregado com sucesso!")
        audio.play(testSound)
    else
        print("Erro: Não foi possível carregar o som de teste.")
    end

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina3/pagina3.png", 768, 1024)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function(event)
        composer.removeScene("pagina3")
        composer.gotoScene("pagina4", {
            effect = "fade",
            time = 500
        })
    end)

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width / 2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function(event)
        composer.removeScene("pagina3")
        composer.gotoScene("pagina2", {
            effect = "fade",
            time = 500
        })
    end)

    local texto2 = display.newImage(sceneGroup, "/assets/texto2/texto2.png", 287, 492)
    texto2.x = display.contentWidth - 590
    texto2.y = display.contentHeight - 490

    local rio = display.newImage(sceneGroup, "/assets/cenarioOndas/rio.png", 400, 707)
    rio.x = display.contentWidth - 195
    rio.y = display.contentHeight - 400
    rio.isVisible = false

    local riosujo = display.newImage(sceneGroup, "/assets/cenarioOndas/riosujo.png", 395, 767)
    riosujo.x = display.contentWidth - 220
    riosujo.y = display.contentHeight - 400

    lixo = display.newImage(sceneGroup, "/assets/lixo/lixo.png", 345, 263)
    lixo.x = display.contentWidth - 300
    lixo.y = display.contentHeight - 330
    physics.addBody(lixo, "dynamic", { radius = 20, isSensor = true })
    lixo.id = "lixo"

    lixo2 = display.newImage(sceneGroup, "/assets/lixo/lixo2.png", 345, 263)
    lixo2.x = display.contentWidth - 100
    lixo2.y = display.contentHeight - 330
    physics.addBody(lixo2, "dynamic", { radius = 20, isSensor = true })
    lixo2.id = "lixo2"

    lixo3 = display.newImage(sceneGroup, "/assets/lixo/lixo3.png", 345, 263)
    lixo3.x = display.contentWidth - 208
    lixo3.y = display.contentHeight - 330
    physics.addBody(lixo3, "dynamic", { radius = 20, isSensor = true })
    lixo3.id = "lixo3"

    local dica2 = display.newImage(sceneGroup, "/assets/dica2/dica2.png", 359, 38)
    dica2.x = display.contentWidth - 220
    dica2.y = display.contentHeight - 700

    lixeira2 = display.newImage(sceneGroup, "/assets/lixeira/lixeira2.png", 132, 132)
    lixeira2.x = display.contentWidth - 200
    lixeira2.y = display.contentHeight - 110
    physics.addBody(lixeira2, "dynamic", { radius = 50, isSensor = true })
    lixeira2.isDragging = false

    local nmr3 = display.newImage(sceneGroup, "/assets/nmr3/nmr3.png", 29, 70)
    nmr3.x = display.contentWidth - 390
    nmr3.y = display.contentHeight - 85

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width / 2 - MARGIN - 500
    som.y = display.contentHeight - som.height / 2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width / 2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height / 2 - MARGIN
    semsom.isVisible = false

    backgroundSound = audio.loadStream("audio3/audio3.mp3")

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

    clickSound = audio.loadSound("assets/audios/audio3.mp3")
    if not clickSound then
        print("Erro: Som de clique não foi carregado.")
    end

    local function dragLixeira(event)
        local lixeira = event.target
        local phase = event.phase

        if phase == "began" then
            display.currentStage:setFocus(lixeira)
            lixeira.isDragging = true
        elseif phase == "moved" then
            if lixeira.isDragging then
                lixeira.x = event.x
                lixeira.y = event.y
            end
        elseif phase == "ended" or phase == "cancelled" then
            display.currentStage:setFocus(nil)
            lixeira.isDragging = false
        end

        return true
    end

    lixeira2:addEventListener("touch", dragLixeira)

    local function onCollision(event)
        if event.phase == "began" then
            local obj1 = event.object1
            local obj2 = event.object2

            if (obj1 == lixeira2 and obj2 == lixo) or (obj2 == lixeira2 and obj1 == lixo) then
                print("Lixo 1 removido!")
                lixo:removeSelf()
                lixo = nil
            end

            if (obj1 == lixeira2 and obj2 == lixo2) or (obj2 == lixeira2 and obj1 == lixo2) then
                print("Lixo 2 removido!")
                lixo2:removeSelf()
                lixo2 = nil
            end

            if (obj1 == lixeira2 and obj2 == lixo3) or (obj2 == lixeira2 and obj1 == lixo3) then
                print("Lixo 3 removido!")
                lixo3:removeSelf()
                lixo3 = nil
            end

            if lixo == nil and lixo2 == nil and lixo3 == nil then
                print("Todos os lixos foram recolhidos!")
                riosujo.isVisible = false
                rio.isVisible = true
            end
        end
    end

    Runtime:addEventListener("collision", onCollision)
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

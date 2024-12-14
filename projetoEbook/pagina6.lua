local composer = require("composer")

local scene = composer.newScene()

local MARGIN = 40

function scene:create(event)
    local sceneGroup = self.view

    audio.setVolume(1)

    local testSound = audio.loadSound("assets/audios/audio6.mp3")
    if testSound then
        print("Som de teste carregado com sucesso!")
        audio.play(testSound)
    else
        print("Erro: Não foi possível carregar o som de teste.")
    end

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina6/pagina6.png", 768, 1024)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function(event)
        composer.removeScene("pagina6")
        composer.gotoScene("contracapa", {
            effect = "fade",
            time = 500,
        })
    end)

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width / 2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function(event)
        composer.removeScene("pagina6")
        composer.gotoScene("pagina5", {
            effect = "fade",
            time = 500,
        })
    end)

    local mapa = display.newImageRect(sceneGroup, "/assets/mapa/mapa.png", 494, 330)
    mapa.x = display.contentCenterX + 6
    mapa.y = display.contentHeight - 370

    local area = display.newImageRect(sceneGroup, "/assets/mapa/area.png", 594, 330)
    area.x = display.contentCenterX + 6
    area.y = display.contentHeight - 370
    area.isVisible = false

    local texto5 = display.newImageRect(sceneGroup, "/assets/texto5/texto5.png", 653, 305)
    texto5.x = display.contentCenterX + 6
    texto5.y = display.contentHeight - 710

    local nmr6 = display.newImageRect(sceneGroup, "/assets/nmr6/nmr6.png", 29, 70)
    nmr6.x = display.contentCenterX - 5
    nmr6.y = display.contentHeight - 85

    local dica5 = display.newImageRect(sceneGroup, "/assets/dica5/dica5.png", 350, 59)
    dica5.x = display.contentCenterX - 5
    dica5.y = display.contentHeight - 150

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width / 2 - MARGIN - 500
    som.y = display.contentHeight - som.height / 2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width / 2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height / 2 - MARGIN
    semsom.isVisible = false

    backgroundSound = audio.loadStream("audio6/audio6.mp3")

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

    clickSound = audio.loadSound("assets/audios/audio6.mp3")
    if not clickSound then
        print("Erro: Som de clique não foi carregado.")
    end

    local initialDistance = nil
    local initialScale = nil
    local isZoomedIn = false
    local touches = {}

    local function calculateDistance()
        local keys = {}
        for k in pairs(touches) do
            table.insert(keys, k)
        end

        if #keys < 2 then
            return nil
        end

        local touch1 = touches[keys[1]]
        local touch2 = touches[keys[2]]

        local dx = touch2.x - touch1.x
        local dy = touch2.y - touch1.y
        return math.sqrt(dx * dx + dy * dy)
    end

    local function onTouch(event)
        local id = event.id

        if event.phase == "began" then
            touches[id] = { x = event.x, y = event.y }
            if #touches == 2 then
                initialDistance = calculateDistance()
                initialScale = mapa.xScale
            end
        elseif event.phase == "moved" and touches[id] then
            touches[id] = { x = event.x, y = event.y }
            if #touches == 2 and initialDistance then
                local newDistance = calculateDistance()
                if newDistance then
                    local scaleChange = newDistance / initialDistance
                    mapa.xScale = math.max(1, math.min(3, initialScale * scaleChange))
                    mapa.yScale = mapa.xScale

                    if mapa.xScale >= 2.5 and not isZoomedIn then
                        isZoomedIn = true
                        area.isVisible = true
                    elseif mapa.xScale < 2.5 and isZoomedIn then
                        isZoomedIn = false
                        area.isVisible = false
                    end
                end
            end
        elseif event.phase == "ended" or event.phase == "cancelled" then
            touches[id] = nil
            if #touches < 2 then
                initialDistance = nil
            end
        end

        return true
    end

    Runtime:addEventListener("touch", onTouch)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
    elseif (phase == "did") then
        if isSoundOn and backgroundSound and not isSoundPlaying then
            backgroundSoundHandle = audio.play(backgroundSound, { loops = -1 })
            isSoundPlaying = true
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
        end
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
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

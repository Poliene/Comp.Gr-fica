local composer = require("composer")
local audio = require("audio") -- Certifique-se de carregar o módulo correto

local scene = composer.newScene()

local MARGIN = 40
local isSoundOn = true -- Controle do estado do som

-- Variável para o som de fundo
local backgroundSound

function scene:create(event)
    local sceneGroup = self.view

    -- Background
    local background = display.newImageRect(sceneGroup, "assets/capa/capa.png", 768, 1024)
    background.x = display.contentCenterX
    background.y = display.contentCenterY

    -- Botão Próximo
    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function(event)
        composer.gotoScene("pagina2", {
            effect = "fade",
            time = 500
        })
    end)

    -- Botões de Som e Sem Som
    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width / 2 - MARGIN - 500
    som.y = display.contentHeight - som.height / 2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width / 2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height / 2 - MARGIN
    semsom.isVisible = false -- Inicialmente invisível

    -- Carregar o áudio de fundo
    backgroundSound = audio.loadStream("audios/audio1.mp3")

    -- Função para alternar som
    local function toggleSound(event)
        if som.isVisible then
            som.isVisible = false
            semsom.isVisible = true
            audio.stop() -- Pausar o som
            print("Som desligado")
        else
            som.isVisible = true
            semsom.isVisible = false
            audio.play(backgroundSound, { loops = -1 }) -- Reproduzir o som
            print("Som ligado")
        end
        return true -- Previne propagação do evento
    end

    -- Adiciona os eventos de toque aos botões
    som:addEventListener("tap", toggleSound)
    semsom:addEventListener("tap", toggleSound)
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Antes da cena aparecer
    elseif (phase == "did") then
        -- Quando a cena está visível
        if isSoundOn then
            audio.play(backgroundSound, { loops = -1 }) -- Reproduzir som ao mostrar a cena
        end
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase

    if (phase == "will") then
        -- Antes da cena desaparecer
        audio.stop() -- Parar o som ao sair da cena
    elseif (phase == "did") then
        -- Depois da cena desaparecer
    end
end

function scene:destroy(event)
    local sceneGroup = self.view

    -- Limpeza de recursos
    if backgroundSound then
        audio.dispose(backgroundSound) -- Liberar o áudio da memória
        backgroundSound = nil
    end
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

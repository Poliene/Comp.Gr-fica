local composer = require( "composer" )
 
local scene = composer.newScene()
 
local MARGIN = 40
 
function scene:create( event )
    local sceneGroup = self.view

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina2/pagina2.png", 768, 1024)

    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width/2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function (event)
        composer.removeScene("pagina2")
        composer.gotoScene("pagina3", {
            effect = "fade",
            time = 500
        });
        
    end)

    local casa = display.newImage(sceneGroup, "/assets/casa/casa.png", 356, 356)
    casa.x = display.contentWidth - 435
    casa.y = display.contentHeight - 360

    -- Coordenadas do local onde o cano vazio deve ser colocado
local destinoX = display.contentCenterX + 180
local destinoY = display.contentCenterY + 155

-- Coordenadas do chuveiro
local chuveiroDestinoX = display.contentCenterX - 260
local chuveiroDestinoY = display.contentHeight - 310

-- Criar o cano vazio
local cano = display.newImageRect(sceneGroup, "/assets/cano/cano.png", 290, 137)
cano.x = display.contentCenterX - 260
cano.y = display.contentCenterY + 70
cano.isVisible = true -- Começa visível

-- Criar o canolimpo (cano cheio)
local canolimpo = display.newImageRect(sceneGroup, "/assets/canolimpo/canolimpo.png", 290, 137)
canolimpo.x = destinoX
canolimpo.y = destinoY
canolimpo.isVisible = false -- Começa invisível

local chuveirosujo = display.newImageRect(sceneGroup, "/assets/chuveirosujo/chuveirosujo.png", 105, 105)
    chuveirosujo.x = display.contentCenterX - 260
    chuveirosujo.y = display.contentHeight - 280
    chuveirosujo.isVisible = true

local chuveirolimpo = display.newImageRect(sceneGroup, "/assets/chuveirolimpo/chuveirolimpo.png", 105, 105)
    chuveirolimpo.x = display.contentCenterX - 260
    chuveirolimpo.y = display.contentHeight - 280
    chuveirolimpo.isVisible = false

-- Variável para rastrear se o cano foi substituído
local canoSubstituido = false


-- Função para arrastar o cano vazio
local function arrastarCano(event)
    if event.phase == "moved" then
        -- Atualizar a posição do cano vazio enquanto é arrastado
        cano.x = event.x
        cano.y = event.y
    elseif event.phase == "ended" then
        -- Verificar se o cano vazio foi posicionado no local correto
        if math.abs(cano.x - destinoX) < 30 and math.abs(cano.y - destinoY) < 30 then
            print("Cano posicionado corretamente!")

            -- Tornar o canolimpo visível e ocultar o cano vazio
            canolimpo.isVisible = true 
            cano.isVisible = false

            -- Substituir o chuveiro automaticamente
            chuveirosujo.isVisible = false
            chuveirolimpo.isVisible = true
            --canoSubstituido = true -- Indicar que o cano foi substituído
        else
            print("Cano ainda não está na posição correta.")
        end
    end
    return true 
end

-- Adicionar o ouvinte de evento 'touch' ao cano vazio
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

    
    

    --local canolimpo = display.newImageRect(sceneGroup, "/assets/canolimpo/canolimpo.png", 290, 137)
    --canolimpo.x = display.contentCenterX + 180
    --canolimpo.y = display.contentHeight - 380
    --canolimpo.isVisible = false







    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width/2 - MARGIN - 500
    voltar.y = display.contentHeight - 940


    voltar:addEventListener("tap", function (event)
        composer.removeScene("pagina2")
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
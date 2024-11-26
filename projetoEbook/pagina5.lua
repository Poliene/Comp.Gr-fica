local composer = require( "composer" )
 
local scene = composer.newScene()
 
local MARGIN = 40
 
function scene:create( event )
    local sceneGroup = self.view

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina5/pagina5.png", 768, 1024)

    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width/2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function (event)
        composer.removeScene("pagina5")
        composer.gotoScene("pagina6", {
            effect = "fade",
            time = 500
        });
        
    end)

    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width/2 - MARGIN - 500
    voltar.y = display.contentHeight - 940
    voltar:addEventListener("tap", function (event)
        composer.removeScene("pagina5")
        composer.gotoScene("pagina4", {
            effect = "fade",
            time = 500
        });
        
    end)

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width/2 - MARGIN - 500
    som.y = display.contentHeight - som.height/2 - MARGIN

    local texto4 = display.newImageRect(sceneGroup, "/assets/texto4/texto4.png", 653, 333)
    texto4.x = display.contentCenterX - 6
    texto4.y = display.contentHeight - 710

    local lojas = display.newImageRect(sceneGroup, "/assets/lojas/lojas.png", 760, 272)
    lojas.x = display.contentCenterX - 10
    lojas.y = display.contentHeight - 340

    local bueiro = display.newImageRect(sceneGroup, "/assets/bueiro/bueiro.png", 218, 218)
    bueiro.x = display.contentCenterX + 250
    bueiro.y = display.contentHeight - 100
    
    local garrafa = display.newImageRect(sceneGroup, "/assets/garrafa/garrafa.png", 64, 64)
    garrafa.x = display.contentCenterX + 30
    garrafa.y = display.contentHeight - 140

    local lixoorganico = display.newImageRect(sceneGroup, "/assets/lixoorganico/lixoorganico.png", 83, 83)
    lixoorganico.x = display.contentCenterX + 80
    lixoorganico.y = display.contentHeight - 200

    local vidro = display.newImageRect(sceneGroup, "/assets/vidro/vidro.png", 105, 84)
    vidro.x = display.contentCenterX + 200
    vidro.y = display.contentHeight - 200

    local papel = display.newImageRect(sceneGroup, "/assets/papel/papel.png", 55, 55)
    papel.x = display.contentCenterX - 10
    papel.y = display.contentHeight - 200




    -- Água para simular inundação
    agua = display.newRect(sceneGroup, display.contentCenterX, display.contentHeight, 768, 200)
    agua:setFillColor(0, 0, 1, 0.5) -- Azul translúcido
    agua.height = 50 -- Começa com nível baixo

    -- Lixos
    local lixos = {}
    lixos[1] = display.newImageRect(sceneGroup, "/assets/garrafa/garrafa.png", 64, 64)
    lixos[1].x = display.contentCenterX + 30
    lixos[1].y = display.contentHeight - 140
    lixos[1].id = "garrafa"

    lixos[2] = display.newImageRect(sceneGroup, "/assets/lixoorganico/lixoorganico.png", 83, 83)
    lixos[2].x = display.contentCenterX + 80
    lixos[2].y = display.contentHeight - 200
    lixos[2].id = "lixoorganico"

    lixos[3] = display.newImageRect(sceneGroup, "/assets/vidro/vidro.png", 105, 84)
    lixos[3].x = display.contentCenterX + 200
    lixos[3].y = display.contentHeight - 200
    lixos[3].id = "vidro"

    lixos[4] = display.newImageRect(sceneGroup, "/assets/papel/papel.png", 55, 55)
    lixos[4].x = display.contentCenterX - 10
    lixos[4].y = display.contentHeight - 200
    lixos[4].id = "papel"

    local nmr5 = display.newImageRect(sceneGroup, "/assets/nmr5/nmr5.png", 29, 70)
    nmr5.x = display.contentCenterX - 10
    nmr5.y = display.contentHeight - 85

    -- Função para criar chuva
    local function criarChuva()
        local gota = display.newCircle(sceneGroup, math.random(0, display.contentWidth), 0, 5)
        gota:setFillColor(0.5, 0.5, 1)
        transition.to(gota, {y = display.contentHeight, time = 2000, onComplete = function() display.remove(gota) end})
    end

    -- Timer para chuva
    chuvaTimer = timer.performWithDelay(200, criarChuva, 0)

    -- Função para aumentar o nível da água
    local function aumentarAgua()
        if agua.height < 200 then
            agua.height = agua.height + 5
            agua.y = display.contentHeight - agua.height / 2
        else
            print("Inundação total!")
            timer.cancel(chuvaTimer) -- Para a chuva se a água atingir o limite
        end
    end

    -- Timer para simular aumento da água
    local aguaTimer = timer.performWithDelay(1000, aumentarAgua, 0)

    -- Função para arrastar lixo
    local function arrastarLixo(event)
        local lixo = event.target
        if event.phase == "began" then
            display.currentStage:setFocus(lixo)
            lixo.isFocus = true
        elseif event.phase == "moved" then
            if lixo.isFocus then
                lixo.x = event.x
                lixo.y = event.y
            end
        elseif event.phase == "ended" or event.phase == "cancelled" then
            if lixo.isFocus then
                display.currentStage:setFocus(nil)
                lixo.isFocus = nil
                -- Verificar se o lixo foi colocado no bueiro
                if math.abs(lixo.x - bueiro.x) < 50 and math.abs(lixo.y - bueiro.y) < 50 then
                    print("Lixo colocado no bueiro:", lixo.id)
                    display.remove(lixo) -- Remover o lixo
                    lixoCount = lixoCount + 1 -- Incrementar o contador de lixos
                    -- Diminuir o nível da água
                    if agua.height > 50 then
                        agua.height = agua.height - 10
                        agua.y = display.contentHeight - agua.height / 2
                    end
                end
            end
        end
        return true
    end

    -- Adicionar listeners para os lixos
    for i = 1, #lixos do
        lixos[i]:addEventListener("touch", arrastarLixo)
    end
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
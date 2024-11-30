local composer = require("composer")

local scene = composer.newScene()

local MARGIN = 40

function scene:create(event)
    local sceneGroup = self.view

    
    local backgroud = display.newImageRect(sceneGroup, "assets/pagina5/pagina5.png", 768, 1024)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

  
    local lojas = display.newImageRect(sceneGroup, "/assets/lojas/lojas.png", 760, 272)
    lojas.x = display.contentCenterX - 10
    lojas.y = display.contentHeight - 340

   
    local bueiro = display.newImageRect(sceneGroup, "/assets/bueiro/bueiro.png", 218, 218)
    bueiro.x = display.contentCenterX + 270
    bueiro.y = display.contentHeight - 170
    local bueiroEntupido = true 

    
    local lixeira = display.newImageRect(sceneGroup, "/assets/lixeira/lixeira.png", 72, 81)
    lixeira.x = display.contentCenterX - 90
    lixeira.y = display.contentHeight - 280

 
    local lixos = {}
    lixos[1] = display.newImageRect(sceneGroup, "/assets/garrafa/garrafa.png", 64, 64)
    lixos[1].x = bueiro.x - 60
    lixos[1].y = bueiro.y - 10
    lixos[1].id = "garrafa"

    lixos[2] = display.newImageRect(sceneGroup, "/assets/lixoorganico/lixoorganico.png", 83, 83)
    lixos[2].x = bueiro.x
    lixos[2].y = bueiro.y + 10
    lixos[2].id = "lixoorganico"

    lixos[3] = display.newImageRect(sceneGroup, "/assets/vidro/vidro.png", 105, 84)
    lixos[3].x = bueiro.x - 10
    lixos[3].y = bueiro.y - 20
    lixos[3].id = "vidro"

    lixos[4] = display.newImageRect(sceneGroup, "/assets/papel/papel.png", 55, 55)
    lixos[4].x = bueiro.x
    lixos[4].y = bueiro.y - 40
    lixos[4].id = "papel"

    local nmr5 = display.newImageRect(sceneGroup, "/assets/nmr5/nmr5.png", 29, 70)
    nmr5.x = display.contentCenterX - 10
    nmr5.y = display.contentHeight - 85

    
    local lixosNaLixeira = 0
    local drenagemTimer

    
    local drenagemConcluida = false


    local function criarChuva()
        local gota = display.newCircle(sceneGroup, math.random(0, display.contentWidth), 0, 5)
        gota:setFillColor(0, 0, 1)
        transition.to(gota, {y = display.contentHeight, time = 2000, onComplete = function()
            display.remove(gota)
        end})
    end

   
    local chuvaTimer = timer.performWithDelay(200, criarChuva, 0)

  
    local function aumentarAgua()
        if bueiroEntupido and agua.height < 350 and not drenagemConcluida then
            agua.height = agua.height + 10
            agua.y = agua.y - 5
        end
    end

   
    local function diminuirAgua()
        if agua.height > 10 then
            agua.height = agua.height - 10
            agua.y = agua.y + 5
        end
    end

  
    local aguaTimer = timer.performWithDelay(1000, aumentarAgua, 0)

   
    local function drenarAgua()
        if chuvaTimer then
            timer.cancel(chuvaTimer)
            chuvaTimer = nil
        end

        print("Parando chuva. Iniciando drenagem da água.")

        drenagemTimer = timer.performWithDelay(100, function()
            if agua.height > 0 then
                agua.height = agua.height - 10
                agua.y = agua.y + 5
            else
                if drenagemTimer then
                    timer.cancel(drenagemTimer)
                    drenagemTimer = nil
                end
                drenagemConcluida = true 
                print("A água foi completamente drenada.")
            end
        end, 0)
    end

   
    local function verificarLixos()
        if lixosNaLixeira == #lixos then
            print("Todos os lixos foram colocados na lixeira. Parando chuva e iniciando drenagem.")
            bueiroEntupido = false
            drenarAgua() 
        end
    end

    
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

               
                if math.abs(lixo.x - lixeira.x) < 50 and math.abs(lixo.y - lixeira.y) < 50 then
                    print("Lixo colocado na lixeira:", lixo.id)
                    display.remove(lixo)
                    lixosNaLixeira = lixosNaLixeira + 1 
                    verificarLixos() 
                    
                    
                    diminuirAgua()
                end
            end
        end
        return true
    end

    
    for i = 1, #lixos do
        lixos[i]:addEventListener("touch", arrastarLixo)
    end

    
    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width / 2 - MARGIN - 500
    voltar.y = display.contentHeight - 940
    voltar:addEventListener("tap", function(event)
        composer.removeScene("pagina5")
        composer.gotoScene("pagina4", {
            effect = "fade",
            time = 500
        })
    end)

    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width / 2 - MARGIN - 500
    som.y = display.contentHeight - som.height / 2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width/2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height/2 - MARGIN
    semsom.isVisible = false  

  
    backgroundSound = audio.loadStream("audios/audio5.mp3")


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

    
    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940
    proximo:addEventListener("tap", function(event)
        composer.removeScene("pagina5")
        composer.gotoScene("pagina6", {
            effect = "fade",
            time = 500
        })
    end)

    -- Texto
    local texto4 = display.newImageRect(sceneGroup, "/assets/texto4/texto4.png", 653, 333)
    texto4.x = display.contentCenterX - 6
    texto4.y = display.contentHeight - 710

    
    local dica4 = display.newImageRect(sceneGroup, "/assets/dica4/dica4.png", 375, 163)
    dica4.x = display.contentCenterX - 190
    dica4.y = display.contentHeight - 500

   
    agua = display.newRect(sceneGroup, display.contentCenterX, bueiro.y + 50, 768, 10)
    agua:setFillColor(0, 0, 1, 0.5) 
    agua.height = 10 
    sceneGroup:insert(agua) 
end

function scene:show(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
    elseif (phase == "did") then
    end
end

function scene:hide(event)
    local sceneGroup = self.view
    local phase = event.phase
    if (phase == "will") then
    elseif (phase == "did") then
    end
end

function scene:destroy(event)
    local sceneGroup = self.view
end

scene:addEventListener("create", scene)
scene:addEventListener("show", scene)
scene:addEventListener("hide", scene)
scene:addEventListener("destroy", scene)

return scene

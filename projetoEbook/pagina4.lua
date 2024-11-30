local composer = require("composer")

local scene = composer.newScene()

local MARGIN = 40

function scene:create(event)
    local sceneGroup = self.view

    local backgroud = display.newImageRect(sceneGroup, "assets/pagina4/pagina4.png", 768, 1024)
    backgroud.x = display.contentCenterX
    backgroud.y = display.contentCenterY

    
    local proximo = display.newImage(sceneGroup, "/assets/botao/proximo.png")
    proximo.x = display.contentWidth - proximo.width / 2 - MARGIN
    proximo.y = display.contentHeight - 940

    proximo:addEventListener("tap", function(event)
        composer.removeScene("pagina4")
        composer.gotoScene("pagina5", {
            effect = "fade",
            time = 500
        })
    end)

    
    local voltar = display.newImage(sceneGroup, "/assets/botao/voltar.png")
    voltar.x = display.contentWidth - voltar.width / 2 - MARGIN - 500
    voltar.y = display.contentHeight - 940

    voltar:addEventListener("tap", function(event)
        composer.removeScene("pagina4")
        composer.gotoScene("pagina3", {
            effect = "fade",
            time = 500
        })
    end)

   
    local texto3 = display.newImageRect(sceneGroup, "/assets/texto3/texto3.png", 653, 255)
    texto3.x = display.contentCenterX + 8
    texto3.y = display.contentHeight - 770

    local dica3 = display.newImageRect(sceneGroup, "/assets/dica3/dica3.png", 321, 330)
    dica3.x = display.contentCenterX - 130
    dica3.y = display.contentHeight - 600

    local nmr4 = display.newImageRect(sceneGroup, "/assets/nmr4/nmr4.png", 29, 70)
    nmr4.x = display.contentCenterX - 8
    nmr4.y = display.contentHeight - 80

    
    local botaoVerde = display.newImageRect(sceneGroup, "/assets/botaoVerde/botaoVerde.png", 188, 97)
    botaoVerde.x = display.contentCenterX + 200
    botaoVerde.y = display.contentHeight - 595

    
    local cenarioOndas = display.newImageRect(sceneGroup, "/assets/cenarioOndas/cenarioOndas.png", 767, 542)
    cenarioOndas.x = display.contentCenterX - 1
    cenarioOndas.y = display.contentHeight - 380

    local ondaSuja = display.newImageRect(sceneGroup, "/assets/cenarioOndas/ondaSuja.png", 768, 432)
    ondaSuja.x = display.contentCenterX - 2
    ondaSuja.y = display.contentHeight - 350
    ondaSuja.isVisible = false 

    
    local matoVerde = display.newImageRect(sceneGroup, "/assets/matoVerde/matoVerde.png", 768, 136)
    matoVerde.x = display.contentCenterX - 1
    matoVerde.y = display.contentHeight - 300

    local matoVerde2 = display.newImageRect(sceneGroup, "/assets/matoVerde/matoVerde.png", 768, 136)
    matoVerde2.x = display.contentCenterX - 1
    matoVerde2.y = display.contentHeight - 260

    
    local peixe = display.newImageRect(sceneGroup, "/assets/peixe/peixe.png", 670, 184)
    peixe.x = display.contentCenterX - 1
    peixe.y = display.contentHeight - 390

    local peixeMorto = display.newImageRect(sceneGroup, "/assets/peixe/peixeMorto.png", 631, 169)
    peixeMorto.x = display.contentCenterX - 1
    peixeMorto.y = display.contentHeight - 322
    peixeMorto.isVisible = false 

    
    local function alternarCenario()
        
        if cenarioOndas.isVisible then
            cenarioOndas.isVisible = false
            ondaSuja.isVisible = true
            peixe.isVisible = false
            peixeMorto.isVisible = true
            matoVerde.isVisible = false
            matoVerde2.isVisible = false
        else
            cenarioOndas.isVisible = true
            ondaSuja.isVisible = false
            peixe.isVisible = true
            peixeMorto.isVisible = false
            matoVerde.isVisible = true
            matoVerde2.isVisible = true
        end
    end

    
    botaoVerde:addEventListener("tap", alternarCenario)

    local function movimentarCenario()
        transition.to(cenarioOndas, {
            x = cenarioOndas.x + 10,
            time = 2000,
            onComplete = function()
                transition.to(cenarioOndas, {
                    x = cenarioOndas.x - 10,
                    time = 2000,
                    onComplete = movimentarCenario
                })
            end
        })

        transition.to(ondaSuja, {
            x = ondaSuja.x + 10,
            time = 2000,
            onComplete = function()
                transition.to(ondaSuja, {
                    x = ondaSuja.x - 10,
                    time = 2000,
                    onComplete = movimentarCenario
                })
            end
        })
    end

    local function movimentarMato()
        transition.to(matoVerde, {
            x = matoVerde.x + 5,
            time = 3000,
            onComplete = function()
                transition.to(matoVerde, {
                    x = matoVerde.x - 5,
                    time = 3000,
                    onComplete = movimentarMato
                })
            end
        })

        transition.to(matoVerde2, {
            x = matoVerde2.x + 5,
            time = 3000,
            onComplete = function()
                transition.to(matoVerde2, {
                    x = matoVerde2.x - 5,
                    time = 3000,
                    onComplete = movimentarMato
                })
            end
        })
    end

    local function movimentarPeixe()
        transition.to(peixe, {
            y = peixe.y - 10,
            time = 2000,
            onComplete = function()
                transition.to(peixe, {
                    y = peixe.y + 10,
                    time = 2000,
                    onComplete = movimentarPeixe
                })
            end
        })

        transition.to(peixeMorto, {
            y = peixeMorto.y - 10,
            time = 2000,
            onComplete = function()
                transition.to(peixeMorto, {
                    y = peixeMorto.y + 10,
                    time = 2000,
                    onComplete = movimentarPeixe
                })
            end
        })
    end

    
    movimentarCenario()
    movimentarMato()
    movimentarPeixe()

    
    local som = display.newImage(sceneGroup, "/assets/botao/som.png")
    som.x = display.contentWidth - som.width / 2 - MARGIN - 500
    som.y = display.contentHeight - som.height / 2 - MARGIN

    local semsom = display.newImage(sceneGroup, "/assets/botao/semsom.png")
    semsom.x = display.contentWidth - semsom.width / 2 - MARGIN - 500
    semsom.y = display.contentHeight - semsom.height / 2 - MARGIN
    semsom.isVisible = false 

    backgroundSound = audio.loadStream("audio4/audio4.mp3")

    
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

scene:addEventListener("create", scene)

return scene

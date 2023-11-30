class JogoDaForca
    def initialize
        @palavra = escolher_palavra
        @letras_corretas = []
        @letras_erradas = []
        @max_tentativas = 10
    end

    def escolher_palavra
        palavras = File.readlines("palavras.txt").sample.chomp.downcase
    end

    def exibir_palavra_mascarada
        mascarada = @palavra.chars.map do |letra|
        if @letras_corretas.include?(letra)
            letra
        else
            "_"
        end
    end
        mascarada.join(" ")
    end

    def exibir_tentativas
        puts "Letras corretas: #{@letras_corretas.join(', ')}"
        puts "Letras erradas: #{@letras_erradas.join(', ')}"
    end

    def jogar
        while true
            system("clear") || system("cls")
            puts "Jogo da Forca"
            puts "Dica: A palavra está relacionada com linguagens de PROGRAMAÇÃO"
            puts "Palavra: #{exibir_palavra_mascarada}"
            exibir_tentativas
            puts "Digite uma letra: "
            letra = gets.chomp.downcase

        if letra.length != 1 || !letra.match?(/[a-z]/)
            puts "Por favor, digite uma letra válida."
                next
        end

        if @letras_corretas.include?(letra) || @letras_erradas.include?(letra)
            puts "Você já tentou essa letra. Tente outra."
                next
        end

        if @palavra.include?(letra)
            @letras_corretas << letra
        else
            @letras_erradas << letra
        end

        if ganhou?
            system("clear") || system("cls")
            puts "Parabéns! Você acertou a palavra: #{@palavra}"
            break
        elsif perdeu?
            system("clear") || system("cls")
            puts "Infelizmente você perdeu. A palavra era: #{@palavra}"
            break
            end
        end
    end

    def ganhou?
        (@palavra.chars - @letras_corretas).empty?
    end

    def perdeu?
        @letras_erradas.length >= @max_tentativas
    end
end

# Iniciar o jogo
jogo = JogoDaForca.new
jogo.jogar

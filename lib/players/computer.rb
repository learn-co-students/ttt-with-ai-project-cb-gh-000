module Players
  class Computer < Player
    def move(board)
      move = nil

      # Cuando va primero, toma el cuadrado del medio. Cuando va segundo, tome el cuadro del medio si aún no se ha tomado.
      if !board.taken?(5)
        move = "5"

      # Si vas en segundo lugar y se toma el cuadrado del medio, toma el cuadrado de la esquina superior izquierda.
      elsif board.turn_count == 1
        move = "1"

      # Si fue primero (y tomó el centro), tome una esquina con su segundo movimiento.
      elsif board.turn_count == 2
        move = [1, 3, 7, 9].detect{|i| !board.taken?(i)}.to_s

      # Si fue segundo (y tomó el medio) y el otro jugador ocupó los cuadrados de esquina opuestos, explote el intento de trampa tomando un cuadrado lateral.
      elsif board.turn_count == 3 && (board.position(1) == board.position(9) || board.position(3) == board.position(7))
        move = "2"

      # A partir de ahora, ejecute la matriz WIN_COMBINATIONS, verificando si alguna de las combinaciones tiene dos cuadrados llenos con el mismo token y un tercer cuadrado vacío.
      else
        Game::WIN_COMBINATIONS.detect do |cmb|

          # Primero, verifica si tienes posibilidades de ganar, ya que no importa si el oponente tiene la posibilidad de ganar si puedes ganar primero.
          if cmb.select{|i| board.position(i+1) == token}.size == 2 && cmb.any?{|i| board.position(i+1) == " "}
            move = cmb.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s

          # Si no puedes jugar ningún movimiento ganador, juega un movimiento para evitar que el oponente gane.
          elsif cmb.select{|i| board.position(i+1) != " " && board.position(i+1) != token}.size == 2 && cmb.any?{|i| board.position(i+1) == " "}
            move = cmb.select{|i| !board.taken?(i+1)}.first.to_i.+(1).to_s
          end
        end

        # Si ninguno de los patrones WIN_COMBINATIONS tiene dos cuadrados tomados por el mismo token y un tercer cuadrado vacío, juegue en el primer cuadrado abierto que encuentre, primero revisando las esquinas y luego revisando los lados.
        move = [1, 3, 7, 9, 2, 4, 6, 8].detect{|i| !board.taken?(i)}.to_s if move == nil
      end
      move
    end
  end
end

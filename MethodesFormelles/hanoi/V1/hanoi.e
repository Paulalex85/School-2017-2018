class HANOI
	--
	-- Le jeu des tours de Hanoi
	--
--
	
creation {ANY}
	make

feature {}
	nb: INTEGER
			-- Taille des tours

	tower1, tower2, tower3: TOWER
	      -- Les 3 tours du jeu

feature {ANY}
	make is
			-- Creation du jeu et boucle principale
		do
			io.put_string("Hauteur des tours : ")
			io.flush
			io.read_integer
			nb := io.last_integer

			create tower1.full(nb)
			create tower2.empty(nb)
			create tower3.empty(nb)
			io.put_string("Situation au depart :%N")
			print_game
			resolve(nb, tower1, tower2, tower3)
			io.put_string("Situation a la fin :%N")
			print_game
		end

	resolve (how_many: INTEGER; source, intermediate, destination : TOWER) is
			-- Algorithme recursif de resolution du jeu qui transfère how_many jetons de la tour source à la tour destination en passant par la tour intermediate
		local
			disque: INTEGER
		do
			if how_many > 0 then 
				resolve(how_many-1, source,destination ,intermediate)
				disque := source.retirer_disque()
				destination.ajouter_disque(disque)
				resolve(how_many-1, intermediate, source, destination)
			end
			
		end


	print_game is
			-- Affichage de l'etat courant de la partie
		local
			i: INTEGER
		do
		from
			i := nb
		until
			i = 0
		loop
			io.put_character(' ')
			tower1.afficher_etage(i)
			io.put_character(' ')
			tower2.afficher_etage(i)
			io.put_character(' ')
			tower3.afficher_etage(i)
			io.put_string("%N")
			i := i-1
		end
	
		from
			i:= (2 * (nb + 1) + 1) * 3 - 2
		until
			i = 0
		loop
			io.put_character('-')
			i := i - 1
		end
	   io.put_string("%N")

	end
	

end -- class HANOI

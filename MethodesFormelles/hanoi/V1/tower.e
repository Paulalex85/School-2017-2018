class TOWER
-- Represente une tour et les disques qu'elle contient
	
creation {ANY}
	full, empty

feature {}
	t: ARRAY[INTEGER]
			-- La tour est un tableau d'entiers.
	      -- L'index i du tableau représente la taille du disque à 
	      -- l'étage i
	top: INTEGER
			-- Represente le dernier étage auquel un disque est present

feature {}
	full (n: INTEGER) is
			-- Creation d'une tour de taille n, avec n disques presents
		require
			n >= 1
		local
			i: INTEGER
		do
			create t.make(1,n)
			top := n
			from
				i := 0
			until
				i = n
			loop
				i := i + 1
				t.put(n - i + 1 ,i)
			end
		end

	empty (n: INTEGER) is
			-- Creation d'une tour vide de taille n
		require
			n >= 1
		do
			create t.make(1,n)
		ensure
			height = n
			top = 0
		end

feature {HANOI}
	height: INTEGER is
			-- La taille de la tour
		do
			Result := t.upper
		end

	afficher_etage (d: INTEGER) is
			-- Affiche l'etage d de la tour
		require
			1 <= d
			d <= height
		local
			taille_disque, taille_disque_max, i: INTEGER
		do
			taille_disque := t.item(d)
			taille_disque_max := height
			from
				i := taille_disque_max - taille_disque
			until
				i = 0
			loop
				io.put_character(' ')
				i := i - 1
			end
			from
				i := taille_disque
			until
				i = 0
			loop
				io.put_character('=')
				i := i - 1
			end
			io.put_character('|')
			from
				i := taille_disque
			until
				i = 0
			loop
				io.put_character('=')
				i := i - 1
			end
			from
				i := taille_disque_max - taille_disque
			until
				i = 0
			loop
				io.put_character(' ')
				i := i - 1
			end
		end

	retirer_disque: INTEGER is
			-- Retire le dernier disque de la tour courante
		do
			if top > 0 then
				Result := t.item(top)
				t.put(0,top)
				top := top - 1
			else
				Result := 0
			end
		ensure
			top >= 0
		end

	ajouter_disque (d: INTEGER) is
			-- Ajoute un disque de taille d sur la tour.
			-- Renvoie une erreur (Explicite) si le disque ne peut pas etre ajoute
		do
			if top = 0 or else t.item(top) > d then
				top := top + 1
				t.put(d,top)
			else
				io.put_string("Erreur : Disque inferieur plus petit")
				io.put_new_line
			end
		ensure
			top <= height
		end

end -- class TOWER

 # encoding: UTF-8 
class NuevaCompetenciaController < ApplicationController
	@volver = false
	def paso1
		$nombre_competencia = params[:nombre_competencia]
		$desc_competencia = params[:desc_competencia]
		$tipo_competencia = params[:tipo]
		$ida_vuelta = params[:ida_vuelta]
		if $tipo_competencia == "torneo"
			$cant_participantes = params[:participantes_torneo]
		else
			if params[:cant_participantes]
				$cant_participantes = params[:cant_participantes]['participantes']
			end
		end

		if $tipo_competencia == "copa"
			if params[:cant_grupos]
				$cant_grupos = params[:cant_grupos]['grupos']
			end

			if params[:cant_clasificados]
				$cant_clasificados = params[:cant_clasificados]['clasificados']
			end
		else
			$cant_grupos = 0
		end

		if fecha1 = params[:fecha1]
			$fecha_inicio = Date.new fecha1["fecha_inicio(1i)"].to_i, fecha1["fecha_inicio(2i)"].to_i, fecha1["fecha_inicio(3i)"].to_i
		end

		if fecha2 = params[:fecha2]
			$fecha_fin = Date.new fecha2["fecha_fin(1i)"].to_i, fecha2["fecha_fin(2i)"].to_i, fecha2["fecha_fin(3i)"].to_i
		end

		$privacidad = params[:privacidad]

		if request.post?
			if $fecha_fin < $fecha_inicio
				@alert = 'La fecha de inicio es posterior a la fecha de fin. Por favor, ingrese un fecha valida'
			elsif $cant_grupos.to_i != 0 && $cant_participantes.to_i % $cant_grupos.to_i != 0
				@alert = 'La cantidad de grupos no coincide con la cantidad de participantes. Es estrictamente necesario que cada grupo tenga la misma cantidad de participantes.'
			elsif $cant_grupos.to_i != 0 && $cant_clasificados.to_i > $cant_participantes.to_i/$cant_grupos.to_i-1
				@alert = 'La cantidad de clasificados no puede ser mayor o igual que la cantidad de participantes por grupo'
			else
				redirect_to action: 'paso2'
			end
		end
	end

	def paso2
		if params[:arbitros]
			$cant_arbitros = params[:arbitros]['cant_arbitros']
		end
		if params[:jugadores]
			$cant_jugadores = params[:jugadores]['cant_jugadores']
		end
		if params[:titulares]
			$cant_titulares = params[:titulares]['jug_titulares']
		end
		if params[:cambios]
			$cant_cambios = params[:cambios]['cant_cambios']
		end
		if params[:banca]
			$cant_banca = params[:banca]['jug_banca']
		end

		if request.post?
			if $cant_jugadores.to_i < $cant_titulares.to_i + $cant_banca.to_i
				@alert = 'La cantidad máxima de jugadores es inferior a la cantidad de jugadores titulares más la cantidad de jugadores en banca'	
			elsif $cant_cambios.to_i > $cant_banca.to_i
				@alert = 'La cantidad máxima de cambios permitidos es mayor que la cantidad de jugadores en banca'
			elsif @volver_paso1
				redirect_to action: 'paso1'
			else
				redirect_to action: 'paso3'
			end
		end
	end

	def paso3
		$participantes = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				fila = row.to_hash
				$participantes.push(fila)
			end
		end

		nombre_repetido = false
		campo_vacio = false
		campo_invalido = false

		$participantes.each do |participante|
			if participante['Nombre'] == nil || participante['Pais'] == nil
				campo_vacio = true
			elsif participante['Nombre'] !~ /^([A-Z]|[a-z]|\s|\d)*/ || participante['Pais'] !~ /^([A-Z]|[a-z])*/
				campo_invalido = true
			end
		end


		if $participantes != [] && $participantes != nil
			for i in (0..$participantes.length-1)
				for j in(i+1..$participantes.length)
					if i != j
						if $participantes[i] != nil && $participantes[j] != nil
							if $participantes[i]['Nombre'] == $participantes[j]['Nombre']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end
		#$cant_participantes = $participantes.length
		$participantes.sort! {|x,y| x['Nombre'] <=> y['Nombre']}

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay nombres de participantes que están repetidos'
			elsif $cant_participantes.to_i != $participantes.length
				@alert = 'La cantidad de participantes del archivo no coincide con la indicada en un principio. Cantidad indicada: '+$cant_participantes.to_s+'  - Cantidad en el archivo: '+$participantes.length.to_s
				@noCoinciden = true	
			elsif campo_invalido
				@alert = 'Alguno de los campos del archivo no coincide con el formato solicitado. El nombre no puede contener caracteres especiales (-, /, \', !, etc) y el país no puede contener números ó caracteres especiales'	
			else
				redirect_to action: 'paso4'
			end
		end
	end

	def paso4
		$jugadores = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$jugadores.push(row.to_hash)
			end
		end

		nombre_repetido = false
		campo_vacio = false
		campo_invalido = false

		$jugadores.each do |jugador|
			if jugador['Institucion Deportiva'] == nil || jugador['Nombre'] == nil || jugador['Apellido Paterno'] == nil || jugador['Apellido Materno'] == nil || jugador['RUT'] == nil || jugador['Sexo'] == nil || jugador['Fecha nacimiento'] == nil || jugador['Email'] == nil
				campo_vacio = true
			elsif jugador['Nombre'] !~ /^([A-Z]|[a-z])*/ || jugador['Apellido Paterno'] !~ /^([A-Z]|[a-z])*/ || jugador['Apellido Materno'] !~ /^([A-Z]|[a-z])*/ || jugador['Sexo'] !~ /^M{1}|F{1}/ || jugador['RUT'] !~ /^\d{8}-(\d|k)/ || jugador['Fecha nacimiento'] !~ /^(\d{1,2})\/(\d{1,2})\/(\d{4})/ || jugador['Email'] !~ /^([a-z]|\d)*\@([a-z]|\d)*\.[a-z]*/
				campo_invalido = true	
			end
		end

		#VERIFICA QUE NO HAYAN REPETIDOS
		if $jugadores != [] && $jugadores != nil
			for i in (0..$jugadores.length-1)
				for j in(i+1..$jugadores.length)
					if i != j
						if $jugadores[i] != nil && $jugadores[j] != nil
							if $jugadores[i]['Email'] == $jugadores[j]['Email'] || $jugadores[i]['RUT'] == $jugadores[j]['RUT']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		#VERIFICA SI TODOS LOS JUGADORES TIENEN UNA INSTITUCIÓN DEPORTIVA VÁLIDA
		jugador_sin_club = false
		$jugadores.each do |jugador|
			flag = 0
			$participantes.each do |participante|
				if jugador['Institucion Deportiva'] == participante['Nombre']
					flag += 1
				end
			end
			if flag == 0
				jugador_sin_club = true
			end
		end
		
		$jugadores.sort! {|x,y| x['Institucion Deportiva'] <=> y['Institucion Deportiva']}

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay jugadores que están inscritos dos veces'
			elsif campo_invalido
				@alert = 'Alguno de los campos del archivo no coincide con el formato solicitado. Tanto el Nombre como los Apellidos no pueden contener caracteres especiales ni números. El RUT debe ser en el formato 12345678-k. El sexo puede ser indicado como F en caso de ser Femenino o M en el caso de ser Masculino. La fecha de nacimiento debe ser en el formato dd/mm/aaaa'	
			elsif jugador_sin_club
				@alert = 'Hay uno o más jugadores cuyas Instituciones Deportivas indicadas no coinciden con las registradas previamente. Compruebe el uso de mayúsculas y minúsculas.'	
			else
				redirect_to action: 'paso5'
			end
		end
	end

	def paso5
		$entrenadores = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$entrenadores.push(row.to_hash)
			end
		end

		nombre_repetido = false
		campo_vacio = false
		campo_invalido = false

		$entrenadores.each do |entrenador|
			if entrenador['Institucion Deportiva'] == nil || entrenador['Nombre'] == nil || entrenador['Apellido Paterno'] == nil || entrenador['Apellido Materno'] == nil || entrenador['RUT'] == nil || entrenador['Sexo'] == nil || entrenador['Fecha nacimiento'] == nil || entrenador['Email'] == nil
				campo_vacio = true
			elsif entrenador['Nombre'] !~ /^([A-Z]|[a-z])*/ || entrenador['Apellido Paterno'] !~ /^([A-Z]|[a-z])*/ || entrenador['Apellido Materno'] !~ /^([A-Z]|[a-z])*/ || entrenador['Sexo'] !~ /^M{1}|F{1}/ || entrenador['RUT'] !~ /^\d{8}-(\d|k)/ || entrenador['Fecha nacimiento'] !~ /^(\d{1,2})\/(\d{1,2})\/(\d{4})/ || entrenador['Email'] !~ /^([a-z]|\d)*\@([a-z]|\d)*\.[a-z]*/
				campo_invalido = true
			end
		end


		if $entrenadores != [] && $entrenadores != nil
			for i in (0..$entrenadores.length-1)
				for j in(i+1..$entrenadores.length)
					if i != j
						if $entrenadores[i] != nil && $entrenadores[j] != nil
							if $entrenadores[i]['Email'] == $entrenadores[j]['Email'] || $entrenadores[i]['RUT'] == $entrenadores[j]['RUT']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		#VERIFICA SI TODOS LOS ENTRENADORES TIENEN UNA INSTITUCIÓN DEPORTIVA VÁLIDA
		entrenador_sin_club = false
		$entrenadores.each do |entrenador|
			flag = 0
			$participantes.each do |participante|
				if entrenador['Institucion Deportiva'] == participante['Nombre']
					flag += 1
				end
			end
			if flag == 0
				entrenador_sin_club = true
			end
		end

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay entrenadores que están inscritos dos veces'
			elsif campo_invalido
				@alert = 'Alguno de los campos del archivo no coincide con el formato solicitado. Tanto el Nombre como los Apellidos no pueden contener caracteres especiales ni números. El RUT debe ser en el formato 12345678-k. El sexo puede ser indicado como F en caso de ser Femenino o M en el caso de ser Masculino. La fecha de nacimiento debe ser en el formato dd/mm/aaaa'
			elsif entrenador_sin_club
				@alert = 'Hay uno o más entrenadores cuyas Instituciones Deportivas indicadas no coinciden con las registradas previamente. Compruebe el uso de mayúsculas y minúsculas.'	
			else
				redirect_to action: 'paso6'
			end
		end
	end
	
	def paso6
		$jueces = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$jueces.push(row.to_hash)
			end
		end

		nombre_repetido = false
		campo_vacio = false
		campo_invalido = false

		$jueces.each do |juez|
			if juez['Nombre'] == nil || juez['Apellido Paterno'] == nil || juez['Apellido Materno'] == nil || juez['RUT'] == nil || juez['Sexo'] == nil || juez['Fecha nacimiento'] == nil || juez['Email'] == nil
				campo_vacio = true
			elsif juez['Nombre'] !~ /^([A-Z]|[a-z])*/ || juez['Apellido Paterno'] !~ /^([A-Z]|[a-z])*/ || juez['Apellido Materno'] !~ /^([A-Z]|[a-z])*/ || juez['Sexo'] !~ /^M{1}|F{1}/ || juez['RUT'] !~ /^\d{8}-(\d|k)/ || juez['Fecha nacimiento'] !~ /^(\d{1,2})\/(\d{1,2})\/(\d{4})/ || juez['Email'] !~ /^([a-z]|\d)*\@([a-z]|\d)*\.[a-z]*/
				campo_invalido = true
			end
		end


		if $jueces != [] && $jueces != nil
			for i in (0..$jueces.length-1)
				for j in(i+1..$jueces.length)
					if i != j
						if $jueces[i] != nil && $jueces[j] != nil
							if $jueces[i]['Email'] == $jueces[j]['Email'] || $jueces[i]['RUT'] == $jueces[j]['RUT']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay jueces que están inscritos dos veces'
			elsif campo_invalido
				@alert = 'Alguno de los campos del archivo no coincide con el formato solicitado. Tanto el Nombre como los Apellidos no pueden contener caracteres especiales ni números. El RUT debe ser en el formato 12345678-k. El sexo puede ser indicado como F en caso de ser Femenino o M en el caso de ser Masculino. La fecha de nacimiento debe ser en el formato dd/mm/aaaa'
			else
				redirect_to action: 'paso7'
			end
		end
	end
	
	def paso7
		$recintos = Array.new
		if file = params[:archivo]
			CSV.foreach(file.path, headers: true) do |row|
				$recintos.push(row.to_hash)
			end
		end
		
		nombre_repetido = false
		campo_vacio = false
		campo_invalido = false

		$recintos.each do |recinto|
			if recinto['Nombre'] == nil || recinto['Ciudad'] == nil || recinto['Pais'] == nil || recinto['Capacidad'] == nil 
				campo_vacio = true
			elsif recinto['Nombre'] !~ /^([A-Z]|[a-z])*/ || recinto['Ciudad'] !~ /^([A-Z]|[a-z])*/ || recinto['Pais'] !~ /^([A-Z]|[a-z])*/ || recinto['Capacidad'] !~ /^\d*/ 
				campo_invalido = true					
			end
		end


		if $recintos != [] && $recintos != nil
			for i in (0..$recintos.length-1)
				for j in(i+1..$recintos.length)
					if i != j
						if $recintos[i] != nil && $recintos[j] != nil
							if $recintos[i]['Nombre'] == $recintos[j]['Nombre'] && $recintos[i]['Pais'] == $recintos[j]['Pais'] && $recintos[i]['Ciudad'] == $recintos[j]['Ciudad']
								nombre_repetido = true
							end
						end
					end
				end
			end
		end

		if request.post?
			if campo_vacio
				@alert = 'Hay campos del archivo que están vacíos. Por favor revise que el archivo siga el formato adecuado'
			elsif nombre_repetido
				@alert = 'Hay recintos deportivos que están registrados dos veces'
			elsif campo_invalido
				@alert = 'Alguno de los campos del archivo no coincide con el formato solicitado. Los campos Nombre, Ciudad y País no pueden contener números ni caracteres especiales. La cantidad debe ser expresada sólo en números naturales'	
			else
				redirect_to action: 'paso8'
			end
		end
	end
	

	def paso8
		if request.post?
			#INSERT A LA TABLA COMPETENCIA
			competencia = Competencia.new
			competencia.nombre_comp = $nombre_competencia
			competencia.descripcion_comp = $desc_competencia
			competencia.tipo_comp = $tipo_competencia
			if $ida_vuelta == "ida"
				competencia.ida_vuelta_comp = true
			else
				competencia.ida_vuelta_comp = false
			end
			competencia.cant_part_comp = $cant_participantes.to_i
			competencia.fecha_inicio_comp = $fecha_inicio
			competencia.fecha_termino_comp = $fecha_fin
			competencia.cant_grupos_comp = $cant_grupos.to_i
			if $tipo_competencia == "liga"
				if $cant_participantes % 2 == 0
					$cant_fases = $cant_participantes.to_i-1
				else
					$cant_fases = $cant_participantes
				end
			elsif $tipo_competencia == "torneo"	
				$cant_fases = Math.log($cant_participantes.to_i)/Math.log(2)				
			else #COPA
				if $cant_grupos.to_i > 1
					cant_por_grupo = $cant_participantes.to_i/$cant_grupos.to_i-1
					cant_por_fase = $cant_clasificados.to_i*$cant_grupos.to_i
					for i in(0..6)
						if cant_por_fase == 2**i
							$cant_fases = cant_por_fase + cant_por_grupo
						elsif cant_por_fase > 2**i && cant_por_fase < 2**(i+1)
							$cant_fases = 2**(i+1) + cant_por_grupo
						end
					end
				end
			end
			if $ida_vuelta != "ida"
				$cant_fases= $cant_fases.to_i * 2
			end
			competencia.cant_fases_comp = $cant_fases
			competencia.cant_arbitros_comp = $cant_arbitros.to_i
			competencia.cant_jug_tit = $cant_titulares.to_i
			competencia.cant_jug_ban = $cant_banca.to_i
			competencia.cant_max_jug_comp = $cant_jugadores.to_i
			competencia.cant_mod_comp = $cant_cambios.to_i
			if $privacidad == "si"
				competencia.privacidad_comp = true
			else
				competencia.privacidad_comp = false
			end
			competencia.organizador_id = 0 #AGREGAAAAAAAAR!!!!
			competencia.save


			#INSERT A LA TABLA PARTICIPANTES
			ids_participantes = Array.new
			ids_part_comp = Array.new
			$participantes.each do |participante|
				nuevo_participante = Participante.new
				nuevo_participante.nombre_par = participante['Nombre']
				nuevo_participante.pais_par = participante['Pais']
				#participante_aux = {"nombre_par"=>participante['Nombre'], "pais_par"=>participante['Pais']}
				#Participante.create! participante_aux
				nuevo_participante.save

				#INSERT A LA TABLA PARTICIPANTE COMPETENCIA
				nueva_part_competencia = ParticipanteCompetencium.new
				nueva_part_competencia.competencia_id = competencia.id
				nueva_part_competencia.participante_id = nuevo_participante.id
				nueva_part_competencia.enc_ganados_par_com = 0
				nueva_part_competencia.enc_perdidos_par_com = 0
				nueva_part_competencia.enc_empatados_par_com = 0
				nueva_part_competencia.goles_favor_par_com = 0
				nueva_part_competencia.goles_contra_par_com = 0
				nueva_part_competencia.cant_tarjetas_amar_par_com = 0
				nueva_part_competencia.cant_tarjetas_roja_par_com = 0
				nueva_part_competencia.cant_puntos_par_com
				nueva_part_competencia.cant_enc_jugados_par_com = 0
				nueva_part_competencia.grupo_par_com = 0
				nueva_part_competencia.total_enc_grupo_par_com = 0
				nueva_part_competencia.save
				ids_part_comp.push({'id'=>nueva_part_competencia.id, 'nombre'=>participante['Nombre']})

				ids_participantes.push({'id'=>nuevo_participante.id, 'nombre'=>participante['Nombre']})
			end

			#INSERT A LA TABLA JUGADOR
			ids_jugadores = Array.new
			$jugadores.each do |jugador|
				nuevo_jugador = Jugador.new
				nuevo_jugador.nombre_jug = jugador['Nombre']
				nuevo_jugador.apellido_pat_jug = jugador['Apellido Paterno']
				nuevo_jugador.apellido_mat_jug = jugador['Apellido Materno']
				nuevo_jugador.rut_jug = jugador['RUT']
				nuevo_jugador.sexo_jug = jugador['Sexo']
				nuevo_jugador.fecha_nac_jug = jugador['Fecha nacimiento']
				nuevo_jugador.email_jug = jugador['Email']
				nuevo_jugador.save
				ids_jugadores.push({'id'=>nuevo_jugador.id, 'Institucion Deportiva'=>jugador['Institucion Deportiva']})
			end

			#INSERT A LA TABLA CONVOCATORIA
			#RELACIONAMIENTO ENTRE JUGADOR E INSTITUCIÓN DEPORTIVA
			for i in(0..ids_jugadores.length-1)
				for j in(0..ids_participantes.length-1)
					if ids_jugadores[i]['Institucion Deportiva'] == ids_participantes[j]['nombre']
						nueva_convocatoria = Convocatoria.new
						nueva_convocatoria.jugador_id = ids_jugadores[i]['id']
						nueva_convocatoria.participante_id = ids_participantes[j]['id']
						nueva_convocatoria.save						
					end
				end
			end

			#INSERT A LA TABLA RECINTO
			ids_recintos = Array.new
			$recintos.each do |recinto|
				nuevo_recinto = Recinto.new
				nuevo_recinto.nombre_rec = recinto['Nombre']
				nuevo_recinto.ciudad_rec = recinto['Ciudad']
				nuevo_recinto.pais_rec = recinto['Pais']
				nuevo_recinto.capacidad_rec = recinto['Capacidad']
				nuevo_recinto.save
				ids_recintos.push(nuevo_recinto.id)
			end

			#INSERT A LA TABLA RECINTO_COMPETENCIA
			ids_recintos.each do |recinto|
				nuevo_rec_comp = RecintoCompetencia.new
				nuevo_rec_comp.recinto_id = recinto
				nuevo_rec_comp.competencia_id = competencia.id
				nuevo_rec_comp.save
			end

			#INSERT A LA TABLA TECNICO
			ids_tecnicos = Array.new
			$entrenadores.each do |entrenador|
				nuevo_tecnico = Tecnico.new
				nuevo_tecnico.nombre_tec = entrenador['Nombre']
				nuevo_tecnico.apellido_pat_tec = entrenador['Apellido Paterno']
				nuevo_tecnico.apellido_mat_tec = entrenador['Apellido Materno']
				nuevo_tecnico.rut_tec = entrenador['RUT']
				nuevo_tecnico.sexo_tec = entrenador['Sexo']
				nuevo_tecnico.fecha_nac_tec = entrenador['Fecha nacimiento']
				nuevo_tecnico.email_tec = entrenador['Email']
				nuevo_tecnico.save
				ids_tecnicos.push({'id'=>nuevo_tecnico.id, 'Institucion Deportiva'=>entrenador['Institucion Deportiva']})

				#INSERT A LA TABLA ROL_CUERPO_TECNICO
				
				ids_part_comp.each do |part_comp|
					if part_comp['nombre'] == entrenador['Institucion Deportiva']
						nuevo_rol_cuerpo_tecnico = RolCuerpoTecnico.new
						nuevo_rol_cuerpo_tecnico.participante_competencium_id = part_comp['id']
						nuevo_rol_cuerpo_tecnico.tecnico_id = nuevo_tecnico.id
						nuevo_rol_cuerpo_tecnico.save
					end
				end

			end
			#INSERT A LA TABLA JUEZ
			$jueces.each do |juez|
				nuevo_juez = Juece.new
				nuevo_juez.nombre_juez = juez['Nombre']
				nuevo_juez.apellido_pat_juez = juez['Apellido Paterno']
				nuevo_juez.apellido_mat_juez = juez['Apellido Materno']
				nuevo_juez.rut_juez = juez['RUT']
				nuevo_juez.sexo_juez = juez['Sexo']
				nuevo_juez.fecha_nac_juez = juez['Fecha nacimiento']
				nuevo_juez.email_juez = juez['Email']
				nuevo_juez.save
			end			

			#COMPETENCIA DE TIPO LIGA
			if $tipo_competencia == "liga"
				#CREACIÓN DE LAS ETAPAS CORRESPONDIENTES
				$ids_etapas = Array.new
				id_etapa_siguiente = nil
				num_fases = $cant_fases.to_i
				while num_fases > 0
					etapa = Etapa.new
					etapa.nombre_etp = "Fecha "+num_fases.to_s
					etapa.tipo_etp = 0
					etapa.competencia_id = competencia.id
					etapa.etapa_id = id_etapa_siguiente
					etapa.save
					id_etapa_siguiente = etapa.id
					$ids_etapas.push(etapa.id)
					num_fases -= 1
				end

				#GENERACIÓN DEL FIXTURE EN UNA MATRIZ
				$fixture = Array.new($cant_fases.to_i) {Array.new($cant_participantes.to_i/2){Array.new(2)}}

				equipo1 = $cant_participantes.to_i-2
				equipo2 = 0
				alterna = true
				
				$fixture.each do |fecha|
					iteracion1 = true
					fecha.each do |encuentro|
						if iteracion1
							if alterna							
								encuentro[0] = $participantes[equipo1]	
								equipo1 -= 1
								encuentro[1] = $participantes[$cant_participantes.to_i-1]
								alterna = false
							else
								encuentro[1] = $participantes[equipo1]	
								equipo1 -= 1
								encuentro[0] = $participantes[$cant_participantes.to_i-1]
								alterna = true
							end
							iteracion1 = false
						else
							encuentro[0] = $participantes[equipo1]	
							equipo1 -= 1
							encuentro[1] = $participantes[equipo2]
							equipo2 += 1
						end

						if equipo1 < 0
							equipo1 = $cant_participantes.to_i-2
						end
						if equipo2 > $cant_participantes.to_i-2
							equipo2 = 0
						end
					end
					iteracion1 = false
				end

				#REGISTRO DE LOS ENCUENTROS
				i = 0
				$fixture.each do |fecha|
					fecha.each do |encuentro|
						nuevo_encuentro = Encuentro.new
						ids_participantes.each do |participante|
							#print $fixture[0][0][0]
							if encuentro[0]["Nombre"] == participante['nombre']
								nuevo_encuentro.id_local = participante['id']
							end
						end

						ids_participantes.each do |participante|
							if encuentro[1]["Nombre"] == participante['nombre']
								nuevo_encuentro.id_visita = participante['id']
							end
						end
						
						nuevo_encuentro.competencia_id = competencia.id
						nuevo_encuentro.etapa_id = $ids_etapas[i]
						nuevo_encuentro.estado_enc = "POR JUGAR"
						nuevo_encuentro.save
					end
					i += 1
				end
			
			#COMPETENCIA DE TIPO TORNEO
			elsif $tipo_competencia == "torneo"
				#CREACIÓN DE LAS ETAPAS CORRESPONDIENTES Y GENERACIÓN DEL FIXTURE
				ids_etapas = Array.new
				ids_aux = Array.new
				id_etapa_siguiente = nil
				for i in(0..$cant_fases.to_i-1)
					cont = 1
					(2**i).times do 
						etapa = Etapa.new
						if i == 0
							etapa.nombre_etp = "Final"
						elsif i == 1
							etapa.nombre_etp = "Semi Final"
						elsif i == 2
							etapa.nombre_etp = "Cuartos de Final"
						elsif i == 3
							etapa.nombre_etp = "Octavos de Final"
						elsif i == 4 
							etapa.nombre_etp = "16avos de Final"
						elsif i == 5
							etapa.nombre_etp = "32avos de Final"				
						end
						etapa.tipo_etp = 0
						etapa.competencia_id = competencia.id
						if cont%2 == 1
							etapa.etapa_id = ids_aux[0]
							cont += 1
						elsif cont%2 == 0
							etapa.etapa_id = ids_aux.shift
							cont += 1
						end	
						etapa.save
						ids_aux.push(etapa.id)
						if 2**i == 2**($cant_fases.to_i-1)
							ids_etapas.push({'id'=>etapa.id, 'nombre'=>etapa.nombre_etp})
						end
					end
					id_etapa_siguiente = etapa.id
				end

				#REGISTRO DE LOS ENCUENTROS
				contAux = 0
				for i in(0..ids_etapas.length-1)
					nuevo_encuentro = Encuentro.new						
					nuevo_encuentro.id_local = ids_participantes[contAux]['id']
					contAux += 1	
					nuevo_encuentro.id_visita = ids_participantes[contAux]['id']
					contAux += 1
					nuevo_encuentro.competencia_id = competencia.id
					nuevo_encuentro.etapa_id = ids_etapas[i]['id']
					nuevo_encuentro.estado_enc = "POR JUGAR"
					nuevo_encuentro.save
				end

			#COMPETENCIAS DE TIPO COPA
			else
				#SEPARACIÓN DE LOS GRUPOS
				part_por_grupo = $cant_participantes.to_i/$cant_grupos.to_i
				$grupos_copa = Array.new($cant_grupos.to_i){Array.new}
				contAux = 0
				$grupos_copa.each do |grupo|
					part_por_grupo.times do
						grupo.push(ids_participantes[contAux])
						contAux += 1
					end
				end

				contAux = 1
				$grupos_copa.each do |grupo|
					grupo.each do |participante|
						part_aux = ParticipanteCompetencium.find_by(participante_id: participante['id'])
						part_aux.grupo_par_com = contAux
						part_aux.save
					end
					contAux += 1
				end

				cant_part_por_grupo = 0
				$fixture_grupo = Array.new
				$grupos_copa.each do |grupo|
					#GENERACIÓN DEL FIXTURE DE CADA GRUPO EN UNA MATRIZ
					if part_por_grupo % 2 == 0
						cant_part_por_grupo = part_por_grupo-1
					else
						cant_part_por_grupo = part_por_grupo
					end
							
					fixture_aux = Array.new(cant_part_por_grupo) {Array.new(grupo.length/2){Array.new(2)}}
					equipo1 = grupo.length-2
					equipo2 = 0
					alterna = true
					
					fixture_aux.each do |fecha|
						iteracion1 = true
						fecha.each do |encuentro|
							if iteracion1
								if alterna							
									encuentro[0] = grupo[equipo1]	
									equipo1 -= 1
									encuentro[1] = grupo[grupo.length-1]
									alterna = false
								else
									encuentro[1] = grupo[equipo1]	
									equipo1 -= 1
									encuentro[0] = grupo[grupo.length-1]
									alterna = true
								end
								iteracion1 = false
							else
								encuentro[0] = grupo[equipo1]	
								equipo1 -= 1
								encuentro[1] = grupo[equipo2]
								equipo2 += 1
							end

							if equipo1 < 0
								equipo1 = grupo.length-2
							end
							if equipo2 > grupo.length-2
								equipo2 = 0
							end
						end
						iteracion1 = false
					end
					fixture_aux.each do |fase|
					end
					$fixture_grupo.push(fixture_aux)
				end

				#CREACIÓN DE LAS ETAPAS DE LA FASE DE GRUPOS
				numFase = cant_part_por_grupo
				fecha_siguiente = nil
				ids_fechas_copa = Array.new
				cant_part_por_grupo.times do
					nueva_fase = Etapa.new
					nueva_fase.nombre_etp = "Fecha "+numFase.to_s+"- Fase de Grupos"
					nueva_fase.tipo_etp = 0
					nueva_fase.competencia_id = competencia.id
					nueva_fase.etapa_id = fecha_siguiente
					nueva_fase.save
					ids_fechas_copa.push(nueva_fase.id)
					fecha_siguiente = nueva_fase.id
					numFase -= 1
				end

				#REGISTRO DE LOS ENCUENTROS
				$fixture_grupo.each do |fixture|
						i = 0
					fixture.each do |fecha|
						fecha.each do |encuentro|
							nuevo_encuentro = Encuentro.new
							nuevo_encuentro.id_local = encuentro[0]['id']
							nuevo_encuentro.id_visita = encuentro[1]['id']
							nuevo_encuentro.competencia_id = competencia.id
							nuevo_encuentro.etapa_id = ids_fechas_copa[i]
							nuevo_encuentro.estado_enc = "POR JUGAR"
							nuevo_encuentro.save
						end
							i += 1
					end  
				end

				#GENERACIÓN DE LA SEGUNDA FASE

				#DETERMINACIÓN DE LA CANTIDAD DE PARTICIPANTES DE LA SEGUNDA FASE
				part_fase2 = $cant_clasificados.to_i * $cant_grupos.to_i
				for i in(1..9)
					if part_fase2 > 2**i && part_fase2 <= 2**(i+1)
						part_fase2 = 2**(i+1)
					end
				end

				#CREACIÓN DE LAS ETAPAS DE LA SEGUNDA FASE
				num_fases = Math.log($cant_participantes.to_i)/Math.log(2)
				id_etapa_siguiente = nil
				ids_aux = Array.new
				id_etapa_final = nil
				for i in(0..num_fases-1)
					cont = 1
					(2**i).times do 
						etapa = Etapa.new
						if i == 0
							etapa.nombre_etp = "Final"
						elsif i == 1
							etapa.nombre_etp = "Semi Final"
						elsif i == 2
							etapa.nombre_etp = "Cuartos de Final"
						elsif i == 3
							etapa.nombre_etp = "Octavos de Final"
						elsif i == 4 
							etapa.nombre_etp = "16avos de Final"
						elsif i == 5
							etapa.nombre_etp = "32avos de Final"				
						end
						etapa.tipo_etp = 0
						etapa.competencia_id = competencia.id
						if cont%2 == 1
							etapa.etapa_id = ids_aux[0]
							cont += 1
						elsif cont%2 == 0
							etapa.etapa_id = ids_aux.shift
							cont += 1
						end	
						etapa.save
						ids_aux.push(etapa.id)
						if i == 0
							etapa_aux = Etapa.find_by(ids_fechas_copa.last)
							etapa_aux.etapa_id = etapa.id
							etapa_aux.save
						end
					end
					id_etapa_siguiente = etapa.id
				end

			end
					
			redirect_to action: 'paso9'
		end
	end

	def paso9

	end
	
	def enviarCorreo

		$jugadores.each do |jugador|

			EnviarCorreo.correo_notificacion(jugador['Email']).deliver
		end
		$entrenadores.each do |entrenador|

			EnviarCorreo.correo_notificacion(entrenador['Email']).deliver
		end
		$jueces.each do |juez|

			EnviarCorreo.correo_notificacion(juez['Email']).deliver
		end
		

	end
end

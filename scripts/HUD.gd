extends CanvasLayer


var visible = false
var select = 1
var menuselect = 1
var mapa = 0
var bussola = 0
var astrolabio = 0
var contador = 0
var velocidade = 1
var resistencia = 1
var tamanho = 1
var tecnologias = 1
var poderFogo = 1
var isNavigation = true
var speed = 0
var onScreen = false
var onMenu = false
var totalEstaleiros = 0
var labelEstaleiro = 1
var verificar = false
var totalTecnologias = 1
var barcoSelecionado = 7
var barcoDANIFICADO = 0
var pagina = 1
signal salvar
func _ready():
	$Holder/Theme.play()
	verificar = false
	
	$Holder/NovoBarco_background/total1.text = "1/"+str(GlobalVariables.vela)
	$Holder/NovoBarco_background/total2.text = "1/"+str(GlobalVariables.Madeira)
	$Holder/NovoBarco_background/total3.text = "1/"+str(GlobalVariables.arquitetura_nautica)
	$Holder/NovoBarco_background/total4.text = "1/3"
	$Holder/NovoBarco_background/total5.text = "1/"+str(GlobalVariables.canhao)
	pass 

func _process(delta):
	
	if !verificar:
		var n = 1
		verificar = true
		
		if GlobalVariables.compass == true:
			
			totalTecnologias += 2
			
		if GlobalVariables.cartography == true:
			
			totalTecnologias += 1
			
		if GlobalVariables.astrolabe == true:
			
			totalTecnologias +=1
			
		for i in range(0,6):
		
			if get_parent().get_node("YSort").get_child(i).purchased == true:
				
				totalEstaleiros +=1
				labelEstaleiro+= 1
				$Holder/Estabelecimento_background/Total2.text = str(n) + "/6"
				n += 1
		
			
	$Holder/HBoxContainer/Coins2.text = str(GlobalVariables.coins)
	$Holder/BarcosPossuidos.text = str(GlobalVariables.totalShips)
	if Input.is_action_just_pressed("esc"):
		if $Holder/Menu.visible == false:
			
			$Holder/Menu.visible = true
			$Holder/Estaleiro_background.visible = false
			$Holder/Expedition_background.visible = false
			$Holder/Studdy_background.visible = false
			$Holder/Mercadoria_background.visible = false
			$Holder/Estabelecimento_background.visible = false
			$Holder/AprimorarBarco_background.visible = false
			$Holder/NovoBarco_background.visible = false
			$Holder/RepararBarco_background.visible = false
			
			onScreen = false
			onMenu = true
			isNavigation = false
			
		else:
			$Holder/Menu.visible = false
			onMenu = false
			isNavigation = true
			
	if speed == 0:
		
		$Holder/Arrow.visible = true
		$Holder/Arrow2.visible = false
		$Holder/Arrow3.visible = false
		$Holder/Arrow4.visible = false
		
	if speed == 1:
		
		$Holder/Arrow.visible = true
		$Holder/Arrow2.visible = true
		$Holder/Arrow3.visible = false
		$Holder/Arrow4.visible = false
		
	if speed == 2:
		
		$Holder/Arrow.visible = true
		$Holder/Arrow2.visible = true
		$Holder/Arrow3.visible = true
		$Holder/Arrow4.visible = false
		
	if speed == 3:
		
		$Holder/Arrow.visible = true
		$Holder/Arrow2.visible = true
		$Holder/Arrow3.visible = true
		$Holder/Arrow4.visible = true
		
	if Input.is_action_just_pressed("speed"):
		
		if(speed == 3):
			speed = 0
			
		else:
			
			speed +=1
			
	if !isNavigation:
		
		$Holder/Selector1.visible = false
		$Holder/Selector2.visible = false
		$Holder/Selector3.visible = false
		$Holder/Selector4.visible = false
		
	if isNavigation:
		
		if Input.is_action_just_pressed("ui_down"):
			
			if(menuselect == 6):
				
				menuselect = 1
				
			else :
				
				menuselect = menuselect +1
				
		if Input.is_action_just_pressed("ui_up"):
			
			if(menuselect == 1):
				
				menuselect = 6
				
			else:
				
				menuselect = menuselect-1
				
		if menuselect == 1:
			
			$Holder/Selector1.visible = true
			$Holder/Selector2.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector5.visible = false
			$Holder/Selector6.visible = false
		if menuselect == 2:
			
			$Holder/Selector2.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector5.visible = false
			$Holder/Selector6.visible = false
			
		if menuselect == 3:
			
			$Holder/Selector3.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector2.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector5.visible = false
			$Holder/Selector6.visible = false
			
		if menuselect == 4:
			
			$Holder/Selector4.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector2.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector5.visible = false
			$Holder/Selector6.visible = false
		pass
		if menuselect == 5:
			$Holder/Selector5.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector2.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector6.visible = false
		
		if menuselect == 6:
			$Holder/Selector6.visible = true
			$Holder/Selector5.visible = false
			$Holder/Selector1.visible = false
			$Holder/Selector2.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector4.visible = false
		
	if $Holder/Mercadoria_background.visible == true:
		
		if Input.is_action_just_pressed("Enter"):
			
			$Holder/Mercadoria_background.visible = false
			isNavigation = true
			menuselect = 1
		

	if $Holder/Studdy_background.visible == true :
		
		if Input.is_action_just_pressed("ui_down"):
			
			if(select == 8):
				
				select = 1
				
			else :
				select = select +1
		if Input.is_action_just_pressed("ui_up"):
			
			if(select == 1):
				
				select = 8
			else:
				
				select = select-1
		
		if select == 1 and $Holder/Studdy_background.visible == true:
			
			$Holder/Studdy_background/Selector1.visible = true
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = false
			if Input.is_action_just_pressed("Enter") and bussola == 0:
				
				bussola = bussola +1
				$Holder/Studdy_background/Comprado1.visible = true
				$Holder/Studdy_background/Preco1 . visible = false
			
			
		if select == 2 and $Holder/Studdy_background.visible == true:
			
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = true
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = false
			
			
			if Input.is_action_just_pressed("Enter") and mapa == 0:
				
				mapa = mapa +1
				$Holder/Studdy_background/Comprado2.visible = true
				$Holder/Studdy_background/Preco2.visible = false
				
			
		if select == 3 and $Holder/Studdy_background.visible == true:
			
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = true
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = false
			
			if Input.is_action_just_pressed("Enter") and astrolabio == 0:
				
				astrolabio = astrolabio +1
				$Holder/Studdy_background/Comprado3.visible = true
				$Holder/Studdy_background/Preco3.visible = false
				
				
		if select == 4:
			
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = true
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = false
			
			if Input.is_action_just_pressed("Enter"):
				$Holder/Studdy_background.visible = false
				isNavigation = true
				onScreen = false
				menuselect = 1
		
		if select == 5:
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = true
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = false
		
		if select == 6:
			
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = true
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = false
		
		if select == 7:
			
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = true
			$Holder/Studdy_background/Selector8.visible = false
			
		if select == 8:
			
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector5.visible = false
			$Holder/Studdy_background/Selector6.visible = false
			$Holder/Studdy_background/Selector7.visible = false
			$Holder/Studdy_background/Selector8.visible = true
				
	
	if $Holder/Expedition_background.visible == true:
		
			if Input.is_action_just_pressed("ui_down"):
				
				if(select == 4):
				
					select = 1
				
				else :
					select = select +1
			if Input.is_action_just_pressed("ui_up"):
				
				if(select == 1):
					
					select = 4
				else:
					
					select = select-1
					
			if select == 1 :
				
				$Holder/Expedition_background/Selector1.visible = true
				$Holder/Expedition_background/Selector2.visible = false
				$Holder/Expedition_background/Selector3.visible = false
				$Holder/Expedition_background/Selector4.visible = false
				
			if select == 2 :
				
				$Holder/Expedition_background/Selector1.visible = false
				$Holder/Expedition_background/Selector2.visible = true
				$Holder/Expedition_background/Selector3.visible = false
				$Holder/Expedition_background/Selector4.visible = false
				
			if select == 3:
				
				$Holder/Expedition_background/Selector1.visible = false
				$Holder/Expedition_background/Selector2.visible = false
				$Holder/Expedition_background/Selector3.visible = true
				$Holder/Expedition_background/Selector4.visible = false
				
			if select == 4:
				
				$Holder/Expedition_background/Selector1.visible = false
				$Holder/Expedition_background/Selector2.visible = false
				$Holder/Expedition_background/Selector3.visible = false
				$Holder/Expedition_background/Selector4.visible = true
				
				pass
	if $Holder/Estaleiro_background.visible == true:
			
		if Input.is_action_just_pressed("ui_down"):
				
			if(select == 4):
				
				select = 1
				
			else :
					select = select +1
		if Input.is_action_just_pressed("ui_up"):
				
			if(select == 1):
				
				select = 4
				
			else:
				select = select-1
				
		if select == 1:
			
			$Holder/Estaleiro_background/Selector1.visible = true
			$Holder/Estaleiro_background/Selector2.visible = false
			$Holder/Estaleiro_background/Selector3.visible = false
			$Holder/Estaleiro_background/Selector4.visible = false
			
		if select == 2 :
			$Holder/Estaleiro_background/Selector1.visible = false
			$Holder/Estaleiro_background/Selector2.visible = true
			$Holder/Estaleiro_background/Selector3.visible = false
			$Holder/Estaleiro_background/Selector4.visible = false
			
		if select == 3:
			
			$Holder/Estaleiro_background/Selector1.visible = false
			$Holder/Estaleiro_background/Selector2.visible = false
			$Holder/Estaleiro_background/Selector3.visible = true
			$Holder/Estaleiro_background/Selector4.visible = false
			
		if select == 4:
			$Holder/Estaleiro_background/Selector1.visible = false
			$Holder/Estaleiro_background/Selector2.visible = false
			$Holder/Estaleiro_background/Selector3.visible = false
			$Holder/Estaleiro_background/Selector4.visible = true

	if $Holder/Estabelecimento_background.visible == true :
		
		if Input.is_action_just_pressed("ui_down"):
				
			if(select == 4):
				
				select = 1
				
			else :
				select = select +1
		if Input.is_action_just_pressed("ui_up"):
				
			if(select == 1):
				
				select = 4
				
			else:
					
				select = select-1
					
		if select == 1:
			
			$Holder/Estabelecimento_background/Selector1.visible = true
			$Holder/Estabelecimento_background/Selector2.visible = false
			$Holder/Estabelecimento_background/Selector3.visible = false
			$Holder/Estabelecimento_background/Selector4.visible = false
			
		if select == 2:
			
			$Holder/Estabelecimento_background/Selector1.visible = false
			$Holder/Estabelecimento_background/Selector2.visible = true
			$Holder/Estabelecimento_background/Selector3.visible = false
			$Holder/Estabelecimento_background/Selector4.visible = false
			
		if select == 3:
			
			$Holder/Estabelecimento_background/Selector1.visible = false
			$Holder/Estabelecimento_background/Selector2.visible = false
			$Holder/Estabelecimento_background/Selector3.visible = true
			$Holder/Estabelecimento_background/Selector4.visible = false
		
		if select == 4:
			
			$Holder/Estabelecimento_background/Selector1.visible = false
			$Holder/Estabelecimento_background/Selector2.visible = false
			$Holder/Estabelecimento_background/Selector3.visible = false
			$Holder/Estabelecimento_background/Selector4.visible = true
			
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		if Input.is_action_just_pressed("ui_down"):
				
			if(select == 6):
				
				select = 1
				
			else :
				
				select = select +1
				
		if Input.is_action_just_pressed("ui_up"):
				
			if(select == 1):
				
				select = 6
				
			else:
					
				select = select-1
					
		if select == 1:
			
			$Holder/AprimorarBarco_background/Selector1.visible = true
			$Holder/AprimorarBarco_background/Selector2.visible = false
			$Holder/AprimorarBarco_background/Selector3.visible = false
			$Holder/AprimorarBarco_background/Selector4.visible = false
			$Holder/AprimorarBarco_background/Selector5.visible = false
			$Holder/AprimorarBarco_background/Selector6.visible = false
		
		if select == 2:
			
			$Holder/AprimorarBarco_background/Selector1.visible = false
			$Holder/AprimorarBarco_background/Selector2.visible = true
			$Holder/AprimorarBarco_background/Selector3.visible = false
			$Holder/AprimorarBarco_background/Selector4.visible = false
			$Holder/AprimorarBarco_background/Selector5.visible = false
			$Holder/AprimorarBarco_background/Selector6.visible = false
			
		if select == 3:
			
			$Holder/AprimorarBarco_background/Selector1.visible = false
			$Holder/AprimorarBarco_background/Selector2.visible = false
			$Holder/AprimorarBarco_background/Selector3.visible = true
			$Holder/AprimorarBarco_background/Selector4.visible = false
			$Holder/AprimorarBarco_background/Selector5.visible = false
			$Holder/AprimorarBarco_background/Selector6.visible = false
			
		if select == 4:
			
			$Holder/AprimorarBarco_background/Selector1.visible = false
			$Holder/AprimorarBarco_background/Selector2.visible = false
			$Holder/AprimorarBarco_background/Selector3.visible = false
			$Holder/AprimorarBarco_background/Selector4.visible = true
			$Holder/AprimorarBarco_background/Selector5.visible = false
			$Holder/AprimorarBarco_background/Selector6.visible = false
			
		if select == 5:
			
			$Holder/AprimorarBarco_background/Selector1.visible = false
			$Holder/AprimorarBarco_background/Selector2.visible = false
			$Holder/AprimorarBarco_background/Selector3.visible = false
			$Holder/AprimorarBarco_background/Selector4.visible = false
			$Holder/AprimorarBarco_background/Selector5.visible = true
			$Holder/AprimorarBarco_background/Selector6.visible = false
			
		if select == 6:
			
			$Holder/AprimorarBarco_background/Selector1.visible = false
			$Holder/AprimorarBarco_background/Selector2.visible = false
			$Holder/AprimorarBarco_background/Selector3.visible = false
			$Holder/AprimorarBarco_background/Selector4.visible = false
			$Holder/AprimorarBarco_background/Selector5.visible = false
			$Holder/AprimorarBarco_background/Selector6.visible = true
			
	if $Holder/NovoBarco_background.visible == true:
		
		if Input.is_action_just_pressed("ui_down"):
				
			if(select == 7):
				
				select = 1
				
			else :
				
				select = select +1
				
		if Input.is_action_just_pressed("ui_up"):
				
			if(select == 1):
				
				select = 7
				
			else:
					
				select = select-1
		
		if select == 1:
			
			$Holder/NovoBarco_background/Selector1.visible = true
			$Holder/NovoBarco_background/Selector2.visible = false
			$Holder/NovoBarco_background/Selector3.visible = false
			$Holder/NovoBarco_background/Selector4.visible = false
			$Holder/NovoBarco_background/Selector5.visible = false
			$Holder/NovoBarco_background/Selector6.visible = false
			$Holder/NovoBarco_background/Selector7.visible = false
			
		if select == 2:
			
			$Holder/NovoBarco_background/Selector1.visible = false
			$Holder/NovoBarco_background/Selector2.visible = true
			$Holder/NovoBarco_background/Selector3.visible = false
			$Holder/NovoBarco_background/Selector4.visible = false
			$Holder/NovoBarco_background/Selector5.visible = false
			$Holder/NovoBarco_background/Selector6.visible = false
			$Holder/NovoBarco_background/Selector7.visible = false
		
		if select == 3:
			
			$Holder/NovoBarco_background/Selector1.visible = false
			$Holder/NovoBarco_background/Selector2.visible = false
			$Holder/NovoBarco_background/Selector3.visible = true
			$Holder/NovoBarco_background/Selector4.visible = false
			$Holder/NovoBarco_background/Selector5.visible = false
			$Holder/NovoBarco_background/Selector6.visible = false
			$Holder/NovoBarco_background/Selector7.visible = false
			
		if select == 4:
			
			$Holder/NovoBarco_background/Selector1.visible = false
			$Holder/NovoBarco_background/Selector2.visible = false
			$Holder/NovoBarco_background/Selector3.visible = false
			$Holder/NovoBarco_background/Selector4.visible = true
			$Holder/NovoBarco_background/Selector5.visible = false
			$Holder/NovoBarco_background/Selector6.visible = false
			$Holder/NovoBarco_background/Selector7.visible = false
			
			
		if select == 5:
			
			$Holder/NovoBarco_background/Selector1.visible = false
			$Holder/NovoBarco_background/Selector2.visible = false
			$Holder/NovoBarco_background/Selector3.visible = false
			$Holder/NovoBarco_background/Selector4.visible = false
			$Holder/NovoBarco_background/Selector5.visible = true
			$Holder/NovoBarco_background/Selector6.visible = false
			$Holder/NovoBarco_background/Selector7.visible = false
			
		if select == 6:
			
			$Holder/NovoBarco_background/Selector1.visible = false
			$Holder/NovoBarco_background/Selector2.visible = false
			$Holder/NovoBarco_background/Selector3.visible = false
			$Holder/NovoBarco_background/Selector4.visible = false
			$Holder/NovoBarco_background/Selector5.visible = false
			$Holder/NovoBarco_background/Selector6.visible = true
			$Holder/NovoBarco_background/Selector7.visible = false
			
		if select == 7:
			
			$Holder/NovoBarco_background/Selector1.visible = false
			$Holder/NovoBarco_background/Selector2.visible = false
			$Holder/NovoBarco_background/Selector3.visible = false
			$Holder/NovoBarco_background/Selector4.visible = false
			$Holder/NovoBarco_background/Selector5.visible = false
			$Holder/NovoBarco_background/Selector6.visible = false
			$Holder/NovoBarco_background/Selector7.visible = true
			
func _on_StuddyButtom_pressed():
	if onScreen == false and !onMenu:
		
			$Holder/Studdy_background.visible = true
			isNavigation = false
			onScreen = true
			select = 1
			$Holder/Studdy_background/total4.text = str(GlobalVariables.Madeira-1)+"/4"
			$Holder/Studdy_background/total5.text = str(GlobalVariables.canhao-1)+"/4"
			$Holder/Studdy_background/total6.text = str(GlobalVariables.vela-1)+"/4"
			$Holder/Studdy_background/total7.text = str(GlobalVariables.arquitetura_nautica-1)+"/2"
			if GlobalVariables.compass == true:
				
				$Holder/Studdy_background/total1.text = " 1/1"
				
				
			if GlobalVariables.cartography == true:
				
				$Holder/Studdy_background/total2.text = " 1/1"
				
				
			if GlobalVariables.astrolabe == true:
				
				$Holder/Studdy_background/total3.text = " 1/1"
				

func _on_MercadoriaButton_pressed():
	if onScreen == false and !onMenu:
		$Holder/Mercadoria_background.visible = true
		isNavigation = false
		onScreen = true
	
	pass # Replace with function body.


func _on_GerenciamentoButton_pressed():
	if onScreen == false and !onMenu:
		
		$Holder/Gerenciamento_background.visible = true
		isNavigation = false
		onScreen = true
	
		
	pass # Replace with function body.


func _on_Button1_mouse_entered():
	
	if $Holder/Expedition_background.visible == true:
		select = 1
	
	pass # Replace with function body.


func _on_Button2_mouse_entered():
	
	if $Holder/Expedition_background.visible == true:
		
		select = 2
	


func _on_Button3_mouse_entered():
		
	if $Holder/Expedition_background.visible == true:
		
		select = 3
	
	pass # Replace with function body.


func _on_Button4_mouse_entered():
		
	if $Holder/Expedition_background.visible == true:
		
		select = 4
	
	pass # Replace with function body.


func _on_ExpeditionButtom_pressed():
	if onScreen == false and !onMenu:
		$Holder/Expedition_background.visible = true
		isNavigation = false
		onScreen = true
		select = 1
	pass # Replace with function body.


func _on_Button1_pressed():
	pass # Replace with function body.


func _on_Button2_pressed():
	pass # Replace with function body.


func _on_Button3_pressed():
	pass # Replace with function body.


func _on_Button4_pressed():
	
	if $Holder/Expedition_background.visible == true:
		
		isNavigation = true
		onScreen = false
		$Holder/Expedition_background.visible = false
		
	pass # Replace with function body.


func _on_MercadoriaButton_mouse_entered():
	
	if isNavigation:
		
		menuselect =3
	pass # Replace with function body.


func _on_GerenciamentoButton_mouse_entered():
	
	if isNavigation:
		
		menuselect =4
		
	pass # Replace with function body.


func _on_ExpeditionButtom_mouse_entered():
	
	if isNavigation:
		
		menuselect =5
		
	pass # Replace with function body.


func _on_StuddyButtom_mouse_entered():
		
	if isNavigation:
		
		menuselect = 6
		
	pass # Replace with function body.


func _on_TimeButton_pressed():
	
	speed+=1
	
	if speed == 4:
		
		speed = 0
			
	pass # Replace with function body.


func _on_EstaleiroButton_mouse_entered():
	
	menuselect = 2
	pass # Replace with function body.


func _on_NovoBarco_Button_mouse_entered():
	
	if $Holder/Estaleiro_background.visible == true:
		select = 1
	
	pass # Replace with function body.


func _on_AprimorarBarco_button_mouse_entered():
	
	if $Holder/Estaleiro_background.visible == true:
		select = 2
	
	pass # Replace with function body.


func _on_Reparar_Barco_mouse_entered():
	
	if $Holder/Estaleiro_background.visible == true:
		select = 3
	
	pass # Replace with function body.


func _on_Sair_mouse_entered():
	
	if $Holder/Estaleiro_background.visible == true:
		select = 4
	
	pass # Replace with function body.


func _on_EstaleiroButton_pressed():
	
	if onScreen == false and !onMenu:
		
	
			
		$Holder/Estaleiro_background.visible = true
		isNavigation = false
		onScreen = true
		select = 1
	
	pass # Replace with function body.


func _on_AutoSave_pressed():
	
	if $Holder/Menu/checkbox.visible == true:
		
		$Holder/Menu/checkbox.visible = false
		$Holder/Menu/checkboxFull.visible = true
		
	elif $Holder/Menu/checkboxFull.visible == true:
		
		
		$Holder/Menu/checkbox.visible = true
		$Holder/Menu/checkboxFull.visible = false



func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"),value)
	pass # Replace with function body.


func _on_Theme_finished():
	$Holder/Theme.play()
	pass # Replace with function body.


func _on_EstabelecimentoButton_pressed():
	if !onMenu and !onScreen:
		
		isNavigation = false
		onScreen = true
		$Holder/Estabelecimento_background.visible = true
	
	pass # Replace with function body.


func _on_EstabelecimentoButton_mouse_entered():
	
	menuselect = 1
	
	pass # Replace with function body.


func _on_Sair_pressed():
	
	onScreen = false
	$Holder/Estaleiro_background.visible = false
	isNavigation = true
	pass # Replace with function body.


func _on_ButtonSairMercadoria_pressed():
	
	$Holder/Mercadoria_background.visible = false
	isNavigation = true
	onScreen = false
	
	pass # Replace with function body.


func _on_BussolButton_mouse_entered():
	
	if $Holder/Studdy_background.visible == true:
		select = 1
		
	pass # Replace with function body.


func _on_CartografiaButton_mouse_entered():
		
	if $Holder/Studdy_background.visible == true:
		select = 2
		
	pass # Replace with function body.


func _on_AstrolabioButton_mouse_entered():
		
	if $Holder/Studdy_background.visible == true:
		select = 3
		
	pass # Replace with function body.


func _on_Sairbutton_mouse_entered():
		
	if $Holder/Studdy_background.visible == true:
		select = 8
		
	pass # Replace with function body.


func _on_BussolButton_pressed():
	
	if GlobalVariables.coins >= 3000 and $Holder/Studdy_background.visible == true:
		
		$Holder/Studdy_background/total1.text = " 1/1"
		GlobalVariables.compass = true
		GlobalVariables.coins -= 3000
		totalTecnologias += 2
		
	pass # Replace with function body.


func _on_CartografiaButton_pressed():
	
	if GlobalVariables.coins >= 3500 and $Holder/Studdy_background.visible == true :
		
		$Holder/Studdy_background/total2.text = " 1/1"
		GlobalVariables.cartography = true
		GlobalVariables.coins -= 3500
		totalTecnologias+=1
	pass # Replace with function body.


func _on_AstrolabioButton_pressed():
	
	if GlobalVariables.coins >= 3500 and $Holder/Studdy_background.visible == true :
		
		$Holder/Studdy_background/total3.text = " 1/1"
		GlobalVariables.astrolabe = true
		GlobalVariables.coins -= 3500
		totalTecnologias+=1
	pass # Replace with function body.


func _on_Sairbutton_pressed():
	
	if  $Holder/Studdy_background.visible == true:
		$Holder/Studdy_background.visible = false
		onScreen = false
		isNavigation = true
	pass # Replace with function body.


func _on_Button_pressed():
	
	if $Holder/Gerenciamento_background.visible == true:
		
		onScreen = false
		isNavigation = true
		$Holder/Gerenciamento_background.visible = false
		
	pass # Replace with function body.


func _on_RefinariaButton_pressed():
	pass # Replace with function body.


func _on_CanhoesButton_pressed():
	
	pass # Replace with function body.


func _on_SairButton_pressed():
	
	if $Holder/Estabelecimento_background.visible == true:
		
		onScreen = false
		isNavigation = true
		$Holder/Estabelecimento_background.visible = false
		
	pass # Replace with function body.


func _on_Estaleiro2Button_pressed():
	
	if $Holder/Estabelecimento_background.visible == true:
		$Holder/Estabelecimento_background/Total2.text = str(labelEstaleiro) + "/6"
		
		if totalEstaleiros <5 && get_parent().get_node("YSort").get_child(5).purchased == false :
			get_parent().get_node("YSort").get_child(totalEstaleiros).purchased = true
			totalEstaleiros += 1
			labelEstaleiro += 1
		

	
	pass # Replace with function body.


func _on_RefinariaButton_mouse_entered():
	
	if $Holder/Estabelecimento_background.visible == true:
		select = 1
	
	pass # Replace with function body.


func _on_CanhoesButton_mouse_entered():
	
	if $Holder/Estabelecimento_background.visible == true:
		select = 3
	
	pass # Replace with function body.


func _on_Estaleiro2Button_mouse_entered():
	
	if $Holder/Estabelecimento_background.visible == true:
		select = 2
	
	pass # Replace with function body.


func _on_SairButton_mouse_entered():
	
	if $Holder/Estabelecimento_background.visible == true:
		select = 4
	pass # Replace with function body.


func _on_FecharJogo_pressed():
	
	if onMenu:
		get_tree().quit()
	
	pass # Replace with function body.


func _on_SairMenu_pressed():
	
	if onMenu:
		$Holder/Menu.visible = false
		onMenu = false
		isNavigation = true
	pass # Replace with function body.


func _on_ManualSave_pressed():
	
	emit_signal("salvar")
	pass # Replace with function body.


func _on_NovoBarco_Button_pressed():
	
	if $Holder/Estaleiro_background.visible == true :
		
		if GlobalVariables.totalShips >=24 :
			
			$Holder/Estaleiro_background/semEspacoPlayer.play("FLIP")
			$Holder/Estaleiro_background/semEspacoPlayer/semEspaco.visible = true
			
			return
		
		
		
		for i in range (0,6):
		
			if get_parent().get_node("YSort").get_child(i).building == false and GlobalVariables.totalShips <24 and get_parent().get_node("YSort").get_child(i).purchased == true  :
			
				$Holder/NovoBarco_background.visible = true
				$Holder/Estaleiro_background.visible = false
				
				velocidade = 1
				resistencia = 1
				tamanho = 1
				tecnologias = 1
				poderFogo = 1
				$Holder/NovoBarco_background/total1.text = str(velocidade)+"/"+str(GlobalVariables.vela)
				$Holder/NovoBarco_background/total2.text =str(resistencia)+"/"+str(GlobalVariables.Madeira)
				$Holder/NovoBarco_background/total3.text = str(tamanho)+"/"+str(GlobalVariables.arquitetura_nautica)
				$Holder/NovoBarco_background/total4.text = str(tecnologias)+"/"+str(totalTecnologias)
				$Holder/NovoBarco_background/total5.text = str(poderFogo)+"/"+str(GlobalVariables.canhao)
				
				
				break
				
			if i == 5:
				if get_parent().get_node("YSort").get_child(i).building == true or get_parent().get_node("YSort").get_child(i).purchased == false :
					
					$Holder/Estaleiro_background/semEspacoPlayer.play("FLIP2")
					$Holder/Estaleiro_background/semEspacoPlayer/SemEstaleiro.visible = true
					
			pass
	
			
		##	pass
			
	pass




func _on_AprimorarBarco_button_pressed():
	
	if $Holder/Estaleiro_background.visible == true :
		
		if GlobalVariables.totalShips == 0:
			
			$Holder/Estaleiro_background/semEspacoPlayer.play("FLIP3")
			$Holder/Estaleiro_background/semEspacoPlayer/semBarcos.visible = true
			
			return
			
		for i in range(0,6):
		
			if get_parent().get_node("YSort").get_child(i).building == false and get_parent().get_node("YSort").get_child(i).purchased == true :
				
				$Holder/Estaleiro_background.visible = false
				$Holder/AprimorarBarco_background.visible = true
				$Holder/AprimorarBarco_background/totalBARCOS.text = str(pagina)+"/"+str(GlobalVariables.totalShips)
				velocidade = get_parent().get_node("YSort").get_child(barcoSelecionado).speed
				resistencia = get_parent().get_node("YSort").get_child(barcoSelecionado).resistance
				tamanho = get_parent().get_node("YSort").get_child(barcoSelecionado).size
				tecnologias = get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies
				poderFogo = get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power
				
				if get_parent().get_node("YSort").get_child(barcoSelecionado) is KinematicBody2D: 
					
					
					$Holder/AprimorarBarco_background/total1.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).speed)+"/"+str(GlobalVariables.vela)
					$Holder/AprimorarBarco_background/total2.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).resistance)+"/"+str(GlobalVariables.Madeira)
					$Holder/AprimorarBarco_background/total3.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).size)+"/"+str(GlobalVariables.arquitetura_nautica)
					$Holder/AprimorarBarco_background/total4.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies)+"/"+str(totalTecnologias)
					$Holder/AprimorarBarco_background/total5.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power)+"/"+str(GlobalVariables.canhao)
				break
				
			if i == 5:
				if get_parent().get_node("YSort").get_child(i).building == true or get_parent().get_node("YSort").get_child(i).purchased == false :
					
					$Holder/Estaleiro_background/semEspacoPlayer.play("FLIP2")
					$Holder/Estaleiro_background/semEspacoPlayer/SemEstaleiro.visible = true
				
	pass # Replace with function body.


func _on_velocidade_button_mouse_entered():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		select = 1
		
	pass # Replace with function body.


func _on_resistencia_button_mouse_entered():
	
	
	if $Holder/AprimorarBarco_background.visible == true:
		select = 2
		
	pass # Replace with function body.


func _on_tamanho_button_mouse_entered():
	
	if $Holder/AprimorarBarco_background.visible == true:
		select = 3
		
	pass # Replace with function body.


func _on_tecnologias_button_mouse_entered():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		select = 4
		
	pass # Replace with function body.


func _on_poder_fogo_button_mouse_entered():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		select = 5
		
	pass # Replace with function body.


func _on_sair_barco_melhorias_mouse_entered():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		select = 6
		
	pass # Replace with function body.


func _on_velocidade_button_pressed():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		if get_parent().get_node("YSort").get_child(barcoSelecionado).speed<5 :
			
			if velocidade < GlobalVariables.vela:
			
				velocidade +=1
				print(velocidade)
				$Holder/AprimorarBarco_background/total1.text = str(velocidade)+"/"+str(GlobalVariables.vela)
		
			else :
				print("here")
				velocidade = get_parent().get_node("YSort").get_child(barcoSelecionado).speed
				$Holder/AprimorarBarco_background/total1.text = str(velocidade)+"/"+str(GlobalVariables.vela)
		pass
	
	pass # Replace with function body.


func _on_Velocidade_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 1
		
	pass # Replace with function body.


func _on_Resistencia_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 2
		
	pass # Replace with function body.


func _on_Tamanho_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 3
		
	pass # Replace with function body.


func _on_Tecnologogias_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 4
		
	pass # Replace with function body.


func _on_PoderDeFogo_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 5
		
	pass # Replace with function body.


func _on_Sair_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 6
		
	pass # Replace with function body.


func _on_Comprar_NOVOBARCO_mouse_entered():
	
	if $Holder/NovoBarco_background.visible == true:
		
		select = 7
		
	pass # Replace with function body.


func _on_Sair_NOVOBARCO_pressed():
	
	if $Holder/NovoBarco_background.visible == true:
		
		$Holder/NovoBarco_background.visible = false
		$Holder/Estaleiro_background.visible = true
		
	pass # Replace with function body.


func _on_SairReparar_button_mouse_entered():
	
	if $Holder/RepararBarco_background.visible == true:
		
		select = 1
	pass # Replace with function body.


func _on_custoReparar_button_mouse_entered():
	
	if $Holder/RepararBarco_background.visible == true:
		
		select = 2
	
	pass # Replace with function body.


func _on_SairReparar_button_pressed():
	
	if $Holder/RepararBarco_background.visible == true:
		
		$Holder/Estaleiro_background.visible = true
		$Holder/RepararBarco_background.visible = false
	
	
	pass # Replace with function body.


func _on_Reparar_Barco_pressed():
	
	if $Holder/Estaleiro_background.visible == true:
		pagina = 1
		barcoDANIFICADO = 0
		
		for i in range (0,24+6):
			
			if get_parent().get_node("YSort").get_child(i) is KinematicBody2D and get_parent().get_node("YSort").get_child(i).name != "TaxesShip":
				get_parent().get_node("YSort").get_child(7).life -= 2
				if get_parent().get_node("YSort").get_child(i).life < 100:
					
					$Holder/Estaleiro_background.visible = false
					$Holder/RepararBarco_background.visible = true
					
					barcoDANIFICADO += 1
					
					
		$Holder/RepararBarco_background/Contador.text = str(pagina)+"/"+str(barcoDANIFICADO)
		$Holder/RepararBarco_background/Label2.text = "VIDA    = "+str(get_parent().get_node("YSort").get_child(7).life )
		$Holder/RepararBarco_background/Label3.text = "VEL     = "+str(get_parent().get_node("YSort").get_child(7).speed)
		$Holder/RepararBarco_background/Label4.text = "RES     = "+str(get_parent().get_node("YSort").get_child(7).resistance)
		$Holder/RepararBarco_background/Label5.text = "TAM     = "+str(get_parent().get_node("YSort").get_child(7).size)
		$Holder/RepararBarco_background/Label6.text = "TEC     = "+str(get_parent().get_node("YSort").get_child(7).navegation_technologies)
		$Holder/RepararBarco_background/Label7.text = "POD     = "+str(get_parent().get_node("YSort").get_child(7).fire_power)
		
		if $Holder/RepararBarco_background.visible == false:
			
			$Holder/Estaleiro_background/semEspacoPlayer.play("FLIP4")
			$Holder/Estaleiro_background/semEspacoPlayer/semBarcoVida.visible = true
			return
			
			
		for i in range(0,6):
		
			if get_parent().get_node("YSort").get_child(i).building == false and get_parent().get_node("YSort").get_child(i).purchased == true :
				
				$Holder/Estaleiro_background.visible = false
				$Holder/RepararBarco_background.visible = true
				
				break
			if i == 5:
				
				if get_parent().get_node("YSort").get_child(i).building == true or get_parent().get_node("YSort").get_child(i).purchased == false :
					
					$Holder/Estaleiro_background/semEspacoPlayer.play("FLIP2")
					$Holder/Estaleiro_background/semEspacoPlayer/SemEstaleiro.visible = true
				
		
		
	pass # Replace with function body.


func _on_custoReparar_button_pressed():
	
	pass # Replace with function body.


func _on_MadeitaButton_mouse_entered():
	
	if $Holder/Studdy_background.visible == true:
		
		select = 4
	pass # Replace with function body.


func _on_CanhaoButton_mouse_entered():
	
	if $Holder/Studdy_background.visible == true:
		
		select = 5
	pass # Replace with function body.


func _on_VelaButton_mouse_entered():
	

	if $Holder/Studdy_background.visible == true:
		
		select = 6
	pass # Replace with function body.


func _on_Arquiteutra_Button_mouse_entered():
	
	if $Holder/Studdy_background.visible == true:
		
		select = 7
	pass # Replace with function body.


func _on_semEspacoPlayer_animation_finished(anim_name):
	
	$Holder/Estaleiro_background/semEspacoPlayer/semEspaco.visible = false
	$Holder/Estaleiro_background/semEspacoPlayer/SemEstaleiro.visible = false
	$Holder/Estaleiro_background/semEspacoPlayer/semBarcos.visible = false
	$Holder/Estaleiro_background/semEspacoPlayer/semBarcoVida.visible = false
	
	pass # Replace with function body.


func _on_sair_barco_melhorias_pressed():
	
	$Holder/AprimorarBarco_background.visible = false
	$Holder/Estaleiro_background.visible = true
	
	
	
	pass # Replace with function body.


func _on_Velocidade_NOVOBARCO_pressed():
	
	if $Holder/NovoBarco_background.visible == true:
		
		if velocidade < GlobalVariables.vela:
			
			velocidade += 1
			$Holder/NovoBarco_background/total1.text = str(velocidade)+"/"+str(GlobalVariables.vela)
		
		else:
			
			velocidade = 1
			$Holder/NovoBarco_background/total1.text = str(velocidade)+"/"+str(GlobalVariables.vela)
		
		pass
	pass # Replace with function body.


func _on_Resistencia_NOVOBARCO_pressed():
	
	if $Holder/NovoBarco_background.visible == true:
		
		if resistencia < GlobalVariables.Madeira:
			
			resistencia += 1
			$Holder/NovoBarco_background/total2.text =str(resistencia)+"/"+str(GlobalVariables.Madeira)
		
		else :
			
			resistencia = 1
			$Holder/NovoBarco_background/total2.text =str(resistencia)+"/"+str(GlobalVariables.Madeira)
	
	pass # Replace with function body.


func _on_Tamanho_NOVOBARCO_pressed():
	
	if $Holder/NovoBarco_background.visible == true:
		
		if tamanho < GlobalVariables.arquitetura_nautica:
			
			tamanho += 1
			$Holder/NovoBarco_background/total3.text = str(tamanho)+"/"+str(GlobalVariables.arquitetura_nautica)
			
		else:
			tamanho = 1
			$Holder/NovoBarco_background/total3.text = str(tamanho)+"/"+str(GlobalVariables.arquitetura_nautica)
	
	pass # Replace with function body.


func _on_Tecnologogias_NOVOBARCO_pressed():
	
	if $Holder/NovoBarco_background.visible == true:
		
		if tecnologias < totalTecnologias:
			
			tecnologias += 1
			$Holder/NovoBarco_background/total4.text = str(tecnologias)+"/"+str(totalTecnologias)
		else :
			
			tecnologias = 1
			$Holder/NovoBarco_background/total4.text = str(tecnologias)+"/"+str(totalTecnologias)
			
	pass # Replace with function body.


func _on_PoderDeFogo_NOVOBARCO_pressed():
	
	if $Holder/NovoBarco_background.visible == true:
		
		if poderFogo < GlobalVariables.canhao :
			
			poderFogo +=1
			$Holder/NovoBarco_background/total5.text = str(poderFogo)+"/"+str(GlobalVariables.canhao)
		
		else:
			
			poderFogo = 1
			$Holder/NovoBarco_background/total5.text = str(poderFogo)+"/"+str(GlobalVariables.canhao)
	
	pass # Replace with function body.


func _on_Comprar_NOVOBARCO_pressed():
	
	for i in range(0,6):
		if get_parent().get_node("YSort").get_child(i).building == false and get_parent().get_node("YSort").get_child(i).purchased == true:
			get_parent().get_node("YSort").get_child(i).buildShip(velocidade,resistencia,tamanho,tecnologias,poderFogo,false,[1,1])
			print("NovoBarco")
			break
	
	velocidade = 1
	resistencia = 1
	tamanho = 1
	tecnologias = 1
	poderFogo = 1
	$Holder/NovoBarco_background/total1.text = str(velocidade)+"/"+str(GlobalVariables.vela)
	$Holder/NovoBarco_background/total2.text =str(resistencia)+"/"+str(GlobalVariables.Madeira)
	$Holder/NovoBarco_background/total3.text = str(tamanho)+"/"+str(GlobalVariables.arquitetura_nautica)
	$Holder/NovoBarco_background/total4.text = str(tecnologias)+"/"+str(totalTecnologias)
	$Holder/NovoBarco_background/total5.text = str(poderFogo)+"/"+str(GlobalVariables.canhao)
	
	pass # Replace with function body.


func _on_MadeitaButton_pressed():
	
	if $Holder/Studdy_background.visible == true:
		
		if GlobalVariables.Madeira <= 4:
			
			$Holder/Studdy_background/total4.text = str(GlobalVariables.Madeira)+"/4"
			GlobalVariables.Madeira+=1
			
			pass
		pass
	pass # Replace with function body.


func _on_CanhaoButton_pressed():
	
	if $Holder/Studdy_background.visible == true:
		
		if GlobalVariables.canhao <=4:
			
			$Holder/Studdy_background/total5.text = str(GlobalVariables.canhao)+"/4"
			GlobalVariables.canhao+=1
			
	pass # Replace with function body.


func _on_VelaButton_pressed():
	
	if $Holder/Studdy_background.visible == true:
		
		if GlobalVariables.vela <=4:
			
			$Holder/Studdy_background/total6.text = str(GlobalVariables.vela)+"/4"
			GlobalVariables.vela+=1
			
	pass # Replace with function body.


func _on_Arquiteutra_Button_pressed():
	
	if $Holder/Studdy_background.visible == true:
		
		if GlobalVariables.arquitetura_nautica <= 2:
			
			$Holder/Studdy_background/total7.text = str(GlobalVariables.arquitetura_nautica)+"/2"
			GlobalVariables.arquitetura_nautica+=1
			
	pass # Replace with function body.


func _on_PROXIMO_pressed():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		if barcoSelecionado < 7+GlobalVariables.totalShips-1:
			pagina +=1 
			barcoSelecionado += 1
		
		
		else:
			barcoSelecionado = 7
			pagina = 1
		
		$Holder/AprimorarBarco_background/totalBARCOS.text = str(pagina)+"/"+str(GlobalVariables.totalShips)
		$Holder/AprimorarBarco_background/total1.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).speed)+"/"+str(GlobalVariables.vela)
		$Holder/AprimorarBarco_background/total2.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).resistance)+"/"+str(GlobalVariables.Madeira)
		$Holder/AprimorarBarco_background/total3.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).size)+"/"+str(GlobalVariables.arquitetura_nautica)
		$Holder/AprimorarBarco_background/total4.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies)+"/"+str(totalTecnologias)
		$Holder/AprimorarBarco_background/total5.text = str(get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power)+"/"+str(GlobalVariables.canhao)
		velocidade = get_parent().get_node("YSort").get_child(barcoSelecionado).speed
		resistencia = get_parent().get_node("YSort").get_child(barcoSelecionado).resistance
		tamanho = get_parent().get_node("YSort").get_child(barcoSelecionado).size
		tecnologias = get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies
		poderFogo = get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power
		print(velocidade)
	pass # Replace with function body.


func _on_resistencia_button_pressed():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		if get_parent().get_node("YSort").get_child(barcoSelecionado).resistance<5 :
			
			if resistencia < GlobalVariables.Madeira:
			
				resistencia +=1
				
				$Holder/AprimorarBarco_background/total2.text = str(resistencia)+"/"+str(GlobalVariables.Madeira)
		
			else :
				
				resistencia = get_parent().get_node("YSort").get_child(barcoSelecionado).resistance
				$Holder/AprimorarBarco_background/total2.text = str(resistencia)+"/"+str(GlobalVariables.Madeira)
		pass
	pass # Replace with function body.


func _on_tamanho_button_pressed():
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		if get_parent().get_node("YSort").get_child(barcoSelecionado).size<3 :
			
			if tamanho < GlobalVariables.arquitetura_nautica:
			
				tamanho +=1
				
				$Holder/AprimorarBarco_background/total3.text = str(tamanho)+"/"+str(GlobalVariables.arquitetura_nautica)
		
			else :
				
				tamanho = get_parent().get_node("YSort").get_child(barcoSelecionado).size
				$Holder/AprimorarBarco_background/total3.text = str(tamanho)+"/"+str(GlobalVariables.arquitetura_nautica)
		pass
	pass # Replace with function body.


func _on_tecnologias_button_pressed():
	
	
	if $Holder/AprimorarBarco_background.visible == true:
		
		if get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies<5 :
			
			if tecnologias < totalTecnologias:
			
				tecnologias +=1
				
				$Holder/AprimorarBarco_background/total4.text = str(tecnologias)+"/"+str(totalTecnologias)
		
			else :
				
				tecnologias = get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies
				$Holder/AprimorarBarco_background/total4.text = str(tecnologias)+"/"+str(totalTecnologias)
		pass
	pass # Replace with function body.


func _on_poder_fogo_button_pressed():
	
	if $Holder/AprimorarBarco_background.visible == true:
		if get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power<5 :
			
				if poderFogo < GlobalVariables.canhao:
			
					poderFogo +=1
				
					$Holder/AprimorarBarco_background/total5.text = str(poderFogo)+"/"+str(GlobalVariables.canhao)
		
				else :
				
					poderFogo = get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power
					$Holder/AprimorarBarco_background/total5.text = str(poderFogo)+"/"+str(GlobalVariables.canhao)
		
	pass # Replace with function body.


func _on_comprar_melhorias_pressed():
	
	if $Holder/AprimorarBarco_background.visible == true:
		if get_parent().get_node("YSort").get_child(barcoSelecionado).anchored == true and poderFogo > get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power or velocidade > get_parent().get_node("YSort").get_child(barcoSelecionado).speed or resistencia > get_parent().get_node("YSort").get_child(barcoSelecionado).resistance or tecnologias > get_parent().get_node("YSort").get_child(barcoSelecionado).navegation_technologies:
			print("ANCORADO")
			for i in range(0,6):
				
				get_parent().get_node("YSort").get_child(i).buildShip(velocidade,resistencia,tamanho,tecnologias,poderFogo,true,[get_parent().get_node("YSort").get_child(barcoSelecionado).resistance,get_parent().get_node("YSort").get_child(barcoSelecionado).fire_power])
				
				$Holder/AprimorarBarco_background.visible = false
				$Holder/Estaleiro_background.visible = true
				break
	pass # Replace with function body.

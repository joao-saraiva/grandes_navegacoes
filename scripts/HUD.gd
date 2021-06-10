extends CanvasLayer

var visible = false
var select = 1
var menuselect = 1
var mapa = 0
var bussola = 0
var astrolabio = 0
var contador = 0
var isNavigation = true
var speed = 0
func _ready():

	pass 

func _process(delta):
	$Holder/Label2.text = str(GlobalVariables.totalShips)+"/20"	#linha de teste
	$Holder/HBoxContainer/Label.text = str(GlobalVariables.coins)#linha de teste
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
			if(menuselect == 4):
				menuselect = 1
				
			else :
				menuselect = menuselect +1
		if Input.is_action_just_pressed("ui_up"):
			if(menuselect == 1):
				menuselect = 4
			else:
				menuselect = menuselect-1
		if menuselect == 1:
			$Holder/Selector1.visible = true
			$Holder/Selector2.visible = false
			$Holder/Selector4.visible = false
		if menuselect == 2:
			$Holder/Selector2.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector3.visible = false
		if menuselect == 3:
			$Holder/Selector3.visible = true
			$Holder/Selector2.visible = false
			$Holder/Selector4.visible = false
		if menuselect == 4:
			$Holder/Selector4.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector3.visible = false
		pass
	if Input.is_action_just_pressed("ui_down"):
		contador+=1
		$Holder/Mercadoria_background/Valor1.text = str(contador)
		
	if $Holder/Mercadoria_background.visible == true:
		if Input.is_action_just_pressed("Enter"):
			$Holder/Mercadoria_background.visible = false
			isNavigation = true
			menuselect = 1
		

	if $Holder/Studdy_background.visible == true :
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
		
		if select == 1 and $Holder/Studdy_background.visible == true:
			$Holder/Studdy_background/Selector1.visible = true
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			if Input.is_action_just_pressed("Enter") and bussola == 0:
				bussola = bussola +1
				$Holder/Studdy_background/Comprado1.visible = true
				$Holder/Studdy_background/Preco1 . visible = false
				print("comprado")
			
		if select == 2 and $Holder/Studdy_background.visible == true:
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector2.visible = true
			if Input.is_action_just_pressed("Enter") and mapa == 0:
				mapa = mapa +1
				$Holder/Studdy_background/Comprado2.visible = true
				$Holder/Studdy_background/Preco2.visible = false
				print("comprado")
			
		if select == 3 and $Holder/Studdy_background.visible == true:
			$Holder/Studdy_background/Selector2.visible = false
			$Holder/Studdy_background/Selector4.visible = false
			$Holder/Studdy_background/Selector3.visible = true
			if Input.is_action_just_pressed("Enter") and astrolabio == 0:
				astrolabio = astrolabio +1
				$Holder/Studdy_background/Comprado3.visible = true
				$Holder/Studdy_background/Preco3.visible = false
				print("comprado")
		if select == 4:
			$Holder/Studdy_background/Selector3.visible = false
			$Holder/Studdy_background/Selector1.visible = false
			$Holder/Studdy_background/Selector4.visible = true
			if Input.is_action_just_pressed("Enter"):
				$Holder/Studdy_background.visible = false
				isNavigation = true
				menuselect = 1



func _on_StuddyButtom_pressed():
			$Holder/Studdy_background.visible = true
			isNavigation = false
			select = 1
		
		
		





func _on_MercadoriaButton_pressed():
	$Holder/Mercadoria_background.visible = true
	isNavigation = false
	
	pass # Replace with function body.


func _on_GerenciamentoButton_pressed():
	$Holder/Gerenciamento_background.visible = true
	isNavigation = false
	pass # Replace with function body.

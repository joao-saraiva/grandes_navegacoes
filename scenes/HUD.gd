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
var mouse1 = false
var mouse2 = false
var mouse3 = false
var mouse4 = false
func _ready():

	pass 

func _process(delta):
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
			
			if(menuselect == 5):
				
				menuselect = 1
				
			else :
				
				menuselect = menuselect +1
				
		if Input.is_action_just_pressed("ui_up"):
			
			if(menuselect == 1):
				
				menuselect = 5
				
			else:
				
				menuselect = menuselect-1
				
		if menuselect == 1:
			
			$Holder/Selector1.visible = true
			$Holder/Selector2.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector5.visible = false
		if menuselect == 2:
			
			$Holder/Selector2.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector5.visible = false
		if menuselect == 3:
			
			$Holder/Selector3.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector2.visible = false
			$Holder/Selector4.visible = false
			$Holder/Selector5.visible = false
			
		if menuselect == 4:
			
			$Holder/Selector4.visible = true
			$Holder/Selector1.visible = false
			$Holder/Selector2.visible = false
			$Holder/Selector3.visible = false
			$Holder/Selector5.visible = false
		pass
		if menuselect == 5:
			$Holder/Selector5.visible = true
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
	$Holder/Expedition_background.visible = true
	isNavigation = false
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
		$Holder/Expedition_background.visible = false
		
	pass # Replace with function body.


func _on_MercadoriaButton_mouse_entered():
	
	if isNavigation:
		
		menuselect =2
	pass # Replace with function body.


func _on_GerenciamentoButton_mouse_entered():
	
	if isNavigation:
		
		menuselect =3
		
	pass # Replace with function body.


func _on_ExpeditionButtom_mouse_entered():
	
	if isNavigation:
		
		menuselect =4
		
	pass # Replace with function body.


func _on_StuddyButtom_mouse_entered():
		
	if isNavigation:
		
		menuselect =5
		
	pass # Replace with function body.


func _on_TimeButton_pressed():
	
	speed+=1
	
	if speed == 4:
		
		speed = 0
			
	pass # Replace with function body.


func _on_EstaleiroButton_mouse_entered():
	
	menuselect = 1
	pass # Replace with function body.

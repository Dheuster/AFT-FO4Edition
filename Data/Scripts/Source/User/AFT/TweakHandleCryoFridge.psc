Scriptname AFT:TweakHandleCryoFridge extends ObjectReference Const

Potion Property pNukaColaQuantum Auto Const
Potion Property pNukaColaCherry  Auto Const
Potion Property pNukaCola        Auto Const

Potion Property pNukaColaQuantum_cold Auto Const
Potion Property pNukaColaCherry_cold  Auto Const
Potion Property pNukaCola_cold        Auto Const

Event OnInit()
	AddInventoryEventFilter(pNukaColaQuantum)
	AddInventoryEventFilter(pNukaColaCherry)
	AddInventoryEventFilter(pNukaCola)
EndEvent

Event OnItemAdded(Form akBaseItem, int aiItemCount, ObjectReference akItemReference, ObjectReference akSourceContainer)
	if (akBaseItem == pNukaColaQuantum)
		RemoveItem(akBaseItem, aiItemCount, true)
		AddItem(pNukaColaQuantum_cold, aiItemCount, true)
	elseif (akBaseItem == pNukaColaCherry)
		RemoveItem(akBaseItem, aiItemCount, true)
		AddItem(pNukaColaCherry_cold, aiItemCount, true)
	elseif (akBaseItem == pNukaCola)
		RemoveItem(akBaseItem, aiItemCount, true)
		AddItem(pNukaCola_cold, aiItemCount, true)		
	endif	
EndEvent
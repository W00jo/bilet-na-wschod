extends Sprite2D
class_name InteractiveBook2D

#func _ready():
	#current_page = 0
	#go_to_page(current_page)

## - Use this to always get a page number that is within the set page count
## - Cycles the number when a value outside the accepted range is provided
#func clamp_current_page(new_page : int) -> int:
	## - negative values are interpreted as wanting to go to the last page
	#if new_page < 0:
		#new_page = page_count
	## - number greater than the page count are interpreted as wanting to go back to the first
	#elif new_page > page_count:
		#new_page = 0
	#
	#return new_page # return the updated number once in accepted range
	
#func go_to_page(page : int):
	## do nothing if already at the given page
	#if current_page == page:
		#return
	## do nothing if given a negative number or a number outside the page count
	#if page < 0 or page > page_count:
		#return
	## going to the first page - closed from front
	#if page == 0:
		#if current_page == 1: # on the first page
			#play("close_from_first") # play animation for closing the book from the first page
		#elif current_page == page_count: # book closed from back
			#play("closed_front") # go directly to closed front animation. As if flipping the book
		#else: # close from the middle otherwise
			#play("close_from_middle")
	## going to the last page - closed from back
	#elif page == page_count:
		#if current_page == page_count - 1: # on the last page
			#play("close_from_last") # play animation for closing the book from the last page
		#elif current_page == 0: # book closed from front
			#play("closed_back") # go directly to closed front animation. As if flipping the book
	## going to the first page
	#elif page == 1:
		#if current_page == 0: # currently closed from front
			#play("open_to_first") # open the book to the first page
		#elif current_page == 2: # on the second page
			#play("previous_to_first") # go back to the first page
	## going to the last page
	#elif page == page_count - 1:
		#if current_page == page_count: # currently closed from back
			#play("open_to_last") # open to the last page
		#if current_page == page_count - 2: # on the second to last page
			#play("next_to_last") # go to the last page
	## going to second page from fist
	#elif page == 2 and current_page == 1:
		#play("next_from_first")
	## going to second last page from last
	#elif page == page_count - 2 && current_page == page_count - 1:
		#play("previous_from_last")
	## going to any middle page
	#else:
		#if page > current_page: # play next page if next page number is greater
			#play("next_page")
		#elif page < current_page: # play previous page if next page number is lesser
			#play("previous_page")
	#
	#current_page = page # set current page to the new page

func _on_next_page_button_pressed() -> void:
	print("next page")

func _on_previous_page_button_pressed() -> void:
	print("previous page")

func _on_exit_button_pressed() -> void:
	get_tree().quit()

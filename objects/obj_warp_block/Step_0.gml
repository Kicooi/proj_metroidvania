if place_meeting(x,y, obj_player) {
	room_goto(target_rm);
	if vertical == false {
		obj_player.x = target_x;
	}
	if vertical == true {
		obj_player.y = target_y;
	}
}
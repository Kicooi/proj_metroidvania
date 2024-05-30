right = input_check("right");
left = input_check("left");
jump = input_check_pressed("accept");
crouch = input_check("special");
mask_index = IDLE;
switch (state) {
	#region IDLE;
	case IDLE:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + 1, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd > 0 {state = RUN}
		if xspd < 0 {state = TURN}
		if (jump) {state = JUMP}
		if (crouch) {
			crouching = true;
			state = CROUCH;
		}
	break
	#endregion
	
	#region RUN
	case RUN:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd < 0 {state = TURN}
		if xspd == 0 && right == 0 {state = IDLE};
		if (jump) {state = JUMP}
	break;
	#endregion
	
	#region TURN
	case TURN:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		// Assign Sprites/Change States //
		if ceil(image_index) == image_number-1 && left == 0 {state = IDLE_L}
		if ceil(image_index) == image_number-1 && left > 0 {state = RUN_L}	
		show_debug_message(string(image_index));
	break;
	#endregion
	
	#region JUMP
	case JUMP:
		xspd = (right-left) * move_spd;
		yspd = -6;
		if jumping == false {
			jumping = true;
			alarm[0] = 20;
		}		
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
			//state = IDLE;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		if xspd < 0 {state= JUMP_L}
	break;
	#endregion
	
	#region JUMPFALL_TRANS
	case JUMPFALL_TRANS:
		xspd = (right-left) * move_spd;
		yspd = 0;
		image_index = 0;
		if jumping == true {
			alarm[1] = 10;
			jumping = false;
		}
		//collison
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		if xspd < 0 {state = JUMPFALL_TRANS_L}
	break;
	#endregion
	
	#region FALL
	case FALL:
		xspd = (right-left) * move_spd;
		yspd = 6;
		
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
			if xspd == 0 {
				state = IDLE;
			}
			if xspd > 0 {
				state = RUN;
			}
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		if xspd < 0 {state = FALL_L}
	break;
	#endregion
	
	#region CROUCH
	case CROUCH:
		xspd = (right-left) * move_spd/2;
		yspd = 6;
		mask_index = sprite[CROUCH];
		if (!crouch) && crouching == true {
			if place_empty(x,y-11, obj_wall) {
				crouching = false;
			}
		}
		if (!crouch) && crouching == false {
			y -= 20;
			state = IDLE;
		}
		
		//Collisions
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
	break;
	#endregion
	
	#region IDLE_L
	case IDLE_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd > 0 {state = TURN_L}
		if xspd < 0 {state = RUN_L}
		if (jump) {state = JUMP_L}
	break;
	#endregion
	
	#region RUN_L
	case RUN_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd > 0 {state = TURN_L}
		if xspd == 0 && left == 0 {state = IDLE_L};
		if (jump) {state = JUMP_L}
	break;
	#endregion
	
	#region TURN_L
	case TURN_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		// Assign Sprites/Change States //
		if ceil(image_index) == image_number-1 && right == 0 {state = IDLE}
		if ceil(image_index) == image_number-1 && right > 0 {state = RUN}	
	break;
	#endregion
	
	#region JUMP_L
	case JUMP_L:
		xspd = (right-left) * move_spd;
		yspd = -6;
		if jumping == false {
			jumping = true;
			alarm[0] = 20;
		}		
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
			//alarm[0] = 1;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		if xspd > 0 {state = JUMP}
	break;
	#endregion
	
	#region JUMPFALL_TRANS_L;
	case JUMPFALL_TRANS_L:
		xspd = (right-left) * move_spd;
		yspd = 0;
		image_index = 0;
		if jumping == true {
			alarm[1] = 10;
			jumping = false;
		}
		//collison
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		if xspd > 0 {state = JUMPFALL_TRANS_L}
	break;
	#endregion
	
	#region FALL_L
	case FALL_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			yspd = 0;
			if xspd == 0 {
				state = IDLE_L;
			}
			if xspd < 0 {
				state = RUN_L;
			}
		}
		if place_meeting(x+xspd, y, obj_wall) {
			xspd = 0;
		}
		if xspd > 0 {state = FALL}
	break;
	#endregion
	
}
sprite_index = sprite[state];

x += xspd;
y += yspd;
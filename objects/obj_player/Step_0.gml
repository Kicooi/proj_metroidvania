right = input_check("right");
left = input_check("left");
jump = input_check_pressed("accept");
crouch = input_check("special");
mask_index = IDLE;
switch (state) {
	#region IDLE
	case IDLE:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y+yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd > 0 {state = RUN}
		if xspd < 0 {state = TURN}
		if (jump) {state = JUMP}
		if (crouch) {
			state = CROUCH_TRANS; 
		}
	break
	#endregion
	
	#region RUN
	case RUN:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd < 0 {state = TURN}
		if xspd == 0 && right == 0 {state = IDLE};
		if (jump) {state = JUMP}
		if (crouch) {
			state = CROUCH_TRANS;
		}
	break;
	#endregion
	
	#region TURN
	case TURN:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		// Assign Sprites/Change States //
		if ceil(image_index) == image_number-1 && left == 0 {state = IDLE_L}
		if ceil(image_index) == image_number-1 && left > 0 {state = RUN_L}	
		if (jump) {state = JUMP_L}
		if (crouch) {
			crouching = true;
			state = CROUCH_L;
		}
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
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
			//state = IDLE;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
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
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
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
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
			if xspd == 0 {
				state = IDLE;
			}
			if xspd > 0 {
				state = RUN;
			}
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		if xspd < 0 {state = FALL_L}
	break;
	#endregion
	
	#region CROUCH
	case CROUCH:
		xspd = (right-left) * move_spd/2;
		yspd = 6;
		mask_index = CROUCH;
		// Check if character has room to stand up when player releases crouch key
		if (!crouch) && crouching == true {
			if place_empty(x,y-11, obj_wall) {
				y -= 11;
				alarm[2] = 5;
				state = CROUCH_TRANS;
			}
		}
		//if (!crouch) && crouching == false {
		//	y -= 21;
		//	state = IDLE;
		//}
		
		// Normal Collisions
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		if left > 0 && right == 0 {state = CROUCH_L}
		if xspd < 0 {state = CROUCH_WALK_L}
		if xspd > 0 {state = CROUCH_WALK}
		if (jump) {
			state = JUMP;
			y -= 11;
			crouching = false;
		}
	break;
	#endregion
	
	#region CROUCH_WALK
	case CROUCH_WALK:
		xspd = (right-left) * move_spd/2;
		yspd = 6;
		mask_index = sprite[CROUCH];
		// Check if character has room to stand up when player releases crouch key
		if (!crouch) && crouching == true {
			if place_empty(x,y-11, obj_wall) {
				y -= 11;
				alarm[2] = 5;
				state = CROUCH_TRANS;
			}
		}
		
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// Update sprites
		if xspd == 0 {state = CROUCH}
		if xspd < 0 {state = CROUCH_WALK_L}
		if (jump) {
			state = JUMP;
			y -= 11;
			crouching = false;
		}
		
	break;
	#endregion
	
	#region CROUCH TRANSITION
	case CROUCH_TRANS:
		xspd = (right-left) * move_spd;
		yspd = 0;
		mask_index = CROUCH_TRANS;
		
		if crouching == false {
			crouching = true;
			y += 5;
			alarm[2] = 5;	
		} 
		
		//collison
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
	break;
	#endregion
	
	#region CROUCH TRANSITION_LEFT
	case CROUCH_TRANS_L:
		xspd = (right-left) * move_spd;
		yspd = 0;
		mask_index = CROUCH_TRANS_L;
		
		if crouching == false {
			crouching = true;
			y += 5;
			alarm[3] = 5;	
		} 
		
		//collison
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
	break;
	#endregion
	
	#region CROUCH_WALK_L
	case CROUCH_WALK_L:
		xspd = (right-left) * move_spd/2;
		yspd = 6;
		mask_index = sprite[CROUCH_L];
		// Check if character has room to stand up when player releases crouch key
		if (!crouch) && crouching == true {
			if place_empty(x,y-11, obj_wall) {
				y -= 11;
				alarm[3] = 5;
				state = CROUCH_TRANS_L;
			}
		}
		
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// Update sprites
		if xspd == 0 {state = CROUCH_L}
		if xspd > 0 {state = CROUCH_WALK}
		if (jump) {
			state = JUMP_L;
			y -= 11;
			crouching = false;
		}
		
	break;
	#endregion
	
	#region CROUCH_L
	case CROUCH_L:
		xspd = (right-left) * move_spd/2;
		yspd = 6;
		mask_index = sprite[CROUCH_L];
		// Check if character has room to stand up when player releases crouch key
		if (!crouch) && crouching == true {
			if place_empty(x,y-11, obj_wall) {
				y -= 11;
				alarm[3] = 5;
				state = CROUCH_TRANS_L;
			}
		}
		
		// Normal Collisions
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// switch directions
		if left == 0 && right > 0 {state = CROUCH}
		if xspd < 0 {state = CROUCH_WALK_L}
		if xspd > 0 {state = CROUCH_WALK}
		if (jump) {
			state = JUMP_L;
			y -= 11;
			crouching = false;
		}
		
	break;
	#endregion
	
	#region IDLE_L
	case IDLE_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd > 0 {state = TURN_L}
		if xspd < 0 {state = RUN_L}
		if (jump) {state = JUMP_L}
		if (crouch) {
			state = CROUCH_TRANS_L; 
		}
	break;
	#endregion
	
	#region RUN_L
	case RUN_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		
		// Assign Sprites/Change States //
		if xspd > 0 {state = TURN_L}
		if xspd == 0 && left == 0 {state = IDLE_L};
		if (jump) {state = JUMP_L}
		if (crouch) {
			state = CROUCH_TRANS_L;
		}
	break;
	#endregion
	
	#region TURN_L
	case TURN_L:
		xspd = (right-left) * move_spd;
		yspd = 6;
		// Collisions 
		if place_meeting(x, y + yspd, obj_wall) {
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		// Assign Sprites/Change States //
		if ceil(image_index) == image_number-1 && right == 0 {state = IDLE}
		if ceil(image_index) == image_number-1 && right > 0 {state = RUN}
		if (jump) {state = JUMP}
		if (crouch) {
			crouching = true;
			state = CROUCH;
		}
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
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
			//alarm[0] = 1;
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
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
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
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
			while (!place_meeting(x,y+sign(yspd),obj_wall)) {
				y += sign(yspd);
			}
			yspd = 0;
			if xspd == 0 {
				state = IDLE_L;
			}
			if xspd < 0 {
				state = RUN_L;
			}
		}
		if place_meeting(x+xspd, y, obj_wall) {
			while (!place_meeting(x+sign(xspd),y,obj_wall)) {
				x += sign(xspd);
			}
			xspd = 0;
		}
		if xspd > 0 {state = FALL}
	break;
	#endregion
	
}
sprite_index = sprite[state];

x += xspd;
y += yspd;
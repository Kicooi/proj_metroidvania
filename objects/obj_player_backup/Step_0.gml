right = input_check("right");
left = input_check("left");

xspd = (right - left) * move_spd;
if jumping == false{
	yspd = 6;
}

if keyboard_check_pressed(vk_space) && jumping == false {
	jumping = true
	yspd = -8;
	alarm[0] = 15;
}

// Collisons
if place_meeting(x, y + yspd, obj_wall) {
	yspd = 0;
}
if place_meeting(x+xspd, y, obj_wall) {
	xspd = 0;
}

mask_index = _Idle;
if yspd == 0 {
	if xspd < 0 {face = RIGHT};
	if xspd > 0 {face = LEFT};
}
if yspd > 0 {face = FALL};
if yspd < 0 {face = JUMP};
if xspd < 0 && face == IDLE {face = RIGHT};
if xspd < 0 && face == IDLE_L {face = RIGHT};
if xspd < 0 && face == LEFT {face = RIGHT};
if xspd > 0 && face == IDLE {face = LEFT};
if xspd > 0 && face == IDLE_L {face = LEFT};
if xspd > 0 && face == RIGHT {face = LEFT};

if (xspd == 0) && (yspd == 0) && face == LEFT {
	if right == 0 && left == 0 {
		face = IDLE;
	}
	if (right - left) == 0 {
		face = IDLE;
	}
}
if (xspd == 0) && (yspd == 0) && face == FALL {
	if right == 0 && left == 0 {
		face = IDLE;
	}
	if (right - left) == 0 {
		face = IDLE;
	}
}
if (xspd == 0) && (yspd == 0) && face == RIGHT {
	if right == 0 && left == 0 {
		face = IDLE_L;
	}
	if (right - left) == 0 {
		face = IDLE_L;
	}
}
if (xspd == 0) && (yspd == 0) && face == IDLE_L {
	if left == 1 && right == 0 {
		face = RIGHT;
	}
}
if (xspd == 0) && (yspd == 0) && face == IDLE {
	if left == 0 && right == 1 {
		face = LEFT;
	}
}

sprite_index = sprite[face];

y += yspd;
x += xspd;
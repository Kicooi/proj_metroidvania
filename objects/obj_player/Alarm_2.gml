if crouch{
	state = CROUCH;
	y += 5;
}
if !crouch {
	state = IDLE;
	crouching = false;
	y -= 11;
}
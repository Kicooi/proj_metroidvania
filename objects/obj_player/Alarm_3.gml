if crouch{
	state = CROUCH_L;
	y += 5;
}
if !crouch {
	state = IDLE_L;
	crouching = false;
	y -= 11;
}
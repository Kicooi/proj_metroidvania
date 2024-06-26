// Initialize variables
yspd = 6;
xspd = 0;

pos_y = y;
pos_x = x;
right = 0;
left = 0;
jump = 0;
crouch = 0;

move_spd = 2;
jumping = false;
crouching = false;

//initialize sprites in an array
#region SPRITE_ARRAY //Array of 60 Sprites for player movement, action, and animation
sprite = array_create(60, -1);
sprite[ATTACK] = _Attack;
sprite[ATTACK_L] = _Attack_left;
sprite[ATTACK2] = _Attack2;
sprite[ATTACK2_L] = _Attack2_left;
sprite[ATTACK2_NM] = _Attack2NoMovement;
sprite[ATTACK2_NM_L] = _Attack2NoMovement_left;
sprite[ATTACK_COMBO2HIT] = _AttackCombo2hit;
sprite[ATTACK_COMBO2HIT_L] = _AttackCombo2hit_left;
sprite[ATTACK_COMBO_NM] = _AttackComboNoMovement;
sprite[ATTACK_COMBO_NM_L] = _AttackComboNoMovement_left;
sprite[ATTACK_NM] = _AttackNoMovement;
sprite[ATTACK_NM_L] = _AttackNoMovement_left;
sprite[CROUCH] = _Crouch;
sprite[CROUCH_L] = _Crouch_left;
sprite[CROUCH_ATTACK] = _CrouchAttack;
sprite[CROUCH_ATTACK_L] = _CrouchAttack_left;
sprite[CROUCH_FULL] = _CrouchFull;
sprite[CROUCH_FULL_L] = _CrouchFull_left;
sprite[CROUCH_TRANS] = _CrouchTransition;
sprite[CROUCH_TRANS_L] = _CrouchTransition_left;
sprite[CROUCH_WALK] = _CrouchWalk;
sprite[CROUCH_WALK_L] = _CrouchWalk_left;
sprite[DASH] = _Dash;
sprite[DASH_L] = _Dash_left;
sprite[DEATH] = _Death;
sprite[DEATH_L] = _Death_left;
sprite[DEATH_NM] = _DeathNoMovement;
sprite[DEATH_NM_L] = _DeathNoMovement_left;
sprite[FALL] = _Fall;
sprite[FALL_L] = _Fall_left;
sprite[HIT] = _Hit;
sprite[HIT_L] = _Hit_left;
sprite[IDLE] = _Idle;
sprite[IDLE_L] = _Idle_left;
sprite[JUMP] = _Jump;
sprite[JUMP_L] = _Jump_left;
sprite[JUMPFALL_TRANS] = _JumpFallInbetween;
sprite[JUMPFALL_TRANS_L] = _JumpFallInbetween_left;
sprite[ROLL] = _Roll;
sprite[ROLL_L] = _Roll_left;
sprite[RUN] = _run_right;
sprite[RUN_L] = _run_left;
sprite[SLIDE] = _Slide;
sprite[SLIDE_L] = _Slide_left;
sprite[SLIDEFULL] = _SlideFull;
sprite[SLIDEFULL_L] = _SlideFull_left;
sprite[SLIDE_TRANS_END] = _SlideTransitionEnd;
sprite[SLIDE_TRANS_END_L] = _SlideTransitionEnd_left;
sprite[SLIDE_TRANS_START] = _SlideTransitionStart;
sprite[SLIDE_TRANS_START_L] = _SlideTransitionStart_left;
sprite[TURN] = _TurnAround;
sprite[TURN_L] = _TurnAround_left;
sprite[WALL_CLIMB] = _WallClimb;
sprite[WALL_CLIMB_L] = _WallClimb_left;
sprite[WALL_CLIMB_NM] = _WallClimbNoMovement;
sprite[WALL_CLIMB_NM_L] = _WallClimbNoMovement_left;
sprite[WALL_HANG] = _WallHang;
sprite[WALL_HANG_L] = _WallHang_left;
sprite[WALL_SLIDE] = _WallSlide;
sprite[WALL_SLIDE_L] = _WallSlide_left;
#endregion

state = IDLE;
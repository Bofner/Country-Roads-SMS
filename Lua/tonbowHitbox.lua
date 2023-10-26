


while true do
	--Variables change every frame. Location found using Emulicious
	--Tonbow hurtbox
	tonbowHurtBoxX1 = memory.readbyte(0xC128);
	tonbowHurtBoxY1 = memory.readbyte(0xC127);
	tonbowHurtBoxW = memory.readbyte(0xC12B);
	tonbowHurtBoxH = memory.readbyte(0xC12C);
	--Tonbow hitbox
	tonbowHitBoxX1 = memory.readbyte(0xC122);
	tonbowHitBoxY1 = memory.readbyte(0xC121);
	tonbowHitBoxX2 = memory.readbyte(0xC124);
	tonbowHitBoxY2 = memory.readbyte(0xC123);
	--Demo Orb 1 hitbox
	demoOrb1HitBoxX1 = memory.readbyte(0xC146);
	demoOrb1HitBoxY1 = memory.readbyte(0xC145);
	demoOrb1HitBoxX2 = memory.readbyte(0xC148);
	demoOrb1HitBoxY2 = memory.readbyte(0xC147);

	--Variables will be ahead of what's being drawn, so if we draw the next frame
	--first,then the hitboxes will match up with how the hitboxes are drawn on screen
	emu.frameadvance();

	--Draw the hurtbox for the Tonbow
	gui.drawRectangle(tonbowHurtBoxX1, tonbowHurtBoxY1, tonbowHurtBoxW, tonbowHurtBoxH, "yellow");

	--Draw the hitbox for the Tonbow
	gui.drawBox(tonbowHitBoxX1, tonbowHitBoxY1, tonbowHitBoxX2, tonbowHitBoxY2, "green");

	--Draw the hitbox for the Demo Orb
	gui.drawBox(demoOrb1HitBoxX1, demoOrb1HitBoxY1, demoOrb1HitBoxX2, demoOrb1HitBoxY2, "red");

	
end

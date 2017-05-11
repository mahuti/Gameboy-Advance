//
// Gameboy Advance
// Theme by Mahuti
// vs. 1.0
//

// layout was built in photoshop. all numbers in this used are based off of the photoshop file's size. 
local base_width = 1440.0; // make sure this number is followed by .0 to make it a float. 
local base_height = 1080.0; // see note above. 

class UserConfig {
	</ label="Enable Logos", help="If wheel images/logos aren't used, game titles will be shown instead.", order=1, options="show logos, show titles" />
	enable_logos="show logos";
}

local config = fe.get_config();

// width conversion factor
local xconv = fe.layout.width / base_width; 
// height conversion factor
local yconv = fe.layout.height / base_height; 


// get a width value converted using conversion factor
function width( num )
{
    return  num * xconv; 
}
// get a height value converted using conversion factor
function height( num )
{
	return num * yconv; 
}
// get a x position converted using conversion factor
function xpos( num )
{
    return num * xconv; 
}
// get the y position value converted using conversion factor
function ypos( num )
{
	return num * yconv; 
}
// debug text to tty
function debug( text )
{
    print( "Debug: " + text + "\n" );
    return true;
}

function set_titles( unused )
{
	// Title
	local title = fe.add_text("[Title]", xpos(18), ypos(18), width(317), height(32));
 	title.charsize = 24;
	title.set_rgb(247, 35, 0);
	title.font = "Pretendo"; 
} 

//Background
local bg = fe.add_image("gba_background.jpg", 0,0, width(1440), height(1080) );


// Boxart
local flyer = fe.add_artwork("flyer", xpos(675), ypos(-279), width(947), height(946));
flyer.preserve_aspect_ratio = false;
flyer.trigger = Transition.EndNavigation;

// Snap
local snap = fe.add_artwork("snap", xpos(407), ypos(351), width(621), height(427) );
snap.trigger = Transition.EndNavigation;

local scanlines = fe.add_image("scanlines.png", xpos(400), ypos(345), width(630), height(435));

if ( config["enable_logos"] == "show logos" )
{
 	// wheel
	local wheel = fe.add_artwork("wheel", xpos(88), ypos(18), width(317), height(162));
	wheel.preserve_aspect_ratio = true;
	wheel.trigger = Transition.EndNavigation;
	
	if ( fe.get_art( "wheel" ) == "")
	{
		// set_titles(); 
	}
	
} else {
	set_titles(); 
}
 
 // Gameboy Overlay
local gb_overlay = fe.add_image("gba_foreground.png", 0, 0, width(1440), height(1080));

// Playtime
local playtime = fe.add_text("Playtime : [PlayedTime]", xpos(16), ypos(1030), width(391),height(39));
playtime.align = Align.Left;
playtime.charsize = 20;
playtime.set_rgb(255, 255, 255);





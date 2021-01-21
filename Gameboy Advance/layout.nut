//
// Gameboy Advance
// Theme by Mahuti
// vs. 2.0 // added pos module, flyers, and other minor things
//
local order = 0
class UserConfig {
	</ label="Show Logos", 
        help="Shows wheel images when enabled", 
        order=order++, 
        options="Yes, No" />
        show_logos="Yes";
  
    </ label="Show Boxart", 
        help="Shows boxart when enabled", 
        order=order++, 
        options="Yes, No" />
        show_boxart="Yes";
    
 	</ label="Show Playtime", 
        help="The amount of time this game's been played.", 
        order=order++, 
        options="Yes, No, Include Romname" />
        show_playtime="Yes";
    
    </ label="Show Scanlines", 
        help="Shows scanlines when enabled", 
        order=order++, 
        options="Yes, No" />
        show_scanlines="No"; 
    
    </ label="Scratched Text", 
        help="This is some text scratched in the desk, which may not always be visible. Set it to blank to hide it", 
        order=order++
        />
        desk_text="colorzz";
}

 
local config = fe.get_config()

fe.load_module("preserve-art")
fe.load_module("pos") // positioning & scaling module
fe.load_module("shadow-glow")

// stretched positioning
local posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "stretch",
    rotate= 0
    debug = false,
}
local pos = Pos(posData)

// scaled positioning
posData =  {
    base_width = 1920.0,
    base_height = 1080.0,
    layout_width = fe.layout.width,
    layout_height = fe.layout.height,
    scale= "scale",
    rotate=0
    debug = false,
}
local scalepos = Pos(posData)

    
//Wood Background
local bg = fe.add_image("gba_bg.png", 0, 0, pos.width(1920), pos.height(1080))

//local positioning = fe.add_image("template.png", 0, 0, scalepos.width(1920), scalepos.height(1080))
//positioning.preserve_aspect_ratio = true
    
local scratch_me = null
if (config["desk_text"] != ""){
    
    local scratch_y = 120
    local scratch_x = 700
    local scratch_width = 1100
    local scratch_height = 200
    local scratch_font_height=44 
    local scratch_rotation = 17
        
    scratch_me = fe.add_text(config["desk_text"], pos.x(scratch_x), pos.y(scratch_y), pos.width(scratch_width), pos.height(scratch_height) )
    pos.set_font_height(scratch_font_height,scratch_me, "TopLeft")

    scratch_me.x = scalepos.x(scratch_x, "right",scratch_me)
    scratch_me.y = scalepos.y(scratch_y, "top",scratch_me)
    scratch_me.alpha=140
    scratch_me.rotation=scratch_rotation
    scratch_me.set_rgb(150,112,72)
    scratch_me.font = "sugar-death-2-italic.ttf"
        
    local scratch_me2 = fe.add_text(config["desk_text"], pos.x(scratch_x), pos.y(scratch_y), pos.width(scratch_width), pos.height(scratch_height) )
    scratch_me2.y = scalepos.y( -2, "top", scratch_me2, scratch_me)
    scratch_me2.x = scalepos.x( -2, "left", scratch_me2, scratch_me)
    pos.set_font_height(scratch_font_height,scratch_me2, "TopLeft")
    scratch_me2.alpha=70    
    scratch_me2.rotation=scratch_rotation
    scratch_me2.set_rgb(88,23,41)
    scratch_me2.font = "sugar-death-2-italic.ttf"
    
   scratch_me2.zorder = scratch_me.zorder
}
 
 // Nintendo Power
local nintendo_power = fe.add_image("nintendo-power-advance.png", scalepos.x(-450), scalepos.y(-450), scalepos.width(1541), scalepos.height(1802))
nintendo_power.preserve_aspect_ratio = true
nintendo_power.y = scalepos.y(-40,"middle",nintendo_power)  



local boxart = null
if ( config["show_boxart"] == "Yes" )
{
    // Boxart
    boxart = fe.add_artwork("boxart", pos.x(700), pos.y(0), pos.width(698), pos.height(698))
    boxart.preserve_aspect_ratio = true
    boxart.trigger = Transition.EndNavigation
    boxart.rotation = -7.5 
    boxart.x = scalepos.x(-50,"right", boxart)
    boxart.zorder = 10
    local ds = DropShadow( boxart, 40, scalepos.x(-10), scalepos.y(20), 83 )
}
// Gameboy Overlay
local gb_overlay = fe.add_image("gba_foreground.png", pos.x(-250), pos.y(50), pos.width(1724), pos.height(1079))
gb_overlay.preserve_aspect_ratio = true
gb_overlay.x=pos.x(-350,"left",gb_overlay,null,"left")

print ("\nwidth: " + fe.layout.width); 
print ("\nheight: " + fe.layout.height); 
print ("\ngb_overlay: " + gb_overlay.x); 
print ("\nx scale"+ scalepos.x(gb_overlay.x));
if (gb_overlay.x< -250)
{
    gb_overlay.x=scalepos.x(-220,"left",gb_overlay,null,"left")
}
gb_overlay.zorder=100
//gb_overlay.alpha=70


local wheel = null
if ( config["show_logos"] == "Yes" )
{
 	// wheel
	wheel = fe.add_artwork("wheel", scalepos.x(1440),scalepos.y(1080), scalepos.width(432), scalepos.height(216))
    wheel.x=pos.x(-300,"right", wheel)
    
    if (boxart != null){
        wheel.y=pos.y(70,"top",wheel, boxart,"bottom") 
    }
    else
    {
        wheel.y=pos.y(10,"bottom",wheel)        
    }
    
    wheel.x=scalepos.x(-60,"left",wheel,gb_overlay,"right")
    wheel.preserve_aspect_ratio = true
	wheel.trigger = Transition.EndNavigation
    wheel.alpha=220
    wheel.zorder=30
}

local notebook = fe.add_image("stuart_hall.png", 0, scalepos.y(30), scalepos.width(1708), scalepos.height(2004))
notebook.x = scalepos.x(-600,"left",notebook,null,"right")
notebook.zorder= 20
    
if (wheel != null){
    notebook.y = scalepos.y(-400,"top",notebook,wheel,"bottom")
}
else
{
    notebook.y = scalepos.y(-400,"top",notebook,null,"bottom")
}

local playtime = null 
if ( config["show_playtime"] != "No" )
{
    // Playtime   
    if ( config["show_playtime"] == "Yes" )
    {
        playtime = fe.add_text("Playtime: [PlayedTime]", pos.x(14),0, pos.width(800), pos.height(108))
    }
    else
    {
        playtime = fe.add_text("Playtime: [PlayedTime] [Name]", pos.x(14),0, pos.width(800), pos.height(108))
    }
    pos.set_font_height(25,playtime, "BottomLeft")
    playtime.y = scalepos.y(-20,"bottom",playtime)
    playtime.x = scalepos.x(20,"left",playtime)
    playtime.set_rgb(10, 10, 10)	
}
    
// Missing Cartridge Underlay
local gb_underlay = fe.add_image("nogame.png", pos.x(370), pos.y(220), pos.width(615), pos.height(616))
gb_underlay.preserve_aspect_ratio = true
gb_underlay.rotation = 4.8
gb_underlay.x=scalepos.x(70,"center",gb_underlay,gb_overlay,"center")
gb_underlay.y=scalepos.y(-50,"center",gb_underlay,gb_overlay,"center")
gb_underlay.zorder = 50

// Snap
local snap = fe.add_artwork("snap", pos.x(340), pos.y(338), pos.width(630), pos.height(420))
snap.trigger = Transition.EndNavigation
snap.preserve_aspect_ratio=true
snap.rotation = 4.8
snap.x=scalepos.x(43,"center",snap,gb_overlay,"center")
snap.y=scalepos.y(-45,"center",snap,gb_overlay,"center")

snap.zorder=60


if (config["show_scanlines"] == "Yes" )
{
    // Scanlines
    local scanlines = fe.add_image("scanlines.png", pos.x(370), pos.y(290), pos.width(655), pos.height(465) )
    scanlines.preserve_aspect_ratio = true
    scanlines.rotation = 5.6
    scanlines.alpha=210
    scanlines.x=scalepos.x(58,"center",scanlines,gb_overlay,"center")
    scanlines.y=scalepos.y(-50,"center",scanlines,gb_overlay,"center")
    scanlines.zorder=70
}

    

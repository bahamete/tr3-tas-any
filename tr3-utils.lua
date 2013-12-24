local function textf(x, y, f, ...) 
    gui.text(x, y, string.format(f, ...)) 
end

local function get_entity_info(offset)
    local offset = offset or 0

    entity = { 
        ["xspeed"]  = memory.readword(offset + 22), 
        ["yspeed"]  = memory.readwordsigned(offset + 24), 
        ["health"]  = memory.readwordsigned(offset + 26), 
        ["xpos"]    = memory.readdwordsigned(offset + 56), 
        ["ypos"]    = memory.readdwordsigned(offset + 60), 
        ["zpos"]    = memory.readdwordsigned(offset + 64), 
        ["pitch"]   = memory.readwordsigned(offset + 68), 
        ["yaw"]     = memory.readwordsigned(offset + 70), 
        ["roll"]    = memory.readwordsigned(offset + 72) 
    }
	
    return entity 
end 

local function print_lara_info() 
    local lara_offset = memory.readdword(0x9923C) + 8
    local lara_data = get_entity_info(lara_offset) 
    local draw_pos = 60
    
    textf(1, draw_pos,      "POS    %04dX, %04dY, %04dZ",
             lara_data["xpos"], lara_data["ypos"], lara_data["zpos"])
    textf(1, draw_pos + 8,  "SPEED  %+03dX, %+04dY", 
             lara_data["xspeed"], lara_data["yspeed"]) 
    textf(1, draw_pos + 16, "ANGLE  %+03dP, %+03dY, %+03dR", 
             lara_data["pitch"], lara_data["yaw"], lara_data["roll"]) 
end

local function draw_bars_info() 
    local health_meter = memory.readwordsigned(0x96778)
    local sprint_meter = memory.readword(0x99228)

    -- Make health bar appear all of the time
    memory.writebyte(0x95EEC, 100)

    gui.transparency(2)
    textf(342, 13, "HEALTH %+03d (%.02f%%)",
                   health_meter, health_meter / 10)
    
    if (sprint_meter < 120) then 
        textf(342, 41, "SPRINT %+03d (%.02f%%)",
                       sprint_meter, (sprint_meter / 120) * 100) 
    end
    gui.transparency(0)
end 

local function print_level_info() 
    
end

local function main() 
    print_lara_info() 
    draw_bars_info()
end

gui.register(main) 
local tileString = [[
          
  S  S  S 
  S  S    
  SSSS  S 
  S  S  S 
          
          
GGGGGGGGGG
DDDDDDDDDD
]]

local quadInfo = { 
  { 'G',  0,  0 }, -- Grass
  { 'D', 80,  0 }, -- Dirt
  { 'S', 160,  0 }, -- Stone
  { '(', 240, 0 }, -- table bottom left
  { ')', 320, 0 }, -- Sand
  { 'W',  400, 0 }, -- Wood
  { 'M', 0, 80 }, -- Moss
  { '', 80,  80 },  -- TNT
  { '', 160, 80 }, -- Glass
  { 'A', 240, 80 }, -- Gold Ore
  { '', 320, 80 }, -- Nu
  {'', 400, 80}, -- Nu
  { ' ', 0,160}, -- Nu
  {'', 80,160 }, -- Nu
}

newMap(80,80,'/assets/spritesheet.PNG', tileString, quadInfo) 

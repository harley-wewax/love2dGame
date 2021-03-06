 local tileW, tileH, tileset, Quads, TileTable 


function newMap(tileWidth, tileHeight, tilesetPath, tileString, quadInfo)
   
    tileW = tileWidth 
    tileH = tileHeight 
    tileset = love.graphics.newImage(tilesetPath)
    
    local tilesetW, tilesetH = tileset:getWidth(), tileset:getHeight()
    
    Quads = {}
     for _,info in ipairs(quadInfo) do
        --infor[1] = x info[2] = y
        Quads[info[1]] = love.graphics.newQuad(info[2], info[3], tileW, tileH, tilesetW, tilesetH)
    end
    
    TileTable = {}
    TileTable.mWidth = tilesetW -- Store Max Width
    TileTable.mHeight = tilesetH -- Store Max Height 
    local width = #(tileString:match("[^\n]+"))
    
    for x =1,width,1 do TileTable[x] = {} end
    
    
    local rowIndex, columnIndex = 1,1
    for row in tileString:gmatch("[^\n]+") do
  assert(#row == width, 'Map is not aligned: width of row'..tostring(rowIndex)..'shouldbe'..tostring(width)..',butit is ' .. tostring(#row))
  columnIndex = 1
  for character in row:gmatch(".") do
      TileTable[columnIndex][rowIndex] = character
      columnIndex = columnIndex + 1
  end
  rowIndex=rowIndex+1
    end
    
end

function loadMap(path)
   
    love.filesystem.load(path)()
end

function drawMap()
  for x,column in ipairs(TileTable) do
    for y,char in ipairs(column) do
      love.graphics.draw(tileset, Quads[ char ] , (x-1)*tileW, (y-1)*tileH)
    end
  end
end
return {
  version = "1.1",
  luaversion = "5.1",
  tiledversion = "0.12.3",
  orientation = "orthogonal",
  width = 8,
  height = 8,
  tilewidth = 70,
  tileheight = 70,
  nextobjectid = 1,
  properties = {},
  tilesets = {
    {
      name = "Tile",
      firstgid = 1,
      tilewidth = 70,
      tileheight = 70,
      spacing = 0,
      margin = 0,
      image = "../assets/Tile.png",
      imagewidth = 350,
      imageheight = 420,
      tileoffset = {
        x = 0,
        y = 0
      },
      properties = {},
      terrains = {},
      tiles = {}
    }
  },
  layers = {
    {
      type = "tilelayer",
      name = "Ground",
      x = 0,
      y = 0,
      width = 8,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["collidable"] = "true"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        1, 2, 2, 2, 2, 2, 0, 0,
        4, 4, 4, 4, 4, 4, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "Ladder",
      x = 0,
      y = 0,
      width = 8,
      height = 8,
      visible = false,
      opacity = 1,
      properties = {
        ["Ladder"] = ""
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 6, 0, 0, 0, 0,
        0, 0, 0, 5, 0, 0, 0, 0,
        0, 0, 0, 5, 0, 0, 0, 0,
        0, 0, 0, 5, 0, 0, 0, 0,
        0, 0, 0, 5, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 0, 0, 0, 0
      }
    },
    {
      type = "tilelayer",
      name = "UpperGround",
      x = 0,
      y = 0,
      width = 8,
      height = 8,
      visible = true,
      opacity = 1,
      properties = {
        ["collidable"] = "true"
      },
      encoding = "lua",
      data = {
        0, 0, 0, 0, 0, 0, 0, 0,
        0, 0, 0, 0, 2, 2, 2, 2,
        0, 0, 0, 0, 0, 0, 4, 4,
        0, 0, 0, 0, 0, 0, 4, 4,
        0, 0, 0, 0, 0, 0, 4, 4,
        0, 0, 0, 0, 0, 0, 4, 4,
        0, 0, 0, 0, 0, 0, 4, 4,
        0, 0, 0, 0, 0, 0, 4, 4
      }
    }
  }
}

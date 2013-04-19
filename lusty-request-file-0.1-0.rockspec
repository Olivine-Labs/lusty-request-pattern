package = "lusty-request-file"
version = "0.1-0"
source = {
  url = "https://github.com/Olivine-Labs/lusty-request-file/v0.1.tar.gz",
  dir = "lusty-request-file"
}
description = {
  summary = "Lusty plugin for handling requests with a lua file.",
  detailed = [[
    Lusty plugin for handling requests with a lua file.
  ]],
  homepage = "http://olivinelabs.com/lusty/",
  license = "MIT <http://opensource.org/licenses/MIT>"
}
dependencies = {
  "lua >= 5.1",
  "lusty >= 0.1-0",
  "busted >= 1.7-1"
}
build = {
  type = "builtin",
  modules = {
    ["lusty-request-file.request.file"]  = "src/request/file.lua",
  }
}

local util = require 'lusty.util'
local paramMatch = '([^/?]*)'
local baseUrlLen = table.concat(channel, '/', 2):len()+3
local patterns = {}

for i=1, #config.patterns do
  for match, file in pairs(config.patterns[i]) do
    local item = {}
    item.file = file
    item.param = {}
    item.pattern = match:gsub("{([^}]*)}", function(c)
      item.param[#item.param+1]=c
      return paramMatch
    end)
    patterns[#patterns+1] = item
  end
end

return {
  handler = function(context)
    local url = context.request.url:sub(baseUrlLen)
    for i=1, #patterns do
      local item = patterns[i]
      local tokens = {url:match(item.pattern)}
      if #tokens > 0 then
        local arguments = {}
        for j=1, #tokens do
          context.log(item.param[j])
          arguments[item.param[j]]=tokens[j]
        end
        arguments.config=config
        arguments.context=context
        util.inline(item.file, arguments)
        break
      end
    end
  end
}

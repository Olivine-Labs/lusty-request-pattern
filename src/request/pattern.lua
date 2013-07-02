local util = require 'lusty.util'
local paramMatch = '([^/?]*)'
local patterns = {}

for i=1, #config.patterns do
  for match, file in pairs(config.patterns[i]) do
    local item = {
      file = file,
      param = {}
    }

    item.pattern = "^"..match:gsub("{([^}]*)}", function(c)
      item.param[#item.param+1]=c
      return paramMatch
    end) .. "/?"

    patterns[#patterns+1] = item
  end
end

return {
  handler = function(context)
    context.response.status = 404
    local url = context.suffix and table.concat(context.suffix, '/')
    for i=1, #patterns do
      local item = patterns[i]

      local tokens = {url:match(item.pattern)}

      if #tokens > 0 then
        local arguments = {}

        if url ~= tokens[1] then
          for j=1, #tokens do
            if tokens[j] ~= '' and item.param[j] then
              arguments[item.param[j]]=tokens[j]
            end
          end
        end

        arguments.config=config
        arguments.context=context

        util.inline(item.file, arguments)
        break
      end
    end
  end
}

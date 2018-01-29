-- General utility functions

-- Return sorted array of string keys
local function util_keys(t)
  local ks = {}
  for k, _ in pairs(t) do
    if type(k) == "string" then
      table.insert(ks, k)
    end
  end
  table.sort(ks)
  return ks
end

local function util_pkeys(t)
  local ks = util_keys(t)
  for _, v in ipairs(ks) do print(v) end
end

return {
  keys = util_keys,
  pkeys = util_pkeys
}

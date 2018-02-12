-- Functions to operate on tables that consist of an array and "n"
-- Tables may contain nil values.

local function _print(t)
  for i = 1, t.n do print(t[i]) end
end

local _pack = table.pack

local function _unpack(t)
  return table.unpack(t, 1, t.n)
end

-- Return a new tn table from (shallow) concatenation of tn tables
local function _cat(...)
  local args = _pack(...)
  local tnew = _pack()
  for i = 1, args.n do
    local t = args[i]
    for j = 1, t.n do
      tnew.n = tnew.n + 1
      tnew[tnew.n] = t[j]
    end
  end
  return tnew
end

return {
  cat = _cat,
  pack = _pack,
  print = _print,
  unpack = _unpack,
}


-- Functions to operate on tables that consist of an array and "n"
-- Tables may contain nil values.

local function tn_itr(t)
  local i = 0
  return function ()
    i = i + 1
    if t.n < i then
      return nil
    else
      return i, t[i]
    end
  end
end

local function tn_pack(...)
  local t = table.pack(...)
  return t
end

local function tn_unpack(t)
  return table.unpack(t, 1, t.n)
end

return {
  itr = tn_itr,
  pack = tn_pack
  unpack = tn_unpack
}


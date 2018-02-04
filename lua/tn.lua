-- Functions to operate on tables that consist of an array and "n"
-- Tables may contain nil values.

local tn_pack = table.pack

local function tn_unpack(t)
  return table.unpack(t, 1, t.n)
end

return {
  pack = tn_pack,
  unpack = tn_unpack,
}


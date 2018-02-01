-- Functions to operate on tables that consist of an array and "n"
-- Tables may contain nil values.

local tn_pack = table.pack

local function tn_unpack(t)
  return table.unpack(t, 1, t.n)
end

local function tn_insert(t, itr)
  
end

local function tn_cat(a, b)
  
end

return {
  pack = tn_pack,
  unpack = tn_unpack
}


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

return {
  itr = tn_itr,
}


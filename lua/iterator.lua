-- Stateful iterator that returns control, value.
-- End of iteration is indicated by a control value of nil.

local function itr_foldl(f, a, b)
  local i, v = b()
  if i == nil then
    return a
  else
    return itr_foldl(f, f(a, v), b)
  end
end

return {
  foldl = itr_foldl,
}

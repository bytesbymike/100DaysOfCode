-- Stateful iterator that returns control, value.
-- End of iteration is indicated by a control value of nil.

local function itr_foldl(f, acc, itr)
  local i, v = itr()
  if i == nil then
    return acc
  else
    return itr_foldl(f, f(acc, v), itr)
  end
end

return {
  foldl = itr_foldl,
}

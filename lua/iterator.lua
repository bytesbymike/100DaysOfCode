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


local function itr_of_tn(t)
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
  foldl = itr_foldl,
  of_tn = itr_of_tn,
}

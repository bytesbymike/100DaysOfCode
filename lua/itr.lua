-- Stateful iterator that returns control, value.
-- End of iteration is indicated by a control value of nil.

local tn = require("tn")

-- Extract
--   nil, ... -> nil
--   a -> a, a
--   ... -> ...
local function _fnext_vals(...)
  local vals = tn.pack(...)
  if vals[1] == nil then
    return nil
  elseif vals.n == 1 then
    return vals[1], vals[1]
  else
    return ...
  end
end

local function _tn_fnext(t, i0)
  if i0 < t.n then
    local i1 = i0 + 1
    return i1, t[i1]
  else
    return nil
  end
end

local function _tn_fnext_rev(t, i0)
  if i0 > 1 then
    local i1 = i0 - 1
    return i1, t[i1]
  else
    return nil
  end
end

local function _of_tn(t) return _tn_fnext, t, 0 end

local function _of_tn_rev(t) return _tn_fnext_rev, t, t.n + 1 end

local function _of_vargs(...) return _of_tn(tn.pack(...)) end

return {
  fnext_vals = _fnext_vals,
  of_tn = _of_tn,
  of_tn_rev = _of_tn_rev,
  of_vargs = _of_vargs,
}

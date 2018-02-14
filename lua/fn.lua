-- Utilities for functional programming

local itr = require("itr")
local tn = require("tn")

local _curry_partial
local _curry_impl

_curry_partial = function (n, f, args0)
  return function (...)
    local args1 = tn.cat(args0, tn.pack(...))
    return _curry_args(n, f, args1)
  end
end

_curry_args = function (n, f, args)
  if args.n < n then
    return _curry_partial(n, f, args)
  else
    return f(tn.unpack(args))
  end
end

local function _curryn(n, f)
  return _curry_partial(n, f, tn.pack())
end

local function _identity(...) return ... end

local _add = _curryn(2, function (a, b) return a + b end)
local _inc = _add(1)
local _dec = _add(-1)
local _mul = _curryn(2, function (a, b) return a * b end)

-- `if` as a function
local function _fif(bool_val, true_val, false_val)
  if bool_val then
    return true_val
  else
    return false_val
  end
end

local function _range_next(n_offset, i0)
  local i1 = i0 + 1
  local v = i1 + n_offset[2]
  return itr.fnext_vals(_fif(i1 > n_offset[1], nil, i1), v)
end

local function _range(a, b)
  local offset = a - 1
  local n = b - offset
  return _range_next, {n,offset}, 0
end

-- fnext(invariant, stprev) -> stnext, vals
local function _eager_foldl(f, acc, fnext, invariant, stprev)
  local stnext, vals = itr.fnext_vals(fnext(invariant, stprev))
  if stnext == nil then
    return acc
  else
    local fval = (f(acc, vals)) -- adjust to 1
    return _eager_foldl(f, fval, fnext, invariant, stnext)
  end
end

_foldl = _curryn(_5, eager_foldl)

local function _map_create_fnext2(f, fnext)
  local function _fnext2(invariant, stprev)
    local stnext, vals = itr.fnext_vals(fnext(invariant, stprev))
    if stnext == nil then
      return nil
    else
      return stnext, f(vals)
    end
  end
  return _fnext2
end

local function _map(f, fnext, invariant, stprev)
  return _map_create_fnext2(f, fnext), invariant, stprev
end

local function _filter_create_fnext(f, fnext)
  local function _fnext2(invariant, stprev)
    local stnext, vals = itr.fnext_vals(fnext(invariant, stprev))
    if stnext == nil then
      return nil
    else
      if f(vals) == false then
        return _fnext2(invariant, stnext)
      else
        return stnext, vals
      end
    end
  end
  return _fnext2
end

local function _filter(f, fnext, invariant, stprev)
  return _filter_create_fnext(f, fnext), invariant, stprev
end

local function _compose2(f, g)
  return function(...) return f(g(...)) end
end

local function _compose(f, g, ...)
  local fg = _compose2(f, g)
  if select("#", ...) == 0 then
    return fg
  else
    return _compose(fg, ...)
  end
end

return {
  add = _add,
  curryn = _curryn,
  compose = _compose,
  dec = _dec,
  fif = _fif,
  filter = _filter,
  foldl = _foldl,
  identity = _identity,
  inc = _inc,
  map = _map,
  mul = _mul,
  range = _range,
}


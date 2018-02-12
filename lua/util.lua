-- General utility functions

-- Return sorted array of string keys
local function _keys(t)
  local ks = {}
  for k, _ in pairs(t) do
    if type(k) == "string" then
      table.insert(ks, k)
    end
  end
  table.sort(ks)
  return ks
end

local function _pkeys(t)
  local ks = _keys(t)
  for _, v in ipairs(ks) do print(v) end
end

local function _ifnil(a, value_if_nil)
  if (a == nil) then
    return value_if_nil
  else
    return a
  end
end

local function _print_module_status(modname, varname)
  print('package.loaded["' .. modname .. '"] '
          .. tostring(package.loaded[modname])
          .. '    _G["' .. varname .. '"] '
          .. tostring(_G[varname]))
end

local function _resolve_names(name, opt_name1, opt_name2)
  local name1 = _ifnil(opt_name1, name)
  local name2 = _ifnil(opt_name2, name1)
  return name1, name2
end

local function _load(modname, opt_varname)
  local varname = _ifnil(opt_varname, modname)
  _print_module_status(modname, varname)
  _G[varname] = require(modname)
  _print_module_status(modname, varname)  
end

local function _unload(modname, opt_varname)
  local varname = _ifnil(opt_varname, modname)
  _print_module_status(modname, varname)
  package.loaded[modname] = nil
  _G[varname] = nil
  _print_module_status(modname, varname)  
end

local function _reload(modname, opt_varname_cur, opt_varname_new)
  local varname_cur, varname_new = _resolve_names(
    modname, opt_varname_cur, opt_varname_new)
  _unload(modname, varname_cur)
  _load(modname, varname_new)
end

return {
  ifnil = _ifnil,
  keys = _keys,
  pkeys = _pkeys,
  load = _load,
  unload = _unload,
  reload = _reload,
}

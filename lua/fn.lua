-- Utilities for functional programming

local function fn_identity(...) return ... end

return {
  identity = fn_identity,
}


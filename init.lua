local function get_source_directory()
  return debug
    .getinfo(3, "S")
    .source
    :sub(2)
    :match("(.*/)")
end

local function get_file_name(path)
  return path
    :match(".*/(.*)", 2)
end

return function(path)
  local source_directory = get_source_directory()

  local old_path = package.path
  package.path = source_directory .. path .. ";" .. old_path
  local module = require(get_file_name(path))
  package.path = old_path

  return module
end

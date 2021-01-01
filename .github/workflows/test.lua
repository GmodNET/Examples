hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function run_test()
	local module_loaded = dotnet.load("NativeMath")
	assert(module_loaded)

	-----------------------



	-----------------------

	local module_unloaded = dotnet.unload("NativeMath")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function run_test()
	local module_loaded = dotnet.load("HashCalc")
	assert(module_loaded)

	-----------------------

	local sha256 = HashCalc.CalculateSHA256("test")
	print("SHA256 = " .. sha256)
	assert(sha256==string.upper("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"))

	-----------------------

	local module_unloaded = dotnet.unload("HashCalc")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

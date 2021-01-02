hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function run_test()
	local module_loaded = dotnet.load("HashCalc")
	assert(module_loaded)

	-----------------------

	local sha256 = HashCalc.CalculateSHA256("test")
	assert(sha256==string.upper("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"))

	local sha256_unicode = HashCalc.CalculateSHA256("☭")
	assert(sha256_unicode==string.upper("d7f6fc82e3665ba40899bbf7bf6dc6f5c7f349ea054f6360c1d983f01c07601a"))

	-----------------------

	local module_unloaded = dotnet.unload("HashCalc")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

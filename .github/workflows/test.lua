hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function run_test()
	local module_loaded = dotnet.load("HashCalc")
	assert(module_loaded)

	-----------------------

	local sha256 = CalculateHash("SHA256","test")
	assert(sha256==string.upper("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"))

	local sha256_unicode = CalculateHash("SHA256","☭")
	assert(sha256_unicode==string.upper("d7f6fc82e3665ba40899bbf7bf6dc6f5c7f349ea054f6360c1d983f01c07601a"))

	local md5 = CalculateHash("MD5","test")
	assert(md5==string.upper("098f6bcd4621d373cade4e832627b4f6"))

	local md5_unicode = CalculateHash("MD5","☭")
	assert(md5_unicode==string.upper("7da15a125400bc658992457c218d7d47"))
	-----------------------

	local module_unloaded = dotnet.unload("HashCalc")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

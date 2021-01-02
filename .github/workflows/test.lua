hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function run_test()
	local module_loaded = dotnet.load("HashCalc")
	assert(module_loaded)

	--------SHA256--------

	local sha256 = CalculateHash("SHA256","test")
	assert(sha256==string.upper("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"))

	local sha256_unicode = CalculateHash("SHA256","☭")
	assert(sha256_unicode==string.upper("d7f6fc82e3665ba40899bbf7bf6dc6f5c7f349ea054f6360c1d983f01c07601a"))

	---------MD5----------

	local md5 = CalculateHash("MD5","test")
	assert(md5==string.upper("098f6bcd4621d373cade4e832627b4f6"))

	local md5_unicode = CalculateHash("MD5","☭")
	assert(md5_unicode==string.upper("7da15a125400bc658992457c218d7d47"))

	--------SHA512--------

	local sha512 = CalculateHash("SHA512","test")
	assert(sha512==string.upper("ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff"))

	local sha512_unicode = CalculateHash("SHA512","☭")
	assert(sha512_unicode==string.upper("52d54669d285a26c36374220204ea3e7ac480a7ef1d39cd5af0a6852309caa46faf19ebf0122eccae9ae4d4575b805e162a0b725c92aa43fd9a169835fea1734"))

	----------------------

	local module_unloaded = dotnet.unload("HashCalc")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

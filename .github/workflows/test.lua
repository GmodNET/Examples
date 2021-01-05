hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function run_test()
	local module_loaded = dotnet.load("HashCalc")
	assert(module_loaded)

	--------SHA256--------

	local sha256 = CalculateHash("SHA256","test")
	assert(sha256==string.upper("9f86d081884c7d659a2feaa0c55ad015a3bf4f1b2b0b822cd15d6c15b0f00a08"))

	local sha256_unicode = CalculateHash("SHA256","♥")
	assert(sha256_unicode==string.upper("7c546e1819d9562a67643820b4305c3892fd9a151628e447c8e8dae162fe8f57"))

	---------MD5----------

	local md5 = CalculateHash("MD5","test")
	assert(md5==string.upper("098f6bcd4621d373cade4e832627b4f6"))

	local md5_unicode = CalculateHash("MD5","♥")
	assert(md5_unicode==string.upper("d7d4076e1ad9c734baad210480cc903a"))

	--------SHA512--------

	local sha512 = CalculateHash("SHA512","test")
	assert(sha512==string.upper("ee26b0dd4af7e749aa1a8ee3c10ae9923f618980772e473f8819a5d4940e0db27ac185f8a0e1d5f84f88bc887fd67b143732c304cc5fa9ad8e6f57f50028a8ff"))

	local sha512_unicode = CalculateHash("SHA512","♥")
	assert(sha512_unicode==string.upper("09de9680f8bfc115d42d36646ef28b4cfe3fbffab095bb2ac86c1be9d9ad164a67aa07227d13fea504acf320a68f5fc507c86b803942a7023ccb0e4d23b65f04"))

	----------------------

	local module_unloaded = dotnet.unload("HashCalc")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

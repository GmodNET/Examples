hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

local function benchmark_single(name, fn)
	local startTime = SysTime()
	fn()
	local elapsed = SysTime()-startTime
	print(name.."_single"..elapsed)
	return elapsed
end

local function benchmark_thousand(name, fn)
	local startTime = SysTime()
	for i=0,1000 do
		fn()
	end
	local elapsed = SysTime()-startTime
	print(name.."_thousand"..elapsed)
	return elapsed
end

local function benchmark(name, fn)
	return {
		single = benchmark_single(name, fn),
		thousand = benchmark_thousand(name, fn)
	}
end

local function run_test()
	local module_loaded = dotnet.load("NativeMath")
	assert(module_loaded)

	-----------------------

	local lua_math_Approach = benchmark("math_Approach", function()
		return math.Approach(0,100,20)
	end)

	PrintTable(lua_math_Approach)

	NativeMath()

	print(type(math.Approach))

	local native_math_Approach = benchmark("math_Approach", function()
		return math.Approach(0,100,20)
	end)

	PrintTable(native_math_Approach)
	

	-----------------------

	local module_unloaded = dotnet.unload("NativeMath")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

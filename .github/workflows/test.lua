hook.Add("Tick", "Template_CloseServer", engine.CloseServer)
require("dotnet")

function donothingwithit(something) end

local function benchmark(name, fn)
	local startTime = SysTime()
	fn()
	local elapsed = SysTime()-startTime
	print(name.." "..elapsed)
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

local function math_Approach()
	benchmark("math_Approach", function()
		local current = 0
		for i=0,10000 do
			current = math.Approach(current,100,0.01)
		end
		print(current)
	end)
end

local function math_Distance()
	benchmark("math_Distance", function()
		local current = 0
		for i=0,10000 do
			current = math.Distance(current,0,200,100)
		end
		print(current)
	end)
end

local function run_test()
	local module_loaded = dotnet.load("NativeMath")
	assert(module_loaded)

	-----------------------

	math_Approach()
	math_Distance()

	NativeMath()

	math_Approach()
	math_Distance()

	-----------------------

	local module_unloaded = dotnet.unload("NativeMath")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

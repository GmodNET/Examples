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

local function run_test()
	local module_loaded = dotnet.load("NativeMath")
	assert(module_loaded)

	-----------------------


	benchmark("math_Approach", function()
		local current = 0
		for i=0,1000 do
			current = math.Approach(0,100,0.1)
		end
		print(current)
	end)

	NativeMath()

	benchmark("math_Approach", function()
		local current = 0
		for i=0,1000 do
			current = math.Approach(0,100,0.1)
		end
		print(current)
	end)


	-----------------------

	local module_unloaded = dotnet.unload("NativeMath")
	assert(module_unloaded)
end

run_test()

print("tests are successful!")
file.Write("success.txt", "done")

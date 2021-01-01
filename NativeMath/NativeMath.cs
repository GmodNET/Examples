using GmodNET.API;
using System;
using System.Collections.Generic;
using System.Runtime.InteropServices;

namespace NativeMath
{
	public class NativeMath : IModule
	{
		public string ModuleName => "NativeMath";

		public string ModuleVersion => "0.0.1";

		private List<GCHandle> handles;

		public void Load(ILua lua, bool is_serverside, ModuleAssemblyLoadContext assembly_context)
		{
			lua.PushSpecial(SPECIAL_TABLES.SPECIAL_GLOB);

			handles = new();

			handles.Add(lua.PushManagedFunction((lua) =>
			{
				Console.WriteLine("native mafs");
				lua.PushSpecial(SPECIAL_TABLES.SPECIAL_GLOB);
				lua.GetField(-1, "math");
				handles.Add(lua.PushManagedFunction((lua) =>
				{
					double current = Math.Abs(lua.GetNumber(1));
					double target = lua.GetNumber(2);
					double increment = lua.GetNumber(3);

					if (current < target)
					{
						lua.PushNumber(Math.Min(current + increment, target));
					}
					else if (current > target)
					{
						lua.PushNumber(Math.Max(current - increment, target));
					}
					else
					{
						lua.PushNumber(target);
					}
					return 1;
				}));
				lua.SetField(-2, "Approach");
				lua.Pop();
				return 0;
			}));
			lua.SetField(-2, "NativeMath");
			lua.Pop();
		}

		public void Unload(ILua lua)
		{
			foreach (var handle in handles)
			{
				handle.Free();
			}
			handles = null;
		}
	}
}

using GmodNET.API;
using System;
using System.Runtime.InteropServices;

namespace NativeMath
{
	public class NativeMath : IModule
	{
		public string ModuleName => "NativeMath";

		public string ModuleVersion => "0.0.1";

		private GCHandle NativeMathHandle;

		public void Load(ILua lua, bool is_serverside, ModuleAssemblyLoadContext assembly_context)
		{
			lua.PushSpecial(SPECIAL_TABLES.SPECIAL_GLOB);
			NativeMathHandle = lua.PushManagedFunction((lua) =>
			{
				Console.WriteLine("native mafs");
				return 0;
			});
			lua.SetField(-2, "NativeMath");
			lua.Pop();
		}

		public void Unload(ILua lua)
		{
			NativeMathHandle.Free();
		}
	}
}

using GmodNET.API;
using System;
using System.Collections.Generic;
using System.Numerics;
using System.Runtime.CompilerServices;
using System.Runtime.InteropServices;
using System.Security.Cryptography;
using System.Text;

namespace NativeMath
{
	public class HashCalc : IModule
	{
		public string ModuleName => "HashCalc";

		public string ModuleVersion => "0.0.1";

		private List<GCHandle> handles;

		[UnmanagedCallersOnly(CallConvs = new Type[] { typeof(CallConvCdecl) })]
		private static int CalculateSHA256(IntPtr luaState)
		{
			ILua lua = GmodInterop.GetLuaFromState(luaState);
			SHA256 sha256 = SHA256.Create();
			string data = lua.GetString(1);
			byte[] hash = sha256.ComputeHash(Encoding.UTF8.GetBytes(data));
			lua.PushString(Encoding.UTF8.GetString(hash));
			return 1;
		}

		public void Load(ILua lua, bool is_serverside, ModuleAssemblyLoadContext assembly_context)
		{
			handles = new();

			lua.PushSpecial(SPECIAL_TABLES.SPECIAL_GLOB);
			lua.CreateTable();
			unsafe
			{
				lua.PushCFunction(&CalculateSHA256);

				lua.SetField(-2, "CalculateSHA256");
			}
			lua.SetField(-2, "HashCalc");
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

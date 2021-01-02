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
		private static int CalculateHash(IntPtr luaState)
		{
			ILua lua = GmodInterop.GetLuaFromState(luaState);
			string hashName = lua.GetString(1);
			string data = lua.GetString(2);
			HashAlgorithm hashAlgorithm = HashAlgorithm.Create(hashName);
			byte[] hash = hashAlgorithm.ComputeHash(Encoding.UTF8.GetBytes(data));
			int hashLength = hash.Length;
			StringBuilder builder = new();
			for (int i = 0; i < hashLength; i++)
			{
				builder.Append(hash[i].ToString("X2"));
			}
			lua.PushString(builder.ToString());
			return 1;
		}

		public void Load(ILua lua, bool is_serverside, ModuleAssemblyLoadContext assembly_context)
		{
			handles = new();

			lua.PushSpecial(SPECIAL_TABLES.SPECIAL_GLOB);
			unsafe
			{
				lua.PushCFunction(&CalculateHash);
				lua.SetField(-2, "CalculateHash");
			}
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

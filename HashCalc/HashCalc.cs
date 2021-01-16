using GmodNET.API;
using System;
using System.Collections.Generic;
using System.Linq;
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

		private static readonly string[] hashNames = new[]{
			"SHA", "SHA1", "System.Security.Cryptography.SHA1", "System.Security.Cryptography.HashAlgorithm",
			"MD5", "System.Security.Cryptography.MD5",
			"SHA256", "SHA-256", "System.Security.Cryptography.SHA256",
			"SHA384", "SHA-384", "System.Security.Cryptography.SHA384",
			"SHA512", "SHA-512", "System.Security.Cryptography.SHA512"
		};

		private static int CalculateHash(ILua lua)
		{
			string hashName = lua.GetString(1);
			string data = lua.GetString(2);
			if (!hashNames.Contains(hashName)) throw new ArgumentException("invalid hash algorithm name");
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
			GCHandle handle = lua.PushManagedFunction(CalculateHash);
			handles.Add(handle);
			lua.SetField(-2, "CalculateHash");
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

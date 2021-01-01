using GmodNET.API;
using System;

namespace NativeMath
{
    public class NativeMath : IModule
    {
        public string ModuleName => "NativeMath";

        public string ModuleVersion => "0.0.1";

        public void Load(ILua lua, bool is_serverside, ModuleAssemblyLoadContext assembly_context)
        {
            lua.PushSpecial(SPECIAL_TABLES.SPECIAL_GLOB);
            lua.PushManagedFunction((lua) =>
            {
                Console.WriteLine("native mafs");
                return 0;
            });
            lua.SetField(-2, "NativeMath");
            lua.Pop();
        }

        public void Unload(ILua lua)
        {

        }
    }
}

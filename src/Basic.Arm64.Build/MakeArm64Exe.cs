using Microsoft.Build.Utilities;
using System;
using System.IO;
using System.Reflection.PortableExecutable;

namespace Basic.Arm64.Build
{
    public sealed class MakeArm64Exe : Task
    {
        public string AssemblyName { get; set; }

        public string Directory { get; set; }

        public override bool Execute()
        {
            var filePath = Path.Combine(Directory, Path.ChangeExtension(AssemblyName, ".exe"));
            using var stream = File.Open(filePath, FileMode.Open, FileAccess.ReadWrite, FileShare.Read);
            using var peReader = new PEReader(stream);
            stream.Position = peReader.PEHeaders.CoffHeaderStartOffset;

            using var writer = new BinaryWriter(stream);
            writer.Write((ushort)Machine.Arm64);
            writer.Flush();
            stream.Flush();
            return true;
        }
    }
}

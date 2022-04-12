using System;
using System.Runtime.InteropServices;

namespace ExampleExe
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine($"The architecture is {RuntimeInformation.ProcessArchitecture}");
        }
    }
}

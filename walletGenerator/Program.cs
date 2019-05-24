using System;
using System.Threading.Tasks;
using WalletGenerator.CommandLine;

namespace WalletGenerator
{
    class Program
    {
        static async Task Main(string[] args)
        {
            // TODO: ask to write down mnemonics
            // TODO: take wallet name as argument

			await CommandInterpreter.ExecuteCommandsAsync(args);


			/*
            string password = "test123";

            Console.Write("Choose a wallet password: ");

            password = PasswordConsole.ReadPassword();
			password = Guard.Correct(password);

            string filePath = "wallet.json";

            var manager = KeyManager.CreateNew( out Mnemonic mnemonic, password, filePath );
			*/
            //manager.ToFile();
        }
    }
}

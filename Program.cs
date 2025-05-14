//https://community.ibm.com/community/user/blogs/tapan-kumar-ghosh/2023/09/11/deploy-and-capture-db2trc-on-red-hat-openshift
using IBM.Data.Db2;

namespace OCTest
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Console.WriteLine("Using DB2 .NET8 provider");

            string uid = Environment.GetEnvironmentVariable("uid");

            string pwd = Environment.GetEnvironmentVariable("pwd");

            string server = Environment.GetEnvironmentVariable("server");

            string db = Environment.GetEnvironmentVariable("db");

            string security = Environment.GetEnvironmentVariable("security");

            string libpath = Environment.GetEnvironmentVariable("LD_LIBRARY_PATH");
            Console.WriteLine("The LIBPATH is "+libpath);
            
            //Connection String

            string connString = "uid=" + uid + ";pwd=" + pwd + ";server=" + server + ";database=" + db + ";Security=" + security;

            Console.WriteLine("Connection string is "+connString);
            
            //DB2Connection con = new DB2Connection(connString);

            try
            {
                //con.Open();
            }
            catch(Exception ex)
            {
                Console.WriteLine("The connection error is "+ex.Message);
            }

            Console.WriteLine("Connection Opened successfully");

            //con.Close();

            Console.WriteLine("Connection Closed");

        }
    }
}




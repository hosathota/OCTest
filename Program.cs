//https://community.ibm.com/community/user/blogs/tapan-kumar-ghosh/2023/09/11/deploy-and-capture-db2trc-on-red-hat-openshift
using IBM.Data.Db2;

namespace OCTest
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello, World!");
            Console.WriteLine("Using DB2 .NET6 provider");

            string uid = Environment.GetEnvironmentVariable("uid");

            string pwd = Environment.GetEnvironmentVariable("pwd");

            string server = Environment.GetEnvironmentVariable("server");

            string db = Environment.GetEnvironmentVariable("db");

            string security = Environment.GetEnvironmentVariable("security");

            //Connection String

            string connString = "uid=" + uid + ";pwd=" + pwd + ";server=" + server + ";database=" + db + ";Security=" + security;

            DB2Connection con = new DB2Connection(connString);

            con.Open();

            Console.WriteLine("Connection Opened successfully");

            con.Close();

            Console.WriteLine("Connection Closed");

        }
    }
}




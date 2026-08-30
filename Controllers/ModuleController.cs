using Microsoft.AspNetCore.Mvc;
using Microsoft.CodeAnalysis;
using Microsoft.CodeAnalysis.CSharp;
using Microsoft.CodeAnalysis.Emit;
using Microsoft.Data.SqlClient;
using System.Data;
using System.IO;
using System.Reflection;
using System.Text;

namespace LoginDemo.Controllers
{
    public class ModuleController : Controller
    {
        private readonly IConfiguration _configuration;

        public ModuleController(IConfiguration configuration)
        {
            _configuration = configuration;
        }
                
        public IActionResult Sql()
        {
            return View();
        }
        public IActionResult SqlTopic(string topic)
        {
            ViewBag.Topic = topic;
            return View();
        }

        //public IActionResult CSharpCompiler()
        //{
        //    return View();
        //}
        public IActionResult CSharpCompiler(string code = null)
        {
            if (string.IsNullOrEmpty(code))
            {
                code = @"using System;

class Program
{
    static void Main()
    {
        Console.WriteLine(""Hello World"");
    }
}";
            }

            ViewBag.Code = code;

            return View();
        }
        public IActionResult CSharpTopic(string topic)
        {
            ViewBag.Topic = topic;
            return View();
        }

        // 🔥 EXECUTE SQL QUERY
        [HttpPost]
        public IActionResult ExecuteSql(string sqlQuery)
        {
            ViewBag.Query = sqlQuery;
            ViewBag.Topic = "SQL Practice";

            string connStr = _configuration.GetConnectionString("DefaultConnection");

            try
            {
                using (SqlConnection con = new SqlConnection(connStr))
                {
                    //SqlCommand cmd = new SqlCommand(sqlQuery, con);
                    SqlCommand cmd = new SqlCommand("sp_Validate_Sql_Query", con);
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@SqlQuery", sqlQuery);
                    con.Open();

                    // SELECT QUERY
                    if (sqlQuery.Trim().ToUpper().StartsWith("SELECT"))
                    {
                        SqlDataAdapter da = new SqlDataAdapter(cmd);
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        ViewBag.Result = ConvertTableToHtml(dt);
                    }
                    else
                    {
                        int rows = cmd.ExecuteNonQuery();
                        ViewBag.Result = $"<b>{rows}</b> row(s) affected.";
                    }
                }
            }
            catch (Exception ex)
            {
                ViewBag.Result = $"<span style='color:red'>{ex.Message}</span>";
            }

            return View("SqlTopic");
        }

        // Convert DataTable to HTML
        private string ConvertTableToHtml(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();

            sb.Append("<table class='table table-bordered table-sm'><tr>");
            foreach (DataColumn col in dt.Columns)
            {
                sb.Append("<th>" + col.ColumnName + "</th>");
            }
            sb.Append("</tr>");

            foreach (DataRow row in dt.Rows)
            {
                sb.Append("<tr>");
                foreach (var item in row.ItemArray)
                {
                    sb.Append("<td>" + item + "</td>");
                }
                sb.Append("</tr>");
            }

            sb.Append("</table>");
            return sb.ToString();
        }

        [HttpGet]
        public IActionResult GetSqlTopic(string topic)
        {
            string connStr = _configuration.GetConnectionString("DefaultConnection");

            string result = "";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT TopicContent FROM SQLTopics WHERE TopicName=@topic";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@topic", topic);

                con.Open();
                var data = cmd.ExecuteScalar();

                if (data != null)
                    result = data.ToString();
            }

            return Json(result);
        }

        [HttpGet]
        public IActionResult GetCSharpTopic(string topic)
        {
            string connStr =_configuration.GetConnectionString("DefaultConnection");

            string content = "";
            string sampleCode = "";

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = @"
            SELECT TopicContent, Code
            FROM [C#Topics]
            WHERE TopicName = @TopicName";

                SqlCommand cmd = new SqlCommand(query, con);

                cmd.Parameters.AddWithValue("@TopicName", topic);

                con.Open();

                using (SqlDataReader dr = cmd.ExecuteReader())
                {
                    if (dr.Read())
                    {
                        content = dr["TopicContent"].ToString();
                        sampleCode = dr["Code"].ToString();
                    }
                }
            }

            return Json(new
            {
                content = content,
                sampleCode = sampleCode
            });
        }

        [HttpGet]
        public IActionResult GetTopics(string language)
        {
            string connStr = _configuration.GetConnectionString("DefaultConnection");

            List<string> topics = new List<string>();

            using (SqlConnection con = new SqlConnection(connStr))
            {
                SqlCommand cmd= new SqlCommand("", con);
                if (language == "SQL")
                {
                    string query = "SELECT TopicName FROM SQLTopics WHERE Language = @Language";
                    cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Language", language);
                }
                else if (language == "C#")
                {
                    string query = "SELECT TopicName FROM [C#Topics] where Id like '%0' and Language = @Language";
                    cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@Language", language);
                }

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                while (dr.Read())
                {
                    topics.Add(dr["TopicName"].ToString());
                }
            }

            return Json(topics);
        }

        [HttpGet]
        public IActionResult GetCSharpSubTopics(string topicName)
        {
            if (string.IsNullOrWhiteSpace(topicName))
            {
                return Json(new List<string>());
            }

            string query = @"
        SELECT TopicName
        FROM C#Topics
        WHERE ParentID IN
        (
            SELECT ID
            FROM C#Topics
            WHERE TopicName = @TopicName
        )
        AND ID NOT IN
        (
            SELECT ID
            FROM C#Topics
            WHERE TopicName = @TopicName
        )
        ORDER BY ID";

            var topics = new List<string>();

            using (SqlConnection con = new SqlConnection(_configuration.GetConnectionString("DefaultConnection")))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@TopicName", topicName);

                    con.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            topics.Add(reader["TopicName"].ToString());
                        }
                    }
                }
            }

            return Json(topics);
        }
        public class CSharpCodeRequest
        {
            public string Code { get; set; }
        }

        [HttpPost]
        public IActionResult CompileCSharp(
            [FromBody] CSharpCodeRequest request)
        {
            try
            {
                if (request == null ||
                    string.IsNullOrWhiteSpace(request.Code))
                {
                    return Json(new
                    {
                        success = false,
                        output = "Please enter C# code."
                    });
                }

                // ============================================
                // CREATE SYNTAX TREE
                // ============================================

                SyntaxTree syntaxTree =
                    CSharpSyntaxTree.ParseText(request.Code);


                // ============================================
                // GET .NET RUNTIME ASSEMBLIES
                // ============================================

                var references = new List<MetadataReference>();

                var trustedAssemblies =
                    AppContext.GetData("TRUSTED_PLATFORM_ASSEMBLIES")
                    as string;

                if (!string.IsNullOrEmpty(trustedAssemblies))
                {
                    foreach (var assemblyPath
                             in trustedAssemblies.Split(
                                 Path.PathSeparator))
                    {
                        references.Add(
                            MetadataReference.CreateFromFile(
                                assemblyPath));
                    }
                }


                // ============================================
                // CREATE COMPILATION
                // ============================================

                CSharpCompilation compilation =
                    CSharpCompilation.Create(
                        "CSharpPractice_" +
                        Guid.NewGuid().ToString("N"),

                        new[] { syntaxTree },

                        references,

                        new CSharpCompilationOptions(
                            OutputKind.ConsoleApplication)
                    );


                // ============================================
                // COMPILE
                // ============================================

                using var memoryStream =
                    new MemoryStream();

                EmitResult emitResult =
                    compilation.Emit(memoryStream);


                // ============================================
                // COMPILATION ERROR
                // ============================================

                if (!emitResult.Success)
                {
                    var errors =
                        emitResult.Diagnostics
                            .Where(x =>
                                x.Severity ==
                                DiagnosticSeverity.Error)
                            .Select(x => x.ToString());

                    return Json(new
                    {
                        success = false,
                        output = string.Join(
                            Environment.NewLine,
                            errors)
                    });
                }


                // ============================================
                // LOAD COMPILED ASSEMBLY
                // ============================================

                memoryStream.Position = 0;

                Assembly assembly =
                    Assembly.Load(
                        memoryStream.ToArray());


                // ============================================
                // FIND MAIN METHOD
                // ============================================

                Type programType =
                    assembly.GetTypes()
                        .FirstOrDefault(t =>
                            t.GetMethod(
                                "Main",
                                BindingFlags.Static |
                                BindingFlags.Public |
                                BindingFlags.NonPublic)
                            != null);


                if (programType == null)
                {
                    return Json(new
                    {
                        success = false,
                        output = "Main() method not found."
                    });
                }


                MethodInfo mainMethod =
                    programType.GetMethod(
                        "Main",
                        BindingFlags.Static |
                        BindingFlags.Public |
                        BindingFlags.NonPublic);


                // ============================================
                // CAPTURE CONSOLE OUTPUT
                // ============================================

                TextWriter originalOutput =
                    Console.Out;

                using StringWriter writer =
                    new StringWriter();

                try
                {
                    Console.SetOut(writer);

                    mainMethod.Invoke(
                        null,
                        null);
                }
                finally
                {
                    Console.SetOut(originalOutput);
                }


                // ============================================
                // RETURN OUTPUT
                // ============================================

                return Json(new
                {
                    success = true,
                    output = writer.ToString()
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    output =
                        ex.InnerException?.Message
                        ?? ex.Message
                });
            }
        }


    }
}

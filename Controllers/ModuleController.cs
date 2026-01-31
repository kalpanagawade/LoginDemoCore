using Microsoft.AspNetCore.Mvc;
using Microsoft.Data.SqlClient;
using System.Data;
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
    }
}

using LoginDemo.Models;
using Microsoft.AspNetCore.Mvc;
//using System.Data.SqlClient;
using Microsoft.Data.SqlClient;

namespace LoginDemo.Controllers
{
    public class AccountController : Controller
    {
        private readonly IConfiguration _configuration;

        public AccountController(IConfiguration configuration)
        {
            _configuration = configuration;
        }

        // GET: Login Page
        public IActionResult Login()
        {
            return View();
        }

        // POST: Login Action
        [HttpPost]
        public IActionResult Login(UserModel model)
        {
            string connStr = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection con = new SqlConnection(connStr))
            {
                string query = "SELECT COUNT(*) FROM Users WHERE Username=@u AND Password=@p";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@u", model.Username);
                cmd.Parameters.AddWithValue("@p", model.Password);

                con.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    return RedirectToAction("Dashboard");
                }
                else
                {
                    ViewBag.Message = "Invalid Username or Password";
                }
            }
            return View();
        }

        public IActionResult Dashboard()
        {
            return View();

        }
        
        // GET: Register Page
        public IActionResult Register()
        {
            return View();
        }

        // POST: Register Action
        [HttpPost]
        public IActionResult Register(UserModel model)
        {
            string connStr = _configuration.GetConnectionString("DefaultConnection");

            using (SqlConnection con = new SqlConnection(connStr))
            {
                // Check if user already exists
                string checkQuery = "SELECT COUNT(*) FROM Users WHERE Username=@u";
                SqlCommand checkCmd = new SqlCommand(checkQuery, con);
                checkCmd.Parameters.AddWithValue("@u", model.Username);

                con.Open();
                int userExists = (int)checkCmd.ExecuteScalar();

                if (userExists > 0)
                {
                    ViewBag.Error = "Username already exists!";
                    return View();
                }

                // Insert new user
                string insertQuery = "INSERT INTO Users (Username, Password) VALUES (@u, @p)";
                SqlCommand insertCmd = new SqlCommand(insertQuery, con);
                insertCmd.Parameters.AddWithValue("@u", model.Username);
                insertCmd.Parameters.AddWithValue("@p", model.Password);

                insertCmd.ExecuteNonQuery();

                ViewBag.Success = "Registration successful!";
                ViewBag.ShowLoginButton = true;
            }

            return View();
        }

    }
}

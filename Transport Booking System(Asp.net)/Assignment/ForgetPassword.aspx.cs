using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Net.Mail;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class ForgetPassword : System.Web.UI.Page
    {
        int randomCode;
        public static string to;


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["role"] != null)
            {
                string link = (string)Session["link"];
                Response.Redirect(link);
            }
        }

        protected void ButtonSendCode_Click(object sender, EventArgs e)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            string to = emailVerify.Text;

            if (to != "")
            {
                string from = "xinjunwong0602@gmail.com"; // Fix the typo in the email address
                string password = "zrnx miaz oohs bfrp"; // Replace with the actual password or use a secure method

                Random rand = new Random();
                randomCode = (rand.Next(999999));

                ICredentialsByHost credentials = new NetworkCredential(from, password);

                SmtpClient smtpClient = new SmtpClient()
                {
                    Host = "smtp.gmail.com",
                    Port = 587,
                    EnableSsl = true,
                    Credentials = credentials
                };

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(from);
                mail.To.Add(to);
                mail.Subject = "Password Reset code";
                mail.Body = "Your reset code is  " + randomCode.ToString();

                try
                {

                    conn.Open();

                    string querySelect = "SELECT * FROM [User] WHERE email = @Email;";
                    SqlCommand cmd = new SqlCommand(querySelect, conn);
                    cmd.Parameters.AddWithValue("@Email", to);
                    SqlDataReader reader = cmd.ExecuteReader();

                    if (reader.Read() == true)
                    {
                        string userId = reader["userId"].ToString();
                        reader.Close();

                        string queryUpdateCode = "UPDATE [User] SET verifyCode = @verifyCode WHERE userId = @userId;";
                        SqlCommand cmd1 = new SqlCommand(queryUpdateCode, conn);
                        cmd1.Parameters.AddWithValue("@verifyCode", randomCode);
                        cmd1.Parameters.AddWithValue("@userId", userId);
                        cmd1.ExecuteNonQuery();

                        try
                        {
                            smtpClient.Send(mail);
                            Session["verifyCodeSentSuccessfully"] = "true";
                            LblError.Text = "Code Send Successfully";
                        }
                        catch (Exception ex)
                        {
                            string errorMessage = "Error: " + ex.Message;
                            Response.Write("<script>alert('" + errorMessage + "')</script>");
                        }
                    }
                    else
                    {
                        LblError.Text = "Code Send Unsuccessfully, Please Try Again!";
                    }
                }
                catch (Exception ex)
                {
                    string errorMessage = "Error: " + ex.Message;
                    Response.Write("<script>alert('" + errorMessage + "')</script>");
                }
                finally
                {
                    conn.Close();
                }
            }
            else
            {
                LblError.Text = "Email Required !";
            }
        }

        protected void ButtonVerify_Click(object sender, EventArgs e)
        {
            int c = check(CodeVerify.Text, emailVerify.Text);
            if (c == 1)
            {

                SqlConnection conn;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                conn = new SqlConnection(strCon);
                string query = "SELECT * FROM [User] Where verifyCode = @verifyCode AND email = @email";
                SqlCommand cmdSelect = new SqlCommand(query, conn);
                cmdSelect.Parameters.AddWithValue("@verifyCode", CodeVerify.Text);
                cmdSelect.Parameters.AddWithValue("@email", emailVerify.Text);

                conn.Open();
                SqlDataReader user = cmdSelect.ExecuteReader();
                if (user.HasRows)
                {
                    if (user.Read())
                    {
                        Session["role"] = user["role"].ToString();
                        Session["userid"] = user["userid"].ToString();
                        Session["username"] = user["username"].ToString();
                        Session["email"] = user["email"].ToString();
                        updateVerifyCode();
                        string link = "Home.aspx";
                        if (Session["link"] != null)
                        {
                            link = Session["link"].ToString();
                        }
                        Response.Redirect(link);
                    }
                }
            }
            else
            {
                LblErrorCode.Text = "Wrong Code, Please Try Again!";
            }

        }
        int check(string CodeVerify, string email)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();
            string query = "select count(*) FROM [User] where email ='" + email + "'AND verifyCode ='" + CodeVerify + "'";
            SqlCommand cmd = new SqlCommand(query, conn);
            int c = (int)cmd.ExecuteScalar();
            conn.Close();
            return c;
        }

        protected void updateVerifyCode()
        {

            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            try
            {
                string queryUpdateCode = "UPDATE [User] SET verifyCode = @verifyCode WHERE email = @email;";
                SqlCommand cmd1 = new SqlCommand(queryUpdateCode, conn);
                cmd1.Parameters.AddWithValue("@verifyCode", "");
                cmd1.Parameters.AddWithValue("@email", emailVerify.Text);
                conn.Open();
                cmd1.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                string errorMessage = "Error: " + ex.Message;
                Response.Write("<script>alert('" + errorMessage + "')</script>");
            }
            finally
            {
                conn.Close();
            }
        }

    }

}
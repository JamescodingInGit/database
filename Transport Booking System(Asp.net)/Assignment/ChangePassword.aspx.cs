using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Security.Cryptography;
using System.Net;
using System.Net.Mail;

namespace Assignment
{

    public partial class ChangePassword : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            Session["link"] = "Profile.aspx";
            if (Session["role"] == null)
            {
                Response.Redirect("Login.aspx");
            }
            if (!IsPostBack)
            {
                updateVerifyCode();
            }
        }

        protected void btnUpdate_Click(object sender, EventArgs e)
        {
            int c = check(txtVerify.Text);
            if (c == 1)
            {
                int userId = Convert.ToInt32(Session["userid"]);

                if (txtNPass.Text != txtCNPass.Text)
                {
                    lblMessage.Text = "The new password and new confirm password must be same!!!";
                }
                if (txtNPass.Text != "" && txtCNPass.Text != "")
                {
                    if (txtNPass.Text == txtCNPass.Text)
                    {
                        SqlConnection conn;
                        string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                        conn = new SqlConnection(strCon);

                        try
                        {
                            string queryEdit = "Update [User] Set password = @password WHERE [userID] = @userID";

                            // Create SqlConnection and SqlCommand
                            using (SqlCommand cmdEdit = new SqlCommand(queryEdit, conn))
                            {
                                byte[] hashBytes = ComputeHash(txtNPass.Text);
                                cmdEdit.Parameters.AddWithValue("@userID", userId);
                                cmdEdit.Parameters.AddWithValue("@password", hashBytes);
                                updateVerifyCode();
                                try
                                {
                                    conn.Open();
                                    // Execute the update query
                                    cmdEdit.ExecuteNonQuery();
                                    Response.Write("<script>alert('Successful Change password !!!')</script>");
                                    Session.Clear();
                                    Session.Abandon();
                                    Response.Redirect("Login.aspx");
                                }
                                catch (Exception ex)
                                {
                                    // Handle exceptions, log, or display an error message
                                    Response.Write("<script>alert('" + ex + "')</script>");
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            Response.Write("<script>alert('" + ex + "')</script>");
                        }

                        conn.Close();
                    }
                }
                else
                {
                    lblMessage.Text = "Please fillout all field!!!";
                }

            }
            else
            {
                lblMessage.Text = "Wrong Code, Please Try Again!";
            }

        }

        protected byte[] ComputeHash(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                // Convert the input string to bytes
                byte[] inputBytes = Encoding.UTF8.GetBytes(input);

                // Compute hash value from the bytes
                return sha256.ComputeHash(inputBytes);
            }
        }

        int randomCode;
        protected void bttVerify_Click(object sender, EventArgs e)
        {
            string to = Session["email"].ToString();

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

                SqlConnection conn;
                string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                conn = new SqlConnection(strCon);
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
                            lblMessage.Text = "Code Send Successfully";
                        }
                        catch (Exception ex)
                        {
                            string errorMessage = "Error: " + ex.Message;
                            Response.Write("<script>alert('" + errorMessage + "')</script>");
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Code Send Unsuccessfully, Please Try Again!";
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

        }

        protected void updateVerifyCode()
        {
            string userID = Session["userID"].ToString();


            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            try
            {
                string queryUpdateCode = "UPDATE [User] SET verifyCode = @verifyCode WHERE userId = @userId;";
                SqlCommand cmd1 = new SqlCommand(queryUpdateCode, conn);
                cmd1.Parameters.AddWithValue("@verifyCode", "");
                cmd1.Parameters.AddWithValue("@userId", userID);
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

        int check(string CodeVerify)
        {
            SqlConnection conn;
            string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            conn = new SqlConnection(strCon);
            conn.Open();
            string query = "select count(*) FROM [User] where userID ='" + Session["userID"].ToString() + "'AND verifyCode ='" + CodeVerify + "'";
            SqlCommand cmd = new SqlCommand(query, conn);
            int c = (int)cmd.ExecuteScalar();
            conn.Close();
            return c;
        }

    }
}
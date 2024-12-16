using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
	public partial class Register : System.Web.UI.Page
	{
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["role"] != null)
			{
				string link = (string)Session["link"];
				if (link == null)
				{
					Response.Redirect(link);
				}

			}
		}

		protected void BtnRegister_Click(object sender, EventArgs e)
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			try
			{
				if (TxtFirstname.Text != "" && TxtLastname.Text != "" && TxtEmail.Text != "" && Txtusername.Text != ""
					&& TxtPsw.Text != "" && TxtConfirmPsw.Text != "" && TxtContact.Text != "")
				{
					if (TxtPsw.Text == TxtConfirmPsw.Text)
					{
						int c = check(TxtEmail.Text);
						if (c != 1)
						{
							if (checkUsername(Txtusername.Text) != 1)
							{
								byte[] hashBytes = ComputeHash(TxtPsw.Text);
								conn = new SqlConnection(strCon);
								conn.Open();
								SqlCommand cmd = new SqlCommand("INSERT INTO [User] (firstName, lastName, email, username, password, role, contactNumber) " +
									"VALUES(@firstName, @lastName, @email, @username, @password, @role, @contactNumber)", conn);
								cmd.Parameters.AddWithValue("@firstName", TxtFirstname.Text);
								cmd.Parameters.AddWithValue("@lastName", TxtLastname.Text);
								cmd.Parameters.AddWithValue("@email", TxtEmail.Text);
								cmd.Parameters.AddWithValue("@username", Txtusername.Text);
								cmd.Parameters.AddWithValue("@password", hashBytes);
								cmd.Parameters.AddWithValue("@role", "Customer");
								cmd.Parameters.AddWithValue("@contactNumber", TxtContact.Text);
								cmd.ExecuteNonQuery();
								conn.Close();
								Response.Redirect("Login.aspx");
							}
							else
							{
								MessageBox.Text = "This Username already Registered";
							}
						}
						else
						{
							MessageBox.Text = "This Email already Registered";
						}
					}
					else
					{
						MessageBox.Text = "Password Does Not Match";
					}
				}
			}
			catch (Exception ex)
			{
				MessageBox.Text = (ex.Message);
			}

		}

		int check(string TxtEmail)
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			conn.Open();
			string query = "SELECT COUNT(*) FROM [User] WHERE email = @Email";
			SqlCommand cmd = new SqlCommand(query, conn);
			cmd.Parameters.AddWithValue("@Email", TxtEmail);
			int c = (int)cmd.ExecuteScalar();
			conn.Close();
			return c;
		}

		int checkUsername(string username)
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			conn.Open();
			string query = "SELECT COUNT(*) FROM [User] WHERE username = @username";
			SqlCommand cmd = new SqlCommand(query, conn);
			cmd.Parameters.AddWithValue("@username", username);
			int c = (int)cmd.ExecuteScalar();
			conn.Close();
			return c;
		}

		protected void BtnGoLogin_Click(object sender, EventArgs e)
		{
			Response.Redirect("Login.aspx");
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
	}
}
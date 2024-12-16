using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Assignment
{
    public partial class Login : System.Web.UI.Page
    {
		protected void Page_Load(object sender, EventArgs e)
		{
			if (Session["role"] != null)
			{
				string link = (string)Session["link"];
				Response.Redirect(link);
			}

		}
		//Data Sources 是 Connection String
		
		protected void BtnLogin_Click(object sender, EventArgs e)
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			string query = "SELECT * FROM [User] Where username = @username";
			SqlCommand cmdSelect = new SqlCommand(query, conn);
			cmdSelect.Parameters.AddWithValue("@username", Txtusername.Text);
			cmdSelect.Parameters.AddWithValue("@pwd", TxtPsw.Text);

			conn.Open();
			SqlDataReader user = cmdSelect.ExecuteReader();
			String uname;
			bool lockStatus;
			DateTime lockdatetime = DateTime.Now;
			if (!user.HasRows)
			{
				MessageBox.Text = "Invalid Username Or Password ! Please Try Again.";
			}
			else
			{
				if (user.Read())
				{
					uname = user["username"].ToString();
                    if (user["locked"].ToString() == "1")
                    {
						lockStatus = true;

                    }
                    else
                    {
						lockStatus = false;

					}

					if (lockStatus == true)
					{
						lockdatetime = Convert.ToDateTime(user["lockDateTime"].ToString());
						lockdatetime = Convert.ToDateTime(lockdatetime.ToString("dd/MM/yyyy HH:mm:ss"));

					}
					if (lockStatus == true)
					{
						DateTime dateTime = Convert.ToDateTime(DateTime.Now.ToString("dd/MM/yyyy HH:mm:ss"));
						TimeSpan ts = dateTime.Subtract(lockdatetime);
						Int32 minutesLocked = Convert.ToInt32(ts.TotalMinutes);
						Int32 pendingminutes = 5 - minutesLocked;
						if (pendingminutes <= 0)
						{
							unlockAccount();
						}
						else
						{
							MessageBox.Text = "Your Account has been locked for 5 minutes for 3 Invalid Attempts. It will be automatically unlocked with " + pendingminutes + " Minutes";
						}

					}
					else
					{
						byte[] hashBytes = ComputeHash(TxtPsw.Text);
						string hashString = Convert.ToBase64String(hashBytes);
						byte[] storedPasswordBytes = (byte[])user["password"]; 

						if (storedPasswordBytes.Length == hashBytes.Length)
						{
							bool passwordsMatch = true;
							for (int i = 0; i < storedPasswordBytes.Length; i++)
							{
								if (storedPasswordBytes[i] != hashBytes[i])
								{
									passwordsMatch = false;
									break; // Exit loop early if a mismatch is found
								}
							}

							if (passwordsMatch)
							{
								// Passwords match, perform actions (set session variables, redirect, etc.)
								Session["role"] = user["role"].ToString();
								Session["userid"] = user["userid"].ToString();
								Session["username"] = user["username"].ToString();
								string link = Session["link"].ToString();
								Response.Redirect(link);
							}
							else
							{
								int attemptCount;
								if (Session["invalidloginattempt"] != null)
								{
									attemptCount = Convert.ToInt16(Session["invalidloginattempt"].ToString());
									attemptCount = attemptCount + 1;
								}
								else
								{
									attemptCount = 1;
								}
								Session["invalidloginattempt"] = attemptCount;
								if (attemptCount == 3)
								{
									MessageBox.Text = "Your Account has been locked for 5 minutes for 3 Invalid Attempts. It will be automatically unlocked with 5 Minutes";
									changeLockStatus();
								}
								else
								{
									MessageBox.Text = "Invalid Username Or Password! Please Try Again. You still have " + (3 - attemptCount) + " times to login";
								}
							}
						}
						

					}
					conn.Close();
				}

			}

		}

		void changeLockStatus()
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			String format = "MM/dd/yyyy HH:mm:ss";
			String updateQuery = "Update User set locked=1, lockDateTime='" + DateTime.Now.ToString(format) + "' where username = '" + Txtusername.Text + "'";
			conn.Open();
			SqlCommand cmd = new SqlCommand();
			cmd.CommandText = updateQuery;
			cmd.Connection = conn;
			cmd.ExecuteNonQuery();
		}

		void unlockAccount()
		{
			SqlConnection conn;
			string strCon = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
			conn = new SqlConnection(strCon);
			String updateQuery = "Update User set locked=0, lockDateTime=NULL where username= '" + Txtusername.Text + "'";
			conn.Open();
			SqlCommand cmd = new SqlCommand();
			cmd.CommandText = updateQuery;
			cmd.Connection = conn;
			cmd.ExecuteNonQuery();

		}
		protected void BtnGoRegister_Click(object sender, EventArgs e)
		{
			Response.Redirect("Register.aspx");
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
package com.example.assignment.util

import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import java.util.Properties
import javax.mail.Authenticator
import javax.mail.Message
import javax.mail.PasswordAuthentication
import javax.mail.Session
import javax.mail.Transport
import javax.mail.internet.MimeMessage

class SimpleEmail(
    private var to     : String  = "",
    private var subject: String  = "",
    private var content: String  = "",
    private var isHtml : Boolean = false,
) {
    // --- UPDATE THE FOLLOWINGS -------------------------------------------------------------------

    private val username = "xinjunwong0602@gmail.com" // EMAIL ACCOUNT
    private val password = "hpxnaqbnxzradwbj"   // APP PASSWORD
    private val personal = "😊 Reset Password"   // DISPLAY NAME

    private val host = "smtp.gmail.com"
    private val port = "587"

    // ---------------------------------------------------------------------------------------------

    private val from = "$personal<$username>"
    private var message: MimeMessage? = null

    fun to(to: String): SimpleEmail {
        this.to = to
        return this
    }

    fun subject(subject: String): SimpleEmail {
        this.subject = subject
        return this
    }

    fun content(content: String): SimpleEmail {
        this.content = content
        return this
    }

    fun isHtml(isHtml: Boolean = true): SimpleEmail {
        this.isHtml = isHtml
        return this
    }

    private fun getMessage(): MimeMessage {
        if (message == null) {
            val prop = Properties().apply {
                put("mail.smtp.auth", "true")
                put("mail.smtp.starttls.enable", "true")
                put("mail.smtp.host", host)
                put("mail.smtp.port", port)
                put("mail.smtp.ssl.trust", host)
                put("mail.smtp.ssl.protocols", "TLSv1.2")
            }

                val auth = object : Authenticator() {
                    override fun getPasswordAuthentication() =
                        PasswordAuthentication(username, password)
                }

                val sess = Session.getDefaultInstance(prop, auth)

                message = MimeMessage(sess)
            }

            return message!!
        }

        fun send(callback: () -> Unit = {}) {
            val type = if (isHtml) "text/html;charset=utf-8" else "text/plain;charset=utf-8"

            val msg = getMessage()
            msg.setFrom(from)
            msg.setRecipients(Message.RecipientType.TO, to)
            msg.setSubject(subject)
            msg.setContent(content, type)

            CoroutineScope(Dispatchers.IO).launch {
                // NOTE: Use try-catch-finally block to silent runtime error
                Transport.send(msg)
                withContext(Dispatchers.Main) { callback() }
            }
        }
    }
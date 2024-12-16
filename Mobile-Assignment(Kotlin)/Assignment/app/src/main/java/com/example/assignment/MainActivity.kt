package com.example.assignment

import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.ConnectivityManager
import android.net.NetworkCapabilities
import android.os.Build
import android.os.Bundle
import android.view.View
import android.widget.Toast
import androidx.activity.viewModels
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.app.AppCompatDelegate
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import androidx.core.os.bundleOf
import androidx.lifecycle.lifecycleScope
import androidx.navigation.fragment.findNavController
import androidx.navigation.ui.AppBarConfiguration
import androidx.navigation.ui.navigateUp
import androidx.navigation.ui.setupActionBarWithNavController
import androidx.navigation.ui.setupWithNavController
import kotlinx.coroutines.launch
import com.example.assignment.data.AuthVM
import com.example.assignment.data.RoomVM
import com.example.assignment.data.ChatVM
import com.example.assignment.data.User
import com.example.assignment.data.UserVM
import com.example.assignment.databinding.ActivityMainBinding
import com.example.assignment.databinding.HeaderBinding
import com.google.android.gms.auth.api.signin.GoogleSignIn
import com.google.android.gms.auth.api.signin.GoogleSignInClient
import com.google.android.gms.auth.api.signin.GoogleSignInOptions
import com.google.android.gms.tasks.OnCompleteListener
import com.google.firebase.auth.FirebaseAuth
import com.google.firebase.messaging.FirebaseMessaging
import kotlinx.coroutines.delay
import com.example.assignment.util.setImageBlob


class MainActivity : AppCompatActivity() {

    private lateinit var binding: ActivityMainBinding
    internal val nav by lazy { supportFragmentManager.findFragmentById(R.id.host)!!.findNavController() }
    private lateinit var abc: AppBarConfiguration
    private val auth: AuthVM by viewModels()
    private val roomVM: RoomVM by viewModels()
    private val users: UserVM by viewModels()
    private val chatVM: ChatVM by viewModels()
    private lateinit var mGoogleSignInClient: GoogleSignInClient
    private lateinit var mauth: FirebaseAuth

    override fun onCreate(savedInstanceState: Bundle?) {

        users.init()
        roomVM.init()
        chatVM.init()
        auth.init()

        super.onCreate(savedInstanceState)

        // Nightmode save
        val sharedPreferences = getSharedPreferences("Mode", Context.MODE_PRIVATE)
        val nightMode = sharedPreferences.getBoolean("night", false)
        if (nightMode) {
            AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_YES)
        } else {
            AppCompatDelegate.setDefaultNightMode(AppCompatDelegate.MODE_NIGHT_NO)
        }

        val isFirstTime = sharedPreferences.getBoolean("is_first_time", true)

        if (isFirstTime) {
            if (ContextCompat.checkSelfPermission(this, android.Manifest.permission.POST_NOTIFICATIONS) != PackageManager.PERMISSION_GRANTED) {
                ActivityCompat.requestPermissions(this, arrayOf(android.Manifest.permission.POST_NOTIFICATIONS), 300)
            }
            sharedPreferences.edit().putBoolean("is_first_time", false).apply()
        }

        // Setup Google Sign-In
        val gso = GoogleSignInOptions.Builder(GoogleSignInOptions.DEFAULT_SIGN_IN)
            .requestIdToken(getString(R.string.server_client_id))
            .requestEmail()
            .build()
        mGoogleSignInClient = GoogleSignIn.getClient(this, gso)
        mauth = FirebaseAuth.getInstance()

        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        setSupportActionBar(binding.toolbar)

        abc = AppBarConfiguration(
            setOf(
                R.id.homeFragment,
                R.id.messageFragment,
                R.id.activityFragment,
                R.id.favoriteFragment,
                R.id.accountFragment

            ),
            binding.root
        )

        setupActionBarWithNavController(nav, abc)
        binding.bv.setupWithNavController(nav)
        binding.nv.setupWithNavController(nav)

        checkAuthenticationState()

        lifecycleScope.launch { auth.loginFromPreferences() }

        binding.nv.menu.findItem(R.id.logout).setOnMenuItemClickListener {
            auth.logout()
            nav.navigate(R.id.firstFragment)
            true
        }

        auth.getUserLD().observe(this) { user ->
            // TODO(5A): Clear menu + remove header
            binding.nv.menu.clear()
            val h = binding.nv.getHeaderView(0)
            binding.nv.removeHeaderView(h)

            // TODO(5B): Inflate menu + header (based on login status)
            if (user == null) {
                binding.nv.inflateMenu(R.menu.drawer)
                binding.nv.inflateHeaderView(R.layout.header)
            }
            else {
                binding.nv.inflateMenu(R.menu.drawer)
                binding.nv.inflateHeaderView(R.layout.header)
                setHeader(user)
            }
        }

        if(!checkNetwork()){
            Toast.makeText(this, "No Internet Connection", Toast.LENGTH_LONG).show()
        }

    }

    // Check google login state
    private fun checkAuthenticationState() {
        val currentUser = mauth.currentUser
        if (currentUser != null) {
            lifecycleScope.launch {
                // User is signed in, retrieve user data
                val googleAccount = GoogleSignIn.getLastSignedInAccount(this@MainActivity)
                val googleEmail = googleAccount?.email
                if (googleEmail != null) {
                    val userExists = users.doesUserExist(googleEmail)
                    if (userExists) {
                        val user = users.get(googleEmail)
                        if (user != null) {
                            auth.setUser(user)
                        }
                    }
                }
            }
        }
    }

    private suspend fun getFCMToken() {
        waitForUser()
        FirebaseMessaging.getInstance().token.addOnCompleteListener(OnCompleteListener { task ->
            if (task.isSuccessful) {
                val token = task.result
                if(auth.getUser() != null){
                    val user = auth.getUser()
                    if(user!= null){
                        user.fcmToken = token
                        users.set(user)
                    }

                }
            }

        })
    }

    fun Context.checkNetwork(): Boolean {
        val connectivityManager = this.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {

            val network = connectivityManager.activeNetwork ?: return false

            val activeNetwork = connectivityManager.getNetworkCapabilities(network) ?: return false

            return when {
                activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_WIFI) -> true
                activeNetwork.hasTransport(NetworkCapabilities.TRANSPORT_CELLULAR) -> true

                else -> false
            }
        } else {
            // if the android version is below M
            @Suppress("DEPRECATION") val networkInfo =
                connectivityManager.activeNetworkInfo ?: return false
            @Suppress("DEPRECATION")
            return networkInfo.isConnected
        }
    }

    override fun onSupportNavigateUp(): Boolean {
        return nav.navigateUp(abc)
    }
    fun hideBV(){
        binding.bv.visibility = View.GONE
    }

    fun showBV(){
        binding.bv.visibility = View.VISIBLE
    }


    private fun setHeader(user: User) {
        val h = binding.nv.getHeaderView(0)
        val b = HeaderBinding.bind(h)
        b.imgPhoto.setImageBlob(user.photo)
        b.txtName.text  = user.name
        b.txtEmail.text = user.email
    }

    override fun onStart() {
        super.onStart()
        val sharedPreferences = getSharedPreferences("Settings", Context.MODE_PRIVATE)
        val isNotificationsEnabled = sharedPreferences.getBoolean("notifications_enabled", true)
        lifecycleScope.launch {
            waitForUser()
            auth.updateUserStatus("online")
            if(isNotificationsEnabled){
                getFCMToken()
            }
        }
    }

    override fun onResume() {
        super.onResume()
        if (auth.getUser() != null) {
            auth.updateUserStatus("online")
        }
    }

    override fun onStop() {
        super.onStop()
        if (auth.getUser() != null) {
            auth.updateUserStatus("offline")
        }
    }

    private suspend fun waitForUser() {
        while (auth.getUser() == null) {
            delay(100)  // Check every 100 milliseconds
        }
    }


}

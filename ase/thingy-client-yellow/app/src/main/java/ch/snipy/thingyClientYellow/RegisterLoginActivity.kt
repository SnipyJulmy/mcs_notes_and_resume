package ch.snipy.thingyClientYellow

import android.content.Context
import android.net.ConnectivityManager
import android.os.Bundle
import android.util.Log
import android.view.View
import android.widget.AutoCompleteTextView
import android.widget.EditText
import android.widget.Toast
import androidx.fragment.app.FragmentActivity
import androidx.fragment.app.FragmentTransaction
import ch.snipy.thingyClientYellow.routes.DyrAccountService


class RegisterLoginActivity : FragmentActivity() {

    val accountService = DyrAccountService.create()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_register_login)
        supportFragmentManager.beginTransaction()
            .add(R.id.register_login_activity_frame_layout, RegisterActivityFragment.newInstance())
            .commit()
    }

    fun onSelectFragment(view: View) {
        when (view.id) {
            R.id.sign_up_nav -> {
                Log.d("Sign up nav", "NAV")
                val transaction = supportFragmentManager.beginTransaction()
                val fragment = RegisterActivityFragment.newInstance()
                transaction.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN)
                transaction.replace(R.id.register_login_activity_frame_layout, fragment)
                transaction.commit()
            }
            R.id.sign_in_nav -> {
                Log.d("Sign in nav", "NAV")
                val transaction = supportFragmentManager.beginTransaction()
                val fragment = LoginActivityFragment.newInstance()
                transaction.setTransition(FragmentTransaction.TRANSIT_FRAGMENT_OPEN)
                transaction.replace(R.id.register_login_activity_frame_layout, fragment)
                transaction.commit()
            }
        }
    }

    fun onClickCreateAccount(view: View) {
        Log.d("on click create account", "CALLBACK")

        val email = findViewById<EditText>(R.id.create_account_email)
        val password1 = findViewById<EditText>(R.id.create_account_password_1).text.toString()
        val password2 = findViewById<EditText>(R.id.create_account_password_2).text.toString()

        if (password1 != password2) {
            Toast.makeText(applicationContext, getString(R.string.passwords_not_same), Toast.LENGTH_SHORT).show()
        }

        assert(password1 == password2)

        if (isNetworkAvailable()) {
            val request = accountService.register(User(null, null, email.text.toString(), password1)).execute()
            if (request.isSuccessful) {
                navigateToMainActivity()
            } else {
                Toast.makeText(applicationContext, R.string.account_creation_fail, Toast.LENGTH_SHORT).show()
            }
        } else {
            Toast.makeText(applicationContext, "Not connected to the internet", Toast.LENGTH_SHORT).show()
        }
    }

    fun onClickSignIn(view: View) {
        Log.d("on click sign in", "CALLBACK")

        val email = findViewById<AutoCompleteTextView>(R.id.login_email).text.toString()
        val password = findViewById<EditText>(R.id.login_password).text.toString()

        Toast.makeText(applicationContext, R.string.sign_in_fail, Toast.LENGTH_SHORT).show()

        val request = accountService.connect(User(null, null, email, password)).execute()

        if (request.isSuccessful) {
            navigateToMainActivity()
        } else {
            Toast.makeText(applicationContext, R.string.sign_in_fail, Toast.LENGTH_SHORT).show()
        }
    }

    private fun navigateToMainActivity() {
        Toast.makeText(applicationContext, "MainActivity", Toast.LENGTH_SHORT).show()
    }

    private fun isNetworkAvailable(): Boolean {
        val connectivityManager = getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager
        val activeNetworkInfo = connectivityManager.activeNetworkInfo
        return activeNetworkInfo != null && activeNetworkInfo.isConnected
    }
}

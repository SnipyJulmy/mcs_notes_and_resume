package ch.snipy.thingyClientYellow

import androidx.test.ext.junit.runners.AndroidJUnit4
import androidx.test.filters.LargeTest
import androidx.test.rule.ActivityTestRule

import org.junit.Rule
import org.junit.Test
import org.junit.runner.RunWith

@RunWith(AndroidJUnit4::class)
@LargeTest
class LoginViewTest {
    @get:Rule
    val activityResult: ActivityTestRule<RegisterLoginActivity> = ActivityTestRule(RegisterLoginActivity::class.java)

    // TODO
    // @Test
}
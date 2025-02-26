package com.example.flutter_demo.activities

import android.os.Bundle
import com.example.flutter_demo.ChannelResolver
import com.facebook.react.ReactActivity
import com.facebook.react.ReactActivityDelegate
import com.facebook.react.defaults.DefaultNewArchitectureEntryPoint.fabricEnabled
import com.facebook.react.defaults.DefaultReactActivityDelegate


class ReactNativeActivity : ReactActivity() {

    override fun getMainComponentName(): String = "ReactNativeDemo"

    override fun createReactActivityDelegate(): ReactActivityDelegate =
        object : DefaultReactActivityDelegate(this, mainComponentName, fabricEnabled) {
            override fun getLaunchOptions(): Bundle? {
                return intent.extras
            }

            override fun onBackPressed(): Boolean {
                ChannelResolver.resolve()
                return super.onBackPressed()
            }
        }
}
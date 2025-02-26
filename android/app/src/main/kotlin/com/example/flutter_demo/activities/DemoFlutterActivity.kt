package com.example.flutter_demo.activities

import android.content.Intent
import android.os.Bundle
import com.example.flutter_demo.ChannelResolver
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class DemoFlutterActivity : FlutterActivity() {
    private val channel = "flutter.demo/react.native"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channel)
            .setMethodCallHandler { call, result ->
                if (call.method == "openReactNativeScreen") {
                    val arguments = call.arguments<HashMap<String, String>>()

                    val intent = Intent(context, ReactNativeActivity::class.java)
                    if (arguments != null) {
                        val bundle = Bundle().apply {
                            putString("id", arguments["id"])
                            putString("name", arguments["name"])
                            putString("url", arguments["url"])
                            putString("sprite", arguments["sprite"])
                            putBoolean("favorite", arguments["favorite"].toBoolean())
                        }
                        intent.putExtras(bundle)
                    }

                    startActivity(intent)
                    ChannelResolver.setPendingResult(result)
                } else {
                    result.notImplemented()
                }
            }
    }
}

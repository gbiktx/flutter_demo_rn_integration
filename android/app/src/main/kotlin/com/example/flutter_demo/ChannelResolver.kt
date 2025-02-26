package com.example.flutter_demo

import io.flutter.plugin.common.MethodChannel

object ChannelResolver {

    private var pendingResult: MethodChannel.Result? = null
    var favorite: Boolean? = null

    fun setPendingResult(result: MethodChannel.Result) {
        favorite = null
        pendingResult = result
    }

    fun resolve() {
        pendingResult?.success(favorite)
    }
}
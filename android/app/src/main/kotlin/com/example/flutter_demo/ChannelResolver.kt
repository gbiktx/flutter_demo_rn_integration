package com.example.flutter_demo

import io.flutter.plugin.common.MethodChannel

object ChannelResolver {

    private var pendingResult: MethodChannel.Result? = null
    var isFavorite: Boolean? = null

    fun setPendingResult(result: MethodChannel.Result) {
        isFavorite = null
        pendingResult = result
    }

    fun resolve() {
        pendingResult?.success(isFavorite)
    }
}
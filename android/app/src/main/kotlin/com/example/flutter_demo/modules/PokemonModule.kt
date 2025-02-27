package com.example.flutter_demo.modules

import com.example.flutter_demo.ChannelResolver
import com.example.flutter_demo.NativePokemonModuleSpec
import com.facebook.react.bridge.ReactApplicationContext

class PokemonModule(
    private val reactContext: ReactApplicationContext?
) : NativePokemonModuleSpec(reactContext) {

    override fun setFavorite(favorite: Boolean) {
        ChannelResolver.isFavorite = favorite
    }

    override fun exit() {
        reactContext?.currentActivity?.finish()
        ChannelResolver.resolve()
    }

    companion object {
        const val NAME = "NativePokemonModule"
    }

}
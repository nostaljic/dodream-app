package com.example.dodream

import io.flutter.embedding.android.FlutterActivity
import android.content.Intent.getIntent

import android.os.Bundle




class MainActivity: FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {

        // use software rendering (ideally only when you need to)
       getIntent().putExtra("enable-software-rendering", true)

        // start Flutter
        super.onCreate(savedInstanceState)
    }
}

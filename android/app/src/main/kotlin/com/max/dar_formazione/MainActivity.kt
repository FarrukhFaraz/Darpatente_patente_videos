package com.max.dar_formazione

import android.view.WindowManager.LayoutParams
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity() {
    override fun onResume() {
        super.onResume()
        window.addFlags(LayoutParams.FLAG_SECURE)
    }

    override fun onPause() {
        window.clearFlags(LayoutParams.FLAG_SECURE)
        super.onPause()
    }
}
package com.hopegainltd.winitagent

import io.flutter.embedding.android.FlutterActivity
import android.os.Bundle
import com.qoreid.qoreidsdk.QoreidsdkPlugin;

class MainActivity : FlutterActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        QoreidsdkPlugin.initialize(this)
    }
}

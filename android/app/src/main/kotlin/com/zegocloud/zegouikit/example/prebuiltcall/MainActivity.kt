package com.zegocloud.zegouikit.example.prebuiltcall

import android.Manifest
import android.content.Intent
import android.os.Bundle
import android.widget.Toast
import androidx.core.app.ActivityCompat
import androidx.core.content.ContextCompat
import android.content.pm.PackageManager;
import io.flutter.embedding.android.FlutterActivity
import im.zego.zegoexpress.ZegoExpressEngine
import im.zego.zim.ZIM

class MainActivity : FlutterActivity() {
    private companion object {
        const val REQUEST_CODE = 100
        const val AUDIO_PERMISSION = Manifest.permission.RECORD_AUDIO
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        startForegroundNotificationService()
    }

    private fun startForegroundNotificationService() {
        if (isAudioPermissionGranted()) {
            startService(Intent(this, ForegroundService::class.java))
        } else {
            requestAudioPermission()
        }
    }

    private fun isAudioPermissionGranted(): Boolean {
        return ContextCompat.checkSelfPermission(this, AUDIO_PERMISSION) == PackageManager.PERMISSION_GRANTED
    }

    private fun requestAudioPermission() {
        ActivityCompat.requestPermissions(this, arrayOf(AUDIO_PERMISSION), REQUEST_CODE)
    }

    override fun onDestroy() {
        super.onDestroy()
//        ZegoExpressEngine.destroyEngine {}
//
//        ZIM.getInstance()?.destroy()
//
//        // Stop the foreground service if needed
//        stopService(Intent(this, ForegroundService::class.java))
    }

    override fun onRequestPermissionsResult(requestCode: Int, permissions: Array<out String>, grantResults: IntArray) {
        super.onRequestPermissionsResult(requestCode, permissions, grantResults)
        if (requestCode == REQUEST_CODE) {
            if (grantResults.isNotEmpty() && grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                startService(Intent(this, ForegroundService::class.java))
            } else {
                Toast.makeText(this, "Audio permission was rejected", Toast.LENGTH_SHORT).show()
            }
        }
    }
}
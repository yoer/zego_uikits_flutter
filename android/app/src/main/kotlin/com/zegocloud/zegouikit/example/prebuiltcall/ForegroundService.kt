package com.zegocloud.zegouikit.example.prebuiltcall

import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Intent
import android.content.pm.PackageManager
import android.content.pm.ServiceInfo
import android.os.Build
import android.os.IBinder
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat
import com.zegocloud.zegouikit.example.prebuiltcall.R

/**
 * Foreground service used to keep the process in the foreground to receive messages.
 */
class ForegroundService : Service() {

    private companion object {
        const val CHANNEL_ID = "channel"
        const val CHANNEL_NAME = "Channel Name"
        const val CHANNEL_DESC = "Channel Description"
        private const val NOTIFICATION_ID = 65532
    }

    override fun onCreate() {
        super.onCreate()
        createNotificationChannel()
    }

    override fun onBind(intent: Intent): IBinder? {
        return null
    }

    @RequiresApi(Build.VERSION_CODES.Q)
    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val pendingIntent = createPendingIntent()
        val appName = getAppName()

        val notificationBuilder = NotificationCompat.Builder(this, CHANNEL_ID)
            .setSmallIcon(R.mipmap.ic_launcher)
            .setContentTitle(appName)
            .setPriority(NotificationCompat.PRIORITY_DEFAULT)
            .setContentIntent(pendingIntent)
            .setOngoing(false)
            .setAutoCancel(true)

        startForeground(
            NOTIFICATION_ID,
            notificationBuilder.build(),
            if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.R) {
                ServiceInfo.FOREGROUND_SERVICE_TYPE_MICROPHONE
            } else {
                0
            }
        )

        return super.onStartCommand(intent, flags, startId)
    }

    private fun createPendingIntent(): PendingIntent? {
        val appIntent = Intent(this, getLauncherActivityClass()).apply {
            action = Intent.ACTION_MAIN
            addCategory(Intent.CATEGORY_LAUNCHER)
        }

        return PendingIntent.getActivity(
            this,
            0,
            appIntent,
            PendingIntent.FLAG_IMMUTABLE or PendingIntent.FLAG_UPDATE_CURRENT
        )
    }

    private fun getLauncherActivityClass(): Class<*> {
        val intent = Intent(Intent.ACTION_MAIN, null).apply {
            addCategory(Intent.CATEGORY_LAUNCHER)
            setPackage(application.packageName)
        }

        val activities = application.packageManager.queryIntentActivities(intent, 0)
        return if (activities.isNotEmpty()) {
            Class.forName(activities[0].activityInfo.name) // Correctly load the class name
        } else {
            throw IllegalStateException("No launcher activity found")
        }
    }

    private fun getAppName(): String {
        val appInfo = application.packageManager.getApplicationInfo(packageName, PackageManager.GET_META_DATA)
        return if (appInfo.labelRes != 0) {
            getString(appInfo.labelRes)
        } else {
            appInfo.nonLocalizedLabel.toString()
        }
    }

    override fun onDestroy() {
        stopForeground(true)
        stopSelf()
        super.onDestroy()
    }

    private fun createNotificationChannel() {
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            val channel = NotificationChannel(CHANNEL_ID, CHANNEL_NAME, NotificationManager.IMPORTANCE_DEFAULT).apply {
                description = CHANNEL_DESC
                setSound(null, null)
                enableVibration(false)
            }
            val notificationManager = getSystemService(NotificationManager::class.java)
            notificationManager.createNotificationChannel(channel)
        }
    }
}
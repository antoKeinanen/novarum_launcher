package com.example.novarum_launcher

import io.flutter.embedding.android.FlutterActivity

import android.app.WallpaperManager
import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.drawable.BitmapDrawable
import android.graphics.drawable.Drawable
import android.os.Build
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.Result
import org.json.JSONObject
import java.io.ByteArrayOutputStream

class MainActivity: FlutterActivity() {
  var pendingResult: Result? = null
  var wallpaperData: ByteArray? = null

  override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
      super.configureFlutterEngine(flutterEngine)
      MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
          .setMethodCallHandler { call, result ->
              pendingResult = result
              if (call.method.equals("getDeviceInfo")) {
                  deviceInfo
              }
              else if (call.method.equals("getWallpaper")) {
                  getWallpaper
              }
          }
  }

  val deviceInfo: Unit
      get() {
          try {
              val manufacturer: String = Build.MANUFACTURER
              val model: String = Build.MODEL
              val sdkVersion: String = Build.VERSION.SDK
              val osVersion: String = Build.VERSION.RELEASE
              val obj = JSONObject()
              obj.put("platform", "android")
              obj.put("model", model)
              obj.put("manufacturer", manufacturer)
              obj.put("os_version", osVersion)
              obj.put("sdk_version", sdkVersion)
              pendingResult?.success(obj.toString())
          } catch (e: Exception) {
              pendingResult?.error("101", e.message, null)
          }
      }

  val getWallpaper: Unit
      get() {
          try {
              if (wallpaperData != null) {
                  pendingResult?.success(wallpaperData)
                  return
              }

              val wpm = WallpaperManager.getInstance(this);
              try {
                  val wallpaperDrawable = wpm.drawable

                  if (wallpaperDrawable is BitmapDrawable) {
                      wallpaperData = convertToBytes(
                          wallpaperDrawable.bitmap,
                          Bitmap.CompressFormat.JPEG, 100
                      )
                      pendingResult?.success(wallpaperData)
                      return
                  }
              } catch (ex: SecurityException) {
                  pendingResult?.error("101", ex.message, null)
              }

          } catch (e: Exception) {
              pendingResult?.error("101", e.message, null)
          }
      }

  fun convertToBytes(
      image: Bitmap,
      compressFormat: Bitmap.CompressFormat?,
      quality: Int
  ): ByteArray {
      val byteArrayOS = ByteArrayOutputStream()
      image.compress(compressFormat, quality, byteArrayOS)
      return byteArrayOS.toByteArray()
  }

  companion object {
      private const val CHANNEL = "device"
  }
}

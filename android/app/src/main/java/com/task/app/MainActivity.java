package com.task.app;

import android.content.ComponentName;
import android.content.Intent;
import android.util.Log;

import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private final String CHANNEL = "com.qlcv.mobile/channel";
    private MethodChannel channel;

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        channel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        channel.setMethodCallHandler((call, result) -> {
            if ("openApp".equals(call.method)) {
                String packageId = call.argument("package");
                String mainClass = call.argument("class");
                Log.e("OpenApp", packageId + "-" + mainClass);
                try {
                    openApp(packageId, mainClass);
                    result.success(true);
                } catch (Exception e) {
                    result.success(false);
                }

            }
        });
    }

    private void openApp(String packageId, String mainClass) {
        Intent intent = new Intent();
        intent.setComponent(new ComponentName(packageId, mainClass));
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK);
        startActivity(intent);
    }
}

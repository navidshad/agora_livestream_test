package io.flutter.plugins;

import io.flutter.plugin.common.PluginRegistry;
import io.agora.agora_rtc_engine.AgoraRtcEnginePlugin;
import com.baseflow.permissionhandler.PermissionHandlerPlugin;

/**
 * Generated file. Do not edit.
 */
public final class GeneratedPluginRegistrant {
  public static void registerWith(PluginRegistry registry) {
    if (alreadyRegisteredWith(registry)) {
      return;
    }
    AgoraRtcEnginePlugin.registerWith(registry.registrarFor("io.agora.agora_rtc_engine.AgoraRtcEnginePlugin"));
    PermissionHandlerPlugin.registerWith(registry.registrarFor("com.baseflow.permissionhandler.PermissionHandlerPlugin"));
  }

  private static boolean alreadyRegisteredWith(PluginRegistry registry) {
    final String key = GeneratedPluginRegistrant.class.getCanonicalName();
    if (registry.hasPlugin(key)) {
      return true;
    }
    registry.registrarFor(key);
    return false;
  }
}

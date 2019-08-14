package marie.mgc.flutter_vic

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugins.GeneratedPluginRegistrant
import be.tramckrijte.workmanager.WorkmanagerPlugin

class App : FlutterApplication(), PluginRegistry.PluginRegistrantCallback {
    override fun onCreate() {
        super.onCreate()
        WorkmanagerPlugin.setPluginRegistrantCallback(this)
    }

    override fun registerWith(reg: PluginRegistry?) {
        GeneratedPluginRegistrant.registerWith(reg)
    }
}
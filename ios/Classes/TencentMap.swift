import Flutter
import QMapKit

class TencentMapFactory: NSObject, FlutterPlatformViewFactory {
    let registrar: FlutterPluginRegistrar

    init(registrar: FlutterPluginRegistrar) {
        self.registrar = registrar
    }

    func create(withFrame _: CGRect, viewIdentifier _: Int64, arguments _: Any?) -> FlutterPlatformView {
        MapView(registrar)
    }
}

class MapView: NSObject, FlutterPlatformView, QMapViewDelegate {
    let mapView: QMapView
    let api: _TencentMapApi
    let mLatLng: LatLng
    let mapHandler: TencentMapHandler

    init(_ registrar: FlutterPluginRegistrar) {
        mapView = QMapView()
        api = _TencentMapApi(mapView)
        TencentMapApiSetup(registrar.messenger(), api)
        mLatLng = LatLng()
        mapHandler = TencentMapHandler(binaryMessenger: registrar.messenger())
        super.init()
        mapView.delegate = self
        mapView.setUserTrackingMode(QUserTrackingMode.followWithHeading, animated: true)
        mapView.showsUserLocation = true
    }

    func view() -> UIView {
        mapView
    }
    
    func mapView(_ mapView: QMapView!, regionDidChangeAnimated animated: Bool, gesture bGesture: Bool) {   
        mLatLng.latitude = (mapView.centerCoordinate.latitude) as NSNumber
        mLatLng.longitude = (mapView.centerCoordinate.longitude) as NSNumber
        
        mapHandler.onCameraIdleCameraPosition(CameraPosition.make(withBearing: mapView.rotation as NSNumber, target:mLatLng, tilt: mapView.overlooking as NSNumber, zoom: mapView.zoomLevel as NSNumber), completion: {_ in } )
    }
}

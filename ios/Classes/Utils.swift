import QMapKit

extension LatLng {
    var latLng: CLLocationCoordinate2D? {
        if latitude != nil, longitude != nil {
            return CLLocationCoordinate2DMake(latitude!.doubleValue, longitude!.doubleValue)
        }
        return nil
    }
}

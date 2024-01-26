import Foundation
import MapKit

struct Address: Codable {
    let data: [Datum]
}

struct Datum : Codable {
    let latitude, longitude: Double
    let name: String?
}

struct Location : Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

//Petition to api position stack
class MapApi: ObservableObject {
    private let BASE_URL = "http://api.positionstack.com/v1/forward"
    private let API_KEY = "92d0989cebd26dea67f59db3a280d7a6"
    
    //Properties for use on the MapView
    @Published var region: MKCoordinateRegion
    @Published var coordinates = []
    @Published var locations: [Location] = []
    
    //Init for Class and have a default location
    init(){
        self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 43.690783, longitude: -79.604409), span: MKCoordinateSpan(latitudeDelta: 5, longitudeDelta: 5))
        self.locations.insert(Location(name: "Pin", coordinate: CLLocationCoordinate2D(latitude: 43.45335, longitude: 80.39112)), at: 0)
    }
    
    //Method for get the data
    func getLocation(address: String, delta: Double) {
        let pAdrress = address.replacingOccurrences(of: " ", with: "%20")
        let url_string = "\(BASE_URL)?access_key=\(API_KEY)&query=\(pAdrress)"
        
        guard let url = URL(string: url_string) else {
            print("Invalid URL")
            return
        }
        //Petition
        URLSession.shared.dataTask(with: url){ data, response, error in
            guard let data = data else {
                print(error!.localizedDescription)
                return
            }
            //DataMapping
            guard let newCoordinates = try? JSONDecoder().decode(Address.self, from: data) else {
                return
            }
            if newCoordinates.data.isEmpty {
                print("Counld not find the address...")
            }
            //Here we fill the properties with the result of the data
            DispatchQueue.main.async {
                let details = newCoordinates.data[0]
                let lat = details.latitude
                let lon = details.longitude
                let name = details.name
                
                self.coordinates = [lat, lon]
                self.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: lat, longitude: lon), span: MKCoordinateSpan(latitudeDelta: delta, longitudeDelta: delta))
                let newLocation = Location(name: name ?? "Pin", coordinate: CLLocationCoordinate2D(latitude: lat, longitude: lon))
                self.locations.removeAll()
                self.locations.insert(newLocation, at: 0)
                
                print("Successfully loaded the location..\(self.locations[0].name).")
            }
        }.resume()
    }
}

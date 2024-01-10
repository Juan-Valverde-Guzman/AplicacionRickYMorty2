//
//  ViewController.swift
//  CollectionViewRickYMorty
//
//  Created by dam2 on 14/12/23.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UISearchResultsUpdating/*, DatosVaciar*/ {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var arrayPersonajes = [PersonajeModel]()
    
    var filteredPersonajes = [PersonajeModel]()
    
    var episodioSeleccionado = ""
    
    var isSearchBarEmpty: Bool {
        
        return searchController.searchBar.text?.isEmpty ?? true
        
    }
    
    var isFiltering: Bool {
        
        return !searchController.isActive && !isSearchBarEmpty

    }
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var indexpath = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        
        collectionView.delegate = self
        
        searchController.searchResultsUpdater = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        
        searchController.searchBar.placeholder = "no se va a ver"
        
        /*view.addSubview(searchController.searchBar)
        
        searchController.searchBar.sizeToFit()*/
        
        definesPresentationContext = true
        
        searchController.searchBar.text = episodioSeleccionado
        
        filterContentForSearchText(episodioSeleccionado)
        
        self.downloadData()
        
        if (searchController.searchBar.text != "") {
            
            updateSearchResults(for: searchController)
            
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        if (searchController.searchBar.text != "") {
            
            updateSearchResults(for: searchController)
            
        }
        
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        filterContentForSearchText(searchBar.text!)
        
    }

    func downloadData() {
        
        let urlString = "https://rickandmortyapi.com/api/character"
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                
                print(error!.localizedDescription)
                
            }
            
            if let response = response as? HTTPURLResponse {
                
                print(response)
                
            }
            
            guard let data = data else { return }
            
            do {
                
                let personajes = try? JSONDecoder().decode(PersonajeModelResponse.self, from: data)
                
                if personajes != nil {
                    
                    self.arrayPersonajes = personajes!.results
                    
                    DispatchQueue.main.async {
                        
                        self.collectionView.reloadData()
                        
                    }
                    
                } else {
                    
                    print("Se ha producido un error en los datos")
                    
                }
                
            }
            
        }.resume()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let screenWidth = collectionView.frame.width
        
        var celdaWidth = 0
        
        if screenWidth > 700 {
            
            celdaWidth = Int(screenWidth/5 - 12)
            
        } else {
            
            celdaWidth = Int(screenWidth/2 - 8)
            
        }
        
        return CGSize(width: celdaWidth, height: celdaWidth)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if isFiltering {
            
            return filteredPersonajes.count
            
        } else {
            
            return arrayPersonajes.count
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "celda", for: indexPath) as! MiCelda
        
        if isFiltering {
            
            cell.miNombre.text = String(filteredPersonajes[indexPath.item].name)
            
            cell.miEspecie.text = String(filteredPersonajes[indexPath.item].species)
            
            let imageUrl = URL(string: filteredPersonajes[indexPath.item].image)
            
            let dataTask = URLSession.shared.dataTask(with: imageUrl!) { (data, _, _) in
            
                if let data = data {
                    
                    DispatchQueue.main.async {
                        
                        cell.miImagen.image = UIImage(data: data)
                        
                    }
                    
                }
                
            }
            
            dataTask.resume()
            
        } else {
            
            cell.miNombre.text = String(arrayPersonajes[indexPath.item].name)
            
            cell.miEspecie.text = String(arrayPersonajes[indexPath.item].species)
            
            let imageUrl = URL(string: arrayPersonajes[indexPath.item].image)
            
            let dataTask = URLSession.shared.dataTask(with: imageUrl!) { (data, _, _) in
                
                if let data = data {
                    
                    DispatchQueue.main.async {
                        
                        cell.miImagen.image = UIImage(data: data)
                        
                    }
                    
                }
                
            }
            
            dataTask.resume()
            
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //indexpath = indexPath.item
        
        //performSegue(withIdentifier: "Detalles", sender: nil)
        
        /*if presentedViewController != nil {
            
            return
            
        }*/
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "DetallesViewController") as! DetallesViewController
        
        //print("\(arrayPersonajes[indexPath.item].name)")
        
        vc.nombre = arrayPersonajes[indexPath.item].name
        
        vc.imagen = arrayPersonajes[indexPath.item].image
        
        vc.especie = arrayPersonajes[indexPath.item].species
        
        vc.estado = arrayPersonajes[indexPath.item].status
        
        vc.genero = arrayPersonajes[indexPath.item].gender
        
        vc.origen = arrayPersonajes[indexPath.item].origin.name
        
        vc.localizacion = arrayPersonajes[indexPath.item].location.name
        
        vc.episodios = arrayPersonajes[indexPath.item].episode
        
        present(vc, animated: true, completion: nil)
        
    }
    
    func filterContentForSearchText(_ searchText: String) {
        
        filteredPersonajes.removeAll()
        
        filteredPersonajes = arrayPersonajes.filter { (personaje: PersonajeModel) -> Bool in
        
            /*for episodioSeleccionado in personaje.episode {
                
                if episodioSeleccionado.contains(searchText) {
                    
                    return true
                    
                }
                
            }
            
            return false*/
            
            if personaje.episode.contains(self.searchController.searchBar.text!) {
                
                return true
                
            } else {
                
                return false
                
            }
            
        }
        
        collectionView.reloadData()
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "Detalles") {
            
            let vc = segue.destination as! DetallesViewController
            
            //vc.delegate = self
            
            vc.nombre = arrayPersonajes[indexpath].name
            
            vc.imagen = arrayPersonajes[indexpath].image
            
            vc.especie = arrayPersonajes[indexpath].species
            
            vc.estado = arrayPersonajes[indexpath].status
            
            vc.genero = arrayPersonajes[indexpath].gender
            
            vc.origen = arrayPersonajes[indexpath].origin.name
            
            vc.localizacion = arrayPersonajes[indexpath].location.name
            
            //vc.episodios
            
        }
        
    }*/
    
    /*func empty() {
        
        //indexpath = 0
        
    }*/
    
    /*func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        indexpath = 0
        
    }*/

}

/*extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchBar = searchController.searchBar
        
        filterContentForSearchText(searchBar.text!)
        
    }
    
}
*/

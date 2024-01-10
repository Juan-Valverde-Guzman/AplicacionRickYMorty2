//
//  DetallesViewController.swift
//  CollectionViewRickYMorty
//
//  Created by dam2 on 18/12/23.
//

import UIKit

/*protocol DatosVaciar {
    
    func empty()
    
}*/

class DetallesViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    var nombre: String = ""
    
    var imagen: String = ""
    
    var especie: String = ""
    
    var estado: String = ""
    
    var genero: String = ""
    
    var origen: String = ""
    
    var localizacion: String = ""
    
    var episodios: [String] = [String]()
    
    //var favoritos: [String] = [String]()
    
    //var delegate: DatosVaciar?

    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var species: UILabel!
    
    @IBOutlet weak var status: UILabel!
    
    @IBOutlet weak var gender: UILabel!
    
    @IBOutlet weak var origin: UILabel!
    
    @IBOutlet weak var localization: UILabel!
    
    @IBOutlet weak var Tabla: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tabla.delegate = self
        
        Tabla.dataSource = self

        name.text = nombre
        
        //image.image =
        
        species.text = especie
        
        status.text = estado
        
        gender.text = genero
        
        origin.text = origen
        
        localization.text = localizacion
        
        if let imageUrl = URL(string: imagen) {
            
            let dataTask = URLSession.shared.dataTask(with: imageUrl) { (data, _, _) in
            
                if let data = data {
                    
                    DispatchQueue.main.async {
                        
                        self.image.image = UIImage(data: data)
                        
                    }
                    
                }
                
            }
            
            dataTask.resume()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return episodios.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let celda = tableView.dequeueReusableCell(withIdentifier: "celda_episodios", for: indexPath) as! MiCeldaEpisodios
        
        celda.labelEpisodios.text = episodios[indexPath.row]
        
        return celda
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        50
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        
        vc.episodioSeleccionado = episodios[indexPath.row]
        
        present(vc, animated: true, completion: nil)
        
    }
    
    @available(iOS 11.0, *)
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let favoritosAction = UIContextualAction(style: .normal, title: "Favoritos") { [weak self] (action,view,
        completionHandler) in
            
            self?.manejarFavoritos(indexPath.row)
            
            print("Pulsado favoritos")
            
            completionHandler(true)
            
        }
        
        favoritosAction.backgroundColor = .blue
        
        favoritosAction.image = UIImage(systemName: "star")
        
        let deleteAction = UIContextualAction(style: .destructive, title: "Eliminar") { [weak self] (action, view,
                                                                                                     completionHandler) in
        print("Pulsado eliminar")
            
        }
        
        deleteAction.backgroundColor = .red
        
        return UISwipeActionsConfiguration(actions: [favoritosAction, deleteAction])
        
    }
    
    func manejarFavoritos(_ indexPath: Int) {
        
        print(episodios[indexPath])
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        true
        
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        
        if indexPath.row == 0 {
            
            return .none
            
        } else if indexPath.row == 1 {
            
            return .insert
            
        } else {
            
            return .delete
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            episodios.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
            
        } else if editingStyle == .insert {
            
            
            
        }
        
    }
    
    /*override func viewWillDisappear(_ animated: Bool) {
        
        nombre = ""
        
        imagen = ""
        
        especie = ""
        
        estado = ""
        
        genero = ""
        
        origen = ""
        
        localizacion = ""
        
        name.text = nombre
        
        image.image = nil
        
        species.text = especie
        
        status.text = estado
        
        gender.text = genero
        
        origin.text = origen
        
        localization.text = localizacion
        
        //delegate?.empty()
        
    }*/

}

//extension ViewController

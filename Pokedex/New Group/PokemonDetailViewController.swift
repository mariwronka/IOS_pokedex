
import UIKit

class PokemonDetailViewController: UIViewController {

    @IBOutlet weak var gradientView: GradientView!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var pokemonImageViewWidthContraint: NSLayoutConstraint!
    
    @IBOutlet weak var pokemonImageViewHeigthContraint: NSLayoutConstraint!
    
    @IBOutlet weak var pokemonImageViewVerticallyContraint: NSLayoutConstraint!
    
    @IBOutlet weak var pokemonImageViewConstraintTop: NSLayoutConstraint!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var pokemonTypeView: PokemonTypeView!
    
    @IBOutlet weak var backgroudView: DesignableView!
    
    @IBOutlet var labelArray: [UILabel]!
    
    @IBOutlet var progressArray: [UIProgressView]!
    
    @IBOutlet weak var descriptionViewLabel: UILabel!
    
    @IBAction func backAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var pokemon : Pokemon?
    
    let requestMaker = RequestMaker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initialConfig()
        
        if let type = pokemon?.types.first {
            self.pokemonTypeView.config(type: type)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loadPokemonAnimation()
        self.requestPokemon()
    }
    
    func requestPokemon(){
        if let pokemon = self.pokemon {
            requestMaker.make(withEndpoint: .details(query: pokemon.id)) {
                (pokemon: Pokemon) in
                self.animateImagePokemonToTop()
                
            }
        }
    }
    
    func animateImagePokemonToTop() {
        DispatchQueue.main.async {
            self.imageView.layer.removeAllAnimations()
            self.pokemonImageViewVerticallyContraint.priority = UILayoutPriority(rawValue: 900)
            self.pokemonImageViewConstraintTop.priority = UILayoutPriority(rawValue: 999)
            self.pokemonImageViewHeigthContraint.constant = 80
            self.pokemonImageViewWidthContraint.constant = 80
            
            UIView.animate(withDuration: 1, animations: {
                self.backgroudView.alpha = 1
                self.imageView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func loadPokemonAnimation() {
        
        UIView.animate(withDuration: 1, delay: 0,
                       options: [.repeat, .autoreverse],
                       animations: {
            self.imageView.alpha = 0.2
        })
    }
    
    func initialConfig() {
        
        if let pokemon = pokemon {
            let color = pokemon.types.first?.color ?? .lightGray
            
            self.gradientView.startColor = color
            self.gradientView.endColor = color.lighter() ?? .white
            self.imageView.loadImage(from: pokemon.image)
            self.nameLabel.text = pokemon.name
            self.configProgress(color: color, statusArray: pokemon.status)
        }
        
    }
    
    func configProgress(color: UIColor, statusArray: [Status]?) {
        labelArray.forEach { label in label.textColor = color}
        progressArray.forEach { label in label.configProgress(color: color) }
    }
    
}

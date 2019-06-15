
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
    
    @IBOutlet weak var progressLabelHP: UILabel!
    @IBOutlet weak var progressLabelSPD: UILabel!
    @IBOutlet weak var progressLabelSTACK: UILabel!
    @IBOutlet weak var progressLabelATK: UILabel!
    @IBOutlet weak var progressLabelDEF: UILabel!
    @IBOutlet weak var progressLabelSDEF: UILabel!
    
    @IBOutlet weak var progressHP: UIProgressView!
    @IBOutlet weak var progressSPD: UIProgressView!
    @IBOutlet weak var progressSTACK: UIProgressView!
    @IBOutlet weak var progressATK: UIProgressView!
    @IBOutlet weak var progressDEF: UIProgressView!
    @IBOutlet weak var progressSDEF: UIProgressView!
    
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
                print(pokemon)
                self.pokemon = pokemon
                self.animateImagePokemonToTop()
            }
        }
    }
    
    func animateImagePokemonToTop() {
        DispatchQueue.main.async {

            self.imageView.layer.removeAllAnimations()
            self.pokemonImageViewVerticallyContraint.priority = UILayoutPriority(rawValue: 900)
            self.pokemonImageViewConstraintTop.priority = UILayoutPriority(rawValue: 999)
            self.pokemonImageViewHeigthContraint.constant = 100
            self.pokemonImageViewWidthContraint.constant = 100
            self.configProgress(statsArray: self.pokemon?.stats)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.backgroudView.alpha = 1
                self.imageView.alpha = 1
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func loadPokemonAnimation() {
        
        UIView.animate(withDuration: 0.5, delay: 0,
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
            self.descriptionViewLabel.text = pokemon.description
            labelArray.forEach { label in label.textColor = color}
            progressArray.forEach { label in label.configProgress(color: color) }
        }
        
    }
    
    func configProgress(statsArray: [Stats]?) {
        
        if let stats = self.pokemon?.stats {
            stats.forEach { (stat) in
                let name: String = stat.name.uppercased()
                let value: Float = Float(stat.value)
                
                switch name {
                case "SPEED":
                    progressLabelSPD.text = String(format: "%03d", value)
                    progressSPD.progress = Float(value/100)
                case "SPECIAL-DEFENSE":
                    progressLabelSDEF.text = String(format: "%03d", value)
                    progressSDEF.progress = Float(value/100)
                case "SPECIAL-ATTACK":
                    progressLabelSTACK.text = String(format: "%03d", value)
                    progressSTACK.progress = Float(value/100)
                case "DEFENSE":
                    progressLabelDEF.text = String(format: "%03d", value)
                    progressDEF.progress = Float(value/100)
                case "ATTACK":
                    progressLabelATK.text = String(format: "%03d", value)
                    progressATK.progress = Float(value/100)
                case "HP":
                    progressLabelHP.text = String(format: "%03d", value)
                    progressHP.progress = Float(value/100)
                default:
                    return
                }
            }
        }
    }
    
}

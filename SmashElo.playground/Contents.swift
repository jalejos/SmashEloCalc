//: Playground - noun: a place where people can play

import UIKit

let starterRating = 1600.0

class SmashPlayer {
    enum MatchResult: String {
        case win
        case lose
        case draw
    }
    
    var name = ""
    var rating: Double = 0
    var kRating: Int = 0 // this is how much a match affects results; newer players will  have bigger leaps through winning than somebody with multiple entries
    var entries: Int = 0
    
    init(nameDisplay: String) {
        name = nameDisplay
        self.rating = starterRating
        entries = 0
        calckRating()
    }

    public func enterAnotherTournament() {
        entries += 1
        calckRating()
    }
    
    public func match(with otherPlayer: SmashPlayer, result: MatchResult) {
        let expectationSelfWin = getExpectation(player1: self, player2: otherPlayer)
        let expectationOtherWin = getExpectation(player1: otherPlayer, player2: self)
        switch result {
            case .win:
                self.modifyRating(expectation: expectationSelfWin, actual: 1.0)// win score
                otherPlayer.modifyRating(expectation: expectationOtherWin, actual: 0.0)//lose score
                break
            case .lose:
                self.modifyRating(expectation: expectationSelfWin, actual: 0.0)
                otherPlayer.modifyRating(expectation: expectationOtherWin, actual: 1.0)
                break
            case .draw:
                self.modifyRating(expectation: expectationSelfWin, actual: 0.5)// tie score
                otherPlayer.modifyRating(expectation: expectationOtherWin, actual: 0.5)
                break
        }
    }
    
    func modifyRating(expectation: Double, actual: Double) {
        //Cambiamos el rating de acuerdo a su krating (que tanto debe cambiar) y su resultado
        let calc = (self.rating + Double(self.kRating) * (actual - expectation))
        self.rating = calc
    }
    
    
    //Might want to revisit krating formula, for now it's just a range
    func calckRating() {
        if entries < 3 {
            kRating = 300 - entries
        } else if entries < 6 {
            kRating = 250 - entries
        } else if entries < 10 {
            kRating = 200
        }
    }
    
    func getExpectation(player1: SmashPlayer, player2: SmashPlayer) -> Double {
        //calculos confiando en http://stephenwan.net/thoughts/2012/10/02/elo-rating-system.html , parece confiable asi que FUCK IT MAGIC HAPPENS
        let calc = (1.0 / (1.0 + pow(10, ((player2.rating - player1.rating) / 1600))))
        return calc
    }
}

pow(2.0,3.0)


/* 
 * El formato es primero se enlistan los participantes en orden de resultados finales, si el jugador ya existe se marca .enterAnotherTournament
 * de otra manera, se crea un nuevo SmashPlayer con el rating default
 *
 * Las partidas se van registrando por orden de rondas de acuerdo al standard y top 4 se anota todo junto
 *
 * Los brackets estan en smashcuu#, donde # es el numero del torneo, mas adelante se mete el rookies y es un caos, pero ahi estan
 *
 */


// Primer torneo, woooo! *confeti* (/smash sin el 1)
let Eliard  = SmashPlayer(nameDisplay: "Eliard")
let Frank   = SmashPlayer(nameDisplay: "Frank")
let Rene    = SmashPlayer(nameDisplay: "Rene")
let Gus     = SmashPlayer(nameDisplay: "Gus")
let Iram    = SmashPlayer(nameDisplay: "Iram")
let Edy     = SmashPlayer(nameDisplay: "Edy")
let Ra9nar  = SmashPlayer(nameDisplay: "Ra9nar")
let Lexas   = SmashPlayer(nameDisplay: "Lexas")
let CesarT  = SmashPlayer(nameDisplay: "CesarT")

Edy     .match(with: Lexas,     result: .win)
Edy     .match(with: Frank,     result: .win)
Eliard  .match(with: Ra9nar,    result: .win)
Rene    .match(with: Gus,       result: .win)
Iram    .match(with: CesarT,    result: .win)

Lexas   .match(with: CesarT,    result: .win)
Gus     .match(with: Lexas,     result: .win)
Ra9nar  .match(with: Frank,     result: .lose)
Eliard  .match(with: Edy,       result: .win)
Rene    .match(with: Iram,      result: .win)

Edy     .match(with: Gus,       result: .lose)
Iram    .match(with: Frank,     result: .lose)

Eliard  .match(with: Rene,      result: .win)
Frank   .match(with: Gus,       result: .win)
Frank   .match(with: Rene,      result: .win)
Eliard  .match(with: Frank,     result: .win)

// Segundo torneo
Eliard  .enterAnotherTournament()
Edy     .enterAnotherTournament()
Iram    .enterAnotherTournament()
Lexas   .enterAnotherTournament()
Ra9nar  .enterAnotherTournament()
CesarT  .enterAnotherTournament()

Ra9nar  .match(with: CesarT,    result: .win)
Lexas   .match(with: Iram,      result: .lose)

Edy     .match(with: Ra9nar,    result: .lose)
Eliard  .match(with: Iram,      result: .win)
Iram    .match(with: CesarT,    result: .win)
Ra9nar  .match(with: Lexas,     result: .lose)

Edy     .match(with: Eliard,    result: .lose)
Iram    .match(with: Lexas,     result: .win)
Edy     .match(with: Iram,      result: .win)
Eliard  .match(with: Edy,       result: .win)

// Tercer torneo
Eliard          .enterAnotherTournament()
let Gera        = SmashPlayer(nameDisplay: "Gera")
let Leo         = SmashPlayer(nameDisplay: "Leo")
Iram            .enterAnotherTournament()
let ElJorge     = SmashPlayer(nameDisplay: "ElJorge")
Ra9nar          .enterAnotherTournament()
Frank           .enterAnotherTournament()
let BK201       = SmashPlayer(nameDisplay: "BK201")
let CarlosNator = SmashPlayer(nameDisplay: "CarlosNator") //WTF quien es este?
CesarT          .enterAnotherTournament()

Iram        .match(with: CesarT,    result: .win)
CarlosNator .match(with: Leo,       result: .lose)
Frank       .match(with: Iram,      result: .lose)
Gera        .match(with: Ra9nar,    result: .win)
Leo         .match(with: ElJorge,   result: .win)
BK201       .match(with: Eliard,    result: .lose)

BK201       .match(with: CesarT,    result: .win)
Ra9nar      .match(with: CarlosNator,result: .win)
Iram        .match(with: Gera,      result: .lose)
Leo         .match(with: Eliard,    result: .lose)
ElJorge     .match(with: BK201,     result: .win)
Frank       .match(with: Ra9nar,    result: .lose)

Gera        .match(with: Eliard,    result: .lose)
Iram        .match(with: Leo,       result: .lose)
Gera        .match(with: Leo,       result: .win)
Eliard      .match(with: Gera,      result: .win)


// Cuarto torneo
Eliard      .enterAnotherTournament()
let Machete = SmashPlayer(nameDisplay: "Machete")
Gera        .enterAnotherTournament()
Leo         .enterAnotherTournament()
Ra9nar      .enterAnotherTournament()
let Ale     = SmashPlayer(nameDisplay: "Ale")
Gus         .enterAnotherTournament()
CesarT      .enterAnotherTournament()
let Erick   = SmashPlayer(nameDisplay: "Erick")

Eliard  .match(with: Erick,     result: .win)
Gus     .match(with: Eliard,    result: .lose)
Leo     .match(with: Machete,   result: .win)
Ale     .match(with: CesarT,    result: .win)
Gera    .match(with: Ra9nar,    result: .win)


Eliard  .match(with: Leo,       result: .win)
Ale     .match(with: Gera,      result: .win)
Ra9nar  .match(with: Erick,     result: .win)
CesarT  .match(with: Ra9nar,    result: .lose)
Machete .match(with: Gus,       result: .win)


Leo     .match(with: Ra9nar,    result: .win)
Ale     .match(with: Machete,   result: .lose)


Eliard  .match(with: Gera,      result: .win)
Leo     .match(with: Machete,   result: .lose)
Gera    .match(with: Machete,   result: .lose)
Eliard  .match(with: Machete,   result: .win)


// Quinto torneo
Eliard      .enterAnotherTournament()
Gera        .enterAnotherTournament()
ElJorge     .enterAnotherTournament()
Ra9nar      .enterAnotherTournament()
let Fer     = SmashPlayer(nameDisplay: "Fer")
let DJTetor = SmashPlayer(nameDisplay: "DJTetor")


Fer     .match(with: ElJorge,   result: .lose)
Ra9nar  .match(with: DJTetor,   result: .win)
Gera    .match(with: ElJorge,   result: .lose)
Eliard  .match(with: Ra9nar,    result: .win)

Ra9nar  .match(with: Fer,       result: .win)
Gera    .match(with: DJTetor,   result: .win)

Eliard  .match(with: ElJorge,   result: .win)
Ra9nar  .match(with: Gera,      result: .lose)
Gera    .match(with: ElJorge,   result: .win)
Eliard  .match(with: Gera,      result: .win)


// Sexto torneo
Eliard      .enterAnotherTournament()
Machete     .enterAnotherTournament()
Leo         .enterAnotherTournament()
Ra9nar      .enterAnotherTournament()
Iram        .enterAnotherTournament()
let Dan     = SmashPlayer(nameDisplay: "Dan")
Ale         .enterAnotherTournament()
let Javi    = SmashPlayer(nameDisplay: "Javi")
Fer         .enterAnotherTournament()
DJTetor     .enterAnotherTournament()

Dan     .match(with: Javi,      result: .win)
Eliard  .match(with: DJTetor,   result: .win)
Ale     .match(with: Dan,       result: .lose)
Machete .match(with: Iram,      result: .win)
Leo     .match(with: Eliard,    result: .lose)
Fer     .match(with: Ra9nar,    result: .win)

Fer     .match(with: Javi,      result: .lose)
Iram    .match(with: DJTetor,   result: .win)
Dan     .match(with: Machete,   result: .lose)
Eliard  .match(with: Ra9nar,    result: .win)
Leo     .match(with: Javi,      result: .win)
Ale     .match(with: Iram,      result: .lose)

Dan     .match(with: Leo,       result: .lose)
Ra9nar  .match(with: Iram,      result: .win)

Eliard  .match(with: Machete,   result: .win)
Leo     .match(with: Ra9nar,    result: .win)
Machete .match(with: Leo,       result: .win)
Eliard  .match(with: Machete,   result: .win)


// Septimo torneo
Eliard      .enterAnotherTournament()
ElJorge     .enterAnotherTournament()
let Tomas   = SmashPlayer(nameDisplay: "Tomas")
Fer         .enterAnotherTournament()
Iram        .enterAnotherTournament()
Leo         .enterAnotherTournament()
Javi        .enterAnotherTournament()
Dan         .enterAnotherTournament()
let Islas   = SmashPlayer(nameDisplay: "Islas")
let Kapek   = SmashPlayer(nameDisplay: "Kapek")
let Marcos  = SmashPlayer(nameDisplay: "Marcos")
let ElNinio = SmashPlayer(nameDisplay: "ElNinio")
CesarT      .enterAnotherTournament()

ElJorge .match(with: Javi,      result: .win)
CesarT  .match(with: ElNinio,   result: .lose)
Eliard  .match(with: Leo,       result: .win)
Marcos  .match(with: Dan,       result: .win)
Kapek   .match(with: Tomas,     result: .lose)

Iram    .match(with: ElJorge,   result: .lose)
ElNinio .match(with: Eliard,    result: .lose)
Fer     .match(with: Marcos,    result: .win)
Islas   .match(with: Tomas,     result: .lose)
CesarT  .match(with: Leo,       result: .lose)

Islas   .match(with: Javi,      result: .lose)
Marcos  .match(with: Leo,       result: .lose)
ElNinio .match(with: Dan,       result: .lose)
Iram    .match(with: Kapek,     result: .win)

ElJorge .match(with: Eliard,    result: .lose)
Fer     .match(with: Tomas,     result: .lose)
Javi    .match(with: Leo,       result: .lose)
Dan     .match(with: Iram,      result: .lose)

ElJorge .match(with: Leo,       result: .win)
Fer     .match(with: Iram,      result: .win)

Eliard  .match(with: Tomas,     result: .win)
ElJorge .match(with: Fer,       result: .win)
Tomas   .match(with: ElJorge,   result: .lose)
Eliard  .match(with: ElJorge,   result: .lose)   //PRIMER SET PERDIDO POR ALEJOS. AAAAAAAAAAAAH!
ElJorge .match(with: Eliard,    result: .lose)


//  Octavo torneo  - Primer torneo con rookies, 17 participantes
Eliard      .enterAnotherTournament()
ElJorge     .enterAnotherTournament()
Gus         .enterAnotherTournament()
Leo         .enterAnotherTournament()
Ra9nar      .enterAnotherTournament()
Edy         .enterAnotherTournament()
Kapek       .enterAnotherTournament()
Rene        .enterAnotherTournament()
Iram        .enterAnotherTournament()
Dan         .enterAnotherTournament()
ElNinio     .enterAnotherTournament()
DJTetor     .enterAnotherTournament()
Marcos      .enterAnotherTournament()
Islas       .enterAnotherTournament()
Javi        .enterAnotherTournament()
let Diego   = SmashPlayer(nameDisplay: "Diego")
CesarT      .enterAnotherTournament()

Dan     .match(with: Ra9nar,    result: .lose)
Ra9nar  .match(with: Javi,      result: .win)
Leo     .match(with: Ra9nar,    result: .win)
Leo     .match(with: Javi,      result: .win)
Dan     .match(with: Leo,       result: .lose)
Javi    .match(with: Dan,       result: .win)

Eliard  .match(with: Diego,     result: .win)
Kapek   .match(with: Iram,      result: .win)
Kapek   .match(with: Eliard,    result: .lose)
Diego   .match(with: Kapek,     result: .lose)
Eliard  .match(with: Iram,      result: .win)
Iram    .match(with: Diego,     result: .lose)

ElJorge .match(with: Rene,      result: .win)
Rene    .match(with: Marcos,    result: .win)
Marcos  .match(with: DJTetor,   result: .lose)
CesarT  .match(with: Marcos,    result: .lose)
Marcos  .match(with: ElJorge,   result: .lose)
CesarT  .match(with: DJTetor,   result: .lose)
CesarT  .match(with: ElJorge,   result: .lose)
Rene    .match(with: CesarT,    result: .lose)
ElJorge .match(with: DJTetor,   result: .win)
DJTetor .match(with: Rene,      result: .lose)

Islas   .match(with: Edy,       result: .lose)
Edy     .match(with: Gus,       result: .win)
Gus     .match(with: ElNinio,   result: .win)
Gus     .match(with: Islas,     result: .win)
Islas   .match(with: ElNinio,   result: .lose)
ElNinio .match(with: Edy,       result: .lose)

Leo     .match(with: Kapek,     result: .win)
ElJorge .match(with: Gus,       result: .win)
Ra9nar  .match(with: Eliard,    result: .lose)
Rene    .match(with: Edy,       result: .lose)

Leo     .match(with: ElJorge,   result: .lose)
Eliard  .match(with: Edy,       result: .win)
Kapek   .match(with: Gus,       result: .lose)
Ra9nar  .match(with: Rene,      result: .win)

Edy     .match(with: Gus,       result: .lose)
Leo     .match(with: Ra9nar,    result: .win)

Eliard  .match(with: ElJorge,   result: .win)
Gus     .match(with: Leo,       result: .win)
ElJorge .match(with: Gus,       result: .win)
Eliard  .match(with: ElJorge,   result: .lose)  // Segunda derrota de alejos
ElJorge .match(with: Eliard,    result: .lose)

Islas   .match(with: CesarT,    result: .win)
Javi    .match(with: Islas,     result: .lose)
ElNinio .match(with: Dan,       result: .win)
Diego   .match(with: Marcos,    result: .lose)
DJTetor .match(with: Iram,      result: .win)

DJTetor .match(with: CesarT,    result: .win)
Islas   .match(with: ElNinio,   result: .lose)
Marcos  .match(with: Iram,      result: .lose)
Diego   .match(with: DJTetor,   result: .lose)
Dan     .match(with: Javi,      result: .win)

Islas   .match(with: DJTetor,   result: .lose)
Marcos  .match(with: Dan,       result: .lose)

ElNinio .match(with: Iram,      result: .lose)
DJTetor .match(with: Dan,       result: .lose)
ElNinio .match(with: Dan,       result: .lose)
Iram    .match(with: Dan,       result: .win)


//Noveno torneo no sera considerado debido a que fue el primer torneo random + hubo caos de innasistencias 
// Decimo torneo - Rookies3
Eliard      .enterAnotherTournament()
ElJorge     .enterAnotherTournament()
Gus         .enterAnotherTournament()
Iram        .enterAnotherTournament()
Leo         .enterAnotherTournament()
Frank       .enterAnotherTournament()
let Tonio   = SmashPlayer(nameDisplay: "Tonio")
let Noe     = SmashPlayer(nameDisplay: "Noe")
Ra9nar      .enterAnotherTournament()
let Fong    = SmashPlayer(nameDisplay: "Fong")
let Andrei  = SmashPlayer(nameDisplay: "Andrei")
Marcos      .enterAnotherTournament()
CesarT      .enterAnotherTournament()
Javi        .enterAnotherTournament()
Diego       .enterAnotherTournament()

Ra9nar  .match(with: Iram,      result: .draw)
Andrei  .match(with: Ra9nar,    result: .draw)
Ra9nar  .match(with: Eliard,    result: .lose)
Eliard  .match(with: Andrei,    result: .win)
Eliard  .match(with: Iram,      result: .win)
Andrei  .match(with: Iram,      result: .lose)

Tonio   .match(with: Marcos,    result: .win)
Frank   .match(with: Tonio,     result: .win)
Tonio   .match(with: Fong,      result: .win)
Fong    .match(with: Frank,     result: .lose)
Fong    .match(with: Marcos,    result: .win)
Frank   .match(with: Marcos,    result: .win)

Leo     .match(with: CesarT,    result: .draw)
Diego   .match(with: Leo,       result: .lose)
Leo     .match(with: Noe,       result: .win)
Noe     .match(with: Diego,     result: .win)
Noe     .match(with: CesarT,    result: .win)
Diego   .match(with: CesarT,    result: .lose)

Gus     .match(with: ElJorge,   result: .lose)
Javi    .match(with: ElJorge,   result: .lose)
Gus     .match(with: Javi,      result: .draw)

Eliard  .match(with: Tonio,     result: .win)
Leo     .match(with: Gus,       result: .win)
Iram    .match(with: Frank,     result: .lose)
Noe     .match(with: ElJorge,   result: .lose)

Eliard  .match(with: Leo,       result: .win)
Frank   .match(with: ElJorge,   result: .lose)
Tonio   .match(with: Gus,       result: .lose)
Iram    .match(with: Noe,       result: .win)

Frank   .match(with: Gus,       result: .lose)
Leo     .match(with: Iram,      result: .lose)

Eliard  .match(with: ElJorge,   result: .win)
Gus     .match(with: Iram,      result: .win)
ElJorge .match(with: Gus,       result: .win)
Eliard  .match(with: ElJorge,   result: .win)

Marcos  .match(with: Ra9nar,    result: .win)
Andrei  .match(with: Fong,      result: .lose)
Diego   .match(with: Javi,      result: .win)

CesarT  .match(with: Ra9nar,    result: .win)
Fong    .match(with: Javi,      result: .lose)
Andrei  .match(with: Diego,     result: .lose)
Javi    .match(with: Marcos,    result: .lose)
CesarT  .match(with: Andrei,    result: .win)

Ra9nar  .match(with: Fong,      result: .lose)
Marcos  .match(with: Andrei,    result: .lose)
Ra9nar  .match(with: Andrei,    result: .lose)
Fong    .match(with: Ra9nar,    result: .win)
Ra9nar  .match(with: Fong,      result: .win)

// Onceavo torneo - Rookies4 (incompleto)
ElJorge     .enterAnotherTournament()    //Primer torneo de ElJorge, woop
Eliard      .enterAnotherTournament()
var getRekt = SmashPlayer(nameDisplay: "getRekt")
Frank       .enterAnotherTournament()
Iram        .enterAnotherTournament()
Leo         .enterAnotherTournament()
Javi        .enterAnotherTournament()
Dan         .enterAnotherTournament()
//Reorganizar cuando suceda el final
Tonio       .enterAnotherTournament()
Andrei      .enterAnotherTournament()
Ra9nar      .enterAnotherTournament()
Noe         .enterAnotherTournament()
var Xavi    = SmashPlayer(nameDisplay: "Xavi")
Fong        .enterAnotherTournament()
CesarT      .enterAnotherTournament()

Tonio   .match(with: Xavi,      result: .win)
ElJorge .match(with: Tonio,     result: .win)
Dan     .match(with: Tonio,     result: .win)
Dan     .match(with: ElJorge,   result: .lose)
Xavi    .match(with: Dan,       result: .lose)
Xavi    .match(with: ElJorge,   result: .lose)

CesarT  .match(with: Eliard,    result: .lose)
Javi    .match(with: CesarT,    result: .win)
Fong    .match(with: CesarT,    result: .draw)
Fong    .match(with: Javi,      result: .lose)
Eliard  .match(with: Fong,      result: .win)
Eliard  .match(with: Javi,      result: .win)

Ra9nar  .match(with: Iram,      result: .draw)
Andrei  .match(with: Ra9nar,    result: .win)
getRekt .match(with: Ra9nar,    result: .win)
getRekt .match(with: Andrei,    result: .win)
Iram    .match(with: getRekt,   result: .lose)
Iram    .match(with: Andrei,    result: .win)

Frank   .match(with: Noe,       result: .win)
Leo     .match(with: Frank,     result: .win)
Noe     .match(with: Leo,       result: .lose)

ElJorge .match(with: Javi,      result: .win)
getRekt .match(with: Frank,     result: .win)
Dan     .match(with: Eliard,    result: .lose)
Iram    .match(with: Leo,       result: .win)

ElJorge .match(with: getRekt,   result: .win)
Eliard  .match(with: Iram,      result: .win)
Javi    .match(with: Frank,     result: .lose)
Iram    .match(with: Leo,       result: .lose)

Iram    .match(with: Frank,     result: .lose)
getRekt .match(with: Leo,       result: .win)

ElJorge .match(with: Eliard,    result: .win)
Frank   .match(with: getRekt,   result: .lose)
Eliard  .match(with: getRekt,   result: .win)
ElJorge .match(with: Eliard,    result: .lose)
Eliard  .match(with: ElJorge,   result: .lose)

//Group 4 people template
//Tonio.match(with: Xavi, result: .win)
//ElJorge.match(with: Tonio, result: .win)
//Dan.match(with: Tonio, result: .win)
//Dan.match(with: ElJorge, result: .win)
//Xavi.match(with: Dan, result: .win)
//Xavi.match(with: ElJorge, result: .win)
//
//Top 8 template
//Javier.match(with: Islas, result: .lose)
//ElNinio.match(with: Dan, result: .win)
//Diego.match(with: Marcos, result: .lose)
//DJTetor.match(with: Iram, result: .win)
//
//Islas.match(with: ElNinio, result: .lose)
//Marcos.match(with: Iram, result: .lose)
//Diego.match(with: DJTetor, result: .lose)
//Dan.match(with: Javi, result: .win)
//
//Islas.match(with: DJTetor, result: .lose)
//Marcos.match(with: Dan, result: .lose)
//
//ElNinio.match(with: Iram, result: .lose)
//DJTetor.match(with: Dan, result: .lose)
//ElNinio.match(with: Dan, result: .lose)
//Iram.match(with: Dan, result: .win)



//Current scores
var playersArray: [SmashPlayer] = [Eliard, Frank, Rene, Gus, Iram, Edy, Ra9nar, Lexas, CesarT, Gera, Leo, ElJorge, BK201, CarlosNator, Fer, DJTetor, Dan, Javi, Tomas, Islas, Kapek, Marcos, ElNinio, Diego, Tonio, Noe, Fong, Andrei]


playersArray = playersArray.sorted(by: { $0.rating > $1.rating })
for player in playersArray {
    let roundedRating = Double(round(1000*player.rating)/1000)
    print("\(player.name)'s score: \(roundedRating)")
}

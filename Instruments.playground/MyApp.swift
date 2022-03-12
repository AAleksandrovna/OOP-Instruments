import SwiftUI

class Piano:  Instrument  {
    let hasPedals: Bool
    
    static let whiteKeys = 52
    static let blackKeys = 36
    
    init(brand: String, hasPedals: Bool = false) {
           self.hasPedals = hasPedals
       super.init(brand: brand)
    }
    
    override func tune() -> String {
        return "Piano standard tuning for \(brand)."
    }
    /*override func play(_ music: Music) -> String {
    let preparedNotes = super.play(music)
         return "Piano playing \(preparedNotes)"
    }*/
    override func play(_ music: Music) -> String {
        return play(music, usingPedals: hasPedals)
    }
    
    func play(_ music: Music, usingPedals: Bool) -> String {
        let preparedNotes = super.play(music)
        if hasPedals && usingPedals {
            return "Play piano notes \(preparedNotes) with pedals."
        } else {
            return "Play piano notes \(preparedNotes) without pedals."
        }
    }
}

let piano = Piano(brand: "Yamaha", hasPedals: true)
var pianoTune = piano.tune()
let music = Music(notes: ["C", "G", "F"])
var superPianoPlay = piano.play(music, usingPedals: false)
var pianoPlay = piano.play(music)
var resultWhiteKeys = Piano.whiteKeys
var resultBlackKeys = Piano.blackKeys

class Guitar: Instrument  {
    let stringGauge: String
    
    init(brand: String, stringGauge: String = "medium") {
        self.stringGauge = stringGauge
        super.init(brand: brand)
    }
}

class AcousticGuitar: Guitar  {
    static let numberOfStrings = 6
    static let fretCount = 20

    override func tune() -> String {
        return "Tune \(brand) acoustic with E A D G B E"
    }

    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play folk tune on frets \(preparedNotes)."
    }
 }

let acousticGuitar = AcousticGuitar(brand: "Roland", stringGauge: "light")
var guitarTune = acousticGuitar.tune()
var guitarPlay = acousticGuitar.play(music)

class Amplifier  {
    private var _volume: Int
    private(set) var isOn: Bool

    init() {
        isOn = false
        _volume = 0
    }

    func plugIn() {
        isOn = true
    }
    func unplug() {
        isOn = false
    }

    var volume: Int {
        get {
            return isOn ? _volume : 0
        }
        set {
            _volume = min(max(newValue, 0), 10)
        }
    }
}

class ElectricGuitar: Guitar  {
    let amplifier: Amplifier
    
    init(brand: String, stringGauge: String = "light", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }
    
    override func tune() -> String {
        amplifier.plugIn()
        amplifier.volume = 5
        return "Tune \(brand) electric with E A D G B E"
    }
    override func play(_ music: Music) -> String {
        let preparedNotes = super.play(music)
        return "Play solo \(preparedNotes) at volume \(amplifier.volume)."
    }
}

class BassGuitar: Guitar  {
    let amplifier: Amplifier
   
    init(brand: String, stringGauge: String = "heavy", amplifier: Amplifier) {
        self.amplifier = amplifier
        super.init(brand: brand, stringGauge: stringGauge)
    }

    override func tune() -> String {
        amplifier.plugIn()
        return "Tune \(brand) bass with E A D G"
    }
    override func play(_ music: Music) -> String {
            let preparedNotes = super.play(music)
            return "Play bass line \(preparedNotes) at volume \(amplifier.volume)."
    }
}

let amplifier = Amplifier()
let electicGuitar = ElectricGuitar(brand: "Gibson", stringGauge: "medium", amplifier: amplifier)
let electricGuitarTune = electicGuitar.tune()
let bassGuitar = BassGuitar(brand: "Fender", stringGauge: "heavy", amplifier: amplifier)
let bassGuitarTune = bassGuitar.tune()
let bassGuitarAmplifierVolume = bassGuitar.amplifier.volume
let electricGuitarAmplifierVolume = electicGuitar.amplifier.volume
let bassGuitarAmplifierUnplug: () = bassGuitar.amplifier.unplug()
let bassGuitarAmplifierVolume2 = bassGuitar.amplifier.volume
let electricGuitarAmplifierVolume2 = electicGuitar.amplifier.volume
let bassGuitarAmplifierPlugIn: () = bassGuitar.amplifier.plugIn()
let bassGuitarAmplifierVolume3 = bassGuitar.amplifier.volume
let electricGuitarAmplifierVolume3 = electicGuitar.amplifier.volume

class Band  {
    let instruments: [Instrument]

    init(instruments: [Instrument]) {
        self.instruments = instruments
    }

    func perform(_ music: Music) {
        for instrument in instruments {
        instrument.perform(music)
        }
    }
}

let instruments = [piano, acousticGuitar,
                electicGuitar, bassGuitar]
let band = Band(instruments: instruments)
let bandPerform: () = band.perform(music)



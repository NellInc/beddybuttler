//
//  AudioFile.swift
//  Beddy Butler
//
//  Created by David Garces on 18/08/2015.
//  Copyright (c) 2015 Nell Watson Inc. All rights reserved.
//
import AVFoundation

class AudioPlayer {
    
    
    var audioPlayer: AVAudioPlayer?
    var soundFileURL: URL?
    let urls = Bundle.main.urls(forResourcesWithExtension: "mp3", subdirectory: nil)
    
    
    enum AudioFiles {
        case insistent, shy, zombie
        
        init (stringValue: String) {
            switch stringValue {
                case "Insistent":
                    self = .insistent
                case "Shy":
                    self = .shy
                case "Zombie":
                    self = .zombie
            default:
                    self = .shy
            }
        }
        
        func description() -> String {
            switch self  {
            case .insistent:
                return "Insistent"
            case .shy:
                return "Shy"
            case .zombie:
                return "Zombie"
            }
        }
        
        func progressiveDescription() -> AudioFiles {
            switch self {
            case .shy:
                return .insistent
            default:
                return .zombie
            }
        }
    }
    
    /// Plays the audio file for the given file name: AudioFiles.Shy, AudioFiles.Insistent or AudioFiles.Zombie
    func playFile(_ file: AudioFiles) {
        
        let filteredURLs = urls?.filter { $0.absoluteString.contains(file.description()) }
        
        // Select a random file from the list
        let randomIndex = Int(arc4random_uniform(UInt32(filteredURLs!.count)))

        // play the file
        do {
            try audioPlayer = AVAudioPlayer(contentsOf: filteredURLs![randomIndex])
            audioPlayer?.play()
        } catch {
            NSLog("File could not be played")
        }
        
    }
    

    
}

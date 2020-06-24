//
//  ViewModels.swift
//  LayoutDemo
//
//  Created by localadmin on 24.06.20.
//  Copyright © 2020 Mark Lucking. All rights reserved.
//

import Combine
import Foundation

class ViewModels {
    
    static let mainViewModel = MainViewModel()
    static let soundSelectionViewModel = SoundSelectionViewModel()
    static let soundPlayingViewModel = SoundPlayingViewModel()
    static let nightNannyViewModel = NightNannyViewModel()
    
}

class NightNannyViewModel : ObservableObject {
}

class SoundSelectionViewModel : ObservableObject {
}

class SoundPlayingViewModel : ObservableObject {
}

class MainViewModel : ObservableObject {

private let audioService = Services.audioService
private var stateUpdatingSubscriber: AnyCancellable?
    

  enum MainViewModelState {
      case soundSelection
      case soundPlaying
      case nightNanny
  }

}

class Services {
    
    static let audioService = AudioService()
    
}

class AudioService {

    @Published var playbackState: AudioState = .idle
    
    enum AudioState {
    case idle
    
    // Manual Playback Mode
    case playingHeartBeat
    case playingRain
    case playingWashingMachine
    case playingWind
    
    // Night Nanny Mode
    case nightNannyListening
    case nightNannyHearingNoise
    case nightNannyPlayingHeartBeat
    case nightNannyPlayingRain
    case nightNannyPlayingWashingMachine
    case nightNannyPlayingWind
}
}

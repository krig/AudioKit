//: ## Tracking Frequency of an Audio File
//: A more real-world example of tracking the pitch of an audio stream
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: "leadloop.wav")

var player = try AKAudioPlayer(file: file)
player.looping = true

let tracker = AKFrequencyTracker(player)

AudioKit.output = tracker
AudioKit.start()
player.play()

//: User Interface
import AudioKitUI

class PlaygroundView: AKPlaygroundView {

    var trackedAmplitudeSlider: AKSlider?
    var trackedFrequencySlider: AKSlider?

    override func setup() {

        AKPlaygroundLoop(every: 0.1) {
            self.trackedAmplitudeSlider?.value = tracker.amplitude
            self.trackedFrequencySlider?.value = tracker.frequency
        }

        addTitle("Tracking An Audio File")

        trackedAmplitudeSlider = AKSlider(property: "Tracked Amplitude", range: 0 ... 0.55) { _ in
            // Do nothing, just for display
        }
        addSubview(trackedAmplitudeSlider)

        trackedFrequencySlider = AKSlider(property: "Tracked Frequency",
                                          range: 0 ... 1_000,
                                          format: "%0.3f Hz"
        ) { _ in
            // Do nothing, just for display
        }
        addSubview(trackedFrequencySlider)

        addSubview(AKRollingOutputPlot.createView())
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()

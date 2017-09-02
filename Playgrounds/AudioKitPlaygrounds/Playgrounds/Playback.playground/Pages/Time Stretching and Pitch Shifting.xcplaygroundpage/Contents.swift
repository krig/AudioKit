//: ## Time Stretching and Pitch Shifting
//: With AKTimePitch you can easily change the pitch and speed of a
//: player-generated sound.  It does not work on live input or generated signals.
//:
import AudioKitPlaygrounds
import AudioKit

let file = try AKAudioFile(readFileName: playgroundAudioFiles[0])

let player = try AKAudioPlayer(file: file)
player.looping = true

var timePitch = AKTimePitch(player)
timePitch.rate = 2.0
timePitch.pitch = -400.0
timePitch.overlap = 8.0

AudioKit.output = timePitch
AudioKit.start()
player.play()

//: User Interface Set up
import AudioKitUI

class PlaygroundView: AKPlaygroundView {

    override func setup() {
        addTitle("Time/Pitch")

        addSubview(AKResourcesAudioFileLoaderView(player: player, filenames: playgroundAudioFiles))

        addLabel("Time/Pitch Parameters")

        addSubview(AKBypassButton(node: timePitch))

        addSubview(AKSlider(property: "Rate", value: timePitch.rate, range: 0.312_5 ... 5) { sliderValue in
            timePitch.rate = sliderValue
        })

        addSubview(AKSlider(property: "Pitch",
                            value: timePitch.pitch,
                            range: -2_400 ... 2_400,
                            format: "%0.3f Cents"
        ) { sliderValue in
            timePitch.pitch = sliderValue
        })

        addSubview(AKSlider(property: "Overlap", value: timePitch.overlap, range: 3 ... 32) { sliderValue in
            timePitch.overlap = sliderValue
        })
    }
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true
PlaygroundPage.current.liveView = PlaygroundView()

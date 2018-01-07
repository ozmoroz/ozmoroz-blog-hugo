---
Title: MIDI routing in FL Studio via a MIDI loopback device
slug: midi-routing-in-fl-studio-via-midi
Date: 2014-11-01
categories: ["lifestyle"]
Tags: [music_production]
Author: Sergey Stadnik
Summary: How to record the output of one MIDI track (for example, arpeggiator’s output) into another MIDI track in FL Studio.
aliases:
  - /2014/11/midi-routing-in-fl-studio-via-midi.html
---

This tutorial explains how to record the output of one MIDI track (for example, arpeggiator’s output) into another MIDI track.

Although FL Studio allow internal MIDI routing, it is not possible to record MIDI information which is being internally routed from one MIDI track into another. I.e. you can have an arpeggiator in one MIDI track transmitting notes into another track, where a synth would play it, but you won’t be able to record the notes arppegiator transmits. Fortunately, there is a workaround that allows us to do just that.

For that you need to download and install Tobias Erichsen’s loopMIDI device.

Once installed, click on loopMIDI icon in the system tray to bring up its window. Click “+” to create a MIDI device.

![Loopmidi window](/images/2014-11-01_loopmidi.png)

Open FL Studio, go to Options → MIDI Setting

![FL Studio MIDI Settings](/images/2014-11-01_flstudio-settings.png)

Find the loopMIDI you created both in "Input" and "Output" sections. Set the loopMIDI Input MIDI port to 1, and Output to 2. (You may choose other port numbers, just make sure that output port is different from input).

Insert an instrument you want to transmit the MIDI data from into one instrument channel, and a receiving instrument into another channel. In my example I use BlueArp arppegiator into a track containing Synth1 synthesizer. BluArp itself requires a MIDI input, so I drew a simple 3-note pattern in the piano roll of its instrument channel.

![BlueARP track in channel list](/images/2014-11-01_flstudio_1.png)

Now we neet to set up the MIDI routing.

Open BlueArp and set its MIDI Output Port to 1 (the number we used for our Output loopMIDI port). Click on the "Gear" icon to open BlueArp's Fruity Wrapper and set Output Port also to 1.

![BLueARP channel settings](/images/2014-11-01_flstudio_2.png)

Now open the Synth 1's Fruity Wrapper and set its MIDI Input Port to 2 (the number we used for our Input loopMIDI port).

![Synth1 channel settings](/images/2014-11-01_flstudio_5.png)

That's all the setup you need to do.

Now press "Record" button and arm recording of Automation & Score.

![Recording dialogue](/images/2014-11-01_flstudio_3.png)

Press Play to kick of the recording, and you should see the output of the arpeggiator recording into the Synth1's piano roll.

![Recorded MIDI from BlueARP](/images/2014-11-01_flstudio_4.png)
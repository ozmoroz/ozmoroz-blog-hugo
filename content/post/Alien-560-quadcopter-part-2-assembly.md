---
Title: "Alien 560 Quadcopter Build - Part 2 - Assembly"
Series: ["Alien 560 Quadcopter Build"]
Date: 2016-09-25
Author: Sergey Stadnik
categories: ["lifestyle"]
Tags: [multirotors]
aliases:
  - /2016/09/alien-560-quadcopter-build-part-2-assembly.html
---

Unlike a conventional helicopter, a multirotor aircraft contains very few moving parts: no gears, no swash plates, no contrarotating propellers. It only has motors directly driving propellers, and that's it. So there was no complex mechanics to assemble. The frame was probably the most complicated bit. The Alien 560 frame consists of a couple of dozen carbon fibre plates which need to be screwed together by a hundred or so tiny screws.
<!-- more -->
The assembly instruction was not included in the kit, but it can be downloaded from [here](http://www.hobbyking.com/hobbyking/store/uploads/646621344X318849X41.pdf). In the end, it is not much complex than a large Meccano set. I found that placing a magnetic mat or tray under the frame during the assembly reduces the chances of losing those little screws. I also put a [medium-strength thread lock](http://www.loctiteproducts.com/p/t_lkr_blue/overview/Loctite-Threadlocker-Blue-242.htm) on the screws which are prone to loosening from vibration, such as motor mounts. I held off attaching the upper deck (the frame's lid) for now; that would wait till all the cables are in place.

The next step was to assemble the power system. The Pixhawk comes with a [power module](http://ardupilot.org/copter/docs/common-3dr-power-module.html) which sits between the battery and the rest of the electrical parts and provides power to the flight controller. A [power distribution harness](http://www.hobbyking.com/hobbyking/store/__67928__Multistar_XT60_to_4_x_3_5mm_with_JST_Plug_Quadcopter_Distribution_Harness.html) plugs into the other side of the power module and distributes the power to the 4 [ESCs](http://www.hobbyking.com/hobbyking/store/uh_viewItem.asp?idProduct=49812) *(electronic speed controllers)*. The Alien frame has compartments in the landing gear's "legs" for mounting ESCs - that position provides optimal cooling during flight. Because the power harness's wires were too short to reach the ESC bays, I had to make the extender leads out of [16AWG wires](http://www.hobbyking.com/hobbyking/store/__78197__Turnigy_High_Quality_16AWG_Silicone_Wire_1m_Red_.html) and [bullet connectors](http://www.hobbyking.com/hobbyking/store/__68__PolyMax_3_5mm_Gold_Connectors_10_PAIRS_20PC_.html). The ESCs then feed power to the [motors](http://www.hobbyking.com/hobbyking/store/__38455__Turnigy_Multistar_4220_880Kv_16Pole_Multi_Rotor_Outrunner.html) positioned at the ends of the foldable "arms" (more extension power leads were necessary here). I insulated all the electrical connection points with shrink-wraps to avoid short circuits. The power fed to each motor can reach 10A, so you definitely don't want that to happen.

![quadcopter frame with assembled electrics](/images/alien_560_1.jpg)

![quadcopter frame with assembled electrics](/images/alien_560_2.jpg)

That was it for the power circuits. The next step was to assemble the signal chains.

First, the receiver. I used an [FRSky X8R receiver](http://www.hobbyking.com/hobbyking/store/__41609__FrSky_XJT_2_4Ghz_Combo_Pack_for_JR_w_Telemetry_Module_X8R_8_16Ch_S_BUS_ACCST_Telemetry_Receiver.html). It is a good idea to pair your receiver to the transmitter before installing it. The included FRSky manual describes the steps to do that, and there are plenty of videos on Youtube showing the process.

FRSky X8R receiver has two *diversity* antennas, and it chooses the one with the strongest signal during the operation. FRSky recommends putting the antennas apart at 90 degrees angle to each other. I made an antenna mount out of a piece of plastic, drilled the hole in the frame and mounted the antennas so that they pointed downwards. Then mounted the receiver on the lower deck attached by a piece of a double-sided sticky tape.

![receiver mount on the bottom plate](/images/alien_560_3.jpg)

**I can't stress enough that an utmost care must be taken while working with carbon fibre. Carbon fibre dust is extremely harmful. Therefore any drilling or sanding carbon fibre must be carried out in a well-ventilated area, and a respirator with N95 safety rating must be worn.**{.text-danger}

There are multiple ways to plug a receiver into Pixhawk. The [serial SBus interface](http://www.futabarc.com/sbus/) both Pixhawk and FRSky support is the easiest option. It allows connecting the receiver to the flight controller via a single cable rather than one for each channel. [This page](http://hypomaniac.co.uk/passing-rssi-x8r-pixhawk/) describes how to make the connection.

The GPS receiver has to be mounted on the top of the aircraft away from any sources of interference such as battery and motors. And because [Neo-M8N GPS module](http://www.hobbyking.com/hobbyking/store/__76928__Ublox_Neo_M8N_GPS_with_Compass.html) I used also had a compass in it, it had to be oriented the right way forward. The best way to mount a GPS module on a quadcopter is to lift it above the deck on [a mast](http://www.banggood.com/Tarot-Plug-Type-M2_5-22mm-GPS-Mount-Fixture-Holder-Black-TL8X005-p-965752.html). But the Alien frame had an elevated GPS mount plate which I decided to use. By design, it would be sitting at the far back of the aircraft, like a scorpion's tail, but because my GPS cable was short, I moved it closer to the centre and rotated 180 degrees.

The next step was to connect the GPS and the telemetry. And that was where Pixhawk Lite played a joke on me. The wiring of all the Pixhawk modules is spelt out in the [Adrupilot Wiki](http://ardupilot.org/plane/docs/common-pixhawk-wiring-and-quick-start.html). If you buy all the electronic components such as GSP, telemetry, and OSD in a package then connecting them together should be as easy as plugging the appropriate wires. But Pixhawk Lite's designers [committed a few mistakes](http://www.rcgroups.com/forums/showthread.php?t=2418029) when laying out the controller's connectors. Therefore some of the signal leads had to be rewired. These are the bits which had to be changed (extracted from the [rcgroups forum's thread](http://www.rcgroups.com/forums/showthread.php?t=2418029) mentioned above and [Banggood comments](http://www.banggood.com/PX4-Pixhawk-Lite-V2_4_6-32Bits-Open-Source-Flight-Controller-for-QAV250-Multicopter-p-993849.html):

* **GPS Cable Changes Required:** The 5V and GND wires are reversed. The RX and TX lines of the GPS are connected to the telemetry lines etc. So they need to be directly moved by two pins towards the new 5V line.

* **Telemetry Cable Changes Required:** The 5V and GND wires are also reversed. The RX and TX also need to be swapped, but the lines stay in their current pins.

* Although the wiring of the power connector is compatible with the included power module, the standard Pixhawk's power module cannot be used because of the wiring changes.

After carefully rewiring the connectors I was finally able to plug the modules together.

I wanted to mount the telemetry transmitter with its antenna facing down for a better signal. But the problem was that telemetry antenna was huge compared to the rest of the components. Its size was dictated by the frequency is used, which was 915 Mhz - the frequency allowed in Australia.  That made the antenna as large as a one of a Wi-Fi router. I decided to place the telemetry receiver at the back on the upper deck with its antenna strapped to one of the rear landing gear. That would keep it secure and out of reach of the spinning propellers. The antenna's weight at the back will also counteract the weight of a camera in front should I decide to install one later.

![telemetry antenna mounted at the back of the quadcopter](/images/alien_560_4.jpg)

Pixhawk has an external reset button which I glued to the upper deck with a drop of hot glue.

The last thing to install was the flight controller itself. As [prescribed by the Pixhawk's designers](http://ardupilot.org/copter/docs/common-mounting-the-flight-controller.html), it should be mounted at the centre of an aircraft on an anti-vibration pad. High-frequency vibrations produced by spinning motors interfere with the Pixhawk's built-in gyroscopes jeopardising the flight stability. There are many different ways to dampen the vibration. A genuine 3DR Pixhawk, for example, comes with a few pieces of a 3M double-sided foam. Also, copter builders through experimentation [discovered a few more efficient ways](http://ardupilot.org/copter/docs/common-vibration-damping.html). I decided to go with an [anti-vibration mount](http://www.ebay.com.au/itm/Anti-vibration-Plate-Pixhawk-APM-2-5-2-6-2-8-Shock-Absorber-RC-Flight-Control-WS-/381666613231?) consisting of two plates with rubber bushings in between which was similar to the highly recommended [3D printed mount](http://ardupilot.org/copter/docs/common-vibration-damping.html#an-excellent-3d-printed-anti-vibration-platform). I fastened the dampening mount to the upper deck with a couple of screws and attached the Pixhawk Lite to it with a servo tape.

Now was the time to secure the top upper deck to the rest of the frame with the remaining screws from the frame kit and to plug all the signal cables into the flight controller: GPS, compass, telemetry, receiver and ESCs. The four ESCs are plugged into [Pixhawk's servo channels 1 - 4](http://ardupilot.org/copter/docs/connect-escs-and-motors.html) strictly [according to the aircraft's configuration](http://ardupilot.org/copter/docs/connect-escs-and-motors.html). An important note is that although Pixhawk servo connectors have +5V pin, Pixhawk [doesn't provide +5V power to the servo rail](http://ardupilot.org/copter/docs/connect-escs-and-motors.html). Considering that in our build the Pixhawk is powered from its power module rather than a servo rail (that configuration is [also possible](http://ardupilot.org/copter/docs/connect-escs-and-motors.html)), it makes sense to disconnect +5V (red) wire from the ESC connectors before plugging them in. That is because +5V from the power module may not have the exact same potential as +5V from the ESCs, and that can create a harmful voltage differential.

![pixhawk mounted on the top plate](/images/alien_560_5.jpg)

Finally, I had everything installed and plugged in. The next step would be to set up the software.

![Alien 560 from the front](/images/alien_560_6.jpg)

To be continued...

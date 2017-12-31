---
Title: "Alien 560 Quadcopter Build - Part 1 - Parts"
Series: ["Alien 560 Quadcopter Build"]
Date: 2016-09-23
Author: Sergey Stadnik
Category: lifestyle
Tags: [multirotors]
---

When I was at school, I was an electronics geek. I was spending days in a library looking for schematics of AM radios and circuits of blinking lights and beeping sounds, and then long evenings in an electronics club trying to solder them together. Unfortunately, none of the stuff I built ever worked properly: radios received only static, lights blinked out of order, and beepers screaked. But most of all I was obsessed with remote control models.
<!-- PELICAN_END_SUMMARY -->
I had a book about remote control models my dad gave to me. It was a 300-pages manual describing in details how to build a remote-controlled ship, a glider, and a car, complete with blueprints and full schematics and circuit designs of the transmitter and the receiver. It was all analogue like almost everything in the 80s, and the transmitter required some precisely machined metal parts for control handles. I drooled over that book for years but sadly I clearly understood that I had zero chances of assembling a radio and a working model.

Many years passed, but my yearning for remote control models remained. And finally, when I moved to Australia I decided that I had waited long enough. I bought my first hobby-grade remote controlled car, then another one, and before I knew I had a few.

![Rack full of R/C cars]({filename}/images/rc_cars_rack_large.jpg){.center}

Those cars are a lot of fun to play with, and they are quite reliable. The oldest one I own is eight years old and still going strong. It had to repair it after some accidents, but it was nothing major.

About a year ago one of my friends talked me into attempting to assemble a quadcopter. He has built a few quad- and hexacopters himself and, as you can imagine, he knew quite a lot about them. The way he talked about copters sounded intriguing, and I' ve got hooked up.

Rather than buying a ready to fly quadcopter off the shelf, I decided to build one myself from scratch to make it more interesting. With the help of my friend I have put together a list of the necessary components which looked like this:

Category  | Item
------------- | -------------
Frame  | [HobbyKing® Alien 560 Folding Quad-Copter Carbon Fiber Version (Kit)](http://www.hobbyking.com/hobbyking/store/__60363__HobbyKing_174_Alien_560_Folding_Quad_Copter_Carbon_Fiber_Version_Kit_UK_Warehouse_.html)
Flight Controller + GPS / Compass + OSD + Telemetry  | [Pixhawk PX4 2.4.6 32bit Flight Controller Led NEO-M8N GPS PPM OSD 3DR 915Mhz 433Mhz](http://www.banggood.com/Pixhawk-PX4-2_4_6-Flight-Controller-NEO-M8N-GPS-Radio-Telemetry-PPM-OSD-3DR-p-977597.html)
Flight Controller Anti-vibration mount | [Anti-vibration-Plate-Pixhawk-APM-2-5-2-6-2-8-Shock-Absorber-RC-Flight-Control-WS](http://www.ebay.com.au/itm/Anti-vibration-Plate-Pixhawk-APM-2-5-2-6-2-8-Shock-Absorber-RC-Flight-Control-WS-/381666613231?)
Motors (x4)	| [Turnigy Multistar 4220-880Kv 16Pole Multi-Rotor Outrunner](http://www.hobbyking.com/hobbyking/store/__38455__Turnigy_Multistar_4220_880Kv_16Pole_Multi_Rotor_Outrunner.html)
ESC (x4) | [Afro ESC 30Amp Multi-rotor Motor Speed Controller (SimonK Firmware)](http://www.hobbyking.com/hobbyking/store/uh_viewItem.asp?idProduct=49812)
Propellers (x2) | [Quanum Carbon Fiber T-Style Propeller 11x5.5 (CW/CCW) (2pcs)](http://www.hobbyking.com/hobbyking/store/__66676__Quanum_Carbon_Fiber_T_Style_Propeller_11x5_5_CW_CCW_2pcs_.html)
Propeller Balancer | [Carbon Fiber Propeller Balancer Maglev 4-axis Rack](http://www.ebay.com.au/sch/sis.html?_nkw=Carbon+Fiber+Magnetic+Multi+axis+Rack+Propeller+Balancer+For+Quadcopter+FPV+SN&_itemId=161820733921&_trksid=p2047675.m4099)
Transmitter (w/o module) | [Turnigy 9XR PRO Radio Transmitter Mode 2 (without module)](http://www.hobbyking.com/hobbyking/store/uh_viewItem.asp?idProduct=68660)
Transmitter module & Receiver combo | [FrSky XJT 2.4Ghz Combo Pack for JR w/ Telemetry Module & X8R 8/16Ch S.BUS ACCST Telemetry Receiver](http://www.hobbyking.com/hobbyking/store/__41609__FrSky_XJT_2_4Ghz_Combo_Pack_for_JR_w_Telemetry_Module_X8R_8_16Ch_S_BUS_ACCST_Telemetry_Receiver.html)
Transmitter Battery	| [Turnigy 9XR Safety Protected 11.1v (3s) 2200mAh 1.5C Transmitter Pack](http://www.hobbyking.com/hobbyking/store/__45679__Turnigy_9XR_Safety_Protected_11_1v_3s_2200mAh_1_5C_Transmitter_Pack_AU_Warehouse_.html)
Batteries | [ZIPPY Compact 5800mAh 3S 25C Lipo Pack](http://www.hobbyking.com/hobbyking/store/__33002__ZIPPY_Compact_5800mAh_3S_25C_Lipo_Pack_AU_Warehouse_.html)
Battery Strap | [Turnigy Battery Strap 330mm](http://www.hobbyking.com/hobbyking/store/__30758__Turnigy_Battery_Strap_330mm_AU_Warehouse_.html)
Power distribution harness | [Multistar XT60 to 4 x 3.5mm with JST Plug Quadcopter Distribution Harness](http://www.hobbyking.com/hobbyking/store/__67928__Multistar_XT60_to_4_x_3_5mm_with_JST_Plug_Quadcopter_Distribution_Harness.html)
Power wires (2m each color) | Turnigy High Quality 16AWG Silicone Wire: [red](http://www.hobbyking.com/hobbyking/store/__78197__Turnigy_High_Quality_16AWG_Silicone_Wire_1m_Red_.html), [blue](http://www.hobbyking.com/hobbyking/store/__78199__Turnigy_High_Quality_16AWG_Silicone_Wire_1m_Blue_.html), [black](http://www.hobbyking.com/hobbyking/store/__78196__Turnigy_High_Quality_16AWG_Silicone_Wire_1m_Black_.htm)
Power Connectors (x2) | [PolyMax 3.5mm Gold Connectors 10 PAIRS (20PC)](http://www.hobbyking.com/hobbyking/store/__68__PolyMax_3_5mm_Gold_Connectors_10_PAIRS_20PC_.html)
Servo Extension Leads | [15cm Servo Lead Extention (JR) 26AWG (10pcs/bag)](http://www.hobbyking.com/hobbyking/store/__9697__15cm_Servo_Lead_Extention_JR_26AWG_10pcs_bag_.html)
Servo Leads | [10CM Male to Male Servo Lead (JR) 26AWG (10pcs/set)](http://www.hobbyking.com/hobbyking/store/__61681__10CM_Male_to_Male_Servo_Lead_JR_26AWG_10pcs_set_.html)
Heat Shrinks | [A bunch of various heat shrinks ](http://www.ebay.com.au/itm/328Pcs-Assorted-8-Sizes-Heat-Shrink-Tube-Set-Kit-3mm-4mm-6mm-8mm-10mm-Heatshink-/232056178868?hash=item3607a048b4:g:1KYAAOSw3YNXZLby)
Cable Ties | [75PCS Assorted heavy duty black nylon cable tie](http://www.ebay.com.au/itm/75PCS-ASSORTED-HEAVY-DUTY-BLACK-NYLON-CABLE-TIE-2-5x100mm-3-6x200mm-3-6x300mm-/282098533013?hash=item41ae620295:g:11YAAOSwRJ9XhJYC)
Mounting Tape | [Servo Tape (Clear) 25mm x 1m](http://www.hobbyking.com/hobbyking/store/__55135__Servo_Tape_Clear_25mm_x_1m_AU_Warehouse_.html)


I chose [Alien 560](http://www.hobbyking.com/hobbyking/store/__58206__HobbyKing_174_Alien_560_Folding_Quad_Copter_Carbon_Fiber_Version_Kit_EU_Warehouse_.html) frame because my friend has already built a quadcopter based on it, so I hoped to leverage his experience. It is a carbon fiber frame allowing installation of up to 12'' propellers. It also has foldable "arms" which are very convenient: it doesn't take much storage space folded while unfolding it before a flight takes just a few seconds.

The choice of a flight controller was a key one. A flight controller is a brain which controls all the functions of an aircraft. There are quite a few to choose from on the market. Some, like [CC3D](http://www.dronetrest.com/t/cc3d-flight-controller-guide/830) and [Naze32](http://www.dronetrest.com/t/naze-32-versions-explained-and-what-to-look-out-for/1580) are designed for [drone racing](https://fpvracing.tv/) while others, like [Naza-M](http://www.dji.com/naza-m-v2) are tailored for aerial photography. I chose to base my quadcopter on a [Pixhawk](https://pixhawk.org/). Pixhawk itself is an open source hardware project. Because its schematics is available to anyone who cares, quite a few companies make them. [3DR](https://3dr.com/) is the "official" manufacturer; they use their controllers in their highly acclaimed [3DR Solo](https://3dr.com/solo-drone/) drones. But there is also no shortage of various Chinese manufacturers producing Pixhawk clones in all shapes and sizes, most of them costing half or less of the 3DR's. Most of them use reference design and look identical to each other, but [some are quite different](http://www.hobbyking.com/hobbyking/store/__81874__PixFalcon_Micro_PX4_Autopilot.html). Regardless, they all should all be compatible and work just as well.

I ordered a [package](http://www.banggood.com/Pixhawk-PX4-2_4_6-Flight-Controller-NEO-M8N-GPS-Radio-Telemetry-PPM-OSD-3DR-p-977597.html) containing not just the flight controller itself, but also all the necessary accessories: a power module, GPS, Compass, a telemetry module and an OSD *(on-screen display)*. Unfortunately, Banggood mixed something up and sent me a [different package](http://www.banggood.com/PX4-Pixhawk-Lite-V2_4_6-32bit-Open-Source-Flight-Controller-Combo-with-NEO-M8N-GPS-PPM-PM-p-993850.html). While technically also a Pixhawk, that wasn't the one I ordered. A quick search on the internet revealed that Pixhawk Lite I received had [weird wiring issues](http://www.rcgroups.com/forums/showthread.php?t=2418029). I complained to Banggood, explained their mistake, and they agreed to exchange the wrong controller for the right one. I sent the package back and received a new one in a couple of weeks. When I opened it I discovered that it contained the same Pixhawk Lite as the previous one they sent me. Obviously, there was something wrong with their inventory management system. At that point, I decided to give up since I saw no rational way of getting the right controller out of them. After all, there were people who [had successfully built copters](http://www.rcgroups.com/forums/showthread.php?t=2418029) on it, and I figured I could do that too. Luckily for me, Banggood agreed to refund the price difference.

*To be continued...*

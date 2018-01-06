---
Title: "Why I want an autopilot in my racing drone"
Date: 2017-11-23
Author: Sergey Stadnik
Category: lifestyle
Slug: why-i-want-autopilot
Series: ["Building a small GPS drone"]
Tags: [multirotors]
aliases:
  - /2017/11/armattan-tilt-r-the-beginning.html
  - /2017/11/why-i-want-autopilot.html
---

About a year ago Hobbyking was having one of their "Flash Sale" events. During a few days, they dropped prices on a few hundred items. An online shopaholic in me couldn't miss it. I meticulously studied the offerings until I found something worthy of my attention and money. That was a <a href="https://hobbyking.com/en_us/jumper-218-pro-quad-copter-arf.html">Jumper 218 Pro</a> racing quadcopter, almost ready to run. A bargain at a just a bit over $100! I just needed to add an RC receiver.

{{<figure src="https://lh3.googleusercontent.com/-h9Izk-oSzhc/WhUKywZMAJI/AAAAAAAA5W8/vCu0SV_IgQc5xt-nve54oFH1ls62U425ACE0YBhgL/s800/jumper_218.jpg" caption="Jumper 218 Pro Quadcopter | Source:" alt="Jumper 218 Pro Quadcopter" attr="hobbyking.com" attrlink="https://hobbyking.com/en_us/jumper-218-pro-quad-copter-arf.html?___store=en_us">}}

I received it a few days later and, as it often happens, put it on a shelf for a few months. From time to time I would take it off the shelf, hold it in my hands, make a few plans for it, and then put it back. At the time I was still concentrating on building <a href="/2016/09/alien-560-quadcopter-build-part-1-parts.html">my Alien 560 quadcopter</a>, and the smaller drone was a distraction. The "project Alien" appeared to be never-ending. Every time I flew it, I saw a way to improve it. I would disassemble the copter and work on it for a week or two. Then put it back together, fly it, and then dismantle again. Only when <a href="https://youtu.be/SFSsMt6lBdg">I crashed the Alien</a>, I decided to take a break from it and turned my attention to the Jumper.

<!--more-->

Despite it being declared "almost ready to run" by the manufacturer, it took me a while to put it together and set it up. As far as quadcopters go, the Jumper couldn't be further away from the Alien. The Alien was large - 560mm wheelbase (the distance between the opposing motors). The Jumper was less than half of that size - 218mm. The Alien had lots of space in its frame for electronic components. The factory-assembled Jumper had none, and I still had to squeeze an RC receiver. It took me some time to consider mounting options and hook it up in a way that it wouldn't break at the first crash. Then I faced a new challenge.

The Alien was based on Pixhawk autopilot with Ardupilot software. The Jumper had Naze32, a racing flight controller, with Cleanflight. The setup procedures for those two were entirely different. That meant that the knowledge I gained from months of reading the Ardupilot documentation was useless in the Cleanflight world. I had to start with a clean slate.

Finally, all the challenges have been overcome. The Jumper was fully assembled, tuned, and ready to fly.

{{<figure src="https://lh3.googleusercontent.com/-GxZ9iZry9uY/WhUQHyP0smI/AAAAAAAA5Xk/xgLU9dk4hgY9Nt8eoqS7GxqklBsjYXRIwCE0YBhgL/s640/20171021_135220.jpg" alt="Assembled Jumper 218 Pro">}}

I charged the batteries and took it to a nearby park for a test. And a few minutes later I found out that I wasn't a very good pilot.

You see, the Alien had a full set of sensors: a GPS, barometer, compass. If I released the controls, it would stay exactly where I left it despite the wind. I could flip a single switch, and it would fly back to the take-off spot and land itself. If I was flying it via FPV (First Person View), I could see information about altitude, speed, direction and distance to "home" overlaid over the camera feed.

The Jumper, on the other hand, had no sensors. Well, except for a gyro. But drones can't fly without a gyro. In short, the Alien was smart, it could pilot itself, and that took a lot of pressure off its operator. The Jumper was a typical racing drone - as simple and as dumb as they get. Unfortunately, that meant that I was fully responsible for piloting it.

I would put on my FPV goggles, take off, and then in a few seconds, I was lost. Looking through the drone's camera, all the trees around appeared the same. Without a GPS and a compass, I couldn't tell where I was and which direction I was flying towards. Any wind made matters worse by blowing the drone off-course. Inevitably in a few moments, I would crash. Then the drone would detect a loss of signal from the radio controller and start beeping morse SOS furiously. I had to locate it by the sound, sometimes hundreds of meters away buried under leaves, or stuck in a bush. And then repeat it all over again.

It wasn't long until the drone was stuck in a tree 20 meters from the ground. The motors wouldn't start because the copter wasn't level, which is a safety feature. I made a few attempts to shake the quadcopter out of the tree. But it was properly stuck. I left and was prepared to give up and cut the losses. But when I returned a few days later I found my copter laying safely on the ground under the tree. The previous night's storm must have shaken it down.

{{<figure src="https://lh3.googleusercontent.com/-jgp6_iWDCSw/WhUS1UzX4vI/AAAAAAAA5X8/pMGkVCoOaKYpdNh_45WQLDX1aw5vhPcagCE0YBhgL/s800/20171026_190731.jpg" alt="The quadcopter is out of the tree" caption="It's finally out of the tree">}}


The adventure had a happy ending, but it has got me thinking. I enjoyed the thrill of flying a racing drone and wanted to do more of it. However, I also wanted the safety of an autopilot. I wanted to see an arrow pointing to "home" on my OSD (On-Screen Display). And an ability to flip a switch and watch the drone to return to the landing point itself. Therefore, I decided on my next project. It wouldn't be a purely racing drone. Instead, it would be a reasonably agile smart drone but with an autopilot and a full set of sensors. That was how the new quadcopter project started.

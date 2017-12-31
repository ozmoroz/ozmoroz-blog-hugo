---
Title: "Composing and producing electronic music: week 2"
Date: 2012-07-08
Author: Sergey Stadnik
Category: lifestyle
Tags: [music_production]
Slug: composing-and-producing-electronic
Summary: How I made a drum groove from Amen Break for second week's assignment of Composing and Producing Electronic Music course.
---

The assigmnent for week 2 of Composing and Producing Electronic Music
was to make a drum groove for a [Drum'n Bass](http://en.wikipedia.org/wiki/Drum_and_bass) track. Here's how I
did it.

I started with recreating [Amen Break](http://en.wikipedia.org/wiki/Amen_break) in [FL Studio](http://www.image-line.com/documents/flstudio.html).

First of all, I found that I am not good at playing drums. After I
“played” it I had to heavily edit it in the piano roll to match the
groove. Next time when I do my own complex groove from scratch, it will
make sense for me to draw the groove on paper first, then play it and
edit.

Here’s the 100% quantized groove:

![100% quantized groove]({filename}/images/2012-07-08-image001.jpg)

Then I dropped the original Amen Break groove into Slicex, which
automatically sliced it. Oops, made a mistake here: before slicing the
loop should have re-detected it tempo or manually set it to 138.

![Slicing in Slicex]({filename}/images/2012-07-08-image002.png)

Then dumped into piano roll as groove template.

![Groove template in piano roll]({filename}/images/2012-07-08-image003.jpg)

After that I quantized my drum’s piano roll based on the groove template:

![Quantizing based on groove template]({filename}/images/2012-07-08-image004.jpg)

And here’s the final Amen Break in MIDI:

![Amen Break in MIDI]({filename}/images/2012-07-08-image005.jpg)

You can see the waveform of the original Amen Break in the background.
It is helpful for matching velocities.

The drums sounded ok, but I wasn’t satisfied with the riding cymbals. It
seemed like somebody was kicking the bottom of the can. I ripped them
off this midi track. Then I found the cymbal sound I liked in my library
and recreated the cymbals using the [Step Sequencer](http://www.image-line.com/support/FLHelp/html/stepsequencer.htm#Jump_Stepsequencer).

Then applied 50% swing:

![Applying 50% swing]({filename}/images/2012-07-08-image006.png)

I also adjusted the cymbal’s pitch to match the original Amen Break:

![Adjusting the cymbal’s pitch]({filename}/images/2012-07-08-image007.png)

Then I added an orchestral hit into the same step sequencer. And again, adjusted its pitch.

Here’s final Amen Break in MIDI:

<audio controls "controls" preload="none" name="CPEMS2 Sergey Amen Break MIDI">
    Your user agent does not support the HTML5 Audio element.
	<source src="http://ozmoroz-pub.s3.amazonaws.com/music/CPEMS2_Sergey_Amen_Break_MIDI.mp3" type='audio/mpeg'>
</audio>

Just to add a little variety I found a DnB an appropriate drum kit in
[Drumaxx](http://www.image-line.com/support/FLHelp/html/plugins/Drumaxx.htm)
and used it for the drums track. Then I laid the sub kick I did in
Massive over it. Audio editing is frustrating in FL, so to the limited
available time I decided to do away with it this time.

As for mixing, I assigned all the drums to the same mixer track and used
the level knobs on the pattern tracks to adjust relative volumes of the
tracks:

![Adjusting relative volumes of tracks]({filename}/images/2012-07-08-image008.png)

As far as I can see, FL does not have a concept of a mixer bus. Instead
output of each mixer track can be directed to an input of one or more of
other mixer tracks. And vice versa, any track can take input from
multiple other tracks (hence serve as a submix track).

In the screenshot below I created a “Drums” track (1) to serve as a submix of all the drums tracks (2-7).

![Mixing drum tracks]({filename}/images/2012-07-08-image009.png)

The circled pictograms on the screenshot above indicate that the output
of Dummaxx track 2 is directed to the input of Drums track 1. And the
output of “Drums” track is routed to Master:

![Routing drum tracks to master]({filename}/images/2012-07-08-image010.png)

FL puts a limiter into the master track by default, and I left it there
with the default settings. As a result, the drums sound compressed but I
reckon it’s actually better that way.

![Limiter]({filename}/images/2012-07-08-image011.png)

Here's the end result:

<audio controls "controls" preload="none" name="CPEMS2 Sergey final groove">
    Your user agent does not support the HTML5 Audio element.
	<source src="http://ozmoroz-pub.s3.amazonaws.com/music/CPEMS2_Sergey.mp3" type='audio/mpeg'>
</audio>

That’s all for this assignment. If I had more time, I would program 1 or
more different drum patterns a switched them after 8 or 16 bars.
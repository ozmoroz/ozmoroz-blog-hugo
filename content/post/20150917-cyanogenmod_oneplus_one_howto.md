---
Title: How to install CyanogenMod on Oneplus One
Date: 2015-09-17
Author: Sergey Stadnik
categories: ["technology"]
Tags: [gadgets]
aliases:
  - /2015/09/a-new-chapter.html
---

I really like my [OnePlus One](https://oneplus.net/one) phone. It is an exemplary engineering achievement proving that it is possible to design a mobile phone as powerful as leading brand’s flagship models but costing half of their price.

Oneplus One is powered by [Cyanogen OS](https://cyngn.com/cyanogen-os), an open source OS based on [Android Open Source Project](https://source.android.com/) (AOSP). Cyanogen OS has its own update cycles, which OnePlus One receives via over-the-air (OTA) updates. When I bought the phone, it had Cyanogen OS 11 installed, based on Android&trade; 4.4 KitKat. Pretty much when I turned on, it received update to Cyanogen OS 12, based on Android&trade; 5. The update went without a hitch, and the phone performed flawlessly for a few months&hellip; until the next update came through.

`12.1-YOG4PAS1N0` is Cyanogen OS 12.1 based on Android&trade; 5.1.1.
Unfortunately, once that update installed on my OnePlus One, it rendered the phone practically unusable. The problems included LTE connection dropping out, random freezes and reboots, application crashing, you name it&hellip; And after a couple weeks I had enough and decided to do something about that. So, I said goodbye to Cyanogen OS and hello to CyanogenMod Nightly Builds.
<!-- more -->

Although they are closely related, Cyanogen OS and CyanogenMod [are not the same](http://www.xda-developers.com/corporate-explained-whos-cyanogen-whats-cyanogen-os/). The technical difference, though, is very minor. However, because CyanogenMod is not endorsed by OnePlus, it does not receive OnePlus updates, it does not contain applications bundled with Cyanogen OS (which are mostly crapware anyway, with an exception of excellent CameraNext).
Oh, and **installing CyanogenMod may void your warranty**. You’ve been warned.
Instead, CyanogenMod has a useful feature of incremental updates. More on that later.

Although CyanogenMod makes kind-of stable [“snaphot” builds](https://download.cyanogenmod.org/?device=bacon&type=snapshot) from time to time, they are rare and can be quite outdated. And I had experience with my previous phones when  snapshot releases stopped being updated altogether. Because of that I opted for [nightly builds](https://download.cyanogenmod.org/?device=bacon&type=nightly). They are exactly what they sound like - automatic nightly builds of CyanogenMod, including all the code changes made during that day. Although they are untested and technically “unstable”, in practice, as I discovered, they are more stable than official releases of Cyanogen OS.

The first thing you need to do to install CyanogenMod on a stock OnePlus One is to unlock the bootloader and root the phone.

There is an excellent [DaxNagtegaal’s guide](https://forums.oneplus.net/threads/full-guide-setting-drivers-up-unlocking-bootloader-flashing-recovery-roms-kernels-rooting.291274/) on how to do exactly that.

The most “painful” part of it is unlocking the bootloader, because doing that effectively factory resets the phone, wiping all the data including the flash partition. If you want to avoid a pain of reinstalling and reconfiguring all your application from scratch, you’ll probably want to back them up with [Helium](https://www.clockworkmod.com/carbon). This backup method isn’t perfect, it doesn’t always work, and you may not be able to restore some of your applications, but unfortunately that’s the only one that works on stock unrooted devices. Once you root the phone, you’ll have much more powerful [Titanium Backup Pro](http://www.titaniumtrack.com/titanium-backup.html) at your disposal. But not now.
You can also use [TotalCommander](http://www.ghisler.com/) with [ADB plugin](http://forum.xda-developers.com/showthread.php?t=2105707) to copy files from your phone. To my liking that is a bit more convenient than via Windows Explorer.

Once the bootloader is unlocked, [follow the steps](https://forums.oneplus.net/threads/full-guide-setting-drivers-up-unlocking-bootloader-flashing-recovery-roms-kernels-rooting.291274/) to flash [TWRP recovery](https://dl.twrp.me/bacon/). After that follow the guide to flash CyanogenMod nightly build. Skip flashing a kernel and go on to rooting the phone. Once rooting is completed, you’re done!

### A couple of finishing touches:

* Grab [CameraNext apk](http://forum.xda-developers.com/oneplus-one/themes-apps/app-cameranext-apk-lib-cyanogenos-12-1-t3186688) or [CameraNext mod](http://forum.xda-developers.com/oneplus-one/themes-apps/app-cos12-cameranextmod-t3086513) and install it. This camera works much better on OnePlus One than the stock CyanogenMod’s one.
* Install [CM Downloader](https://play.google.com/store/apps/details?id=com.paolinoalessandro.cmromdownloader) and you’ll have an option of incremental OS updates. **Do not forget to backup your system with TWRP before updating!**
* And do not forget to backup your applications with  [Titanium Backup](http://www.titaniumtrack.com/titanium-backup.html)!

### Reference:

* [\[Full Guide\] Setting drivers up, unlocking bootloader, flashing recovery, roms, kernels & rooting](https://forums.oneplus.net/threads/full-guide-setting-drivers-up-unlocking-bootloader-flashing-recovery-roms-kernels-rooting.291274/)
* [\[UNLOCK/ROOT/FLASH\] - Heisenberg's How-To Guide For Beginners](http://forum.xda-developers.com/oneplus-one/general/guides-bacon-timmaaas-how-to-guides-t2839471)
* [Official CM12.1 Nightlies for OneplusOne](https://forums.oneplus.net/threads/5-1-1-nightly-official-cm12-1-nightlies.300277/)
* [PA-GOOGLE APPS Plus(All ROM's)](http://forum.xda-developers.com/android/software/reborn-gapps-5-t3074660)

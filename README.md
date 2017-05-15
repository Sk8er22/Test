# Testasda 

This is an example of AVPlayerController plugin for get notify when people pause/resume a video without a custom layer.

## Install
You will need to copy
```
Plugin/Plugin/ControlPlugin.swift
```
into your project

## Use it

First of all you will have to instance it in your Controller
```
var controlPlugin = ControlPlugin()
```
after that once you have your AVPlayer you will use
```
self.controlPlugin.addObserver(player: self.player)
```
To set the ''rate'' and ''playerDidFinishPlaying'' observers
And thats all... this plugin will show you on console a message when:
- Video ends
- User Play
- User Pause

## IMPORTANT FOR WORK CORRECTLY THE VIDEO HAS TO START PLAYING

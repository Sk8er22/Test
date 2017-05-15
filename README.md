# AVPlayerController plugin: detects Pause/Play/End Video

This is an example of AVPlayerController plugin for get notify when people pause/resum/end Video without a custom layer.

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
after that, once you have your AVPlayer, you need to use
```
self.controlPlugin.addObserver(player: self.player)
```
To set the ''rate'' and ''playerDidFinishPlaying'' observers.
And thats all... this plugin will show you on console a message when:
- Video ends
- User Play
- User Pause
- △ Paused Time 

Also you can recibe a String with all this information using the following function:
```
var finalmessage = controlPlugin.end()
```

## IMPORTANT FOR WORK CORRECTLY THE VIDEO HAS TO START PLAYING

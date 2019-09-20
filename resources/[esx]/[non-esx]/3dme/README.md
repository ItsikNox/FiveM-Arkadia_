# 3D /me
The /me command but it draws it in 3D (and it has log).

<img src=https://imgur.com/vexru3M.png>
<img src=https://imgur.com/k8z57Ws.png>

## Installation
* Download the resource ;
* Drag and drop it in your resources folder ;
* Add ```start 3dme``` to you ```server.cfg```.

## How to use
* In the chat type /me followed by your action.

## Options 
* Color of the text : ```client.lua``` line 2 : ```local color = {r = 37, g = 175, b = 134, alpha = 255}```
* Font of the text : ```client.lua``` line 3 : ```local font = 0``` Available fonts : https://imgur.com/a/oV3ciWs
* Time on screen : ```client.lua``` line 4 : ```local time = 500```
* Enable or disable the dropshadow : ```client.lua``` line 10 : ```local dropShadow = true```
* Enable or disable the log : ```server.lua``` line 1 : ```local logEnabled = true```
* Enable or disable chat messages : ```client.lua``` line 9 : ```local chatMessage = false```
* Background : ```client.lua``` line 5-8 : ```local chatMessage = false```

## Updates
#### V1.1
* The text display an exact amount of time (thanks to @SaltyGrandpa) ;
* Added "the person" at the beginning of the text (```Line 16``` if you want to change the language) ;
* Using /me multiple times doesn't make it unreadable.
#### V1.2
* Bugs fixes ;
* Changed the native color and removed the shadow and the outline (you can still reactivate it) ;
* Now draw when you are close to the person (50 m).
#### V1.3
* Now send a chat message to the people close to the person ;
* Can now draw a background to the text ;
* Added the options to draw a dropshadow.

## Note
* This may not work if are you using a custom chat resource.
* This could conflict with other /me scripts (just disable them).

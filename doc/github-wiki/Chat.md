1. [Chat](#chat)
	1. [Sending messages](#sending-messages)

# Chat

The in-game chat functionality allows players to communicate with each other with short text messages inside a server.

## Sending messages

First of all, before you can chat anything at all, you require the "shout" privilege. Don't worry, most servers give you this privilege by default.

You can chat either by opening the chat window or the console which can be opened with the keys T or F10, respectively (assuming you use the default key bindings). Use the chat window or the console to enter a chat message. There are two kinds of chat messages, public ones and private ones.

**Public messages**

A public message is a message which is visible to all connected players.

**Ordinary public messages**

Your chat message is a normal public message if it doesn't begin with a "/". It appears like this in the chat log:

```
<player> message
```

Example: If you enter "Hello, how are you?" as MrCerealGuy, then this will appear in the chat log:

```
<MrCerealGuy> Hello, how are you?
```

**/me messages**

This function is more like a gimmick than anything else. A /me message is a special case of a public message. The only real difference from the ordinary one is its appearance in the chat log. A /me message can be entered with:

```
/me <message>
```

Replace "&lt;message&gt;" with the actual message. You will get a message in the chat log which looks like this:

```
* <player> <message>
```

Example: Assume you want to say that you think that Stonecraft is awesome, in the third person. If you enter "/me thinks Stonecraft is awesome.", you get:

```
* MrCerealGuy thinks Stonecraft is awesome.
```

**Private messages**

A private message is a chat message which appears only on the chat logs of the sender and a chosen receiver of the message.

You can send a private message (PM) to someone by using the "/msg" server command. Say something in the form of:

```
/msg <player> <message>
```

Replace "&lt;message&gt;" by your actual message and "&lt;player&gt;" by the name of the player you want to send the message to. The message won't be publicly visible in the chatlog and only appears to you and the other player. Be aware that the messages are not encrypted, so do not transfer really sensitive information using the private message feature.

Example: If your name is "MrCerealGuy" and you entered "/msg MrFr33maN I want to show you my hidden chest.", then this will appear in the chat log of MrFr33maN:

```
PM from MrCerealGuy: I want to show you my hidden chest.
```

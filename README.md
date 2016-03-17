# README

Hello, and welcome to Carrot App, the app developed to avoid a noisy social faux pas.  

Is it too quiet to eat a carrot?  Carrot App takes the average decibel level of the room and notifies the user if it is loud enough to avoid disturbing the people around you.  Options for other noises are available at the bottom of your screen.

Developed by Joseph Kim, David Louie, and Lucas Nagle.
Made possible by Dev Bootcamp NYC.

Lead: Lucas Nagle

Dev Opps, and Design: Joseph Kim

Git Master, and Quality Assurance: David Louie

# Key Deliverables: (as of 3/10/16)
* 3 hours: Home Page, with button to take you to decibel meter, and a feedback button (probably with a mailer)

* 6 hours: Decibelometer Page, runs for several seconds, measuring average noise level

* 6 hours: Logo and working animation for the decibel meter page

* 1.5 hours: “Take a bite” page, with links to home and feedback

* 1.5 hours: “Wait it out” page, with links to home and feedback

* 12 hours: Learning Swift

* 6 hours: Learning testing and applying CircleCI

# Revised Key Deliverables (3/17/16)

* Learn Swift to dictate behavior of views, as well as background processes (decibel reading)

* Home page, with buttons, correllating to different noise levels

* Result pages, which inform the user whether or not it's too loud to take action

* Animations during listening process to emulate a timer

# General Process

1. Show a button
2. Set up AVAudioSesion
3. Get microphone permissions
4. Record an audio sample
5. Get decibel reading for the sample
6. Give appropriate response to the ambient dB reading
  * prepareToSegue
  * performSegue


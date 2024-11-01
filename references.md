Art:

https://dinopixel.com/slime-pixel-art-25116

https://www.youtube.com/watch?v=r-pd2yuNPvA

https://github.com/RPicster/Godot-SmartShape2D-Example

Forest models:
https://www.fab.com/sellers/POLYSCANS

Code:

https://medium.com/@merxon22/godot-shader-render-3d-models-as-pixel-art-4839e6528601

https://github.com/arkology/ShaderV
Use shift HSV

https://github.com/appsinacup/godot-softbody2d

https://github.com/kubecz3k/FiniteStateMachine
^^ doesn't work. Need a different one, possibly the godot demo one. Make it an addon?

https://docs.godotengine.org/en/stable/tutorials/shaders/advanced_postprocessing.html#full-screen-quad



Get the skybox rendering in the overall viewport.

Gonna need a decent chunk of reworking to get rid of all the ROS stuff. It's actively overcomplicating things. That's for today.

I have the demo and src, but I'm inside of the godot-cpp dir. Pull it out for gods sake. Just get a minimal integration like you already got, then steal code from the test dir.


[2] Json::Value::type() const (??:0)
[3] Prefs::GetJson(Json::Value const&, ByteString) (??:0)


have I seen this before?

I think this means that one of my singletons isn't properly initialized. Keep in mind, this is a full crash.

Current step:
powdertoy integrates with ros in the ros wrapper. Apply the same integration to godot.

I can have my framerates fully synced between godot and ros because they're literally integrated. Probably will do a low draw rate and high sim rate.

Two months ago, I made my first commit to the ThoughtBot repo.

My core mechanic is particle simulation. It's really important to nail that down. The sooner I have a playable game, the sooner I can start making it great.
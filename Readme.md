# What is this?
It's basically one client for the [instibot server](https://github.com/rosner/instibot "Instibot server project on github") project. I tried to mimic the behaviour of the Messaging App on iOS. There are still some bugs but I learned a lot while doing this.

#Screenshots
Everybody wants images, here they go!  
![](https://github.com/rosner/instibot-ios/raw/master/doc/screens.png)

# Init submodules
Since this project uses [Seriously](https://github.com/probablycorey/seriously) and [RegexKitLite](https://github.com/wezm/RegexKitLite) as git submodules you need to init and update them with the following commands:  
      git submodule init
      git submodule update

#Configuring API endpoint
There are additional keys in the Info.plist (`UPBotId, UPContext, UPHostname, UPPort`) . You need to change those to match your environment. See again [instibot server](https://github.com/rosner/instibot "Instibot server project on github") project for further information. The values configured so far should work with the default server properties.
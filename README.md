<html>
    <p align="center">
        <img width="200px" src="img/censhine_icon_logo.png"/>
    </p>
    <h1 align="center">CEnshine</h1>
    <p align="center">
       Shaders enhancement for Halo Custom Edition aiming to restore Xbox accurate rendering
    </p>
    <p>&nbsp;</p>
</html>

This project is made with the goal of improving Halo Custom Edition shaders and align them with the
shaders quality provided in the MCC/Xbox version of the game, just by the joy of doing it, all of
this is the result of almost 2 weeks of hard work to bring a well deserved set of shaders to
Halo Custom Edition as Gearbox left us with broken version of almost all the shaders.

CEnshine was made using primarily Lua, take a look at the source files on this repository.

For a more strict and robust shaders building solution check [Composer]() a CLI set of programs made
with C++ for decrypting, encrypting, decompiling and compiling of shaders.

# Fixes and future improvements
Some of the things we have fixed with these shaders so far are listed below, as well as unmarked all
the things we plan to do to restore at some point as well.
- **Shader Transparent Plasma** - (Plasma based shaders will render properly, for example biped shields recharge)
- **Environment Reflection** - (Bumped surfaces now will tint correctly perpendicularly and horizontally, dynamic mirror seems to work properly now, needs testing)
- **Environment Light Maps** - (Light map direction will now apply correctly to other textures like bump maps)
- **Transparent Glass Reflection** Bumped - (Glass with bumped reflections)
- **Transparent Water** - (Water color and opacity)
- **Environment Model** - (Objects now draw behind fog, animations fade correctly, cube map alpha applies correctly)
- **Environment Texture** - (Restored normal, blended and blended base specular function types)

# Screenshots
Here are some 2K screenshots demonstrating changes between the broken shaders and the fixed ones, just
to show a few, shaders include other fixes that require looking at them in game to appreciate:

**BEFORE**
![decompilation](img/screenshots/B40_3.png)
**AFTER**
![decompilation](img/screenshots/B40_4.png)
**BEFORE**
![decompilation](img/screenshots/B40_5.png)
**AFTER**
![decompilation](img/screenshots/B40_6.png)
**BEFORE**
![decompilation](img/screenshots/B40_7.png)
**AFTER**
![decompilation](img/screenshots/B40_8.png)

# Thanks to
- [JerryBrick](https://github.com/JerryBrick) - Composer tools creator, tools for decrypting and encrypting shaders
- [MrChromed](https://www.youtube.com/c/MrChromed) - Halo CE Shaders veteran, providing support for validating shaders fixes
- [C20](https://c20.reclaimers.net/h1/engine/renderer/#gearbox-regressions) - Provided a list of known shaders issues
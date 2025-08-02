#!/usr/bin/env python
import os
import sys
from glob import glob

# Primeiro compila o godot-cpp
env = SConscript("godot-cpp/SConstruct")

# Agora configura o ambiente para o seu projeto
env.Append(CPPPATH=["src/"])
env.Append(LIBS=["stdc++"])
env["LINKFLAGS"] = [flag for flag in env.get("LINKFLAGS", []) if flag != "-static-libstdc++"]

# Coloca arquivos objeto em uma pasta separada
env.VariantDir("src/bin/obj", "src", duplicate=0)
sources = Glob("src/*.cpp", strings=True)
sources = ["src/bin/obj/" + os.path.basename(s) for s in sources]

# Compila a biblioteca
if env["platform"] == "macos":
    library = env.SharedLibrary(
        "game/bin/gamecore.{}.{}.framework/gamecore.{}.{}".format(
            env["platform"], env["target"], env["platform"], env["target"]
        ),
        source=sources,
    )
else:
    library = env.SharedLibrary(
        "game/bin/gamecore{}{}".format(env["suffix"], env["SHLIBSUFFIX"]),
        source=sources,
    )

Default(library)
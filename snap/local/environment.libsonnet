{
    CFLAGS: "-I$SNAP/usr/include -I$SNAP/usr/include/$SNAPCRAFT_ARCH_TRIPLET -I$SNAP/gnome-platform/usr/include -I$SNAP/gnome-platform/usr/include/$SNAPCRAFT_ARCH_TRIPLET -I$SNAP/include -I$SNAP/include/$SNAPCRAFT_ARCH_TRIPLET",
    CXXFLAGS: "-I$SNAP/usr/include -I$SNAP/usr/include/$SNAPCRAFT_ARCH_TRIPLET -I$SNAP/include -I$SNAP/include/$SNAPCRAFT_ARCH_TRIPLET",
    LDFLAGS: "-L$SNAP/gnome-platform/lib/$SNAPCRAFT_ARCH_TRIPLET -L$SNAP/gnome-platform/lib -L$SNAP/gnome-platform/usr/lib/$SNAPCRAFT_ARCH_TRIPLET -L$SNAP/gnome-platform/usr/lib -L$SNAP/usr/lib -L$SNAP/usr/lib/$SNAPCRAFT_ARCH_TRIPLET -L$SNAP/gnome-platform/usr/lib -L$SNAP/gnome-platform/usr/lib/$SNAPCRAFT_ARCH_TRIPLET -L$SNAP/lib -L$SNAP/lib/$SNAPCRAFT_ARCH_TRIPLET -L$SNAP/gnome-platform/lib -L$SNAP/gnome-platform/lib/$SNAPCRAFT_ARCH_TRIPLET -L/lib -L/lib/$SNAPCRAFT_ARCH_TRIPLET",
    SWIG_LIB: "$SNAP/usr/share/swig3.0",

    GIT_EXEC_PATH: "$SNAP/usr/lib/git-core",
    MPG123_MODDIR: "$SNAP/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/mpg123",
    VLC_PLUGIN_PATH: "$SNAP/usr/lib",

    MYCROFT_CACHE: "$SNAP_USER_COMMON/.cache/mycroft_web_cache.json",
    MYCROFT_SKILLS: "$SNAP_USER_COMMON/skills/skills",
    PYTHONPATH: "$SNAP/lib/python3.6/site-packages"
    MYCROFT_SKILLS_REPO: "$SNAP_USER_COMMON/skills/.skills-repo",
    "LANG":"en_US.UTF-8",
    "LC_CTYPE":"en_US.UTF-8",
    "LC_NUMERIC":"en_US.UTF-8",
    "LC_TIME":"en_US.UTF-8",
    "LC_COLLATE":"en_US.UTF-8",
    "LC_MONETARY":"en_US.UTF-8",
    "LC_MESSAGES":"en_US.UTF-8",
    "LC_ALL":"en_US.UTF-8"

}
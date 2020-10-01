{
    mycroft: {
        after: ["snapcraft-preload"],
        source: "https://github.com/MycroftAI/mycroft-core.git",
        "source-type": "git",
        plugin: "nil",
        "override-pull": |||
            snapcraftctl pull
            git checkout "$(git describe --tags --abbrev=0 --match release/v*)"
            snapcraftctl set-version "$(git describe --tags | sed -e 's|release/v||')"
            sed -i 's|/var/log/mycroft|$SNAP_USER_COMMON/logs|g' start-mycroft.sh
            cat > scripts/prepare-msm.sh <<EOF
            #!/bin/sh
            true
            EOF
            sed -E -i 's|(python3 -m \$\{_module\} \$_params)|$SNAP/bin/snapcraft-preload \1|g' start-mycroft.sh
        |||,
        "override-build": |||
            mkdir -p $SNAPCRAFT_PART_INSTALL/mycroft-source
            rsync -a --exclude .git ./ $SNAPCRAFT_PART_INSTALL/mycroft-source/
        |||,
        "build-packages": ["rsync"],
    },
    "mycroft-normal": {
        after: ["snapcraft-preload"],
        source: "https://github.com/MycroftAI/mycroft-core.git",
        "source-type": "git",
        "plugin": "python",
        "python-version":"python3",
        "build-packages": ["build-essential", "python3-dev", "libeccodes-dev", "libssl-dev", "libffi-dev", "libxml2-dev", "libxslt1-dev", "zlib1g-dev", "python3-psutil", "libpulse-dev", "swig", "gcc", "g++", "python3-wheel", "libfann2", "libfann-dev"],
    },

    "mycroft-conf": {
        plugin: "nil",
        "override-pull": |||
            cat  > mycroft.conf <<EOF
            {
                "enclosure": {
                    "update": "false"
                },
                "data_dir": "~/snap/mycroft/common/mycroft-data",
                "log_dir": "~/snap/mycroft/common/logs"
            }
            EOF
        |||,
        "override-build": |||
            install -m644 -D -t $SNAPCRAFT_PART_INSTALL/etc/mycroft mycroft.conf
        |||,
    },

    "mycroft-deps": {
        after: ["mimic", "snapcraft-preload"],
        plugin: "nil",
        "override-build": |||
            snapcraftctl build
            ln -sf aclocal-1.15 $SNAPCRAFT_PART_INSTALL/usr/bin/aclocal
            ln -sf automake-1.15 $SNAPCRAFT_PART_INSTALL/usr/bin/automake
            for sofile in libc.so libm.so libpthread.so; do
                sed -Ei 's|(/usr/lib/$SNAPCRAFT_ARCH_TRIPLET)|/snap/mycroft/current\1|g' $SNAPCRAFT_PART_INSTALL/usr/lib/$SNAPCRAFT_ARCH_TRIPLET/$sofile
            done
        |||,
        organize: {
            "usr/lib/*/*fann*.so*": "usr/lib/",
            "usr/bin/mpg123.bin": "usr/bin/mpg123",
        },
        stage: ["-usr/bin/sudo"],
        "stage-packages": [
            "locales-all",
            "yad",
            "autoconf",
            "automake",
            "binutils",
            "bison",
            "build-essential",
            "cmake",
            "coreutils",
            "curl",
            "flac",
            "g++",
            "gcc",
            "git",
            "jq",
            "libasound2-dev",
            "libc++-dev",
            "libc6-dev",
            "libfann-dev",
            "libffi-dev",
            "libglib2.0-dev",
            "libgpm2",
            "libicu-dev",
            "libjack-jackd2-0",
            "libjpeg-dev",
            "libpcre2-dev",
            "portaudio19-dev",
            "libssl-dev",
            "libtool",
            "libvlc-dev",
            "make",
            "mpg123",
            "mplayer",
            "pkg-config",
            "procps",
            "pulseaudio-utils",
            "python3",
            "python3-dev",
            "python3-pip",
            "python3-setuptools",
            "python3-venv",
            "rsync",
            "screen",
            "swig",
            "vlc",
            "zlib1g",
        ],
    },

    mimic: {
        after: ["snapcraft-preload"],
        plugin: "autotools",
        source: "https://github.com/MycroftAI/mimic.git",
        "source-type": "git",
        "source-depth": 1,
        configflags: [
            "--prefix=/usr",
            "--disable-static",
            "--with-audio=alsa",
        ],
        "build-packages": [
            "libasound2-dev",
            "libpcre2-dev",
            "portaudio19-dev",
        ],
        "stage-packages": [
            "libpcre2-8-0",
            "libportaudio2",
        ],
        prime: [
            "usr/bin",
            "usr/include",
            "usr/lib",
            "-usr/lib/*.a",
            "-usr/lib/*.la",
            "-usr/lib/pkgconfig",
            "usr/share/mimic",
        ],
    },

    scripts: {
        source: "scripts",
        "source-type": "local",
        plugin: "dump",
        organize: {"mycroft-*": "bin/"},
        stage: ["bin/mycroft-*", "start-*"]
    },

    "desktop-file": {
        source: "desktop",
        plugin: "dump",
        organize: {
            "mycroft.desktop": "usr/share/applications/mycroft.desktop",
            "mycroft.png": "usr/share/icons/mycroft.png",
        },
    },

    "snapcraft-preload": {
        # Until sergiusens/snapcraft-preload#29 is merged
        source: "https://github.com/diddledan/snapcraft-preload.git",
        "source-branch": "semaphore-support",
        plugin: "cmake",
        "build-packages": [
            { try: [
                "gcc-multilib",
                "g++-multilib",
            ] },
        ],
        "stage-packages": [
            { try: ["lib32stdc++6"] }
        ],
    },
}
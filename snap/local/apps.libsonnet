{
    mycroft: {
        command: "bin/mycroft-launch",
        desktop: "usr/share/applications/mycroft.desktop",
        extensions: ["gnome-3-28"],
        plugs: [
            "audio-playback",
            "audio-record",
            "desktop",
            "desktop-legacy",
            "mount-observe",
            "network",
            "network-bind",
            "pulseaudio",
            "unity7",
            "wayland",
            "x11",
        ],
    },
    "mycroft-messagebus": {
        command: "start-messagebus",
        daemon: "simple",
        "environment":{ "LANG":"C.UTF-8", "LC_ALL":"C.UTF-8"},
        plugs: ["mount-observe", "network", "network-bind"],
    },
    "audio": {
        command: "start-audio",
        "environment":{ "LANG":"C.UTF-8", "LC_ALL":"C.UTF-8"},
        plugs: [
            "audio-playback",
            "audio-record",
            "mount-observe",
            "network",
            "network-bind",
            "pulseaudio",
            "home"
        ]
    },
    "speech-client":{
        command: "start-speech-client",
        daemon: "simple",
        "environment":{ "LANG":"C.UTF-8", "LC_ALL":"C.UTF-8"},
        plugs: [
            "audio-playback",
            "audio-record",
            "mount-observe",
            "network",
            "network-bind",
            "pulseaudio"
        ]
    },

  # mycroftd:
  #   command: mycroft-launch
  #   daemon: forking
  #   plugs:
  #   - alsa
  #   - mount-observe
  #   - network
  #   - network-bind
  #   - pulseaudio
}
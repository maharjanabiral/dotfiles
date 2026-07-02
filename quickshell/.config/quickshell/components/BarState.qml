pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Services.Mpris

Singleton {
    property real volume: 0
    property bool showVolume: false
    property bool showMusic: false
    property bool showCalendar: false
    property MprisPlayer player: Mpris.players.values[0] ?? null
    readonly property bool isPlaying: player?.playbackState === MprisPlaybackState.Playing

    onIsPlayingChanged: if (!isPlaying) showMusic = false
}
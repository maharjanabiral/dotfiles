import Hyprland from "gi://AstalHyprland"
import { createBinding } from "ags"

export default function Workspaces() {
    const hyprland = Hyprland.get_default()
    const workspaces = createBinding(hyprland, "workspaces")
    const focusedWorkspace = createBinding(hyprland, "focusedWorkspace")

    return (
        <box spacing={6}>
            {workspaces(wss =>
                wss
                    .sort((a, b) => a.id - b.id)
                    .filter(ws => ws.id > 0)
                    .map(ws => (
                        <button
                            className={focusedWorkspace(fw =>
                                fw === ws ? "focused" : ""
                            )}
                            onClicked={() => hyprland.dispatch(`workspace ${ws.id}`)}
                        >
                            {ws.id}
                        </button>
                    ))
            )}
        </box>
    )
}
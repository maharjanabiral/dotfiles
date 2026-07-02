import { Astal } from "ags/gtk4"
import Clock from "../widget/Clock"
import Workspaces from "../widget/Workspaces"
// import Workspaces from "../widgets/Workspaces"
// import PowerMenu from "../widgets/PowerMenu"

export default function Bar() {
    const { TOP, LEFT, RIGHT } =
        Astal.WindowAnchor

    return (
        <window
            visible
            anchor={TOP | LEFT | RIGHT}
            exclusivity={
                Astal.Exclusivity.EXCLUSIVE
            }
        >
            <centerbox
                cssClasses={["bar"]}
                hexpand
            >
                <box $type="start">
                    <Workspaces />
                </box>

                <box $type="center">
                    <Clock />
                </box>

                {/* <box $type="end">
                    <PowerMenu />
                </box> */}

             </centerbox>
        </window>
    )
}
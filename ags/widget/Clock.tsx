// widgets/Clock.tsx

import { createPoll } from "ags/time"

export default function Clock() {
    const clock = createPoll(
        "",
        1000,
        "date '+%H:%M'"
    )

    return (
        <label
            cssClasses={["clock"]}
            label={clock}
        />
    )
}
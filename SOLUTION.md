# Solution: Warp Hiring Challenge

## Answer

**Security Code: `XRT-421-ZQP`**

This is the security code of mission `WGU-0200`, the longest successful (Completed) Mars mission at **1,629 days**.

## Approach

### Problem Analysis

The `space_missions.log` file contains ~105,000 lines of pipe-delimited space mission data. Key challenges:

1. **Comment lines** — 2,019 lines starting with `#` must be skipped
2. **Inconsistent spacing** — whitespace around pipe delimiters varies per line
3. **Multiple statuses** — only "Completed" missions qualify as successful
4. **Multiple destinations** — must filter specifically for "Mars"

### Data Format

```
Date | Mission ID | Destination | Status | Crew Size | Duration (days) | Success Rate | Security Code
```

Fields are numbered 1–8 when split on `|`.

### Solution (AWK)

The solution is a single AWK script (`solve.awk`):

```awk
BEGIN { FS = "|"; max = 0 }

!/^#/ && $3 ~ /Mars/ && $4 ~ /Completed/ {
    gsub(/ /, "", $6)
    gsub(/ /, "", $8)
    dur = $6 + 0
    if (dur > max) {
        max = dur
        code = $8
    }
}

END {
    print "Answer:", code
}
```

**How it works:**

1. `FS = "|"` — split each line on the pipe character
2. `!/^#/` — skip comment lines
3. `$3 ~ /Mars/ && $4 ~ /Completed/` — filter for completed Mars missions
4. `gsub(/ /, "", $6)` — strip whitespace from duration field for numeric comparison
5. Track the maximum duration and its corresponding security code
6. Print the result

**Run it:**

```sh
awk -f solve.awk space_missions.log
```

### Verification

The top 5 longest completed Mars missions confirm the answer:

| Duration | Mission ID | Security Code |
|----------|-----------|---------------|
| 1,629    | WGU-0200  | XRT-421-ZQP   |
| 1,482    | AJV-3533  | WCN-103-DVD   |
| 1,479    | LBS-1848  | ZCA-027-KCP   |
| 1,422    | LTZ-4413  | DHA-730-NYP   |
| 1,417    | PGQ-7628  | NQT-363-IFR   |

Mission `WGU-0200` is unambiguously the longest at 1,629 days.

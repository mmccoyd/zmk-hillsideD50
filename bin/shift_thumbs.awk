# Converts a v0.1.0 keymap to the format required by a v0.2.0 keymap.
#
# Moves the thumb key descriptions one row down, the required change.
# Also tucks them under the main rows and trims down the expanded empty center.
# Thus allowing shorter lines and larger fonts, the reason for the change.
#
# To update your user keymap, including making a backup first:
#
# - If you can, normalize your spacing back to the original 14 character columns
#   plus an extra 6 characters between the two halves.
# - Then run:
#
# ```sh
# cd zmk-hillside_d50
# file=config/hillside_d50.keymap
# cp ${file} ${file}.pre_thumb
# awk -f bin/shift_thumbs.awk ${file}.pre_thumb > ${file}
# ```
#
# - Once that works, remove the pre_thumb backup.
#
# If the column widths vary, this can leave a ragged result.
# An example is the commented out test key maps in the default keymap file,
# which were cleaned up manually.

# Create a string of n spaces.
function spaces(n) {
    assert n <= length(SPACES)
    return substr(SPACES, 1, n)
}

BEGIN {
    FS = "&"                    # "&" starts a key description column
    OFS = "&"

    SPACES = "                                                      "
    col_width = 14
    mid_width = 6               # The existing extra middle space
    mid_cut = 4 * col_width     # How much middle space we free and remove
    spc_hang = "  "                 # hanging out dent for thumbs into middle
    spc_hang_2x = spc_hang spc_hang # Twice that to add on right.
}


# Normal row: initially 12 keys, 13 fields -> Same
NF == 13 {
    # Normal main row. Remove empty columns worth of blank space from middle
    last_left = substr($7, 1, length($7) - mid_cut)
    print $1,
        $2, $3, $4, $5, $6, (last_left spc_hang_2x),
        $8, $9, $10, $11, $12, $13
    next
}

# Upper thumb row: initially 16 keys, 17 field -> 12 keys
NF == 17 {
    # Lowest main row. Fill in the small middle space. (skipping add + remove)
    print $1,
        $2, $3, $4, $5, $6, ($7 spaces(mid_width) spc_hang_2x),
        $12, $13, $14, $15, $16, $17

    # Upper thumbs to use in next line. Same middle space as originally
    upper = $8 FS $9 FS $10 FS $11
    next
}

# Lower thumb row: initially 10 keys, 11 fields -> 8 keys line and 6 keys line
NF == 11 {
    # Add upper thumbs between the utility row corner keys
    last_left = substr($3, 1, length($3) - col_width) # removing the skip column
    print $1,
        $2, last_left spc_hang,
        upper spc_hang,
        $10, $11

    # New extra lower thumb row
    gsub(/ +$/, "", $9) # Strip trailing white space
    print $1 spaces(col_width) spc_hang,
        $4, $5, $6,
        $7, $8, $9
    next
}

# Print the other lines unchanged.
{
    print $0
}

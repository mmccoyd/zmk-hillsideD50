# Change log

## v0.2.0

### Breaking change

The expected layout of keys in the keymap file is changed,
    as are their ids for use in combos.
The result is that keymap lines now fit on a laptop screen without a tiny font.

Each thumb key description is moved down one line and over two columns.
The expansion of the central blank area is then removed.
So now the keymap only need a 178 character wide terminal to avoid wrapping,
    instead of a 230 characters, for 52 fewer characters.
The column widths were not reduced and can be varied as needed,
    as normal.

This changes:

-   Ordering in the `.dtsi`, which defines the expected keymap file order.
-   User and default keymap expected ordering of the keys in the layers.
-   Key id numbers used in combos, past id 29.

This change came from realizing the existing keymap file layout
    was too hard to work, not from any hardware change.

### User action needed

Run the included bash script on your user keymap to convert it to the new format.
Otherwise your lower rows will be happily and silently scrambled.
The script moves the thumb key descriptions down one row.
That is the change needed for the new `.dtsi`.

Combo key number id changes will need to be updated manually.
Though the changes only occur past id 29.

The script also removes extra spaces around the thumb key descriptions,
    tucking them under the main rows.
It then removes the expanded empty center of the lines.
Creating shorter lines allowing more readable font sizes.

The script retains a thumb-key two-character hanging indent into the
    central area to still visually distinguish the thumbs a little.
But the user can manually remove or increase that as they like.

### Alternative

Stay on v0.1.0, especially if you have a complex keymap in the GUI keymap tool,
    as I'm not sure how to update such a keymap beyond recreating it manually.


## v0.1.0

Initial version.

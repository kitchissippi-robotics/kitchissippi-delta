Kichesippi-03
=============

A delta design 3D printer.

Initial project will be aimed at getting an initial printer platform established.


Drive System:

- GT2 timing belt driven on machined aluminum GT2-20 pulleys with 608zz bearing idlers.
- Linear motion achieved on 1/4" polished steel tubing, with 608zz carriage sytem from the K-02 prototype.
- Consideration was given to spectra-line drive systems, however the relative cost of GT2 belt and the extra effort required seems economically unsound.
- Standard NEMA17 stepper motors.

Extrusion:

- 1.75mm filament driven through 2mm ID / 4mm OD PTFE tubing.
- Carriage and mounts are based around the current J Head design with some (minor) consideration for other groovemount systems.
- Fan shrouding is designed for the needs of a J Head running at elevated temperatures, there is a 25mm x 10mm fan aimed at the cooling fins in the PEEK/cold-end portion of the design - always on.
- Ducting may be beneficial to other similar hotends, however I would not recommend using the Carriage - Core piece with an all-metal hotend unless it has been printed in a high temperature plastic, such as ABS or Nylon
- Dual 25mm x 10mm fans ducted around the hotend towards the print immediately below the carriage for plastics that need active cooling - software controlled.

Movement:

- Universal joints created using pins extracted from used bicycle chain.
- Joints have a snap-assemble design but are not very conducive to repeated disassembly.
- Using 1/4" solid aluminum rod for the carriage arms, will need to be glued into the universal joint arms.
- Currently testing alternative plastics for the core of the universal joint - PETT (Taulman t-glase brand).

Calibration:

- Initial build will not have consideration for auto-levelling.
  Once the base design has matured from an initial testing prototype to a working proof consideration can be applied to such advanced topics.

Assembly Notes:

- The universal joint arms may split if you try to force them onto the carriage arms.
  I recommend printing them in PLA and then dipping them in hot water for 10 seconds to soften the plastic before carefully pushing them over the rods for a dry-run fitting.
  Let them cool on the rod before removing them to dry them off so that you retain the internal shape.

- The universal joint has some play to it it's movement.
  To counter this issue the joint core is being made with a slightly tighter hold for the pins.
  Will be testing the PETT cores with a drop of hot glue inside to hold the pin with less room for movement.
  It shouldn't be important for the glue to cling tightly to the pin, it's mostly for filler.
  Apply thick grease to the pin holders on the carriages.